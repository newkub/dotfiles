---
title: Run Scan
description: รัน ast-grep scan เพื่อตรวจสอบ codebase ด้วย AST-based patterns
auto_execution_mode: 3
related_workflows:
  - /ast-grep
  - /write-ast-grep-rules
---

## Goal

รัน ast-grep scan เพื่อตรวจสอบ codebase ด้วย AST-based patterns และแก้ไขปัญหาที่พบ

## Execute

### 1. Setup And Write Rules

1. ทำ `/ast-grep` เพื่อติดตั้งและตั้งค่า ast-grep
2. ตรวจสอบ `sgconfig.yml` มี `ruleDirs: rules` และมี `scan` script ใน `package.json`
3. ทำ `/write-ast-grep-rules` เพื่อสร้าง rules ใน `rules/` directory

### 2. Run Scan

1. รัน `bun run scan` หรือ `ast-grep scan`
2. ตรวจสอบ output และระบุ issues
3. พิจารณา rules ที่ไม่เหมาะสม ว่าถูกต้องไหมเหมาะสมไหม และจัดการอย่างไร
4. แก้ไข code ตาม suggestions ที่เหมาะสม หรือใช้ `--interactive` mode

### 3. Verify

1. รัน scan ซ้ำจนกว่าจะไม่มี issues
2. ตรวจสอบว่า fixes ไม่ทำให้ code เสีย
3. ใช้ `ast-grep test` เพื่อ verify rules

## Rules

### 1. Scan Configuration

ตั้งค่าการรัน scan:

- ต้องมี `sgconfig.yml` ที่ root directory
- ต้องมี `scan` script ใน `package.json`
- rules ต้องอยู่ใน `rules/` directory
- ใช้ severity ตามความสำคัญ (error, warning, info)

### 2. Fix Application

กฎการ apply fixes:

- ตรวจสอบ output ทุกครั้งก่อน apply fixes
- ใช้ `--interactive` mode สำหรับ selective apply
- ตรวจสอบ fixes ก่อน commit
- รัน scan ซ้ำหลังจาก apply fixes
- ตรวจสอบว่า code ยังทำงานได้หลังจาก fixes

### 3. Continuous Integration

กฎการ scan อย่างต่อเนื่อง:

- รัน scan ก่อน commit
- เพิ่ม scan ใน CI/CD pipeline
- อัปเดต rules เมื่อมี patterns ใหม่
- ตรวจสอบ false positives และ tune rules

## Expected Outcome

- ast-grep CLI ติดตั้งและตั้งค่าเรียบร้อย
- Rules สร้างใน `rules/` directory
- Scan รันได้และระบุ issues ที่ถูกต้อง
- Issues แก้ไขและ verify เรียบร้อย
- Codebase ผ่าน ast-grep scan โดยไม่มี errors

