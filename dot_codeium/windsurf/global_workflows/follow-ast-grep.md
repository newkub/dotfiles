---
title: Follow Ast Grep
description: ตั้งค่าและใช้งาน ast-grep สำหรับ code search และ transformation ด้วย AST patterns
auto_execution_mode: 3
---

## Goal

ตั้งค่า ast-grep เป็นเครื่องมือสำหรับ code search, lint และ refactoring ด้วย AST-based patterns ที่แม่นยำกว่า regex

## Execute

### 1. Install Dependencies

ติดตั้ง ast-grep CLI ด้วย Bun

1. รัน `bun add -D @ast-grep/cli`
2. ตรวจสอบ installation สำเร็จ

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
2. สร้าง directory `rule-tests/` สำหรับ test cases
3. สร้าง directory `utils/` สำหรับ utility rules (ถ้าจำเป็น)

### 4. Add Scan Script

เพิ่ม script สำหรับการ scan code

1. เพิ่ม script ใน `package.json`:

```json
{
  "scripts": {
    "scan": "ast-grep scan -r"
  }
}
```

2. ตรวจสอบว่า script ถูกเพิ่มอย่างถูกต้อง

### 5. Verify Setup

ทดสอบการทำงานของ ast-grep

1. รัน `bun run scan`
2. ตรวจสอบว่า scan ทำงานได้ถูกต้อง

## Rules

### 1. Installation Rules

กฎการติดตั้ง ast-grep CLI

- ใช้ Bun เป็น package manager
- ติดตั้งเป็น dev dependency ด้วย `-D` flag
- ตรวจสอบ installation สำเร็จก่อนดำเนินการต่อ

### 2. Configuration Rules

กฎการตั้งค่า sgconfig.yml

- สร้าง `sgconfig.yml` ที่ root directory
- ตั้งค่า `ruleDirs` เป็น `rules`
- ตรวจสอบว่า config ถูกต้อง

### 3. Project Structure Rules

กฎการจัดโครงสร้าง project

- สร้าง `rules/` directory สำหรับเก็บ rules
- สร้าง `rule-tests/` directory สำหรับ test cases
- สร้าง `utils/` directory สำหรับ utility rules (ถ้าจำเป็น)

### 4. Script Rules

กฎการเพิ่ม scan script

- มี `scan` script ใน package.json
- ใช้คำสั่ง `ast-grep scan -r` สำหรับ scanning
- ตรวจสอบว่า script สามารถเรียกใช้ได้

## Expected Outcome

- ast-grep CLI ติดตั้งเรียบร้อย
- sgconfig.yml ตั้งค่าเรียบร้อยด้วย ruleDirs
- Project structure สร้างเรียบร้อย (rules/, rule-tests/, utils/)
- Scan script เพิ่มใน package.json
- ast-grep scan ทำงานได้ถูกต้อง
