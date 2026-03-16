---
title: Watch Terminal
description: ตรวจสอบ process ที่กำลังรัน (windsurf, wezterm, code) และ watch terminal ไปเรื่อยๆ จนกว่าจะปิด
auto_execution_mode: 3

file-patterns:
  - "**/*.md"

follow:
  skills: []

  workflows:
    - "/run-dev"

  files: []

  mcp: []
---

## Purpose

ตรวจสอบว่ามีโปรแกรมที่เกี่ยวข้องกับการพัฒนา (windsurf, wezterm, code) กำลังรันอยู่หรือไม่ หากมีให้ watch terminal ต่อไปเรื่อยๆ ทุกๆ 5 วินาที
จนกว่าผู้ใช้จะปิดโปรแกรม แล้วจึงเริ่ม run-dev

## Steps

1. **ตรวจสอบ Process ที่กำลังรัน**

   รันคำสั่ง PowerShell เพื่อดูรายละเอียด process:

   ```powershell
   Get-Process windsurf,wezterm*,code -ErrorAction SilentlyContinue |
   Where-Object {$_.StartTime} |
   Sort-Object @{Expression={$_.MainWindowTitle -eq ""};Descending=$false},
                StartTime -Descending |
   Select-Object @{n="Process";e={$_.ProcessName}},
                @{n="PID";e={$_.Id}},
                @{n="Threads";e={$_.Threads.Count}},
                @{n="CPU_sec";e={"$([math]::Round($_.CPU,2)) s"}},
                @{n="RAM_MB";e={"$([math]::Round($_.WS/1MB,2)) MB"}},
                @{n="Handles";e={$_.HandleCount}},
                @{n="Priority";e={$_.BasePriority}},
                @{n="Responding";e={$_.Responding}},
                @{n="StartTime";e={$_.StartTime.ToString("HH:mm:ss")}},
                MainWindowTitle |
   Format-Table -AutoSize
   ```

2. **วิเคราะห์ผลลัพธ์**

   - ถ้าไม่มี process ใดๆ รันอยู่ → ข้ามไป step 6 (run-dev)
   - ถ้ามี process รันอยู่ → ไป step 3 (watch loop)

3. **เริ่ม Watch Loop**

   - แสดงสถานะ "Watching terminal... กด Ctrl+C เพื่อหยุด"
   - รอ 5 วินาที
   - ตรวจสอบ process อีกครั้ง

4. **ตรวจสอบ Process ซ้ำ**

   รันคำสั่งเดิมอีกครั้งเพื่อดูว่ายังมี process รันอยู่หรือไม่:

   ```powershell
   $processes = Get-Process windsurf,wezterm*,code -ErrorAction SilentlyContinue
   if ($processes) {
       # ยังมี process รันอยู่ → กลับไป step 3
   } else {
       # ไม่มี process แล้ว → ไป step 5
   }
   ```

5. **หยุด Watch**

   - แสดงข้อความ "All processes closed. Starting development server..."
   - รอ 1 วินาทีเพื่อให้แน่ใจว่า process ปิดสนิท

6. **/run-dev**

   - เริ่ม development server ด้วย workflow /run-dev

## Expected Outcome

- แสดงรายการ process ที่กำลังรันพร้อมรายละเอียดครบถ้วน
- Watch terminal ต่อเนื่องทุกๆ 5 วินาที จนกว่าผู้ใช้จะปิดโปรแกรมทั้งหมด
- เริ่ม run-dev อัตโนมัติเมื่อ process ทั้งหมดปิดแล้ว
- ไม่มีการข้ามขั้นตอนหรือเริ่ม run-dev ก่อนเวลา

## Reference

- `/run-dev` - รัน development server เมื่อ process ทั้งหมดปิดแล้ว
- [PowerShell Get-Process](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process) - Documentation สำหรับดู process information
- [Process Monitoring Best Practices](https://docs.microsoft.com/en-us/windows/win32/procthread/process-management) - Microsoft Windows Process Management
