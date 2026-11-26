# Daily dotfiles backup: checkpoint tracked files, secret-scan, push to
# github.com:newkub/dotfiles. Scheduled via Task Scheduler ("Dotfiles Daily Backup").
$ErrorActionPreference = 'Continue'
$logDir = Join-Path $env:LOCALAPPDATA 'dotfiles-backup'
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$log = Join-Path $logDir 'backup.log'
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:USERPROFILE\.local\bin;$env:PATH"

"===== Dotfiles backup $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') =====" | Tee-Object -FilePath $log -Append

# Rotate log at ~1 MB
if ((Test-Path $log) -and (Get-Item $log).Length -gt 1MB) {
    Move-Item $log "$log.old" -Force
}

& mise dot save 2>&1 | Tee-Object -FilePath $log -Append
if ($LASTEXITCODE -ne 0) {
    "[backup] FAILED: mise dot save exited $LASTEXITCODE" | Tee-Object -FilePath $log -Append
    exit $LASTEXITCODE
}

& mise run dotfiles:sync 2>&1 | Tee-Object -FilePath $log -Append
$code = $LASTEXITCODE
if ($code -eq 0) {
    "[backup] OK - synced to origin" | Tee-Object -FilePath $log -Append
} else {
    "[backup] FAILED: dotfiles:sync exited $code (gitleaks block or sync error - see log)" | Tee-Object -FilePath $log -Append
}
"===== Finished $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') =====`n" | Tee-Object -FilePath $log -Append
exit $code
