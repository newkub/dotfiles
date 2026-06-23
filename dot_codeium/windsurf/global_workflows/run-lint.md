---
title: Run Lint
description: รัน lint และแก้ code โดยไม่ใช้ ignore patterns และไม่แก้ config
auto_execution_mode: 3
related_workflows:
  - /run-format
  - /analyze-errors
  - /resolve-errors
  - /no-use-ignore
---

## Goal

รัน lint และแก้ code เพื่อให้ผ่าน โดยไม่ใช้ ignore patterns และไม่แก้ config

## Scope

รัน lint สำหรับทุก project types และจัดการ errors/warnings จาก linter โดยแก้ code เท่านั้น

## Execute

### 1. Run Format

1. ทำ `/run-format` เพื่อ format code ก่อน
2. รอให้ format เสร็จสิ้นก่อนดำเนินการต่อ

### 2. Run Lint Command

1. รัน lint ตามที่กำหนดไว้ใน config:
   - สำหรับ monorepo: รัน `bun run lint` หรือ `turbo lint`
   - สำหรับโปรเจกต์ทั่วไป: รัน lint command ตาม config
2. รอให้ lint เสร็จสิ้นก่อนดำเนินการต่อ

### 3. Analyze And Fix Errors

1. ทำ `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ errors และ warnings จาก lint
2. ทำ `/resolve-errors` เพื่อแก้ errors และ warnings ตามลำดับความสำคัญ
3. สำหรับ unused variables: ตัดสินใจว่าควรลบ หรือ implement ให้ครบ
4. สำหรับ `any` types: ใส่ type จริงๆ ให้เฉพาะเจาะจง หรือใช้ type inference/generic types แทน `any` ห้ามเปลี่ยนเป็น `unknown` หากไม่จำเป็น

### 4. Verify

1. รัน lint อีกครั้งเพื่อยืนยัน
2. ตรวจสอบว่าไม่มี errors/warnings เหลือ
3. รัน tests ทั้งหมดเพื่อยืนยันว่า code ทำงานได้

## Rules

- ห้ามแก้ไข config files ทุกประเภท ทำตาม `/no-use-ignore`
- แก้ปัญหาที่ source แทนการ suppress ทำตาม `/resolve-errors`
- ไม่ปรับ config ให้เหมาะสมกับ codebase
- รายงานผลลัพธ์ตาม `/report-format-terminal`

## Expected Outcome

โค้ดที่ผ่าน lint โดยไม่มี errors/warnings โดยแก้ code เท่านั้น ไม่แก้ config และไม่ใช้ ignore patterns

