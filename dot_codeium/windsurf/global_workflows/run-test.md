title: Run Test
description: รัน test suite อย่างเป็นระบบ พร้อมแก้ไข errors จนผ่านทั้งหมด
auto_execution_mode: 3
## Purpose

รัน test suite อย่างเป็นระบบ พร้อมแก้ไข errors และ failures จนผ่านทั้งหมด

## Scope

ใช้สำหรับ:

- รัน unit tests และ integration tests
- แก้ไข test failures
- ตรวจสอบ test coverage
- Validate code behavior

## Inputs

| Input | Details |
|-------|---------|
| Test Pattern | (optional) pattern สำหรับรันเฉพาะ test |
| Watch Mode | (optional) รันใน watch mode |

## Rules

### Test Execution

| กรณี | การจัดการ |
|------|-----------|
| Test fail | วิเคราะห์ cause และแก้ไข |
| Test error | ตรวจสอบ error message และ fix |
| Test pass | Continue ไป test ถัดไป |
| Test timeout | ตรวจสอบ performance และ adjust |

### Error Resolution

| ขั้นตอน | การดำเนินการ |
|---------|-------------|
| 1 | อ่าน error message |
| 2 | ระบุ root cause |
| 3 | แก้ไข code หรือ test |
| 4 | รัน test อีกครั้ง |
| 5 | ทำซ้ำจนผ่าน |

## Structure

### File Location

```text
.windsurf/workflows/
└── run-test.md
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| **Pre-test** | Fix all errors first | Run `/fix-error-warning` until passing |
| Setup | เตรียมการ test | install dependencies |
| Execute | รัน tests | run test suite |
| Fix | แก้ไข failures | Use `/fix-error-warning` |
| Verify | ยืนยัน | รันใหม่จนผ่าน |

## Steps

### Phase 0: Pre-test Error Fix

- 0.1 **รัน `/fix-error-warning` ก่อน Test**
  - รัน `/fix-error-warning` เพื่อ fix ทั้ง errors และ warnings
  - ยืนยันไม่มี type errors หรือ lint errors ก่อน run test
  - บันทึกสถานะว่า "pre-test error check passed"

- 0.2 **Verify Clean State**
  - ตรวจสอบว่า codebase error-free
  - ถ้ามี errors → รัน `/fix-error-warning` ซ้ำจนกว่าจะผ่าน
  - ไป Phase 1 เมื่อพร้อม

### Phase 1: Setup

- 1.1 **Install Dependencies**
  - รัน `/run-install`
  - ตรวจสอบ test frameworks ถูกติดตั้ง
  - ตรวจสอบ test configuration

### Phase 2: Execute Tests

- 2.1 **Run Test Suite**
  - รัน `bun run test` หรือ `bun test`
  - บันทึกผลลัพธ์ทั้งหมด
  - ระบุ tests ที่ fail

- 2.2 **Monitor Results**
  - ติดตาม progress ของ tests
  - บันทึก duration ของแต่ละ test
  - ระบุ slow tests

### Phase 3: Fix Failures

- 3.1 **รัน `/fix-error-warning` สำหรับ Test Failures**
  - รัน `/fix-error-warning` เพื่อ fix code issues ที่ทำให้ test fail
  - วนลูปจนกว่าจะผ่าน (max 3 ครั้ง)
  - บันทึกสิ่งที่แก้ไข

- 3.2 **Fix Outdated Tests**
  - แก้ไข test assertions ถ้า test outdated
  - แก้ไข mock data ถ้าจำเป็น
  - รัน `/fix-error-warning` ซ้ำถ้ามี code changes

### Phase 4: Verify

- 4.1 **Re-run Tests**
  - รัน tests อีกครั้งหลังแก้ไข
  - ตรวจสอบว่า failures หมดไป
  - ทำซ้ำถ้ายังมี failures

- 4.2 **Final Verification**
  - รัน tests ทั้งหมดอีกครั้ง
  - ยืนยันว่าผ่าน 100%
  - บันทึกผลลัพธ์สุดท้าย

## Outputs

| Output | Details |
|--------|---------|
| Test Results | สรุปผลการ run tests |
| Failures Fixed | รายการที่แก้ไข |
| Duration | เวลาที่ใช้ในการ run |
| Coverage | test coverage report |

## Expected Outcome

- ทุก tests ผ่านทั้งหมด
- ไม่มี failures หรือ errors
- Test coverage ตามที่กำหนด
- Code behavior ถูกต้องตาม expected

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/run-install` - ติดตั้ง dependencies
- `/fix-error-warning` - Fix ทั้ง errors และ warnings ก่อนและหลัง test
