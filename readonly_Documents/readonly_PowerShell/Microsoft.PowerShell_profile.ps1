

# --- Starship Prompt ---
# https://starship.rs/
Invoke-Expression (&starship init powershell)

# --- Zoxide Navigation ---
# https://github.com/ajeetdsouza/zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# --- PowerToys CommandNotFound ---
# Shows suggestions from WinGet if a command is not found.
Import-Module -Name Microsoft.WinGet.CommandNotFound

# --- x-cmd ---
# https://github.com/x-cmd/x
if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.

# --- IntelliShell ---
# https://intellishell.app/
$env:INTELLI_HOME = "C:\Users\Veerapong\AppData\Roaming\IntelliShell\Intelli-Shell\data"
intelli-shell.exe init powershell | Out-String | Invoke-Expression


# ==============================================================================
# >> ENVIRONMENT VARIABLES
# Custom environment variable settings.
# ==============================================================================

[Environment]::SetEnvironmentVariable("CLAUDE_CODE_GIT_BASH_PATH", "C:\Users\Veerapong\scoop\shims\git.exe", "User")


# ==============================================================================
# >> ALIASES
# Custom shortcuts for frequently used commands.
# ==============================================================================

# --- ni (npm/yarn/pnpm/bun) ---
# https://github.com/antfu-collective/ni
if (-not (Test-Path $profile)) {
  New-Item -ItemType File -Path (Split-Path $profile) -Force -Name (Split-Path $profile -Leaf)
}
$profileEntry = 'Remove-Item Alias:ni -Force -ErrorAction Ignore'
$profileContent = Get-Content $profile
if ($profileContent -notcontains $profileEntry) {
  ("`n" + $profileEntry) | Out-File $profile -Append -Force -Encoding UTF8
}
Remove-Item Alias:ni -Force -ErrorAction Ignore

# --- General Aliases ---

Set-Alias -Name b -Value broot
Set-Alias -Name c -Value cls
Remove-Item -Path Alias:dir -Force
Set-Alias -Name dir -Value pwshdir
Set-Alias -Name e -Value openexplorer
Set-Alias -Name n -Value nvim
Set-Alias -Name q -Value openqoder
Set-Alias -Name w -Value openwindsurf
Set-Alias -Name qoder-workflows -Value cdqoderworkflows
Set-Alias -Name l -Value pwshdir
Set-Alias -Name t -Value misetask
Set-Alias -Name new -Value New-Item
Set-Alias -Name nu -Value $env:USERPROFILE\scoop\apps\nu\current\nu.exe
Set-Alias -Name y -Value yazi

# --- Bun Script Aliases ---
Set-Alias -Name rb -Value runbuild
Set-Alias -Name rd -Value rundev
Set-Alias -Name rl -Value runlint
Set-Alias -Name rr -Value runreview
Set-Alias -Name rt -Value runtest

# --- Other Aliases ---
Set-Alias -Name s -Value google


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
    "images" = "$HOME\Pictures"
    "videos" = "$HOME\Videos"
    "projects" = "$HOME\Projects"
    "scripts" = "$HOME\Documents\PowerShell"    
    "appdata" = "$HOME\AppData"
    "local" = "$HOME\AppData\Local"
    "config" = "$HOME\.config"
    ".config" = "$HOME\.config" # Alias for config
    "dotfiles" = "$HOME\.local\share\chezmoi"
    "temp" = "$env:TEMP"
    "windsurf-path" = "$HOME\.codeium\windsurf"
    "newkub" = "D:\newkub"
}

foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location '$($locationMap[$key])'"))
}

function od {
    explorer "C:\Users\Veerapong\downloads"
}


# ==============================================================================
# >> CUSTOM UTILITY FUNCTIONS
# Helper functions for various tasks.
# ==============================================================================

# --- Directory Listing with eza ---
function pwshdir {
    eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --all
}

# --- mise task run ---
function misetask {
   mise task run
}

# --- Bun Script Runners ---
function rundev {
    ni && bun run dev
}
function runbuild {
    ni && bun run build
}
function runlint {
    ni && bun run lint
}
function runtest {
    ni && bun run test
}
function runreview {
    ni && bun run review
}



function f {
    fd -t f | fzf | ForEach-Object { windsurf $_ }
}

function ff {
    fd -t d | fzf | ForEach-Object { windsurf $_ }
}



function cpath {
    $PWD.Path | Set-Clipboard
}

function openexplorer {
    explorer .
}

function openqoder {
     qoder .
}

function openwindsurf {
     windsurf .
}



function cdqoderworkflows {
    cd C:\Users\Veerapong\.codeium\windsurf\global_workflows && dir
}


# --- GitHub Repo View ---
function repo {
    git rev-parse --is-inside-work-tree *>$null
    if ($LASTEXITCODE -eq 0) {
        gh repo view --web
    } else {
        start "https://github.com/newkub?tab=repositories"
    }
}

# --- Open Google ---
function google {
    start "https://google.com"
}

