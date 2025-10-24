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

[Environment]::SetEnvironmentVariable("CLAUDE_CODE_GIT_BASH_PATH", "C:\Users\Veerapong\scoop\shims\git.exe", "User")



# alias
$locationMap = @{
    "home" = "$HOME"
    "appdata" = "$HOME\AppData"
    "temp" = "$env:TEMP"
    "local" = "$HOME\AppData\Local"
    "windsurf-path" = "$HOME\.codeium\windsurf"
    "d" = "D:\"
    "newkub" = "D:\newkub"
    "downloads" = "$HOME\Downloads"
    ".config" = "$HOME\.config"
    "dotfiles" = "$HOME\.local\share\chezmoi"
    "docs" = "$HOME\Documents"
    "bb" = "nr build"
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




# alias
Set-Alias -Name b -Value broot
Set-Alias -Name new new-Item
Set-Alias -Name y -Value yazi
Set-Alias -Name w -Value windsurf
Set-Alias -Name nu -Value $env:USERPROFILE\scoop\apps\nu\current\nu.exe


# x-cmd
if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.


# x-cmd
if (Test-Path "$Home\.x-cmd.root\local\data\pwsh\_index.ps1") { Set-ExecutionPolicy Bypass -Scope Process; . "$Home\.x-cmd.root\local\data\pwsh\_index.ps1" };  # boot up x-cmd.

