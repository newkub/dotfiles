---
title: Setup Knip
description: Setup Knip for detecting unused files, dependencies, and exports
auto_execution_mode: 3
---

## Goal

ตั้งค่า Knip สำหรับตรวจสอบ unused files, dependencies และ exports

## Execute

### 1. Setup Knip

1. รัน `bun add -D knip`
2. สร้าง `.knip.json` ใน root directory
3. ตั้งค่า config options

### 2. Configure Package.json

1. เพิ่ม scripts สำหรับ Knip
2. ตั้งค่า flags ที่เหมาะสมกับโปรเจกต์

## Rules

- ใช้ Knip สำหรับตรวจสอบ unused files, dependencies และ exports
- รองรับ monorepos ด้วย workspace
- ระบุ entry points สำหรับทุก project
- กำหนด ignore patterns สำหรับ files และ dependencies

### 1. Knip Config

```json [.knip.json]
{
  "$schema": "https://unpkg.com/knip@latest/schema.json",
  "entry": ["apps/*/app.ts", "packages/*/src/index.ts"],
  "project": ["apps/*/package.json", "packages/*/package.json"],
  "ignore": [
    "**/*.config.*",
    "**/*.d.ts",
    "**/dist/**",
    "**/node_modules/**"
  ],
  "ignoreDependencies": [
    "@types/*",
    "typescript",
    "bun-types"
  ]
}
```

### 2. Package.json Scripts

```json [package.json]
{
  "scripts": {
    "knip": "knip",
    "knip:fix": "knip --fix"
  }
}
```

## Expected Outcome

- Knip config ตั้งค่าครบถ้วน
- Scripts สำหรับ Knip พร้อมใช้งาน
- Detect unused files, dependencies และ exports ได้
- Monorepo รองรับการตรวจสอบ
