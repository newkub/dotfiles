

# --- Starship Prompt ---
# https://starship.rs/
Invoke-Expression (&starship init powershell)

gh completion -s powershell | Out-String | Invoke-Expression

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
Remove-Item Alias:h


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

    # เลือก path ด้วย fzf สวย ๆ
    $selected = $dirs | fzf --height 40% --reverse --border --ansi --prompt "Dir> "

    if ($selected) {
        Set-Location $selected
    }
}



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
    ni && bun run check
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

    # เลือก file ด้วย fzf สวย ๆ
    $selected = $files | fzf --height 40% --reverse --border --ansi --prompt "File> "

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

    # เลือก path ด้วย fzf สวย ๆ
    $selected = $dirs | fzf --height 40% --reverse --border --ansi --prompt "Dir> "

    if ($selected) {
        windsurf $selected
    }
}





function zo {
    param(
        [string]$query = ""
    )

    $selected = if ($query) {
        zoxide query -ls $query | fzf
    } else {
        zoxide query -ls | fzf
    }

    if (-not $selected) { return }

    $path = $selected -replace '^\s*\S+\s+', ''
    if ($path) {
        Set-Location $path
    }
}

function cd {
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

    # เลือก path ด้วย fzf สวย ๆ
    $selected = $dirs | fzf --height 40% --reverse --border --ansi --prompt "Dir> "

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


function omd {
    param(
        [string]$query = "",
        [string]$path = "."  # default = current directory
    )

    # ตรวจสอบ path
    if (-not (Test-Path $path)) {
        Write-Host "Path not found: $path" -ForegroundColor Red
        return
    }

    # ค้นหาไฟล์ .md
    $searchQuery = if ($query) { $query } else { "." }
    $files = fd -t f -e md $searchQuery $path

    if (-not $files) {
        Write-Host "No .md files found in $path" -ForegroundColor Yellow
        return
    }

    # เลือกไฟล์ด้วย fzf (multi-select)
    $selected = $files | fzf -m
    if ($selected) {
        foreach ($f in $selected) {
            windsurf $f
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
        $selected = fd -t f $query $notesDir | fzf
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

    # เลือก file ด้วย fzf สวย ๆ
    $selected = $files | fzf --height 40% --reverse --border --ansi --prompt "File> "

    if ($selected) {
        windsurf $selected
    }
}


function owindsurf_global_workflows {
    cd "C:\Users\Veerapong\.codeium\windsurf\global_workflows" | fd -t f | fzf | ForEach-Object { windsurf $_ }
}

function op {
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

    # เลือก path ด้วย fzf สวย ๆ
    $selected = $dirs | fzf --height 40% --reverse --border --ansi --prompt "Dir> "

    if ($selected) {
        windsurf $selected
    }
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

function rmr {
    param(
        [string]$folder = "",
        [switch]$help,
        [switch]$scan
    )
    
    if ($help) {
        Write-Host @"
RMR - Remove Folders Recursively Tool

USAGE:
    rmr [options] [folder_name]

OPTIONS:
    --help       Show this help message
    --scan       Scan for duplicate folders and list them

EXAMPLES:
    rmr node_modules    # Remove all node_modules folders recursively
    rmr .git            # Remove all .git folders recursively
    rmr dist            # Remove all dist folders recursively
    rmr temp            # Remove all temp folders recursively
    rmr --scan          # Scan for duplicate folders and show statistics
    rmr --help          # Show this help message
"@ -ForegroundColor Green
        return
    }
    
    if ($scan) {
        Write-Host "Scanning for duplicate folders..." -ForegroundColor Yellow
        Write-Host ""
        
        # สแกนหาโฟลเดอร์ทั่วไปที่มักจะซ้ำกัน
        $commonFolders = @("node_modules", ".git", "dist", "build", "temp", "tmp", ".vscode", ".idea", "coverage", ".nyc_output", ".next", ".nuxt", ".output")
        
        $folderStats = @{}
        
        foreach ($folderName in $commonFolders) {
            try {
                $folders = Get-ChildItem -Directory -Recurse -Filter $folderName -ErrorAction SilentlyContinue
                if ($folders) {
                    $folderStats[$folderName] = $folders.Count
                    Write-Host "$folderName`: $($folders.Count) folders found" -ForegroundColor Cyan
                    
                    # แสดง path ของโฟลเดอร์เหล่านั้น (จำกัด 10 อันแรก)
                    $folders | Select-Object -First 10 | ForEach-Object {
                        Write-Host "  └─ $($_.FullName)" -ForegroundColor Gray
                    }
                    if ($folders.Count -gt 10) {
                        Write-Host "  └─ ... and $($folders.Count - 10) more" -ForegroundColor Gray
                    }
                    Write-Host ""
                }
            }
            catch {
                Write-Host "Warning: Could not scan some '$folderName' folders due to permissions" -ForegroundColor Yellow
            }
        }
        
        # สรุป
        $totalDuplicates = ($folderStats.Values | Measure-Object -Sum).Sum
        Write-Host "Summary: Found $totalDuplicates duplicate folders across $($folderStats.Count) types" -ForegroundColor Green
        
        if ($totalDuplicates -gt 0) {
            Write-Host ""
            Write-Host "To remove any of these folders, use:" -ForegroundColor Yellow
            $folderStats.Keys | ForEach-Object {
                Write-Host "  rmr $_" -ForegroundColor White
            }
        }
        
        return
    }
    
    if (-not $folder) {
        Write-Host "Use 'rmr --help' for usage information" -ForegroundColor Yellow
        return
    }
    
    $folders = Get-ChildItem -Directory -Recurse -Filter $folder -ErrorAction SilentlyContinue
    
    if (-not $folders) {
        Write-Host "No '$folder' folders found" -ForegroundColor Yellow
        return
    }
    
    Write-Host "Found $($folders.Count) '$folder' folders:" -ForegroundColor Cyan
    $folders | ForEach-Object {
        Write-Host "  $($_.FullName)" -ForegroundColor Gray
    }
    
    $confirm = Read-Host "`nDelete all $($folders.Count) '$folder' folders? (y/n)"
    if ($confirm -eq 'y') {
        $folders | Remove-Item -Recurse -Force
        Write-Host "Successfully removed $($folders.Count) '$folder' folders" -ForegroundColor Green
    } else {
        Write-Host "Cancelled" -ForegroundColor Yellow
    }
}