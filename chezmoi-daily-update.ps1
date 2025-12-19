$logFile = "$env:USERPROFILE\chezmoi-daily-update.log"

# เพิ่ม PATH ของ Scoop
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"

"===== Starting chezmoi daily update at $(Get-Date) =====" |
  Out-File -FilePath $logFile -Append

# รัน chezmoi re-add (sync HOME -> chezmoi source)
chezmoi re-add -v >> $logFile 2>&1

# ไปที่โฟลเดอร์ chezmoi repo
Set-Location "$env:USERPROFILE\.local\share\chezmoi"

# เช็กว่ามี diff ไหม
if (-not (git diff --quiet)) {
    "Changes detected, committing..." |
      Out-File -FilePath $logFile -Append

    git add -A >> $logFile 2>&1
    git commit -m "Daily update $(Get-Date -Format yyyy-MM-dd)" >> $logFile 2>&1
    git push >> $logFile 2>&1
}
else {
    "No changes detected, skip commit" |
      Out-File -FilePath $logFile -Append
}

"===== Finished at $(Get-Date) =====`n" |
  Out-File -FilePath $logFile -Append
