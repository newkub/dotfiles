---
title: Run Test
description: รัน test suite เขียน test ด้วย write-test และตรวจสอบ coverage 100%
auto_execution_mode: 3
related_workflows:
  - /run-lint
  - /run-typecheck
  - /write-test
  - /check-correctness-test-case
  - /run-test-coverage
---

## Goal

รัน test suite อย่างเป็นระบบ เขียน test ด้วย `/write-test` และตรวจสอบ coverage 100% พร้อมแก้ไข errors จนผ่านทั้งหมด

## Scope

ใช้สำหรับทุก workspace ที่มี test script ใน package manifest

## Execute

### 1. Run Lint

1. ทำ `/run-lint` เพื่อตรวจสอบ code quality
2. รอให้ lint เสร็จสิ้นก่อนดำเนินการต่อ

### 2. Run Typecheck

1. ทำ `/run-typecheck` เพื่อตรวจสอบ type safety
2. รอให้ typecheck เสร็จสิ้นก่อนดำเนินการต่อ

### 3. Write Tests

1. ทำ `/write-test` เพื่อเขียน tests ที่ขาดหายไป
2. รอให้ `/write-test` เสร็จสิ้นก่อนดำเนินการต่อ
3. ตรวจสอบว่า test files ครบถ้วนตาม SPEC.md
4. ตรวจสอบว่า test cases ครอบคลุมทุกกรณีใช้งาน

### 4. Run Tests

1. รัน `bun run test` หรือ `bun test`
2. บันทึกผลลัพธ์ทั้งหมด
3. ระบุ tests ที่ fail

### 5. Review Test Results

1. ทำตาม `/review-test-result` เพื่อวิเคราะห์ผลลัพธ์
2. วิเคราะห์ทั้ง test quality และ implementation quality

### 6. Check Coverage

1. ทำ `/run-test-coverage` เพื่อวิเคราะห์ coverage
2. ตรวจสอบว่า coverage ถึง 100% ทุก category (lines, branches, functions, statements)
3. ถ้า coverage ไม่ถึง 100% ให้ทำ `/write-test` เพิ่ม แล้วทำซ้ำขั้นตอน 1-3 ของ section นี้

### 7. Check Correctness

1. ทำ `/check-correctness-test-case` เพื่อตรวจสอบความถูกต้องของ test cases
2. ถ้ามีปัญหาให้แก้ไขก่อนดำเนินการต่อ

### 8. Fix Failures

1. ทำ `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ test failures
2. `/analyze-errors` จะตัดสินใจว่าควรไป workflow ไหนต่อ:
   - ถ้าเป็น cascade issues → `/debug-issue` → `/resolve-errors`
   - ถ้าเป็น isolated errors → `/resolve-errors`
3. แก้ไข code หรือ test ตามลำดับความสำคัญ

### 9. Verify

1. รัน tests อีกครั้งหลังแก้ไข
2. ตรวจสอบว่า failures หมดไป
3. ทำซ้ำขั้นตอน 4-9 จนกว่าจะผ่าน 100%
4. ยืนยันว่า coverage ถึง 100% ทุก category

### 10. Report

1. รัน `/report-format-metrics` เพื่อแสดง test coverage metrics
2. รัน `/report-format-table` เพื่อจัดรูปแบบ test results
3. รัน `/report-format-summary` เพื่อสรุปผลลัพธ์ test

## Rules

- ตรวจสอบ coverage ทุก category (line, branch, function, statement) เป้าหมาย 100%
- วิเคราะห์ผลลัพธ์อย่างละเอียด ไม่เพียงแค่ดู pass/fail
- ระบุ root cause ของการล้มเหลว ไม่ใช่แค่อ่าน error message
- พิจารณาทั้ง test quality และ implementation quality
- ระบุ test ที่ช้าและแนะนำการปรับปรุง
- รายงานผลลัพธ์ตาม `/report-format-metrics` และ `/report-format-table`

## Expected Outcome

- ทุก tests ผ่านทั้งหมด ไม่มี failures หรือ errors
- Test coverage ถึง 100% ทุก category
- Code behavior ถูกต้องตาม expected
- รายงานสรุปผลลัพธ์ test ที่ครบถ้วน
