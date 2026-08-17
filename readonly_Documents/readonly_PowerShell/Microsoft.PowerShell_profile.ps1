# ==============================================================================
# >> SHELL INITIALIZATION
# ==============================================================================

# --- Cached tool initializers ---
# Tools like starship/zoxide emit PowerShell init scripts. Cache them to avoid
# spawning the binary on every startup. Cache invalidates when the binary changes.
$script:ProfileCacheDir = Join-Path $env:LOCALAPPDATA "pwsh-profile-cache"
if (-not (Test-Path $script:ProfileCacheDir)) {
    New-Item -ItemType Directory -Path $script:ProfileCacheDir -Force | Out-Null
}

function Get-ProfileCachedInit {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Command,
        [string[]] $Arguments = @("init", "powershell"),
        [int] $TtlDays = 7
    )
    $cacheFile = Join-Path $script:ProfileCacheDir "$Name-init.ps1"
    $cacheTtl = New-TimeSpan -Days $TtlDays
    if (Test-Path $cacheFile) {
        if ((Get-Date) - (Get-Item $cacheFile).LastWriteTime -lt $cacheTtl) { return $cacheFile }
    }
    $tool = Get-Command $Command -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $tool -or -not (Test-Path $tool.Source)) { return $null }
    $toolTime = (Get-Item $tool.Source).LastWriteTime
    if (-not (Test-Path $cacheFile) -or (Get-Item $cacheFile).LastWriteTime -lt $toolTime) {
        & $tool.Source @Arguments | Out-File -FilePath $cacheFile -Encoding utf8 -Force
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

# --- WezTerm CWD tracking (OSC 7) ---
function Invoke-Starship-PreCommand {
    $loc = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
    if ($loc -and $loc.Provider.Name -eq "FileSystem") {
        $esc = [char]27
        $path = $loc.ProviderPath -replace "\\", "/"
        $host.ui.Write("${esc}]7;file://${env:COMPUTERNAME}/${path}${esc}\")
    }
}

# --- Starship prompt (lazy-load on first render) ---
$script:StarshipInit = $null
$script:StarshipLoaded = $false

# --- Zoxide (lazy-load on first z/zi) ---
$script:ZoxideInit = $null
$script:ZoxideLoaded = $false
function global:__LoadZoxide {
    if ($script:ZoxideLoaded) { return }
    if (-not $script:ZoxideInit) { $script:ZoxideInit = Get-ProfileCachedInit -Name "zoxide" -Command "zoxide" }
    if ($script:ZoxideInit -and (Test-Path $script:ZoxideInit)) { . $script:ZoxideInit }
    $script:ZoxideLoaded = $true
}
function global:z { __LoadZoxide; if (Test-Path Function:\__zoxide_z) { __zoxide_z @args } }
function global:zi { __LoadZoxide; if (Test-Path Function:\__zoxide_zi) { __zoxide_zi @args } }

# --- WinGet CommandNotFound (lazy-load: module import is slow) ---
if (Test-ProfileCachedCommand -Name "winget") {
    $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = {
        $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $null
        Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
    }
}

# --- Prompt: lazy-load Starship on first render ---
function global:prompt {
    if (-not $script:StarshipLoaded) {
        if (-not $script:StarshipInit) {
            $script:StarshipInit = Get-ProfileCachedInit -Name "starship-full" -Command "starship" -Arguments @("init", "powershell", "--print-full-init")
        }
        if ($script:StarshipInit) { . $script:StarshipInit }
        $script:StarshipLoaded = $true
    }
    & $Function:prompt @args
}

# ==============================================================================
# >> ENVIRONMENT
# ==============================================================================

# UTF-8 console for Thai and non-ASCII text
$script:PreviousOutputEncoding = [Console]::OutputEncoding
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
if ($script:PreviousOutputEncoding.CodePage -ne 65001) { chcp 65001 > $null }

# PSReadLine: bounded, deduplicated history with predictions
if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -MaximumHistoryCount 30000 -HistoryNoDuplicate -HistorySearchCursorMovesToEnd -ErrorAction SilentlyContinue
    try { Set-PSReadLineOption -PredictionSource History } catch { }
}

# ==============================================================================
# >> ALIASES
# ==============================================================================

# Clear conflicting built-in aliases so functions below can use those names
Remove-Item Alias:ni, Alias:rd, Alias:h, Alias:cd, Alias:dir -Force -ErrorAction Ignore

# `powershell` -> pwsh (PowerShell 7)
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

function github-issue { gh dash @args }
function files { spf @args }
function code-insiders { & "$env:LOCALAPPDATA\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd" $args }

function cpc {
    param([Parameter(Mandatory)] [string] $File)
    if (Test-Path $File) {
        Get-Content $File -Raw | Set-Clipboard
        Write-Host "Content copied from: $File" -ForegroundColor Green
    } else {
        Write-Host "File not found: $File" -ForegroundColor Red
    }
}

# ==============================================================================
# >> NAVIGATION
# ==============================================================================

# Quick-jump functions generated from a location map
$locationMap = @{
    home         = "$HOME"
    downloads    = "$HOME\Downloads"
    desktop      = "$HOME\Desktop"
    docs         = "$HOME\Documents"
    d            = "D:\"
    cnotes       = "$HOME\Documents\notes"
    images       = "$HOME\Pictures"
    videos       = "$HOME\Videos"
    projects     = "$HOME\Projects"
    scripts      = "$HOME\Documents\PowerShell"
    appdata      = "$HOME\AppData"
    local        = "$HOME\AppData\Local"
    config       = "$HOME\.config"
    dotFiles     = "$HOME\.local\share\chezmoi"
    temp         = "$env:TEMP"
    "windsurf-path" = "$HOME\.codeium\windsurf"
    newkub       = "D:\newkub"
}
foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location '$($locationMap[$key])'"))
}

# Helper: fuzzy-pick a directory under $Root and cd into it
function Select-Directory {
    param([string] $Root = ".", [string] $Query = "")
    $dirs = if ($Query) { fd -t d $Query $Root } else { fd -t d . $Root }
    $selected = $dirs | tv
    if ($selected) { Set-Location $selected }
}

function dd { explorer "$HOME\downloads" }
function ep { explorer $HOME }
function b { broot }

function cc {
    param([string] $query = "")
    Select-Directory -Root "D:\" -Query $query
}

function cd {
    param([string] $query = "")
    if ($query) { Set-Location $query } else { Select-Directory }
}

function cdd {
    param([string] $query = "")
    if ($query) { Set-Location "D:\$query" } else { Select-Directory -Root "D:\" }
}

# ==============================================================================
# >> EDITORS
# ==============================================================================

function o {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $Arguments)
    if ($Arguments) { zed $Arguments } else { zed . }
}

function h {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $Arguments)
    if ($Arguments) { hx $Arguments } else { hx . }
}

# Helper: fuzzy-pick a path and open it in zed
function Select-ZedPath {
    param([string] $Type, [string] $Query, [string] $Root = ".")
    $items = if ($Query) { fd -t $Type $Query $Root } else { fd -t $Type . $Root }
    $selected = $items | tv
    if ($selected) { zed $selected }
}

function f { param([string] $query = ""); Select-ZedPath -Type f -Query $query }
function ff { param([string] $query = ""); Select-ZedPath -Type d -Query $query }

function ozedrules { zed "$HOME\.codeium\windsurf\memories\global_rules.md" }
function opowershellprofile { zed "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
function otd { zed "D:\TODO.md" }

# ==============================================================================
# >> SCRIPT RUNNERS
# ==============================================================================

function dir { eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --hyperlink --all }

# Helper: run `ni` then a package-manager script (bun or moon)
function Invoke-Runner {
    param([string] $Manager, [string] $Script)
    ni
    & $Manager $Script
}

# Bun runners (rd=dev, rw=watch, rb=build, rl=lint, rt=test, rr=review, rf=format, rc=typecheck)
foreach ($pair in @('rd,run dev','rw,run watch','rb,run build','rl,run lint','rt,run test','rr,run review','rf,run format','rc,run typecheck')) {
    $name, $script = $pair -split ','
    Set-Item -Path "Function:$name" -Value ([ScriptBlock]::Create("Invoke-Runner -Manager bun -Script '$script'"))
}

# Moon runners (md/mw/mb/ml/mt/mr/mf/mc)
foreach ($pair in @('md,run :dev','mw,run :watch','mb,run :build','ml,run :lint','mt,run :test','mr,run :review','mf,run :format','mc,run :typecheck')) {
    $name, $script = $pair -split ','
    Set-Item -Path "Function:$name" -Value ([ScriptBlock]::Create("Invoke-Runner -Manager moon -Script '$script'"))
}

# ==============================================================================
# >> FILE OPERATIONS
# ==============================================================================

function rmi {
    param([string] $query = "")
    $dirs = if ($query) { fd -t d --hidden $query } else { fd -t d --hidden }
    $selected = $dirs | tv
    if (-not $selected) { return }
    Write-Host "1=Normal  2=Recursive  (delete '$selected')" -ForegroundColor Yellow
    $choice = Read-Host "Choice"
    $recursive = switch ($choice) { '1' { $false } '2' { $true } default { Write-Host "Canceled" -ForegroundColor Gray; return } }
    $confirm = Read-Host "Delete '$selected'? (y/n)"
    if ($confirm -ne 'y') { Write-Host "Canceled" -ForegroundColor Gray; return }
    if ($recursive) { Remove-Item -Recurse -Force $selected } else { Remove-Item $selected }
    Write-Host "Deleted: $selected" -ForegroundColor Green
}

function notes {
    param([string] $action = "")
    $notesDir = "$HOME\Documents\notes"
    if (-not (Test-Path $notesDir)) { New-Item -ItemType Directory -Path $notesDir | Out-Null }
    if ($action -eq "new") {
        $fileName = Read-Host "Enter note name (no extension)"
        if (-not $fileName) { Write-Host "Cancelled" -ForegroundColor Yellow; return }
        $fullPath = Join-Path $notesDir "$fileName.md"
        if (Test-Path $fullPath) { Write-Host "File exists: $fullPath" -ForegroundColor Red; return }
        New-Item -ItemType File -Path $fullPath | Out-Null
        Write-Host "Note created: $fullPath" -ForegroundColor Green
        zed $fullPath
    } else {
        $selected = fd -t f ($action ? $action : ".") $notesDir | tv
        if ($selected) { zed $selected }
    }
}

# ==============================================================================
# >> UTILITIES
# ==============================================================================

function e { explorer . }
function cpath { $PWD.Path | Set-Clipboard }

# --- GitHub ---
function new-repo {
    $name = Read-Host "Enter repo name"
    gh repo create $name --public --clone
}
function repo {
    git rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -eq 0) { gh repo view --web } else { Start-Process "https://github.com/newkub?tab=repositories" }
}

# --- Web search ---
function g {
    param([Parameter(ValueFromRemainingArguments)] [string[]] $args)
    if (-not $args) { Start-Process "https://www.google.com"; return }
    $engines = @{
        google   = "https://www.google.com/search?q={0}"
        npm      = "https://www.npmjs.com/search?q={0}"
        github   = "https://github.com/search?q={0}"
        youtube  = "https://www.youtube.com/results?search_query={0}"
        chatgpt  = "https://chat.openai.com/?q={0}"
        crates   = "https://crates.io/search?q={0}"
    }
    $first = $args[0].ToLower()
    if ($engines.ContainsKey($first)) {
        $engine = $engines[$first]
        $query = [uri]::EscapeDataString(($args[1..($args.Length - 1)] -join ' '))
    } else {
        $engine = $engines.google
        $query = [uri]::EscapeDataString(($args -join ' '))
    }
    Start-Process ($engine -f $query)
}

function op {
    param([int] $port)
    Start-Process "http://localhost:$port"
}

# --- Clipboard: copy output of last command ---
function cpo {
    $last = Get-History -Count 1
    if (-not $last) { Write-Warning "No history found"; return }
    $output = Invoke-Expression $last[0].CommandLine | Out-String -Width 4096
    ($output -replace "`e\[[\d;]*m", '').TrimEnd() | Set-Clipboard
    Write-Host "Last command output copied as plain text."
}

# ==============================================================================
# >> DEVIN WRAPPER
# `devin` always runs with --permission-mode dangerous.
# ==============================================================================

function devin {
    $devinCmd = (Get-Command devin -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1).Source
    if (-not $devinCmd) { Write-Host "devin not found" -ForegroundColor Red; return }
    & $devinCmd --permission-mode dangerous @args
}

# ==============================================================================
# >> MISE (must be last so it wraps the final prompt function)
# Activates mise for PowerShell; tools are added to PATH dynamically per directory.
# Uses MISE_DATA_DIR=D:\mise to avoid cmd.exe PATH overflow.
# Full path to mise.exe because scoop shims break PowerShell pipes.
# ==============================================================================

(& 'C:\Users\Veerapong\scoop\apps\mise\current\bin\mise.exe' activate pwsh) | Out-String | Invoke-Expression
