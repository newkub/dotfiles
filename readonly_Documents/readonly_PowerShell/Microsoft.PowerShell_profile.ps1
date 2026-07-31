# ==============================================================================
# >> SHELL INITIALIZATION
# Tools and prompts that initialize when PowerShell starts.
# ==============================================================================

# --- Cached shell tool initializers ---
# These tools emit PowerShell init scripts. Caching them avoids spawning TEST
# the binary on every shell startup. Cache is invalidated when the tool binary changes.
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
    # Use cache directly if it exists and is fresh; Get-Command can be slow on a large PATH.
    if (Test-Path $cacheFile) {
        $cacheAge = (Get-Date) - (Get-Item $cacheFile).LastWriteTime
        if ($cacheAge -lt $cacheTtl) { return $cacheFile }
    }
    $tool = Get-Command $Command -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $tool) { return $null }
    $toolPath = $tool.Source
    if (-not (Test-Path $toolPath)) { return $null }
    $toolTime = (Get-Item $toolPath).LastWriteTime
    if (-not (Test-Path $cacheFile) -or (Get-Item $cacheFile).LastWriteTime -lt $toolTime) {
        & $toolPath @Arguments | Out-File -FilePath $cacheFile -Encoding utf8 -Force
    }
    return $cacheFile
}

function Test-ProfileCachedCommand {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [int] $TtlDays = 1
    )
    $cacheFile = Join-Path $script:ProfileCacheDir "$Name-cmd"
    $cacheTtl = New-TimeSpan -Days $TtlDays
    if (Test-Path $cacheFile) {
        $cacheAge = (Get-Date) - (Get-Item $cacheFile).LastWriteTime
        if ($cacheAge -lt $cacheTtl) { return $true }
    }
    if (Get-Command $Name -CommandType Application -ErrorAction SilentlyContinue) {
        New-Item -ItemType File -Path $cacheFile -Force | Out-Null
        return $true
    }
    if (Test-Path $cacheFile) { Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue }
    return $false
}

# --- mise ---
# Use shims instead of adding every tool's bin to PATH to avoid cmd.exe PATH overflow
$miseInit = Get-ProfileCachedInit -Name "mise" -Command "mise" -Arguments @("activate", "pwsh", "--shims")
if ($miseInit) { . $miseInit }

# --- WezTerm CWD tracking (OSC 7) ---
# Emits the current working directory so WezTerm can track pane CWD.
function Invoke-Starship-PreCommand {
    $current_location = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
    if ($current_location -and $current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $host.ui.Write("${ansi_escape}]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\")
    }
}

# --- Starship Prompt ---
# Use --print-full-init so the cached file is the full init script,
# avoiding a starship.exe process spawn on every shell startup.
$starshipInit = Get-ProfileCachedInit -Name "starship-full" -Command "starship" -Arguments @("init", "powershell", "--print-full-init")
if ($starshipInit) { . $starshipInit }

# --- Zoxide Navigation ---
# https://github.com/ajeetdsouza/zoxide
$zoxideInit = Get-ProfileCachedInit -Name "zoxide" -Command "zoxide"
if ($zoxideInit) { . $zoxideInit }

# --- PowerToys CommandNotFound ---
# Shows suggestions from WinGet if a command is not found.
# Lazy-load: the module import is slow (~1.2 s), so defer it until the first missing command.
# Cache the winget lookup so Get-Command only runs once per day.
if (Test-ProfileCachedCommand -Name "winget") {
    $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = {
        $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $null
        Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
    }
}

# --- x-cmd ---
# Temporarily disabled due to atuin GetHistoryItems error
# if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" }

# --- IntelliShell (lazy-load on first prompt) ---
# https://intellishell.app/
$script:IntelliShellPath = "$env:USERPROFILE\.local\share\intelli-shell\shell\_intelli.ps1"
$script:IntelliShellLoaded = $false
function global:Initialize-IntelliShell {
    if ($script:IntelliShellLoaded) { return }
    if (Test-Path $script:IntelliShellPath) {
        . $script:IntelliShellPath
    }
    $script:IntelliShellLoaded = $true
}

# --- Atuin (lazy-load on first prompt) ---
# https://atuin.sh/
$script:AtuinInit = Get-ProfileCachedInit -Name "atuin" -Command "atuin"
$script:AtuinLoaded = $false
function global:Initialize-Atuin {
    if ($script:AtuinLoaded) { return }
    if ($script:AtuinInit -and (Test-Path $script:AtuinInit)) {
        . $script:AtuinInit
    }
    $script:AtuinLoaded = $true
}

# --- Lazy-load Atuin and IntelliShell on first prompt ---
# These tools touch PSReadLine/PSConsoleHostReadLine and are only needed for
# interactive use, so skip loading them until the prompt is first rendered.
$script:PromptLazyOriginal = $Function:prompt
$script:PromptLazyLoaded = $false
function global:prompt {
    if (-not $script:PromptLazyLoaded) {
        Initialize-Atuin
        Initialize-IntelliShell
        $script:PromptLazyLoaded = $true
    }
    & $script:PromptLazyOriginal @args
}

# ==============================================================================
# >> ENVIRONMENT VARIABLES
# Custom environment variable settings.
# ==============================================================================

# Use UTF-8 in the console so Thai and other non-ASCII text renders correctly
$script:PreviousOutputEncoding = [Console]::OutputEncoding
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
# Avoid spawning chcp when the console is already UTF-8
if ($script:PreviousOutputEncoding.CodePage -ne 65001) { chcp 65001 >$null }

# --- Proto Configuration ---
$env:PROTO_HOME = Join-Path $HOME ".proto"
$env:Path = @(
    (Join-Path $env:PROTO_HOME "shims")
    (Join-Path $env:PROTO_HOME "bin")
    $env:Path
) -join [IO.PATH]::PathSeparator

# ==============================================================================
# >> ALIASES
# Custom shortcuts for frequently used commands.
# ==============================================================================

Remove-Item Alias:ni -Force -ErrorAction Ignore
Remove-Item Alias:rd
Remove-Item Alias:h
Remove-Item Alias:cd

# --- General Aliases ---
Remove-Item -Path Alias:dir -Force

# Make `powershell` command point to pwsh (PowerShell 7)
if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    Remove-Item -Path Alias:powershell -Force -ErrorAction SilentlyContinue
    Set-Alias -Name powershell -Value pwsh
}

# --- Tool Aliases ---
Set-Alias -Name c -Value cls
Set-Alias -Name new -Value New-Item
Set-Alias -Name nu -Value $env:USERPROFILE\scoop\apps\nu\current\nu.exe
Set-Alias -Name y -Value yazi
Set-Alias -Name n -Value nvim
Set-Alias -Name v -Value bat
Set-Alias -Name ot -Value hx

# --- GitHub Issue Dashboard ---
function github-issue { gh dash @args }

# --- Superfile (TUI file manager) ---
function files { spf @args }


# --- VS Code Insiders ---
function code-insiders { & "C:\Users\Veerapong\AppData\Local\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd" $args }

# --- Copy File Content ---
function cpc {
    param([Parameter(Mandatory=$true)][string]$File)
    if (Test-Path $File) {
        Get-Content $File -Raw | Set-Clipboard
        Write-Host "Content copied from: $File" -ForegroundColor Green
    } else {
        Write-Host "File not found: $File" -ForegroundColor Red
    }
}

# ==============================================================================
# >> NAVIGATION FUNCTIONS
# Functions to quickly navigate to common directories.
# ==============================================================================

$locationMap = @{
    "home" = "$HOME"
    "downloads" = "$HOME\Downloads"
    "desktop" = "$HOME\Desktop"
    "docs" = "$HOME\Documents"
    "d" = "D:\"
    "cnotes" = "C:\Users\Veerapong\Documents\notes"
    "images" = "$HOME\Pictures"
    "videos" = "$HOME\Videos"
    "projects" = "$HOME\Projects"
    "scripts" = "$HOME\Documents\PowerShell"
    "appdata" = "$HOME\AppData"
    "local" = "$HOME\AppData\Local"
    "config" = "$HOME\.config"
    ".config" = "$HOME\.config"
    "dotfiles" = "$HOME\.local\share\chezmoi"
    "temp" = "$env:TEMP"
    "windsurf-path" = "$HOME\.codeium\windsurf"
    "newkub" = "D:\newkub"
}

foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location '$($locationMap[$key])'"))
}

function dd { explorer "C:\Users\Veerapong\downloads" }
function ep { explorer "C:\Users\Veerapong" }
function b { broot }

function cc {
    param([string]$query = "")
    $root = "D:\"
    $dirs = if ($query) { fd -t d $query $root } else { fd -t d . $root }
    $selected = $dirs | tv
    if ($selected) { Set-Location $selected }
}

function cd {
    param([string]$query = "")
    if ($query) {
        Set-Location $query
    } else {
        $dirs = fd -t d
        $selected = $dirs | tv
        if ($selected) { Set-Location $selected }
    }
}

function cdd {
    param([string]$query = "")
    $root = "D:\"
    if ($query) {
        Set-Location "$root$query"
    } else {
        $dirs = fd -t d . $root
        $selected = $dirs | tv
        if ($selected) { Set-Location $selected }
    }
}


# ==============================================================================
# >> EDITOR FUNCTIONS
# Functions to open files in various editors.
# ==============================================================================

function o {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$Arguments)
    if ($Arguments) { zed $Arguments } else { zed . }
}

function f {
    param([string]$query = "")
    $files = if ($query) { fd -t f $query } else { fd -t f }
    $selected = $files | tv
    if ($selected) { zed $selected }
}

function ff {
    param([string]$query = "")
    $dirs = if ($query) { fd -t d $query } else { fd -t d }
    $selected = $dirs | tv
    if ($selected) { zed $selected }
}

function ozedrules {
    $path = "C:\Users\Veerapong\.codeium\windsurf\memories\global_rules.md"
    zed $path
}

function opowershellprofile {
    $path = "C:\Users\Veerapong\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    zed $path
}

function otd { zed "d:\TODO.md" }

function h {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Arguments)
    if ($Arguments) { hx $Arguments } else { hx . }
}

# ==============================================================================
# >> SCRIPT RUNNERS
# Functions to run common development scripts.
# ==============================================================================

# --- Directory Listing with eza ---
function dir { eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --hyperlink --all }

# --- mise task run ---
function t { mise task run }

# --- Bun Script Runners ---
function rd { ni && bun run dev }
function rw { ni && bun run watch }
function rb { ni && bun run build }
function rl { ni && bun run lint }
function rt { ni && bun run test }
function rr { ni && bun run review }
function rf { ni && bun run format }
function rc { ni && bun run typecheck }

# --- Moon Script Runners ---
function md { ni && moon run :dev }
function mw { ni && moon run :watch }
function mb { ni && moon run :build }
function ml { ni && moon run :lint }
function mt { ni && moon run :test }
function mr { ni && moon run :review }
function mf { ni && moon run :format }
function mc { ni && moon run :typecheck }

# ==============================================================================
# >> FILE OPERATIONS
# Functions for file and directory management.
# ==============================================================================

function rmi {
    param([string]$query = "")
    $dirs = if ($query) { fd -t d --hidden $query } else { fd -t d --hidden }
    $selected = $dirs | tv
    if ($selected) {
        Write-Host "Select delete type:" -ForegroundColor Yellow
        Write-Host "1. Normal delete" -ForegroundColor Cyan
        Write-Host "2. Recursive delete" -ForegroundColor Cyan
        $choice = Read-Host "Enter choice (1 or 2)"
        if ($choice -eq '1') {
            Write-Host "Delete normally '$selected'? (y/n)" -ForegroundColor Red
            $confirm = Read-Host
            if ($confirm -eq 'y') {
                Remove-Item $selected
                Write-Host "Deleted: $selected" -ForegroundColor Green
            } else {
                Write-Host "Canceled" -ForegroundColor Gray
            }
        } elseif ($choice -eq '2') {
            Write-Host "Delete recursively '$selected'? (y/n)" -ForegroundColor Red
            $confirm = Read-Host
            if ($confirm -eq 'y') {
                Remove-Item -Recurse -Force $selected
                Write-Host "Deleted recursively: $selected" -ForegroundColor Green
            } else {
                Write-Host "Canceled" -ForegroundColor Gray
            }
        } else {
            Write-Host "Invalid choice. Canceled" -ForegroundColor Gray
        }
    }
}

function notes {
    param([string]$action = "")
    $notesDir = "C:\Users\Veerapong\Documents\notes"
    if (-not (Test-Path $notesDir)) {
        New-Item -ItemType Directory -Path $notesDir | Out-Null
    }
    if ($action -eq "new") {
        $fileName = Read-Host "Enter note name (no extension)"
        if (-not $fileName) {
            Write-Host "Cancelled" -ForegroundColor Yellow
            return
        }
        $fullPath = Join-Path $notesDir "$fileName.md"
        if (Test-Path $fullPath) {
            Write-Host "File exists: $fullPath" -ForegroundColor Red
            return
        }
        New-Item -ItemType File -Path $fullPath | Out-Null
        Write-Host "Note created: $fullPath" -ForegroundColor Green
        zed $fullPath
    } else {
        $query = if ($action) { $action } else { "." }
        $selected = fd -t f $query $notesDir | tv
        if ($selected) { zed $selected }
    }
}

# ==============================================================================
# >> UTILITY FUNCTIONS
# Helper functions for various tasks.
# ==============================================================================

function e { explorer . }
function cpath { $PWD.Path | Set-Clipboard }

# ==============================================================================
# >> GITHUB FUNCTIONS
# Functions for GitHub operations.
# ==============================================================================

function new-repo {
    $name = Read-Host "Enter repo name"
    gh repo create $name --public --clone
}

function repo {
    git rev-parse --is-inside-work-tree *>$null
    if ($LASTEXITCODE -eq 0) {
        gh repo view --web
    } else {
        open "https://github.com/newkub?tab=repositories"
    }
}

# ==============================================================================
# >> SEARCH FUNCTIONS
# Functions for searching the web.
# ==============================================================================

function g {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$args)
    if (-not $args) {
        Start-Process "https://www.google.com"
        return
    }
    $engines = @{
        google = "https://www.google.com/search?q={0}"
        npm    = "https://www.npmjs.com/search?q={0}"
        github = "https://github.com/search?q={0}"
        youtube= "https://www.youtube.com/results?search_query={0}"
        chatgpt  = "https://chat.openai.com/?q={0}"
        crates  = "https://crates.io/search?q={0}"
    }
    $first = $args[0].ToLower()
    if ($engines.ContainsKey($first)) {
        $engine = $engines[$first]
        $query = [uri]::EscapeDataString(($args[1..($args.Length-1)] -join ' '))
    } else {
        $engine = $engines.google
        $query = [uri]::EscapeDataString(($args -join ' '))
    }
    Start-Process ($engine -f $query)
}

function op {
    param([int]$port)
    Start-Process "http://localhost:$port"
}

# ==============================================================================
# >> CLIPBOARD FUNCTIONS
# Functions for clipboard operations.
# ==============================================================================

function cpo {
    $last = Get-History -Count 1
    if (-not $last) {
        Write-Warning "No history found"
        return
    }
    $cmd = $last[0].CommandLine
    $output = Invoke-Expression $cmd | Out-String -Width 4096
    $plainOutput = $output -replace "`e\[[\d;]*m", ''
    $plainOutput.TrimEnd() | Set-Clipboard
    Write-Host "Last command output copied as plain text."
}

# ==============================================================================
# >> ANALYSIS FUNCTIONS
# Functions for code analysis.
# ==============================================================================


# ==============================================================================
# >> DEVIN WRAPPER
# `devin` always runs as `devin --permission-mode dangerous`.
# ==============================================================================

function devin {
    $devinCmd = (Get-Command devin -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1).Source
    if (-not $devinCmd) {
        Write-Host "devin not found" -ForegroundColor Red
        return
    }
    & $devinCmd --permission-mode dangerous @args
}
