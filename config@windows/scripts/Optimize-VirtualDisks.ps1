[CmdletBinding()]
param(
    [string[]]$Roots = @('C:\', 'D:\'),

    [switch]$Optimize,

    [string]$ReportPath = "$env:USERPROFILE\Desktop\vhd-scan.csv",

    [switch]$NoElevate
)

$ErrorActionPreference = 'Continue'

function Test-IsAdmin {
    ([Security.Principal.WindowsPrincipal]::new(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    )).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function ConvertTo-Argument([string]$Value) {
    if ($Value -notmatch '[\s"]') {
        return $Value
    }

    $escaped = $Value -replace '(\\*)"', '$1$1\"'

    if ($escaped.EndsWith('\')) {
        $escaped += '\'
    }

    return '"' + $escaped + '"'
}

function Exit-Script([int]$Code = 0) {
    if ($NoElevate) {
        Stop-Transcript -ErrorAction SilentlyContinue | Out-Null
        Read-Host 'Press Enter to close this elevated window' | Out-Null
    }

    exit $Code
}

if ($Optimize -and -not $NoElevate -and -not (Test-IsAdmin)) {
    $elevatedArgs = @(
        '-NoProfile'
        '-ExecutionPolicy', 'Bypass'
        '-File', (ConvertTo-Argument $PSCommandPath)
        '-Roots'
    ) + @($Roots | ForEach-Object { ConvertTo-Argument $_ }) + @(
        '-Optimize'
        '-NoElevate'
        '-ReportPath', (ConvertTo-Argument $ReportPath)
    )

    Write-Host 'Administrator rights are required. Opening an elevated PowerShell...' -ForegroundColor Yellow
    Write-Host 'Confirm the UAC prompt to continue.'

    $pwshPath = (Get-Process -Id $PID).Path
    Write-Host "Launcher: $pwshPath"

    try {
        $proc = Start-Process -FilePath $pwshPath `
            -Verb RunAs -ArgumentList ($elevatedArgs -join ' ') `
            -Wait -PassThru -ErrorAction Stop
    } catch {
        Write-Host ("Elevation failed: " + $_.Exception.Message) -ForegroundColor Red
        exit 1
    }

    exit $proc.ExitCode
}

if ($Optimize) {
    if ($NoElevate) {
        Start-Transcript -Path (Join-Path $env:TEMP 'vhd-optimize-elevated.log') -Force | Out-Null
        Write-Host "Elevated child: PID=$PID Admin=$(Test-IsAdmin)"
    }

    # Close WSL before scanning for candidates.
    wsl --shutdown
}

$skip = @(
    '$Recycle.Bin',
    'System Volume Information',
    'Windows',
    'Program Files',
    'Program Files (x86)'
)

$found = foreach ($root in $Roots) {
    if (-not (Test-Path -LiteralPath $root)) {
        Write-Warning "Root not found: $root"
        continue
    }

    Write-Host "Scanning $root ..." -ForegroundColor Cyan

    Get-ChildItem -LiteralPath $root -File -Recurse -Force `
        -ErrorAction SilentlyContinue |
        Where-Object {
            $file = $_
            $relative = $file.FullName.Substring($root.Length)

            $file.Extension -in '.vhd', '.vhdx' -and
            -not ($skip | Where-Object {
                $relative -match (
                    '(^|\\)' + [regex]::Escape($_) + '(\\|$)'
                )
            })
        } |
        Select-Object FullName, Length, LastWriteTime
}

$found = @($found | Sort-Object FullName -Unique)

if (-not $found.Count) {
    Write-Host 'No VHD/VHDX files found.'
    Exit-Script
}

$results = @(
    for ($i = 0; $i -lt $found.Count; $i++) {
        [pscustomobject]@{
            Number = $i + 1
            Path = $found[$i].FullName
            SizeGB = [math]::Round($found[$i].Length / 1GB, 2)
            LastModified = $found[$i].LastWriteTime
            Status = 'Scanned'
        }
    }
)

$results | Format-Table -AutoSize
$results | Export-Csv -LiteralPath $ReportPath `
    -NoTypeInformation -Encoding utf8

Write-Host "Report: $ReportPath"

if (-not $Optimize) {
    Exit-Script
}

Write-Host ''
Write-Host 'Select a disk number to compact. Enter 0 to cancel.'
$selection = Read-Host 'Disk number'

if ($selection -notmatch '^\d+$') {
    throw 'Invalid selection.'
}

$number = [int]$selection

if ($number -eq 0) {
    Write-Host 'Cancelled.'
    Exit-Script
}

if ($number -gt $found.Count) {
    throw 'Disk number out of range.'
}

$target = $found[$number - 1].FullName

Write-Host "Selected: $target" -ForegroundColor Yellow
Write-Host 'Ensure this disk is detached and not in use.'
Write-Host 'Compact can change the virtual disk file on disk.'

$confirm = Read-Host 'Type COMPACT to continue'

if ($confirm -cne 'COMPACT') {
    Write-Host 'Cancelled.'
    Exit-Script
}

# DiskPart performs the actual compaction.
$dp = @(
    "select vdisk file=`"$target`""
    'detail vdisk'
    'compact vdisk'
    'exit'
)

$dpFile = Join-Path $env:TEMP (
    'compact-vhd-' + [guid]::NewGuid().ToString('N') + '.txt'
)

try {
    $dp | Set-Content -LiteralPath $dpFile -Encoding ascii
    & diskpart /s $dpFile

    if ($LASTEXITCODE -ne 0) {
        throw "DiskPart failed with exit code $LASTEXITCODE"
    }
} finally {
    Remove-Item -LiteralPath $dpFile -Force -ErrorAction SilentlyContinue
}

Write-Host 'DiskPart finished. Verify the output and resulting file size.'
Exit-Script
