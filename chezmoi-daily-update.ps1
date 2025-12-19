$logFile = "$env:USERPROFILE\chezmoi-daily-update.log"

# เพิ่ม PATH ของ Scoop
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"

"===== Starting chezmoi daily update at $(Get-Date) =====" |
  Tee-Object -FilePath $logFile -Append

# รัน chezmoi re-add
chezmoi re-add -v 2>&1 |
  Tee-Object -FilePath $logFile -Append

# ไปที่โฟลเดอร์ chezmoi repo
Set-Location "$env:USERPROFILE\.local\share\chezmoi"

# เช็ก diff
if (-not (git diff --quiet)) {
    "Changes detected, committing..." |
      Tee-Object -FilePath $logFile -Append

    git add -A 2>&1 | Tee-Object -FilePath $logFile -Append
    git commit -m "Daily update $(Get-Date -Format yyyy-MM-dd)" 2>&1 |
      Tee-Object -FilePath $logFile -Append
    git push 2>&1 | Tee-Object -FilePath $logFile -Append
}
else {
    "No changes detected, skip commit" |
      Tee-Object -FilePath $logFile -Append
}

"===== Finished at $(Get-Date) =====`n" |
  Tee-Object -FilePath $logFile -Append
