# mise
mise activate pwsh | Out-String | Invoke-Expression



# starship
# https://starship.rs/advanced-config/#transientprompt-in-powershell


# https://carapace-sh.github.io/carapace-bin/setup.html
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

# Import-Module PSCompletions 
Invoke-Expression (&starship init powershell)

Invoke-Expression (& { (zoxide init powershell | Out-String) })


# Aide https://docs.aide.dev/troubleshooting/common-issues/#security-warning-run-only-scripts-that-you-trust-when-accessing-the-terminal
if ($env:TERM_PROGRAM -eq "aide") { . "$(aide --locate-shell-integration-path pwsh)" }

# terminal icons
# Import-Module -Name Terminal-Icons


# https://github.com/devblackops/Terminal-Icons
# Import-Module -Name Terminal-Icons

# ni antfu
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


#powertype
#Enable-PowerType
#Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView 



# inshellisense shell plugin 
#$__IsCommandFlag = ([Environment]::GetCommandLineArgs() | ForEach-Object { $_.contains("-Command") }) -contains $true
#$__IsNoExitFlag = ([Environment]::GetCommandLineArgs() | ForEach-Object { $_.contains("-NoExit") }) -contains $true
#$__IsInteractive = -not $__IsCommandFlag -or ($__IsCommandFlag -and $__IsNoExitFlag)
#if ([string]::IsNullOrEmpty($env:ISTERM) -and [Environment]::UserInteractive -and $__IsInteractive) {
#  is -s pwsh
#  Stop-Process -Id $pid
#}




function home {
    cd "C:\Users\Veerapong"
}
function appdata {
    cd "C:\Users\Veerapong\AppData"
}

function temp {
    cd "C:\\WINDOWS\\TEMP"
}


function local {
    cd "C:\Users\Veerapong\AppData\Local"
}

function newkub {
    cd "D:\newkub"
}


function downloads {
    cd "C:\Users\Veerapong\Downloads"
}


function .config {
    cd "C:\Users\Veerapong\.config"
}


