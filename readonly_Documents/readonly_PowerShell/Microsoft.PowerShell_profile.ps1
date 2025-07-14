

# Starship prompt
Invoke-Expression (&starship init powershell)

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound




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




# alias
$locationMap = @{
    "home" = "$HOME"
    "appdata" = "$HOME\AppData"
    "temp" = "$env:TEMP"
    "local" = "$HOME\AppData\Local"
    "d" = "D:\"
    "newkub" = "D:\newkub"
    "downloads" = "$HOME\Downloads"
    ".config" = "$HOME\.config"
    "nvim" = "$HOME\AppData\Local\nvim"
    "dotfiles" = "$HOME\.local\share\chezmoi"
    "docs" = "$HOME\Documents"
    "desktop" = "$HOME\Desktop"
    "config" = "$HOME\.config"
    "images" = "$HOME\Pictures"
    "videos" = "$HOME\Videos"
    "projects" = "$HOME\Projects"
    "scripts" = "$HOME\Documents\PowerShell"
}

foreach ($key in $locationMap.Keys) {
    Set-Item -Path "Function:$key" -Value ([ScriptBlock]::Create("Set-Location '$($locationMap[$key])'"))
}


# x-cmd
if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.
