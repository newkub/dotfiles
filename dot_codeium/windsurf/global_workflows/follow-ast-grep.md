---
title: Follow Ast Grep
description: ตั้งค่าและใช้งาน ast-grep สำหรับ code search และ transformation ด้วย AST patterns
auto_execution_mode: 3
file-patterns:
  - "sgconfig.yml"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า ast-grep เป็นเครื่องมือสำหรับ code search, lint และ refactoring ด้วย AST-based patterns ที่แม่นยำกว่า regex

## Scope

- ติดตั้ง ast-grep CLI
- กำหนดค่า `sgconfig.yml`
- เพิ่ม rules submodule สำหรับ patterns
- เพิ่ม scan script ใน `package.json`

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Git | ต้องมี git สำหรับ submodule |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | `bun add -D @ast-grep/cli` |
| **Config** | สร้าง `sgconfig.yml` ที่ root |
| **Rules** | ใช้ git submodule สำหรับ shared rules |
| **Script** | มี `scan` script ใน package.json |

## Structure

### Directory Structure

```text
project/
├── sgconfig.yml          # Ast-grep config
├── package.json          # Scan script
└── rules/                # Git submodule
    └── (shared patterns)
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add ast-grep CLI |
| Configure | สร้าง config | sgconfig.yml |
| Rules | เพิ่ม rules | Git submodule |
| Verify | ทดสอบ | Run scan |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี git และ github CLI
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Ast Grep**
  - รัน `bun add -D @ast-grep/cli`
  - ตรวจสอบ installation สำเร็จ

### Phase 2: Configure

- 2.1 **สร้าง sgconfig.yml**
  - ดาวน์โหลด config:
  - `gh download https://github.com/newkub/my-config/blob/main/sgconfig.yml`
  - หรือสร้าง `sgconfig.yml` พื้นฐาน

- 2.2 **เพิ่ม Rules Submodule**
  - รัน `git submodule add https://github.com/newkub/rules`
  - อัปเดต submodule: `git submodule update --init`

### Phase 3: Script

- 3.1 **เพิ่ม Scan Script**
  - เพิ่มใน `package.json`:

```json [package.json]
{
  "scripts": {
    "scan": "ast-grep scan -r"
  }
}
```

### Phase 4: Verify

- 4.1 **ทดสอบการทำงาน**
  - รัน `bun run scan`
  - ตรวจสอบว่า scan ทำงานได้ถูกต้อง

## Outputs

| Output | Details |
|--------|-----------|
| sgconfig.yml | Ast-grep configuration |
| rules/ submodule | Shared rule patterns |
| Updated package.json | Scan script |

## Expected Outcome

- Ast-grep ติดตั้งและทำงานได้
- Config สามารถ scan code ได้
- Rules submodule พร้อมใช้งาน
- Scan script ทำงานได้ถูกต้อง

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows ที่เกี่ยวข้อง
