---
title: Run Lint
description: รัน lint และแก้ config เพื่อให้ผ่าน โดยไม่ใช้ ignore patterns
auto_execution_mode: 3
related_workflows:
  - /run-format
  - /linter
  - /analyze-errors
  - /resolve-errors
---

## Goal

รัน lint และพยายามแก้ config เพื่อให้ผ่าน โดยไม่ใช้ ignore patterns และจัดการ unused variables ตามเหมาะสม

## Scope

รัน lint สำหรับทุก project types และจัดการ errors/warnings จาก linter

## Execute

### 1. Run Format

1. ทำ `/run-format` เพื่อ format code ก่อน
2. รอให้ format เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก format ให้แก้ไขก่อน

### 2. Run Lint

1. รัน lint ตามที่กำหนดไว้ใน config:
   - สำหรับ monorepo: รัน `bun run lint` หรือ `turbo lint`
   - สำหรับโปรเจกต์ทั่วไป: รัน lint command ตาม config
2. รอให้ lint เสร็จสิ้นก่อนดำเนินการต่อ

### 3. Analyze Errors

1. รัน `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ errors ที่เกิดจาก lint
2. ตรวจสอบประเภทของ errors:
   - config-related errors
   - code-related errors
   - unused variables
   - type errors
   - style violations

### 4. Fix Config Issues

1. ถ้าเป็น config-related errors ให้ทำ `/linter` เพื่อแก้ config
2. ปรับ linter config ให้เหมาะสมกับ codebase
3. ปรับ rules ที่เหมาะสมกับ project
4. รัน lint อีกครั้งเพื่อทดสอบ

### 5. Fix Code Issues

1. แก้ code-related errors ตามลำดับความสำคัญ
2. สำหรับ unused variables:
   - ตัดสินใจว่าควรลบ หรือ implement ให้ครบ
   - ถ้าเป็น mock/placeholder ให้ implement ให้เสร็จ
   - ถ้าไม่จำเป็นจริงๆ ให้ลบ
3. สำหรับ type errors ให้แก้ types ให้ถูกต้อง
4. สำหรับ style violations ให้แก้ตาม conventions

### 6. Verify

1. รัน lint อีกครั้งเพื่อยืนยัน
2. ตรวจสอบว่าไม่มี errors/warnings เหลือ
3. รัน tests ทั้งหมดเพื่อยืนยันว่า code ทำงานได้

## Rules

### 1. Config Adjustments

พยายามแก้ config ก่อนแก้ code เสมอ

- ปรับ linter config ให้เหมาะสมกับ codebase
- ปรับ rules ที่เหมาะสมกับ project
- ใช้ `/linter` เพื่อแก้ config อย่างถูกต้อง
- หลีกเลี่ยงการปิด rules โดยไม่จำเป็น

### 2. Unused Variables

จัดการ unused variables ตามเหมาะสม

- ตรวจสอบว่าเป็น mock/placeholder หรือไม่
- ถ้าเป็น mock/placeholder ให้ implement ให้เสร็จ
- ถ้าไม่จำเป็นจริงๆ ให้ลบ
- หลีกเลี่ยงการใช้ ignore comments

### 3. Error Resolution

แก้ปัญหาที่ source แทนการ suppress

- แก้ code ให้ผ่าน lint rules
- ปรับ config ให้เหมาะสมกับ codebase
- หลีกเลี่ยงการใช้ ignore comments/attributes
- ใช้ `/resolve-errors` เมื่อจำเป็น

### 4. Verification

ตรวจสอบว่า code ทำงานได้ปกติ

- รัน lint อีกครั้งเพื่อยืนยัน
- รัน tests ทั้งหมด
- ตรวจสอบว่าไม่มี regressions

## Expected Outcome

โค้ดที่ผ่าน lint โดยไม่มี errors/warnings พร้อมรายงานผลลัพธ์การรัน lint

