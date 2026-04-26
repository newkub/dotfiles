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

### 3. Review Test Results

ทำตาม `/review-test-result` เพื่อวิเคราะห์ผลลัพธ์ที่ครบถ้วน

### 4. Fix Failures

1. วิเคราะห์ cause ของ test failures
2. แก้ไข code หรือ test
3. แก้ไข test assertions ถ้า test outdated
4. แก้ไข mock data ถ้าจำเป็น
5. บันทึกสิ่งที่แก้ไข

### 5. Verify

1. รัน tests อีกครั้งหลังแก้ไข
2. ตรวจสอบว่า failures หมดไป
3. ทำซ้ำขั้นตอน 2-4 จนกว่าจะผ่าน
4. รัน tests ทั้งหมดอีกครั้ง
5. ยืนยันว่าผ่าน 100%

## Rules

### 1. Test Execution

วิธีการจัดการ test ที่มีสถานะต่างกัน

- Test fail: วิเคราะห์ cause และแก้ไข
- Test error: ตรวจสอบ error message และ fix
- Test pass: Continue ไป test ถัดไป
- Test timeout: ตรวจสอบ performance และ adjust

### 2. Error Resolution

ขั้นตอนการแก้ไข error

- อ่าน error message
- ระบุ root cause
- แก้ไข code หรือ test
- รัน test อีกครั้ง
- ทำซ้ำจนผ่าน

### 3. Analysis

การวิเคราะห์ผลลัพธ์

- ต้องวิเคราะห์ผลลัพธ์อย่างละเอียด ไม่เพียงแค่ดู pass/fail
- ต้องระบุ root cause ของการล้มเหลว
- ต้องพิจารณาทั้ง test quality และ implementation quality

### 4. Coverage

การตรวจสอบ code coverage

- ต้องตรวจสอบ coverage ทั้งหมด (line, branch, function, statement)
- ต้องระบุส่วนที่สำคัญแต่ยังไม่มี test
- ต้องพิจารณา criticality ของส่วนที่ไม่มี coverage

### 5. Performance

การตรวจสอบ performance ของ test

- ต้องตรวจสอบ performance ของ test
- ต้องระบุ test ที่ช้าและแนะนำการปรับปรุง
- ต้องพิจารณา impact ต่อ CI/CD pipeline

### 6. Documentation

การประเมิน test documentation

- ต้องประเมินคุณภาพของ test documentation
- ต้องแนะนำการปรับปรุงถ้าจำเป็น
- ต้องส่งเสริม best practices สำหรับการเขียน test

### 7. Reporting

การสร้างรายงาน

- ต้องสร้างรายงานที่ชัดเจนและ action-oriented
- ต้องระบุ priority สำหรับการดำเนินการ
- ต้องให้ข้อมูลเพียงพอสำหรับการตัดสินใจ

## Expected Outcome

- ทุก tests ผ่านทั้งหมด
- ไม่มี failures หรือ errors
- Test coverage ตามที่กำหนด
- Code behavior ถูกต้องตาม expected
- รายงานสรุปผลลัพธ์ test ที่ครบถ้วน