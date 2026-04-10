---
title: Follow Ast Grep
description: ตั้งค่าและใช้งาน ast-grep สำหรับ code search และ transformation ด้วย AST patterns
auto_execution_mode: 3
---

ตั้งค่า ast-grep เป็นเครื่องมือสำหรับ code search, lint และ refactoring ด้วย AST-based patterns ที่แม่นยำกว่า regex

## Execute

### 1. Check Reference

ตรวจสอบ reference ก่อนเริ่มตั้งค่า ast-grep

1. รัน `/check-reference` เพื่อตรวจสอบ reference จาก sources ต่างๆ
2. อ่าน reference จาก ast-grep official documentation
3. ตรวจสอบว่ามีข้อมูลเพียงพอสำหรับตั้งค่า ast-grep
4. บันทึกข้อมูลสำคัญจาก reference ที่จะใช้ใน workflow

### 2. Install Dependencies

ติดตั้ง ast-grep CLI ด้วย Bun

1. รัน `bun add -D @ast-grep/cli`
2. ตรวจสอบ installation สำเร็จ
3. ตรวจสอบว่ามี Bun ติดตั้งแล้ว
4. ตรวจสอบว่ามี git และ github CLI
5. ตรวจสอบว่ามี `package.json` อยู่แล้ว

### 3. Configure sgconfig.yml

สร้างไฟล์ configuration สำหรับ ast-grep

1. ดาวน์โหลด config จาก:
   - `gh download https://github.com/newkub/my-config/blob/main/sgconfig.yml`
   - หรือสร้าง `sgconfig.yml` พื้นฐาน
2. สร้างไฟล์ `sgconfig.yml` ที่ root directory
3. ตรวจสอบว่า config ถูกต้องตามความต้องการ

### 4. Add Rules Submodule

เพิ่ม git submodule สำหรับ shared rule patterns

1. รัน `git submodule add https://github.com/newkub/ast-grep-rules`
2. อัปเดต submodule: `git submodule update --init`
3. ตรวจสอบว่า rules/ directory ถูกสร้างขึ้น
4. ตรวจสอบว่า submodule พร้อมใช้งาน

### 5. Add Scan Script

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
3. ตรวจสอบว่า script สามารถเรียกใช้ได้

### 6. Verify Setup

ทดสอบการทำงานของ ast-grep

1. รัน `bun run scan`
2. ตรวจสอบว่า scan ทำงานได้ถูกต้อง
3. ตรวจสอบว่า rules submodule ทำงานได้
4. ตรวจสอบว่า config ถูกต้อง

## Rules

### 1. Installation Rules

กฎการติดตั้ง ast-grep CLI

1. ใช้ Bun เป็น package manager
2. ติดตั้งเป็น dev dependency ด้วย `-D` flag
3. ตรวจสอบ installation สำเร็จก่อนดำเนินการต่อ

### 2. Configuration Rules

กฎการตั้งค่า sgconfig.yml

1. สร้าง `sgconfig.yml` ที่ root directory
2. ดาวน์โหลด config จาก source ที่เชื่อถือได้
3. ตรวจสอบว่า config ถูกต้องตามความต้องการ

### 3. Rules Submodule Rules

กฎการจัดการ rules submodule

1. ใช้ git submodule สำหรับ shared rules
2. อัปเดต submodule ด้วย `git submodule update --init`
3. ตรวจสอบว่า rules/ directory ถูกสร้างขึ้น

### 4. Script Rules

กฎการเพิ่ม scan script

1. มี `scan` script ใน package.json
2. ใช้คำสั่ง `ast-grep scan -r` สำหรับ scanning
3. ตรวจสอบว่า script สามารถเรียกใช้ได้
