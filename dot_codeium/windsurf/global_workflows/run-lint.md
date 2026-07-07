---
title: Run Lint
description: รัน lint และแก้ code เพื่อให้ผ่าน โดยไม่ใช้ ignore patterns และห้ามแก้ไข config ไฟล์
auto_execution_mode: 3
related_workflows:
  - /follow-linter
  - /analyze-errors
  - /resolve-errors
  - /no-use-ignore
  - /follow-code-quality
  - /run-check
---

## Goal

รัน lint และแก้ code เพื่อให้ผ่าน โดยไม่ใช้ ignore patterns และจัดการ unused variables ตามเหมาะสม โดยห้ามแก้ไข config ไฟล์

## Scope

รัน lint สำหรับทุก project types และจัดการ errors/warnings จาก linter

## Execute

### 1. Run Lint

1. ตรวจสอบ project type และ lint config ก่อนรัน
2. รัน lint ตามที่กำหนดไว้ใน config:
   - สำหรับ monorepo: รัน `bun run lint` หรือ `turbo lint`
   - สำหรับโปรเจกต์ทั่วไป: รัน lint command ตาม config
3. รอให้ lint เสร็จสิ้นก่อนดำเนินการต่อ

### 2. Analyze Errors

1. รัน `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ errors ที่เกิดจาก lint
2. ตรวจสอบประเภทของ errors:
   - config-related errors
   - code-related errors
   - unused variables
   - type errors
   - style violations

### 3. Fix Code Issues

1. แก้ code-related errors ตามลำดับความสำคัญ
2. สำหรับ unused variables:
   - ตัดสินใจว่าควรลบ หรือ implement ให้ครบ
   - ถ้าเป็น mock/placeholder ให้ implement ให้เสร็จ
   - ถ้าไม่จำเป็นจริงๆ ให้ลบ
3. สำหรับ type errors ให้แก้ types ให้ถูกต้อง
4. สำหรับ style violations ให้แก้ตาม conventions

### 4. Verify

1. รัน lint อีกครั้งเพื่อยืนยัน
2. ตรวจสอบว่าไม่มี errors/warnings เหลือ
3. รัน tests ทั้งหมดเพื่อยืนยันว่า code ทำงานได้

## Rules

### 1. No Config Changes

ห้ามแก้ไข config ไฟล์ทุกประเภท

- ห้ามแก้ไข biome.jsonc, eslint.config.js, tsconfig.json หรือ config ไฟล์อื่นๆ
- แก้ code ให้ผ่าน lint rules ที่มีอยู่
- หาก config ไม่เหมาะสม ให้แจ้งผู้ใช้แทนการแก้เอง

### 2. Unused Variables

จัดการ unused variables ตามเหมาะสม

- ตรวจสอบว่าเป็น mock/placeholder หรือไม่
- ถ้าเป็น mock/placeholder ให้ implement ให้เสร็จ
- ถ้าไม่จำเป็นจริงๆ ให้ลบ
- หลีกเลี่ยงการใช้ ignore comments

### 3. Error Resolution

แก้ปัญหาที่ source แทนการ suppress ทำตาม `/no-use-ignore`

- แก้ code ให้ผ่าน lint rules
- หลีกเลี่ยงการใช้ ignore comments/attributes
- ใช้ `/resolve-errors` เมื่อจำเป็น

### 4. Verification

ตรวจสอบว่า code ทำงานได้ปกติ

- รัน lint อีกครั้งเพื่อยืนยัน
- รัน tests ทั้งหมด
- ตรวจสอบว่าไม่มี regressions
- ทำ `/check-unused-files` เพื่อตรวจสอบว่าทุกไฟล์ถูกใช้
- ห้ามใช้ `--unsafe` flag กับ `biome` commands

## Expected Outcome

- โค้ดที่ผ่าน lint โดยไม่มี errors/warnings
- ทุกไฟล์ถูกใช้ ไม่มีไฟล์ที่ไม่ได้ใช้
- รายงานผลลัพธ์การรัน lint

