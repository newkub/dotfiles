---
title: Follow Dprint
description: ตั้งค่าและใช้งาน dprint สำหรับ formatting code หลายภาษาด้วย pluggable architecture
auto_execution_mode: 3
file-patterns:
  - "dprint.json"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า dprint เป็น code formatter ที่รองรับหลายภาษา (TypeScript, JavaScript, Rust, Markdown, etc.) ด้วย pluggable architecture

## Scope

- ติดตั้ง dprint CLI
- กำหนดค่า `dprint.json`
- เพิ่ม format scripts ใน `package.json`
- รองรับหลาย file types

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Languages | TS, JS, Rust, JSON, Markdown |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | `bun add -D dprint` |
| **Config** | ดาวน์โหลด config จาก reference repository |
| **Plugins** | ระบุ plugins สำหรับแต่ละภาษา |
| **Excludes** | กำหนด files ที่ไม่ต้อง format |

## Structure

### Directory Structure

```text
project/
├── dprint.json           # Dprint configuration
├── package.json          # Format scripts
└── src/
    └── *.ts              # Source files
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add dprint |
| Configure | กำหนดค่า | Download config |
| Script | เพิ่ม scripts | package.json |
| Verify | ทดสอบ | Run format |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Dprint**
  - รัน `bun add -D dprint`
  - ตรวจสอบ installation สำเร็จ

### Phase 2: Configure

- 2.1 **ดาวน์โหลด Config**
  - รัน `gh download https://github.com/newkub/my-config/blob/main/dprint.json`
  - หรือสร้าง `dprint.json` พื้นฐาน:

```json [dprint.json]
{
  "typescript": {
    "indentWidth": 2,
    "lineWidth": 100,
    "semiColons": "asi",
    "quoteStyle": "alwaysSingle"
  },
  "json": {
    "indentWidth": 2
  },
  "markdown": {
    "textWrap": "always"
  },
  "includes": [
    "**/*.{ts,tsx,js,jsx,json,md,rs}"
  ],
  "excludes": [
    "**/node_modules",
    "**/dist",
    "**/.git"
  ],
  "plugins": [
    "https://plugins.dprint.dev/typescript-0.88.1.wasm",
    "https://plugins.dprint.dev/json-0.19.1.wasm",
    "https://plugins.dprint.dev/markdown-0.16.3.wasm",
    "https://plugins.dprint.dev/rustfmt-0.6.2.wasm"
  ]
}
```

### Phase 3: Script

- 3.1 **เพิ่ม Format Script**
  - เพิ่มใน `package.json`:

```json [package.json]
{
  "scripts": {
    "format": "dprint fmt",
    "format:check": "dprint check"
  }
}
```

### Phase 4: Verify

- 4.1 **ทดสอบการทำงาน**
  - รัน `bun run format`
  - รัน `bun run format:check`
  - ตรวจสอบว่า format ทำงานได้ถูกต้อง

## Outputs

| Output | Details |
|--------|-----------|
| dprint.json | Dprint configuration |
| Updated package.json | Format scripts |
| Formatted files | All included files |

## Expected Outcome

- Dprint ติดตั้งและทำงานได้
- Config กำหนดค่าถูกต้อง
- Format scripts พร้อมใช้งาน
- รองรับหลาย file types

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows
