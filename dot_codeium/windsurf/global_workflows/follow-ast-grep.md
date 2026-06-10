---
title: Follow Ast Grep
description: ตั้งค่าและใช้งาน ast-grep สำหรับ code search และ transformation ด้วย AST patterns
auto_execution_mode: 3
---

## Goal

ตั้งค่า ast-grep เป็นเครื่องมือสำหรับ code search, lint และ refactoring ด้วย AST-based patterns ที่แม่นยำกว่า regex

## Scope

ครอบคลุมการตั้งค่า ast-grep สำหรับ code search, linting, และ transformation ด้วย AST-based patterns

## Execute

### 1. Use ast-grep

ใช้ ast-grep ผ่าน bunx โดยไม่ต้องติดตั้ง

1. รัน `bunx ast-grep` สำหรับคำสั่งทั้งหมด
2. ไม่ต้องติดตั้ง @ast-grep/cli ใน package.json

### 2. Configure sgconfig.yml

สร้างไฟล์ configuration สำหรับ ast-grep

1. สร้างไฟล์ `sgconfig.yml` ที่ root directory ด้วยเนื้อหา:

```yaml
ruleDirs:
  - rules
```

2. ตรวจสอบว่า config ถูกต้อง

### 3. Setup Project Structure

สร้างโครงสร้าง project ตาม best practices

1. สร้าง directory `rules/` สำหรับเก็บ ast-grep rules

### 4. Add Scan Script

เพิ่ม script สำหรับการ scan code

1. เพิ่ม script ใน `package.json`:

```json
{
  "scripts": {
    "scan": "bunx ast-grep scan"
  }
}
```

2. ตรวจสอบว่า script ถูกเพิ่มอย่างถูกต้อง

### 5. Verify Setup

ทดสอบการทำงานของ ast-grep

1. รัน `bun run scan`
2. ตรวจสอบว่า scan ทำงานได้ถูกต้อง

## Rules

### 1. Usage Rules

กฎการใช้ ast-grep:

- ใช้ `bunx ast-grep` สำหรับคำสั่งทั้งหมด
- ไม่ต้องติดตั้ง @ast-grep/cli ใน package.json

### 2. Configuration Rules

กฎการตั้งค่า sgconfig.yml:

- สร้าง `sgconfig.yml` ที่ root directory
- ตั้งค่า `ruleDirs` เป็น `rules`
- ตรวจสอบว่า config ถูกต้อง

### 3. Project Structure Rules

กฎการจัดโครงสร้าง project:

- สร้าง `rules/` directory สำหรับเก็บ rules

### 4. Script Rules

กฎการเพิ่ม scan script:

- มี `scan` script ใน package.json
- ใช้คำสั่ง `bunx ast-grep scan` สำหรับ scanning
- ตรวจสอบว่า script สามารถเรียกใช้ได้

## Expected Outcome

- ast-grep ใช้งานผ่าน bunx สำเร็จ
- sgconfig.yml ตั้งค่าเรียบร้อยด้วย ruleDirs
- Project structure สร้างเรียบร้อย (rules/)
- Scan script เพิ่มใน package.json
- ast-grep scan ทำงานได้ถูกต้อง

