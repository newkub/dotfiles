

# --- Starship Prompt ---
# https://starship.rs/
Invoke-Expression (&starship init powershell)

gh completion -s powershell | Out-String | Invoke-Expression

# --- Zoxide Navigation ---
# https://github.com/ajeetdsouza/zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })



# --- PowerToys CommandNotFound ---
# Shows suggestions from WinGet if a command is not found.
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
}

# --- x-cmd ---
# https://github.com/x-cmd/x
if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.

# --- IntelliShell ---
# https://intellishell.app/
$env:INTELLI_HOME = "C:\Users\Veerapong\AppData\Roaming\IntelliShell\Intelli-Shell\data"
if (Get-Command intelli-shell.exe -ErrorAction SilentlyContinue) {
    intelli-shell.exe init powershell | Out-String | Invoke-Expression
}



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
Remove-Item Alias:h
Remove-Item Alias:cd


# --- General Aliases ---

Set-Alias -Name c -Value cls
Remove-Item -Path Alias:dir -Force
Set-Alias -Name qoder-workflows -Value cdqoderworkflows
Set-Alias -Name new -Value New-Item
Set-Alias -Name nu -Value $env:USERPROFILE\scoop\apps\nu\current\nu.exe
Set-Alias -Name y -Value yazi
Set-Alias -Name n -Value nvim
Set-Alias -Name ai -Value stakpak
Set-Alias -Name v -Value bat



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
    ".config" = "$HOME\.config" # Alias for config
    "dotfiles" = "$HOME\.local\share\chezmoi"
    "temp" = "$env:TEMP"
    "windsurf-path" = "$HOME\.codeium\windsurf"
    "newkub" = "D:\newkub"
}

foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location '$($locationMap[$key])'"))
}

function dd {
    explorer "C:\Users\Veerapong\downloads"
}



function ep {
    explorer "C:\Users\Veerapong"
}


function b {
    broot
}


function cc {
    param(
        [string]$query = ""
    )

    $root = "D:\"

    # หา directories ด้วย fd จาก root
    $dirs = if ($query) {
        fd -t d $query $root
    } else {
        fd -t d . $root
    }

    # เลือก path ด้วย tv สวย ๆ
    $selected = $dirs | tv

    if ($selected) {
        Set-Location $selected
    }
}







# ==============================================================================
# >> CUSTOM UTILITY FUNCTIONS
# Helper functions for various tasks.
# ==============================================================================

# --- Directory Listing with eza ---
function dir {
    eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --hyperlink --all
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
function wr {
    ni && turbo watch 
}
function rr {
    ni && bun run review
}

function rf {
    ni && bun run format
}
function rc {
    ni && bun run typecheck
}

function h {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Files
    )

    if ($Files) {
        & hx.exe $Files
    } else {
        & hx.exe .
    }
}

function f {
    param(
        [string]$query = ""
    )

    # หา files ด้วย fd
    $files = if ($query) { fd -t f $query } else { fd -t f }

    # เลือก file ด้วย tv สวย ๆ
    $selected = $files | tv

    if ($selected) {
        windsurf $selected
    }
}




function owindsurfrules {
    $path = "C:\Users\Veerapong\.codeium\windsurf\memories\global_rules.md"

    windsurf $path
}

function opowershellprofile {
    $path = "C:\Users\Veerapong\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

    windsurf $path
}





function ff {
    param(
        [string]$query = ""
    )

    # หา directories ด้วย fd
    $dirs = if ($query) { fd -t d $query } else { fd -t d }

    # เลือก path ด้วย tv สวย ๆ
    $selected = $dirs | tv

    if ($selected) {
        windsurf $selected
    }
}





function cd {
    param(
        [string]$query = ""
    )

    if ($query) {
        Set-Location $query
    } else {
        # หา directories ด้วย fd
        $dirs = fd -t d

        # เลือก path ด้วย tv สวย ๆ
        $selected = $dirs | tv

        if ($selected) {
            Set-Location $selected
        }
    }
}

function cdd {
    param(
        [string]$query = ""
    )

    $root = "D:\"

    if ($query) {
        Set-Location "$root$query"
    } else {
        # หา directories ด้วย fd จาก drive D
        $dirs = fd -t d . $root

        # เลือก path ด้วย tv สวย ๆ
        $selected = $dirs | tv

        if ($selected) {
            Set-Location $selected
        }
    }
}





function rmi {
    param(
        [string]$query = ""
    )

    # เลือก directory ด้วย fd + tv (รวม dot folders ทั้งหมด)
    $dirs = if ($query) { fd -t d --hidden $query } else { fd -t d --hidden }
    $selected = $dirs | tv

    if ($selected) {
        # เลือกประเภทการลบ
        Write-Host "Select delete type:" -ForegroundColor Yellow
        Write-Host "1. Normal delete" -ForegroundColor Cyan
        Write-Host "2. Recursive delete" -ForegroundColor Cyan
        $choice = Read-Host "Enter choice (1 or 2)"
        if ($choice -eq '1') {
            # ยืนยันก่อนลบแบบปกติ
            Write-Host "Delete normally '$selected'? (y/n)" -ForegroundColor Red
            $confirm = Read-Host
            if ($confirm -eq 'y') {
                Remove-Item $selected
                Write-Host "Deleted: $selected" -ForegroundColor Green
            } else {
                Write-Host "Canceled" -ForegroundColor Gray
            }
        } elseif ($choice -eq '2') {
            # ยืนยันก่อนลบแบบ recursive
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
    param(
        [string]$action = ""
    )

    $notesDir = "C:\Users\Veerapong\Documents\notes"

    # สร้างโฟลเดอร์ถ้าไม่มี
    if (-not (Test-Path $notesDir)) {
        New-Item -ItemType Directory -Path $notesDir | Out-Null
    }

    if ($action -eq "new") {
        # สร้าง note ใหม่
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

        # สร้างไฟล์เปล่า
        New-Item -ItemType File -Path $fullPath | Out-Null
        Write-Host "Note created: $fullPath" -ForegroundColor Green

        # เปิดไฟล์ใน Windsurf ทันที
        windsurf $fullPath
    }
    else {
        # Search and open existing note
        $query = if ($action) { $action } else { "." }
        $selected = fd -t f $query $notesDir | tv
        if ($selected) {
            windsurf $selected
        }
    }
}


function w {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )

    if ($Arguments) {
        windsurf --reuse-window $Arguments
    } else {
        windsurf .
    }
}

function e {
    explorer .
}



function f {
    param(
        [string]$query = ""
    )

    # หา files ด้วย fd
    $files = if ($query) { fd -t f $query } else { fd -t f }

    # เลือก file ด้วย tv สวย ๆ
    $selected = $files | tv

    if ($selected) {
        windsurf $selected
    }
}




function cpath {
    $PWD.Path | Set-Clipboard
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



function g {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )

    if (-not $args) {
        Start-Process "https://www.google.com"
        return
    }

    # mapping search engines
    $engines = @{
        google = "https://www.google.com/search?q={0}"
        npm    = "https://www.npmjs.com/search?q={0}"
        github = "https://github.com/search?q={0}"
        youtube= "https://www.youtube.com/results?search_query={0}"
        chatgpt  = "https://chat.openai.com/?q={0}"
        crates  = "https://crates.io/search?q={0}"
    }

    # ตรวจสอบ engine ตัวแรก
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
# source ~/.wezterm.sh  # Unix command, disabled for PowerShell


function cpo {
    $last = Get-History -Count 1
    if (-not $last) {
        Write-Warning "No history found"
        return
    }

    $cmd = $last[0].CommandLine
    # ใช้ Out-String เพื่อดึง output แบบ plain text
    $output = Invoke-Expression $cmd | Out-String -Width 4096

    # เอา ANSI/escape codes ออก
    $plainOutput = $output -replace "`e\[[\d;]*m", ''

    # copy ไป clipboard
    $plainOutput.TrimEnd() | Set-Clipboard
    Write-Host "Last command output copied as plain text."
}

# --- Long Files Check ---
function loc {
    param(
        [int]$threshold = 200,
        [string]$path = "."
    )

    # Use fd with ignore to find files
    $files = fd -t f --ignore-vcs $path
    $longFiles = @()

    foreach ($file in $files) {
        try {
            $lineCount = (Get-Content $file -ErrorAction SilentlyContinue).Count
            if ($lineCount -gt $threshold) {
                $longFiles += [PSCustomObject]@{
                    Filename = $file
                    Lines = $lineCount
                }
            }
        }
        catch {
            # Skip files that can't be read
        }
    }

    if ($longFiles.Count -eq 0) {
        Write-Host "No files with more than $threshold lines found." -ForegroundColor Green
    }
    else {
        Write-Host "Files with more than $threshold lines:" -ForegroundColor Yellow
        # Display 2 columns: Filename and Line count
        $longFiles | Sort-Object Lines -Descending | Format-Table -AutoSize
    }
}


Remove-Item Alias:ni -Force -ErrorAction Ignore

Remove-Item Alias:ni -Force -ErrorAction Ignore
