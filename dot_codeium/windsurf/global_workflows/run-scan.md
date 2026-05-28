---
title: Run Scan
description: รัน ast-grep scan เพื่อตรวจสอบ codebase ด้วย AST-based patterns
auto_execution_mode: 3
related_workflows:
  - /follow-ast-grep
  - /write-ast-grep-rules
---

## Goal

รัน ast-grep scan เพื่อตรวจสอบ codebase ด้วย AST-based patterns และแก้ไขปัญหาที่พบ

## Scope

ครอบคลุมการรัน ast-grep scan สำหรับตรวจสอบ codebase ด้วย AST-based patterns และแก้ไขปัญหาที่พบ

## Execute

### 1. Setup Ast-grep

1. ทำ `/follow-ast-grep` เพื่อติดตั้งและตั้งค่า ast-grep
2. ตรวจสอบว่า `sgconfig.yml` มี `ruleDirs: rules`
3. ตรวจสอบว่ามี `scan` script ใน `package.json`

### 2. Write Rules

1. ทำ `/write-ast-grep-rules` เพื่อสร้าง rules สำหรับ linting
2. สร้าง rules ใน `rules/` directory

### 3. Run Scan

1. รัน `bun run scan` หรือ `ast-grep scan`
2. ตรวจสอบ output และระบุ issues ที่พบ
3. แก้ไข code ตาม suggestions หรือใช้ `--interactive` mode

### 4. Verify And Fix

1. รัน scan ซ้ำจนกว่าจะไม่มี issues
2. ตรวจสอบว่า fixes ไม่ทำให้ code เสีย
3. ใช้ `ast-grep test` เพื่อ verify rules

## Rules

### 1. Scan Execution

กฎการรัน ast-grep scan:

- ต้องมี `sgconfig.yml` ที่ root directory
- ต้องมี `scan` script ใน `package.json`
- รัน scan ด้วย `ast-grep scan` หรือ `bun run scan`
- ตรวจสอบ output ทุกครั้งก่อน apply fixes

### 2. Rule Management

กฎการจัดการ rules:

- rules ต้องอยู่ใน `rules/` directory
- ใช้ severity ตามความสำคัญ (error, warning, info)
- ตรวจสอบ rules ด้วย `ast-grep test` ก่อนใช้

### 3. Fix Application

กฎการ apply fixes:

- ใช้ `--interactive` mode สำหรับ selective apply
- ตรวจสอบ fixes ก่อน commit
- รัน scan ซ้ำหลังจาก apply fixes
- ตรวจสอบว่า code ยังทำงานได้หลังจาก fixes

### 4. Continuous Scanning

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
