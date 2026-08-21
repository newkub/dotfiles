$env:MISE_INSTALLS_DIR = 'D:\mise'
(&mise activate --shims pwsh) | Out-String | Invoke-Expression

$script:ProfileCacheDir = Join-Path $env:LOCALAPPDATA "pwsh-profile-cache"
if (-not (Test-Path $script:ProfileCacheDir)) {
    New-Item -ItemType Directory -Path $script:ProfileCacheDir -Force | Out-Null
}

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
        [string[]] $Arguments = @("init", "powershell"),
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
    # This prevents stale init scripts (e.g. starship) pointing to a moved install.
    $cached = Get-Content -Raw $cacheFile -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($cached)) {
        Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue
        Remove-Item $toolPathFile -Force -ErrorAction SilentlyContinue
        return $null
    }
    $exePaths = [regex]::Matches($cached, "[A-Za-z]:\\[^\s']+\.exe") | ForEach-Object { $_.Value }
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

function Invoke-Starship-PreCommand {
    $loc = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
    if ($loc -and $loc.Provider.Name -eq "FileSystem") {
        $esc = [char]27
        $path = $loc.ProviderPath -replace "\\", "/"
        $host.ui.Write("${esc}]7;file://${env:COMPUTERNAME}/${path}${esc}\")
    }
}

$script:StarshipInit = $null
$script:StarshipLoaded = $false

$script:ZoxideInit = $null
$script:ZoxideLoaded = $false
function global:__LoadZoxide {
    if ($script:ZoxideLoaded) { return }
    if (-not $script:ZoxideInit) { $script:ZoxideInit = Get-ProfileCachedInit -Name "zoxide" -Command "zoxide" }
    if ($script:ZoxideInit -and (Test-Path $script:ZoxideInit)) { . $script:ZoxideInit }
    if ($script:ZoxideInit) { $script:ZoxideLoaded = $true }
}
function global:z { __LoadZoxide; if (Test-Path Function:\__zoxide_z) { __zoxide_z @args } }
function global:zi { __LoadZoxide; if (Test-Path Function:\__zoxide_zi) { __zoxide_zi @args } }

if (Test-ProfileCachedCommand -Name "winget") {
    $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = {
        $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $null
        Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
    }
}

function global:prompt {
    if (-not $script:StarshipLoaded) {
        if (-not $script:StarshipInit) {
            $script:StarshipInit = Get-ProfileCachedInit -Name "starship-full" -Command "starship" -Arguments @("init", "powershell", "--print-full-init")
        }
        if ($script:StarshipInit) {
            . $script:StarshipInit
            $script:StarshipLoaded = $true
        }
    }
    & $Function:prompt @args
}

$script:PreviousOutputEncoding = [Console]::OutputEncoding
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
if ($script:PreviousOutputEncoding.CodePage -ne 65001) { chcp 65001 > $null }

if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -MaximumHistoryCount 30000 -HistoryNoDuplicate -HistorySearchCursorMovesToEnd -ErrorAction SilentlyContinue
    try { Set-PSReadLineOption -PredictionSource History } catch { }
}

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

$script:LazyFunctionsFile = "$env:USERPROFILE\Documents\PowerShell\profile-functions.ps1"
if (Test-Path $script:LazyFunctionsFile) { . $script:LazyFunctionsFile }
