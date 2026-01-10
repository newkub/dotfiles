---
trigger: manual
---


1. ดู shell process ที่เปิดอยู่ล่าสุดใน 

```bash
Get-Process powershell, pwsh, cmd -ErrorAction SilentlyContinue |
Where-Object {
  $_.Responding -and
  $_.StartTime -gt (Get-Date).AddMinutes(-10)
} |
ForEach-Object {
  $cim = Get-CimInstance Win32_Process -Filter "ProcessId = $($_.Id)"
  [pscustomobject]@{
    Id                = $_.Id
    ProcessName       = $_.ProcessName
    StartTime         = $_.StartTime
    ParentProcessId   = $cim.ParentProcessId
    ParentProcessName = (Get-Process -Id $cim.ParentProcessId -ErrorAction SilentlyContinue).ProcessName
  }
} |
Sort-Object StartTime -Descending |
Format-Table -AutoSize
```

2. watch teminal แล้วแก้ไข error, warning หรือปรับปรุง uxui ให้ดีขึ้น

หมายเหตุ 
- program กำลังทำงาน รอสักหน่อยมากสุด 30 วินาที 
- ห้ามรัน task ใหม่จนกว่าจะแก้ไขทั้งหมดแล้ว
