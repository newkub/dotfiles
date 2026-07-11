---
title: Run Check
description: รัน lint, typecheck, scan และตรวจสอบ unused deps/files เพื่อตรวจสอบคุณภาพ
auto_execution_mode: 3
related_workflows:
  - /run-lint
  - /run-typecheck
  - /run-scan
  - /check-unused-deps
  - /check-unsued-files
  - /follow-code-quality
---

## Goal

รัน lint, typecheck, scan และตรวจสอบ unused deps/files เพื่อตรวจสอบคุณภาพ

## Scope

ใช้สำหรับทุก workspace เพื่อตรวจสอบคุณภาพ code, dependencies และไฟล์ก่อน commit/deploy

## Execute

### 1. Run Lint

1. ทำ `/run-lint` เพื่อตรวจสอบ code style
2. แก้ไข lint errors ถ้ามี
3. ยืนยันว่า lint ผ่าน

### 2. Run Typecheck

1. ทำ `/run-typecheck` เพื่อตรวจสอบ types
2. แก้ไข type errors ถ้ามี
3. ยืนยันว่า typecheck ผ่าน

### 3. Run Scan

1. ทำ `/run-scan` เพื่อตรวจสอบ code patterns
2. แก้ไข scan issues ถ้ามี
3. ยืนยันว่า scan ผ่าน

### 4. Check Unused Dependencies

1. ทำ `/check-unused-deps` เพื่อตรวจสอบ dependencies ที่ไม่ได้ใช้
2. ลบหรือ mark dependencies ที่ไม่ได้ใช้ถ้ามี
3. ยืนยันว่าไม่มี unused dependencies

### 5. Check Unused Files

1. ทำ `/check-unsued-files` เพื่อตรวจสอบไฟล์ที่ไม่ได้ใช้
2. ลบหรือ implement ไฟล์ที่ไม่ได้ใช้ถ้ามี
3. ยืนยันว่าไม่มี unused files

## Rules

### 1. Check Order

- Lint: ตรวจสอบ code style ก่อน
- Typecheck: ตรวจสอบ types
- Scan: ตรวจสอบ code patterns
- Unused Deps: ตรวจสอบ dependencies ที่ไม่ได้ใช้
- Unused Files: ตรวจสอบไฟล์ที่ไม่ได้ใช้

### 2. Failure Handling

- Lint ล้มเหลว: แก้ไข lint errors
- Typecheck ล้มเหลว: แก้ไข type errors
- Scan ล้มเหลว: แก้ไข scan issues
- Unused Deps พบ: ลบหรือ mark dependencies
- Unused Files พบ: ลบหรือ implement ไฟล์

### 3. Parallel Execution

- รัน lint, typecheck และ scan แบบ parallel เมื่อเป็นไปได้
- รัน check-unused-deps และ check-unsued-files แบบ parallel เมื่อเป็นไปได้
- ใช้ cache เพื่อเพิ่มความเร็ว
- รัน checks ใน CI environment

## Expected Outcome

- Lint ผ่านทั้งหมด
- Typecheck ผ่านทั้งหมด
- Scan ผ่านทั้งหมด
- ไม่มี unused dependencies
- ไม่มี unused files
- Code พร้อมสำหรับ commit/deploy

