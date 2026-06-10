---
title: Run Check
description: รัน checks ทั้งหมด (lint, typecheck, test) เพื่อตรวจสอบคุณภาพ
auto_execution_mode: 3
related_workflows:
  - /run-lint
  - /run-typecheck
  - /run-test
  - /run-verify
---

## Goal

รัน checks ทั้งหมด (lint, typecheck, test) เพื่อตรวจสอบคุณภาพ

## Execute

### 1. Run Lint

1. ทำ `/run-lint` เพื่อตรวจสอบ code style
2. แก้ไข lint errors ถ้ามี
3. ยืนยันว่า lint ผ่าน

### 2. Run Typecheck

1. ทำ `/run-typecheck` เพื่อตรวจสอบ types
2. แก้ไข type errors ถ้ามี
3. ยืนยันว่า typecheck ผ่าน

### 3. Run Tests

1. ทำ `/run-test` เพื่อรัน test suite
2. ตรวจสอบ test coverage
3. แก้ไข test failures ถ้ามี
4. ยืนยันว่า tests ผ่าน

### 4. Run Verification

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ด
2. ตรวจสอบ correctness, duplication, unused files/deps
3. แก้ไข issues ที่พบ

### 5. Generate Report

1. รวบรวมผลลัพธ์จากทุก check
2. สร้าง summary report
3. แชร์ results กับทีม

## Rules

### 1. Check Order

- Lint: ตรวจสอบ code style ก่อน
- Typecheck: ตรวจสอบ types
- Test: รัน tests
- Verify: ตรวจสอบคุณภาพโค้ด

### 2. Failure Handling

- Lint ล้มเหลว: แก้ไข lint errors
- Typecheck ล้มเหลว: แก้ไข type errors
- Test ล้มเหลว: แก้ไข test failures
- Verify ล้มเหลว: แก้ไข issues

### 3. Parallel Execution

- รัน lint, typecheck, test แบบ parallel เมื่อเป็นไปได้
- ใช้ cache เพื่อเพิ่มความเร็ว
- รัน checks ใน CI environment

## Expected Outcome

- Lint ผ่านทั้งหมด
- Typecheck ผ่านทั้งหมด
- Tests ผ่านทั้งหมด
- Verification ผ่านทั้งหมด
- Check report ถูกสร้าง
- Code พร้อมสำหรับ commit/deploy

