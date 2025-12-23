

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

Remove-Item Alias:rd


# --- General Aliases ---

Set-Alias -Name c -Value cls
Remove-Item -Path Alias:dir -Force
Set-Alias -Name qoder-workflows -Value cdqoderworkflows
Set-Alias -Name new -Value New-Item
Set-Alias -Name nu -Value $env:USERPROFILE\scoop\apps\nu\current\nu.exe
Set-Alias -Name y -Value yazi



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

function b {
    broot
}


function cc {
    param(
        [string]$file
    )
    Get-Content $file -Raw | Set-Clipboard
}




# remove all like rimraf, rima
function rmr {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [int]$RetryCount = 3,
        [int]$DelaySec = 1
    )

    if (-Not (Test-Path $Path)) { return }

    for ($i=0; $i -lt $RetryCount; $i++) {
        try {
            # ลบโฟลเดอร์และไฟล์ทั้งหมด
            Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            # ลบโฟลเดอร์หลัก
            Remove-Item $Path -Recurse -Force -ErrorAction SilentlyContinue
            return
        } catch {
            Start-Sleep -Seconds $DelaySec
        }
    }
    Write-Warning "Failed to remove: $Path"
}



# ==============================================================================
# >> CUSTOM UTILITY FUNCTIONS
# Helper functions for various tasks.
# ==============================================================================

# --- Directory Listing with eza ---
function dir {
    eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --all
}

# --- mise task run ---
function t {
   mise task run
}


# --- Bun Script Runners ---
function rd {
    ni && bun run dev
}

function rw {
    ni && bun run watch
}

function rb {
    ni && bun run build
}
function rl {
    ni && bun run lint
}
function wrl {
    ni && turbo watch bun run lint
}
function rt {
    ni && bun run test
}
function wrt {
    ni && turbo watch bun run test
}
function rr {
    ni && bun run review
}
function rs {
    ni && bun run start
}
function wrs {
    ni && turbo watch bun run test
}
function rf {
    ni && bun run format
}
function rc {
    ni && bun run check
}




function f {
    fd -t f | fzf | ForEach-Object { windsurf $_ }
}

function n {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$files
    )

    if ($files) {
        nvim @files
    } else {
        nvim
    }
}



function ff {
    param(
        [string]$query = ""
    )

    # ถ้ามี query ให้ใส่ -i สำหรับ ignore case
    if ($query) {
        fd -t d $query | fzf | ForEach-Object { windsurf $_ }
    } else {
        fd -t d | fzf | ForEach-Object { windsurf $_ }
    }
}

function cff {
    param(
        [string]$query = ""
    )

    # เลือก directory ด้วย fd + fzf
    $selected = if ($query) {
        fd -t d $query | fzf
    } else {
        fd -t d | fzf
    }

    # ถ้าเลือก directory ได้ ให้ cd เข้าไป
    if ($selected) {
        Set-Location $selected
    }
}

function crm {
    param(
        [string]$query = ""
    )

    # เลือก directory ด้วย fd + fzf
    $selected = if ($query) {
        fd -t d $query | fzf
    } else {
        fd -t d | fzf
    }

    if ($selected) {
        # ยืนยันก่อนลบ
        $confirm = Read-Host "Delete '$selected'? (y/n)"
        if ($confirm -eq 'y') {
            Remove-Item -Recurse -Force $selected
            Write-Host "Deleted: $selected"
        } else {
            Write-Host "Canceled"
        }
    }
}



function op {
    param([string]$query = "")
    $selected = if ($query) { fd -t d $query D:\ | fzf } else { fd -t d D:\ | fzf }
    if ($selected) { windsurf $selected }  
}

function w {
    windsurf .
}

function e {
    explorer .
}

function nn {
    param(
        [string]$query = ""
    )

    # ถ้ามี query ให้ใส่ -i สำหรับ ignore case
    if ($query) {
        fd -t f $query | fzf | ForEach-Object { nvim $_ }
    } else {
        fd -t f | fzf | ForEach-Object { nvim $_ }
    }
}




function f {
    fd -t f | fzf | ForEach-Object { windsurf $_ }
}


function owindsurf_global_workflows {
    cd "C:\Users\Veerapong\.codeium\windsurf\global_workflows" | fd -t f | fzf | ForEach-Object { windsurf $_ }
}

function op {
    cd D:\ && fd -t d | fzf | ForEach-Object { windsurf $_ }
}



function cpath {
    $PWD.Path | Set-Clipboard
}



function openqoder {
     qoder .
}



function openwindsurf {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )

    if ($Arguments.Count -gt 0) {
        windsurf $Arguments
    } else {
        windsurf .
    }
}


function new-repo {
    $name = Read-Host "Enter repo name"
    gh repo create $name --public --clone
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
        open "https://github.com/newkub?tab=repositories"
    }
}

# --- Open Google ---
function g {
    open "https://www.google.com"
}

