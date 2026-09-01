#Requires -Version 7.0

# ============================================================================
# Environment & Mise
# ============================================================================
$env:MISE_INSTALLS_DIR = 'D:\mise'
(& mise activate --shims pwsh) | Out-String | Invoke-Expression

$script:ProfileCacheDir = Join-Path $env:LOCALAPPDATA 'pwsh-profile-cache'
if (-not (Test-Path $script:ProfileCacheDir)) {
    New-Item -ItemType Directory -Path $script:ProfileCacheDir -Force | Out-Null
}

# ============================================================================
# Improved cd with fuzzy fallback
# ============================================================================
function cd {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]] $Arguments
    )
    $query = $Arguments -join ' '
    if ([string]::IsNullOrWhiteSpace($query)) {
        $candidates = @(fd -t d --hidden . 'D:\' 2>$null)
        if ($candidates.Count -eq 0) { return }
        $selected = $candidates | tv --select-1
        if ($selected) { Set-Location -Path $selected }
        return
    }
    # Path-like: try normal cd first
    if ($query -match '^[A-Za-z]:' -or $query -match '[\/]' -or $query.StartsWith('~') -or $query.StartsWith('.')) {
        if (Test-Path -Path $query -PathType Container) {
            Set-Location -Path $query
            return
        }
        Set-Location -Path $query
        return
    }
    # Simple keyword: fuzzy search in D:\
    $tokens = $query -split '\s+'
    $pattern = '(' + (($tokens | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')'
    $candidates = @(fd -t d --hidden $pattern 'D:\' 2>$null)
    if ($candidates.Count -eq 0) {
        Write-Host "No directory matched '$query' under D:\" -ForegroundColor Red
        return
    }
    $selected = $candidates | tv --input=$query --select-1
    if ($selected) { Set-Location -Path $selected }
}

# ============================================================================
# Profile init caching helpers
# ============================================================================
function Get-ActualMiseBinaryPath {
    param([string] $Name)
    $miseInstallDir = Join-Path 'D:\mise' $Name
    if (-not (Test-Path $miseInstallDir)) { return $null }
    $exe = Get-ChildItem -Path $miseInstallDir -Recurse -Filter "$Name.exe" -ErrorAction SilentlyContinue |
        Sort-Object -Property FullName -Descending |
        Select-Object -First 1
    if ($exe -and (Test-Path $exe.FullName)) { return $exe.FullName }
    return $null
}

function Get-ProfileCachedInit {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Command,
        [string[]] $Arguments = @('init', 'powershell'),
        [int] $TtlDays = 7
    )
    $cacheFile = Join-Path $script:ProfileCacheDir "$Name-init.ps1"
    $toolPathFile = "$cacheFile.tool"
    $cacheTtl = New-TimeSpan -Days $TtlDays

    $tool = Get-Command $Command -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $tool -or -not (Test-Path $tool.Source)) { return $null }

    $toolPath = $tool.Source
    $actualToolPath = if ($toolPath -like '*\mise\shims\*') { (Get-ActualMiseBinaryPath -Name $Command) } else { $toolPath }
    if (-not $actualToolPath) { $actualToolPath = $toolPath }
    $cachedToolPath = if (Test-Path $toolPathFile) { (Get-Content $toolPathFile -Raw).Trim() } else { $null }

    $cacheFresh = (Test-Path $cacheFile) -and
                  ((Get-Date) - (Get-Item $cacheFile).LastWriteTime -lt $cacheTtl) -and
                  ($cachedToolPath -eq $actualToolPath)

    if (-not $cacheFresh) {
        & $actualToolPath @Arguments | Out-File -FilePath $cacheFile -Encoding utf8 -Force
        $actualToolPath | Out-File -FilePath $toolPathFile -Encoding utf8 -Force
        if (-not (Test-Path $cacheFile) -or (Get-Item $cacheFile).Length -eq 0) {
            Remove-Item $toolPathFile -Force -ErrorAction SilentlyContinue
            return $null
        }
        if ($actualToolPath -ne $toolPath) {
            $cached = Get-Content -Raw $cacheFile -Encoding utf8
            $cached = $cached -replace [regex]::Escape($toolPath), $actualToolPath
            Set-Content -Path $cacheFile -Value $cached -Encoding utf8 -NoNewline
        }
    }

    # Invalidate cache if any hardcoded executable path inside no longer exists.
    $cached = Get-Content -Raw $cacheFile -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($cached)) {
        Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue
        Remove-Item $toolPathFile -Force -ErrorAction SilentlyContinue
        return $null
    }
    $exePaths = [regex]::Matches($cached, '[A-Za-z]:\\[^\s'']+\.exe') | ForEach-Object { $_.Value }
    foreach ($p in $exePaths) {
        if (-not (Test-Path $p)) {
            Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue
            Remove-Item $toolPathFile -Force -ErrorAction SilentlyContinue
            return $null
        }
    }

    return $cacheFile
}

function Test-ProfileCachedCommand {
    param([Parameter(Mandatory)] [string] $Name, [int] $TtlDays = 1)
    $cacheFile = Join-Path $script:ProfileCacheDir "$Name-cmd"
    if (Test-Path $cacheFile) {
        if ((Get-Date) - (Get-Item $cacheFile).LastWriteTime -lt (New-TimeSpan -Days $TtlDays)) { return $true }
    }
    if (Get-Command $Name -CommandType Application -ErrorAction SilentlyContinue) {
        New-Item -ItemType File -Path $cacheFile -Force | Out-Null
        return $true
    }
    if (Test-Path $cacheFile) { Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue }
    return $false
}

# ============================================================================
# Prompt & shell integrations
# ============================================================================
function Invoke-Starship-PreCommand {
    $loc = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
    if ($loc -and $loc.Provider.Name -eq 'FileSystem') {
        $esc = [char]27
        $path = $loc.ProviderPath -replace '\\', '/'
        $host.ui.Write("${esc}]7;file://${env:COMPUTERNAME}/${path}${esc}\")
    }
}

$script:StarshipInit = $null
$script:StarshipLoaded = $false

$script:ZoxideInit = $null
$script:ZoxideLoaded = $false
function global:__LoadZoxide {
    if ($script:ZoxideLoaded) { return }
    if (-not $script:ZoxideInit) { $script:ZoxideInit = Get-ProfileCachedInit -Name 'zoxide' -Command 'zoxide' }
    if ($script:ZoxideInit -and (Test-Path $script:ZoxideInit)) { . $script:ZoxideInit }
    if ($script:ZoxideInit) { $script:ZoxideLoaded = $true }
}
function global:z { __LoadZoxide; if (Test-Path Function:\__zoxide_z) { __zoxide_z @args } }
function global:zi { __LoadZoxide; if (Test-Path Function:\__zoxide_zi) { __zoxide_zi @args } }

if (Test-ProfileCachedCommand -Name 'winget') {
    $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = {
        $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $null
        Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
    }
}

function global:prompt {
    if (-not $script:StarshipLoaded) {
        if (-not $script:StarshipInit) {
            $script:StarshipInit = Get-ProfileCachedInit -Name 'starship-full' -Command 'starship' -Arguments @('init', 'powershell', '--print-full-init')
        }
        if ($script:StarshipInit) {
            . $script:StarshipInit
            $script:StarshipLoaded = $true
        }
    }
    & $Function:prompt @args
}

# ============================================================================
# Encoding & PSReadLine
# ============================================================================
$script:PreviousOutputEncoding = [Console]::OutputEncoding
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
if ($script:PreviousOutputEncoding.CodePage -ne 65001) { chcp 65001 > $null }

if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -MaximumHistoryCount 30000 -HistoryNoDuplicate -HistorySearchCursorMovesToEnd -ErrorAction SilentlyContinue
    try { Set-PSReadLineOption -PredictionSource History } catch { }
}

# ============================================================================
# Simple command aliases
# ============================================================================
Remove-Item Alias:ni, Alias:rd, Alias:h, Alias:cd, Alias:dir -Force -ErrorAction Ignore

if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    Remove-Item Alias:powershell -Force -ErrorAction SilentlyContinue
    Set-Alias powershell pwsh
}

Set-Alias c cls
Set-Alias new New-Item
Set-Alias nu "$env:USERPROFILE\scoop\apps\nu\current\nu.exe"
Set-Alias y yazi
Set-Alias n nvim
Set-Alias v bat
Set-Alias ot hx

# ============================================================================
# Navigation functions (auto-generated from map)
# ============================================================================
$locationMap = @{
    home            = $env:USERPROFILE
    downloads       = "$env:USERPROFILE\Downloads"
    desktop         = "$env:USERPROFILE\Desktop"
    docs            = "$env:USERPROFILE\Documents"
    d               = 'D:\'
    cnotes          = "$env:USERPROFILE\Documents\notes"
    images          = "$env:USERPROFILE\Pictures"
    videos          = "$env:USERPROFILE\Videos"
    projects        = "$env:USERPROFILE\Projects"
    scripts         = "$env:USERPROFILE\Documents\PowerShell"
    appdata         = "$env:USERPROFILE\AppData"
    local           = "$env:USERPROFILE\AppData\Local"
    config          = "$env:USERPROFILE\.config"
    dotfiles        = "$env:USERPROFILE\.local\share\chezmoi"
    temp            = $env:TEMP
    'windsurf-path' = "$env:USERPROFILE\.codeium\windsurf"
    newkub          = 'D:\newkub'
}
foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location -Path '$($locationMap[$key])'"))
}

# ============================================================================
# Fuzzy selection helpers
# ============================================================================
function Select-Fuzzy {
    param([string]$Type, [string]$Query, [string]$Root = '.')
    $items = if ($Query) { fd -t $Type $Query $Root } else { fd -t $Type . $Root }
    $items | tv
}

function Select-Directory {
    param([string]$Root = '.', [string]$Query = '')
    $selected = Select-Fuzzy -Type d -Query $Query -Root $Root
    if ($selected) { Set-Location -Path $selected }
}

function Select-ZedPath {
    param([string]$Type, [string]$Query, [string]$Root = '.')
    $selected = Select-Fuzzy -Type $Type -Query $Query -Root $Root
    if ($selected) { zed $selected }
}

# ============================================================================
# Quick explorers & clipboard
# ============================================================================
function dd { explorer "$env:USERPROFILE\Downloads" }
function ep { explorer $env:USERPROFILE }
function b { broot }
function e { explorer . }
function cpath { $PWD.Path | Set-Clipboard }

function cpc {
    param([Parameter(Mandatory)] [string] $File)
    if (Test-Path $File) {
        Get-Content $File -Raw | Set-Clipboard
        Write-Host "Content copied from: $File" -ForegroundColor Green
    } else {
        Write-Host "File not found: $File" -ForegroundColor Red
    }
}

function cpo {
    $last = Get-History -Count 1
    if (-not $last) { Write-Warning 'No history found'; return }
    $output = Invoke-Expression $last[0].CommandLine | Out-String -Width 4096
    ($output -replace "`e\[[\d;]*m", '').TrimEnd() | Set-Clipboard
    Write-Host 'Last command output copied as plain text.'
}

# ============================================================================
# Fuzzy cd shortcuts
# ============================================================================
function cc {
    param([string] $query = '')
    Select-Directory -Root 'D:\' -Query $query
}

function cdd {
    param([string] $query = '')
    if ($query) { Set-Location -Path "D:\$query" } else { Select-Directory -Root 'D:\' }
}

# ============================================================================
# Editor helpers
# ============================================================================
function o {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $Arguments)
    if ($Arguments) { zed $Arguments } else { zed . }
}

function h {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $Arguments)
    if ($Arguments) { hx $Arguments } else { hx . }
}

function f { param([string] $query = ''); Select-ZedPath -Type f -Query $query }
function ff { param([string] $query = ''); Select-ZedPath -Type d -Query $query }

function ozedrules { zed "$env:USERPROFILE\.codeium\windsurf\memories\global_rules.md" }
function opowershellprofile { zed "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
function otd { zed 'D:\TODO.md' }

# ============================================================================
# Listing, runners, and project helpers
# ============================================================================
function dir { eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --hyperlink --all }

function github-issue { gh dash @args }
function files { spf @args }
function code-insiders { & "$env:LOCALAPPDATA\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd" $args }

function Invoke-Runner {
    param([string] $Manager, [string] $Script)
    ni
    & $Manager $Script
}

$runners = @{
    bun  = 'rd,run dev', 'rw,run watch', 'rb,run build', 'rl,run lint', 'rt,run test', 'rr,run review', 'rf,run format', 'rc,run typecheck'
    moon = 'md,run :dev', 'mw,run :watch', 'mb,run :build', 'ml,run :lint', 'mt,run :test', 'mr,run :review', 'mf,run :format', 'mc,run :typecheck'
}
foreach ($manager in $runners.Keys) {
    foreach ($pair in $runners[$manager]) {
        $name, $script = $pair -split ','
        Set-Item -Path "Function:$name" -Value ([ScriptBlock]::Create("Invoke-Runner -Manager '$manager' -Script '$script'"))
    }
}

# ============================================================================
# GitHub, web, and devin helpers
# ============================================================================
function new-repo {
    $name = Read-Host 'Enter repo name'
    gh repo create $name --public --clone
}

function repo {
    git rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -eq 0) { gh repo view --web } else { Start-Process 'https://github.com/newkub?tab=repositories' }
}

function g {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $args)
    if (-not $args) { Start-Process 'https://www.google.com'; return }
    $engines = @{
        google  = 'https://www.google.com/search?q={0}'
        npm     = 'https://www.npmjs.com/search?q={0}'
        github  = 'https://github.com/search?q={0}'
        youtube = 'https://www.youtube.com/results?search_query={0}'
        chatgpt = 'https://chatgpt.com/?q={0}'
        crates  = 'https://crates.io/search?q={0}'
    }
    $first = $args[0].ToLower()
    if ($engines.ContainsKey($first)) {
        $query = [uri]::EscapeDataString(($args[1..($args.Length - 1)] -join ' '))
    } else {
        $first = 'google'
        $query = [uri]::EscapeDataString(($args -join ' '))
    }
    Start-Process ($engines[$first] -f $query)
}

function op {
    param([int] $port)
    Start-Process "http://localhost:$port"
}

function devin {
    $devinCmd = (Get-Command devin -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1).Source
    if (-not $devinCmd) { Write-Host 'devin not found' -ForegroundColor Red; return }
    & $devinCmd --permission-mode dangerous @args
}

# ============================================================================
# Notes & delete helpers
# ============================================================================
function rmi {
    param([string] $query = '')
    $selected = Select-Fuzzy -Type d -Query $query -Root .
    if (-not $selected) { return }
    Write-Host "1=Normal  2=Recursive  (delete '$selected')" -ForegroundColor Yellow
    $choice = Read-Host 'Choice'
    $recursive = switch ($choice) {
        '1' { $false }
        '2' { $true }
        default { Write-Host 'Canceled' -ForegroundColor Gray; return }
    }
    $confirm = Read-Host "Delete '$selected'? (y/n)"
    if ($confirm -ne 'y') { Write-Host 'Canceled' -ForegroundColor Gray; return }
    if ($recursive) { Remove-Item -Recurse -Force $selected } else { Remove-Item $selected }
    Write-Host "Deleted: $selected" -ForegroundColor Green
}

function notes {
    param([string] $action = '')
    $notesDir = "$env:USERPROFILE\Documents\notes"
    if (-not (Test-Path $notesDir)) { New-Item -ItemType Directory -Path $notesDir | Out-Null }
    if ($action -eq 'new') {
        $fileName = Read-Host 'Enter note name (no extension)'
        if (-not $fileName) { Write-Host 'Cancelled' -ForegroundColor Yellow; return }
        $fullPath = Join-Path $notesDir "$fileName.md"
        if (Test-Path $fullPath) { Write-Host "File exists: $fullPath" -ForegroundColor Red; return }
        New-Item -ItemType File -Path $fullPath | Out-Null
        Write-Host "Note created: $fullPath" -ForegroundColor Green
        zed $fullPath
    } else {
        $selected = Select-Fuzzy -Type f -Query ($action ? $action : '.') -Root $notesDir
        if ($selected) { zed $selected }
    }
}
