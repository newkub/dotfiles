---
title: Run Test
description: รัน test suite อย่างเป็นระบบ เขียน test ด้วย /write-test และตรวจสอบ coverage 100%
auto_execution_mode: 3
related_workflows:
  - /write-test
  - /run-test-coverage
---

## Goal

รัน test suite อย่างเป็นระบบ เขียน test ด้วย /write-test และตรวจสอบ coverage 100% พร้อมแก้ไข errors จนผ่านทั้งหมด

## Execute

### 1. Run Format

1. ทำ `/run-format` เพื่อ format code ก่อน
2. รอให้ format เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก format ให้แก้ไขก่อน

### 2. Run Lint

1. ทำ `/run-lint` เพื่อตรวจสอบ code quality
2. รอให้ lint เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก lint ให้แก้ไขก่อน

### 3. Run Typecheck

1. ทำ `/run-typecheck` เพื่อตรวจสอบ type safety
2. รอให้ typecheck เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก typecheck ให้แก้ไขก่อน

### 4. Setup Test Structure

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

### 5. Write Tests

1. ทำ `/write-test` เพื่อเขียน tests ที่ขาดหายไป
2. รอให้ `/write-test` เสร็จสิ้นก่อนดำเนินการต่อ
3. ตรวจสอบว่า test files ครบถ้วนตาม SPEC.md
4. ตรวจสอบว่า test cases ครอบคลุมทุกกรณีใช้งาน
5. ตรวจสอบว่า tests อยู่ใน location ที่ถูกต้อง
6. ตรวจสอบว่า testing strategy ครอบคลุมทุก test types ที่จำเป็น
7. ตรวจสอบว่า formal verification ถูกทำสำหรับ critical components

### 6. Run Tests

1. รัน `bun run test` หรือ `bun test`
2. บันทึกผลลัพธ์ทั้งหมด
3. ระบุ tests ที่ fail
4. ติดตาม progress ของ tests
5. บันทึก duration ของแต่ละ test
6. รัน mutation tests ถ้ามี
7. รัน security tests ถ้ามี
8. รัน performance tests ถ้ามี

### 7. Review Test Results

ทำตาม `/review-test-result` เพื่อวิเคราะห์ผลลัพธ์ที่ครบถ้วน

### 8. Check Coverage

1. ทำ `/run-test-coverage` เพื่อวิเคราะห์ coverage
2. ตรวจสอบว่า coverage ถึง 100% ทุก category (lines, branches, functions, statements)
3. ระบุส่วนที่ยังไม่มี coverage จาก report
4. ถ้า coverage ไม่ถึง 100%:
   - ทำ `/write-test` เพื่อเพิ่ม tests สำหรับส่วนที่ขาด coverage
   - ทำซ้ำขั้นตอน 3-5 จนกว่า coverage จะถึง 100%
5. ถ้า coverage ถึง 100% แล้ว ดำเนินการต่อ

### 9. Fix Failures

1. รัน `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ test failures
2. `/analyze-errors` จะตัดสินใจว่าควรไป workflow ไหนต่อ:
   - ถ้าเป็น cascade issues → `/debug-issue` → `/resolve-errors`
   - ถ้าเป็น isolated errors → `/resolve-errors`
3. แก้ไข code หรือ test
4. แก้ไข test assertions ถ้า test outdated
5. แก้ไข mock data ถ้าจำเป็น
6. บันทึกสิ่งที่แก้ไข
7. แก้ไข formal verification specifications ถ้าจำเป็น
8. แก้ไข invariants ถ้าจำเป็น

### 10. Verify

1. รัน tests อีกครั้งหลังแก้ไข
2. ตรวจสอบว่า failures หมดไป
3. ทำซ้ำขั้นตอน 3-6 จนกว่าจะผ่าน
4. รัน tests ทั้งหมดอีกครั้ง
5. ยืนยันว่าผ่าน 100%
6. ยืนยันว่า coverage ถึง 100% ทุก category

### 11. Run Formal Verification

1. รัน formal verification tools สำหรับ critical components
2. ตรวจสอบว่า invariants ผ่านทั้งหมด
3. ตรวจสอบว่า type systems ตรวจจับ errors ทั้งหมด
4. ตรวจสอบว่า property-based tests ผ่านทั้งหมด
5. ตรวจสอบว่า model checking ผ่านทั้งหมด
6. ตรวจสอบว่า static analysis ผ่านทั้งหมด
7. Document formal verification results

### 12. Report

1. รัน `/report-format-metrics` เพื่อแสดง test coverage metrics
2. รัน `/report-format-table` เพื่อจัดรูปแบบ test results
3. รัน `/report-format-summary` เพื่อสรุปผลลัพธ์ test
4. รายงาน formal verification results
5. รายงาน mutation testing results
6. รายงาน security testing results
7. รายงาน performance testing results

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
- ใช้ `/run-test-coverage` สำหรับวิเคราะห์ coverage อย่างละเอียด
- เป้าหมาย coverage 100% ทุก category โดยไม่มีข้อยกเว้น
- หาก coverage ไม่ถึง 100% ต้องเพิ่ม tests จนครบ

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
- Test coverage ถึง 100% ทุก category (lines, branches, functions, statements)
- Code behavior ถูกต้องตาม expected
- Formal verification ผ่านสำหรับ critical components
- Mutation testing ผ่านด้วยคะแนนสูง
- Security tests ผ่านทั้งหมด
- Performance tests ผ่านทั้งหมด
- รายงานสรุปผลลัพธ์ test ที่ครบถ้วน
