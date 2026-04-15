---
title: Run Test
description: รัน test suite อย่างเป็นระบบ พร้อมแก้ไข errors จนผ่านทั้งหมด
auto_execution_mode: 3
---

## Goal

รัน test suite อย่างเป็นระบบ พร้อมแก้ไข errors และ failures จนผ่านทั้งหมด

## Execute

### 1. Setup Test Structure

1. ตรวจสอบ test structure ตามมาตรฐาน:

```text
test/
├── unit/          # unit tests
├── integration/   # integration tests
├── e2e/          # end-to-end tests
├── fixtures/     # test fixtures
├── mocks/        # mock data
└── utils/        # test utilities
```

2. สร้าง directories ถ้ายังไม่มี:
   - `test/unit/` - unit tests
   - `test/integration/` - integration tests
   - `test/e2e/` - end-to-end tests
   - `test/fixtures/` - test fixtures
   - `test/mocks/` - mock data
   - `test/utils/` - test utilities
3. ตรวจสอบ test frameworks ถูกติดตั้ง
4. ตรวจสอบ test configuration
5. ยืนยันว่ามี test config files ถ้าจำเป็น

### 2. Run Tests

1. รัน `bun run test` หรือ `bun test`
2. บันทึกผลลัพธ์ทั้งหมด
3. ระบุ tests ที่ fail
4. ติดตาม progress ของ tests
5. บันทึก duration ของแต่ละ test

### 3. Fix Failures

1. วิเคราะห์ cause ของ test failures
2. แก้ไข code หรือ test
3. แก้ไข test assertions ถ้า test outdated
4. แก้ไข mock data ถ้าจำเป็น
5. บันทึกสิ่งที่แก้ไข

### 4. Verify

1. รัน tests อีกครั้งหลังแก้ไข
2. ตรวจสอบว่า failures หมดไป
3. ทำซ้ำขั้นตอน 2-3 จนกว่าจะผ่าน
4. รัน tests ทั้งหมดอีกครั้ง
5. ยืนยันว่าผ่าน 100%

## Rules

1. Test Execution

- Test fail: วิเคราะห์ cause และแก้ไข
- Test error: ตรวจสอบ error message และ fix
- Test pass: Continue ไป test ถัดไป
- Test timeout: ตรวจสอบ performance และ adjust

2. Error Resolution

- อ่าน error message
- ระบุ root cause
- แก้ไข code หรือ test
- รัน test อีกครั้ง
- ทำซ้ำจนผ่าน

## Expected Outcome

- ทุก tests ผ่านทั้งหมด
- ไม่มี failures หรือ errors
- Test coverage ตามที่กำหนด
- Code behavior ถูกต้องตาม expected