$logFile = "$env:USERPROFILE\chezmoi-daily-update.log"

# เพิ่ม PATH ของ Scoop
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"

"Starting chezmoi re-add at $(Get-Date)" | Out-File $logFile

# รัน chezmoi re-add แบบ verbose
chezmoi re-add -v *>> $logFile

# ไปที่โฟลเดอร์ chezmoi repo
Set-Location "$env:USERPROFILE\.local\share\chezmoi"  # ปรับ path ตามเครื่องคุณ

# add all changes (รวม empty commit)
git add -A

# commit - ถ้าไม่มี change ให้ force empty commit
git commit -m "Daily update $(Get-Date -Format yyyy-MM-dd)" --allow-empty *>> $logFile

# push ขึ้น GitHub
git push *>> $logFile

"Finished at $(Get-Date)" | Out-File -FilePath $logFile -Append
