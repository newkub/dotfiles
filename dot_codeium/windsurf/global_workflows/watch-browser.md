---
title: Watch Browser Loop
description: ใช้ agent-browser (จาก vercel-labs) เพื่อ watch และ interact กับ browser สำหรับ AI automation ในรูปแบบ loop ต่อเนื่อง สลับกับ watch-terminal
auto_execution_mode: 3

file-patterns:
  - "**/*.md"

follow:
  skills: []

  workflows:
    - "/watch-terminal"
    - "/learn-from-web"

  files: []

  mcp: []
---

## Purpose

สร้างระบบ watch แบบ loop ต่อเนื่องระหว่าง terminal และ browser:

1. **Watch Terminal** - ตรวจสอบ process (windsurf, wezterm, code) ทุก 5 วินาที
2. **Fix Errors** - ถ้าเจอ error ให้แก้ไขก่อนดำเนินการต่อ
3. **Watch Browser** - ใช้ agent-browser สำหรับ AI automation และ web interaction
4. **Loop Continuously** - ทำงานต่อเนื่องไม่มีหยุด สลับกันไปมา

## Prerequisites

1. **ติดตั้ง agent-browser**

   ```bash
   npm install -g agent-browser
   # หรือ
   npx agent-browser
   ```

2. **ตรวจสอบว่า Chrome/Chromium ติดตั้งแล้ว**

   agent-browser ต้องการ Chrome หรือ Chromium ที่ติดตั้งในเครื่อง

3. **PowerShell Environment**

   สำหรับการตรวจสอบ process บน Windows

## Steps

### Phase 1: Terminal Watch Loop

1. **เริ่มต้นด้วย Watch Terminal**

   รันคำสั่ง PowerShell เพื่อตรวจสอบ process:

   ```powershell
   # ฟังก์ชันตรวจสอบ process
   function Watch-DevProcesses {
       param([int]$Interval = 5)

       Write-Host "Starting terminal watch... กด Ctrl+C เพื่อหยุด" -ForegroundColor Green

       while ($true) {
           Clear-Host
           Write-Host "=== Terminal Watch - $(Get-Date -Format 'HH:mm:ss') ===" -ForegroundColor Cyan

           $processes = Get-Process windsurf,wezterm*,code -ErrorAction SilentlyContinue |
                       Where-Object {$_.StartTime} |
                       Sort-Object @{Expression={$_.MainWindowTitle -eq ""};Descending=$false},
                                    StartTime -Descending

           if ($processes) {
               $processes | Select-Object @{n="Process";e={$_.ProcessName}},
                                      @{n="PID";e={$_.Id}},
                                      @{n="Threads";e={$_.Threads.Count}},
                                      @{n="CPU_sec";e={"$([math]::Round($_.CPU,2)) s"}},
                                      @{n="RAM_MB";e={"$([math]::Round($_.WS/1MB,2)) MB"}},
                                      @{n="Responding";e={$_.Responding}},
                                      @{n="StartTime";e={$_.StartTime.ToString("HH:mm:ss")}},
                                      MainWindowTitle | Format-Table -AutoSize

               Write-Host "Processes found. Continuing watch..." -ForegroundColor Yellow
           } else {
               Write-Host "No development processes found. Ready for browser watch." -ForegroundColor Green
               break
           }

           Write-Host "Next check in $Interval seconds..." -ForegroundColor Gray
           Start-Sleep -Seconds $Interval
       }
   }

   # เรียกใช้งาน
   Watch-DevProcesses
   ```

2. **ตรวจสอบและแก้ไข Errors**

   ถ้าเจอ error ให้ตรวจสอบ:
   - Process ค้าง → ปิดด้วย `Stop-Process -Name <process_name>`
   - Memory สูง → restart process
   - Application not responding → force restart

### Phase 2: Browser Watch Loop

3. **เริ่ม Browser Session**

   ```bash
   # สร้าง session ใหม่
   agent-browser session --new automation
   export AGENT_BROWSER_NATIVE=1
   ```

4. **Watch Loop แบบต่อเนื่อง**

   ```bash
   # ฟังก์ชัน watch browser แบบ loop
   function Watch-Browser() {
       local url="${1:-https://example.com}"
       local interval=10

       echo "Starting browser watch for: $url"

       while true; do
           echo "=== Browser Watch - $(date '+%H:%M:%S') ==="

           # เปิด/refresh เว็บไซต์
           agent-browser open "$url" --allowed-domains="$(echo $url | sed 's|https://||' | cut -d'/' -f1)"

           # สร้าง snapshot
           echo "Creating snapshot..."
           agent-browser snapshot -i --max-output=3000

           # ตรวจสอบว่ามี interactive elements หรือไม่
           echo "Checking for changes..."

           echo "Next check in $interval seconds... (Ctrl+C to stop)"
           sleep $interval
       done
   }

   # เรียกใช้งาน
   Watch-Browser "https://example.com"
   ```

### Phase 3: Combined Loop System

5. **Master Loop - สลับระหว่าง Terminal และ Browser**

   ```powershell
   # Master script สำหรับการทำงานต่อเนื่อง
   function Start-ContinuousWatch {
       param(
           [string]$BrowserUrl = "https://example.com",
           [int]$TerminalInterval = 5,
           [int]$BrowserInterval = 10
       )

       Write-Host "=== Continuous Watch System Started ===" -ForegroundColor Green
       Write-Host "Terminal Interval: $TerminalInterval sec" -ForegroundColor Cyan
       Write-Host "Browser Interval: $BrowserInterval sec" -ForegroundColor Cyan
       Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow

       $watchMode = "terminal"  # เริ่มจาก terminal

       while ($true) {
           if ($watchMode -eq "terminal") {
               Write-Host "\n=== TERMINAL WATCH MODE ===" -ForegroundColor Magenta

               # Terminal watch logic
               $processes = Get-Process windsurf,wezterm*,code -ErrorAction SilentlyContinue

               if ($processes) {
                   Write-Host "Development processes detected:" -ForegroundColor Yellow
                   $processes | Select-Object ProcessName, Id, @{n="RAM_MB";e={[math]::Round($_.WS/1MB,2)}} | Format-Table

                   # ถ้ามี error ให้แก้ไข
                   $hungProcesses = $processes | Where-Object {-not $_.Responding}
                   if ($hungProcesses) {
                       Write-Host "Found hung processes. Fixing..." -ForegroundColor Red
                       $hungProcesses | Stop-Process -Force
                       Write-Host "Hung processes terminated." -ForegroundColor Green
                   }

                   Write-Host "Terminal watch complete. Switching to browser..." -ForegroundColor Cyan
                   $watchMode = "browser"
               } else {
                   Write-Host "No development processes. Ready for browser automation." -ForegroundColor Green
                   $watchMode = "browser"
               }

               Start-Sleep -Seconds $TerminalInterval

           } else {
               Write-Host "\n=== BROWSER WATCH MODE ===" -ForegroundColor Blue

               # Browser watch logic (call bash script)
               $bashScript = @"

## !/bin/bash

export AGENT_BROWSER_NATIVE=1
echo "Browser automation: $BrowserUrl"
agent-browser open "$BrowserUrl"
agent-browser snapshot -i --max-output=2000
echo "Browser watch complete"
"@

               $bashScript | bash

               Write-Host "Browser watch complete. Switching to terminal..." -ForegroundColor Cyan
               $watchMode = "terminal"

               Start-Sleep -Seconds $BrowserInterval
           }

           Write-Host "Loop iteration completed. Continuing..." -ForegroundColor Gray
       }
   }

## เริ่มระบบ

   Start-ContinuousWatch -BrowserUrl "<https://example.com>" -TerminalInterval 5 -BrowserInterval 10

   ```text

### Phase 4: Error Handling & Recovery

6. **Error Detection and Recovery**

   ```powershell
   function Test-SystemHealth {
       $errors = @()

       # ตรวจสอบ CPU usage
       $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' -ErrorAction SilentlyContinue
       if ($cpuUsage.CounterSamples.CookedValue -gt 80) {
           $errors += "High CPU usage: $($cpuUsage.CounterSamples.CookedValue)%"
       }

       # ตรวจสอบ Memory
       $memory = Get-Counter '\Memory\Available MBytes' -ErrorAction SilentlyContinue
       if ($memory.CounterSamples.CookedValue -lt 1000) {
           $errors += "Low memory: $($memory.CounterSamples.CookedValue)MB available"
       }

       # ตรวจสอบ agent-browser
       try {
           $null = Get-Command agent-browser -ErrorAction Stop
       } catch {
           $errors += "agent-browser not installed or not in PATH"
       }

       if ($errors.Count -gt 0) {
           Write-Host "System issues detected:" -ForegroundColor Red
           $errors | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
           return $false
       }

       return $true
   }
   ```

7. **Usage Examples**

   **Basic Usage:**

   ```powershell
   # เริ่มด้วย terminal watch
   . \global_workflows\watch-browser.md
   ```

   **Custom URL:**

   ```powershell
   Start-ContinuousWatch -BrowserUrl "https://github.com/vercel-labs/agent-browser"
   ```

   **Fast Mode:**

   ```powershell
   Start-ContinuousWatch -TerminalInterval 2 -BrowserInterval 5
   ```

### Expected Outcome

- **Continuous Loop System** - ทำงานต่อเนื่องไม่มีหยุด สลับระหว่าง terminal และ browser watch
- **Error Recovery** - ตรวจจับและแก้ไขปัญหาอัตโนมัติ (hung processes, high CPU/memory)
- **Flexible Intervals** - ปรับเวลาในการ watch ได้ตามต้องการ
- **Session Persistence** - Browser sessions คงอยู่ระหว่าง loop
- **Health Monitoring** - ตรวจสอบสถานะระบบก่อนดำเนินการ

### Integration with Workflows

- **[/watch-terminal](watch-terminal.md)** - ใช้สำหรับตรวจสอบ process ก่อน browser automation
- **[/learn-from-web](learn-from-web.md)** - ใช้สำหรับการเรียนรู้และเก็บข้อมูลจากเว็บไซต์

### Troubleshooting

| Issue | Solution |
|-------|----------|
| agent-browser not found | `npm install -g agent-browser` หรือใช้ `npx` |
| Chrome not installed | Install Chrome/Chromium หรือใช้ headless mode |
| High CPU usage | ลด interval หรือใช้ native mode `AGENT_BROWSER_NATIVE=1` |
| Process hangs | รัน `Test-SystemHealth` และปิด process ที่ไม่ตอบสนอง |
| Session timeout | ใช้ `agent-browser session --new` สร้าง session ใหม่ |

### Reference

- [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) -
  Official repository สำหรับ headless browser automation CLI
- `agent-browser --help` - ดูคำสั่งทั้งหมดที่รองรับ
- [Agent Browser Documentation](https://github.com/vercel-labs/agent-browser/tree/main/docs) - Full documentation สำหรับการใช้งานทั้งหมด
- [Agent Browser Skill](https://github.com/vercel-labs/agent-browser/blob/main/skills/agent-browser/SKILL.md) - Skill documentation สำหรับ AI agents
- Chrome DevTools Protocol (CDP) - Protocol ที่ใช้สื่อสารกับ browser ใน native mode
- Playwright - Browser automation library ที่ใช้ใน Node.js daemon mode
