---
title: Browser Watch Workflow
description: เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
---

## Goal

เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ errors อัตโนมัติด้วย /fix-error

## Execute

### 1. Quick Open (Fast Mode)

1. เปิดเบราว์เซอร์ด้วย `agent-browser --headed open <url>`
2. ใช้ command chaining && สำหรับ operations ต่อเนื่อง
3. ถ้า daemon error ให้ใช้ browser-preview แทน

### 2. CLI Options Reference

| Flag | Description | Usage |
|------|-------------|-------|
| `--headed` | Show browser window | `agent-browser --headed open <url>` |
| `--session <name>` | Isolated session | `agent-browser --session mysession open <url>` |
| `--profile <path>` | Persistent profile | `agent-browser --profile ./data open <url>` |
| `--cdp <port>` | Connect via CDP | `agent-browser --cdp 9222 open <url>` |
| `--auto-connect` | Auto-discover Chrome | `agent-browser --auto-connect open <url>` |
| `--json` | JSON output | `agent-browser --json snapshot` |
| `--full` | Full screenshot | `agent-browser --full screenshot` |
| `--annotate` | Annotated screenshot | `agent-browser --annotate screenshot` |

### 3. Environment Variables

| Variable | Description |
|----------|-------------|
| `AGENT_BROWSER_HEADED` | Show browser window |
| `AGENT_BROWSER_SESSION` | Session name |
| `AGENT_BROWSER_PROFILE` | Profile path |
| `AGENT_BROWSER_CONFIG` | Config file path |

### 4. Error Handling

1. ถ้า daemon failed to start: ใช้ browser-preview แทน
2. ถ้า timeout: เพิ่ม --session-name หรือใช้ command chaining
3. ถ้า no Chrome found: ใช้ --auto-connect หรือ --cdp

## Rules

### 1. Browser Configuration

- ใช้ agent-browser เท่านั้นในการจัดการเบราว์เซอร์
- ใช้ --headed เพื่อเปิด browser แบบมองเห็นหน้าต่าง
- ใช้ environment variables สำหรับ configuration ที่ซ้ำซ้อน

### 2. Performance

- ใช้ command chaining && สำหรับ operations ต่อเนื่อง
- ใช้ --session สำหรับ isolated sessions
- ใช้ --profile สำหรับ persistent data

### 3. Error Handling

- เมื่อเจอ error ต้องเรียก /fix-error ทันที
- ถ้า daemon error ให้ใช้ browser-preview แทน

## Expected Outcome

1. Browser เปิดและ watch URL อย่างต่อเนื่อง
2. Console และ network requests ถูก monitor อย่างต่อเนื่อง
3. Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติ
4. การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ

