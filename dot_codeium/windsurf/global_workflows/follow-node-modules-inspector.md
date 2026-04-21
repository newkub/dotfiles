---
title: Setup Node Modules Inspector
description: Setup Node Modules Inspector for interactive node modules inspection
auto_execution_mode: 3
---

## Goal

ตั้งค่า Node Modules Inspector สำหรับ inspection และ debugging node modules แบบ interactive

## Execute

### 1. Setup Node Modules Inspector

1. รัน `bunx node-modules-inspector` ใน project root
2. สร้าง `node-modules-inspector.config.ts` หากจำเป็น
3. ตั้งค่า config options

## Rules

- ใช้ Node Modules Inspector สำหรับ inspection และ debugging node modules
- รองรับ pnpm, npm, และ bun
- ใช้ bunx สำหรับรันโดยไม่ต้องติดตั้ง

```bash [command]
bunx node-modules-inspector
```

## Expected Outcome

- Node Modules Inspector ตั้งค่าเรียบร้อย
- Interactive UI สำหรับ node modules inspection พร้อมใช้ง
