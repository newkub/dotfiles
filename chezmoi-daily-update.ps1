# chezmoi-daily-update.ps1
$logFile = "$env:USERPROFILE\chezmoi-daily-update.log"

# แก้ PATH ให้ Task / NoProfile เจอ chezmoi
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"

# Log เริ่ม
"Starting chezmoi re-add at $(Get-Date)" | Out-File -FilePath $logFile

# ตรวจสอบว่า chezmoi หาเจอหรือไม่
$cmd = Get-Command chezmoi -ErrorAction SilentlyContinue
if ($cmd) {
    "Found chezmoi at $($cmd.Source)" | Out-File -FilePath $logFile -Append
    chezmoi re-add *>> $logFile
} else {
    "chezmoi not found in PATH" | Out-File -FilePath $logFile -Append
}

"Finished at $(Get-Date)" | Out-File -FilePath $logFile -Append
