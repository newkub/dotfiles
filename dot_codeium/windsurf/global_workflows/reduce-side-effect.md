---
title: Reduce Side Effect
description: จัดการและลด side effects โดยแยก pure logic จาก impure operations
auto_execution_mode: 3
---

## Goal

แยก pure logic จาก impure operations เพื่อทำให้ code predictable, testable และ maintainable

## Execute

### 1. Identify Side Effects

ระบุ side effects ใน codebase

1. รัน `/analyze-project` เพื่อดูโครงสร้างปัจจุบัน
2. ระบุ functions ที่มี I/O, state mutations, external calls
3. หา functions ที่ควรเป็น pure แต่ไม่ pure
4. ตรวจสอบ hidden side effects เช่น logging, caching, timing
5. บันทึก areas ที่ต้องแปลงเป็น pure

### 2. Separate Pure And Impure Code

แยก pure logic จาก impure operations

1. แยก business logic ออกจาก I/O operations
2. ทำให้ core functions เป็น pure
3. ย้าย side effects ไปยัง boundary layers
4. ใช้ dependency injection สำหรับ external dependencies
5. ตรวจสอบว่า pure functions ไม่มี side effects

### 3. Encapsulate Side Effects

จัดการ side effects อย่างชัดเจน

1. สร้าง explicit interfaces สำหรับ side effects
2. ใช้ ports and adapters pattern
3. จัดเก็บ side effects ที่ centralized
4. ทำให้ side effects predictable และ testable
5. รัน `/follow-error-handling` สำหรับ error handling

### 4. Make Effects Explicit

ทำให้ effects ชัดเจนใน type signatures

1. ใช้ type signatures ที่ระบุ effects อย่างชัดเจน
2. ใช้ effect types ถ้า language รองรับ
3. บันทึก effects ใน documentation
4. ตรวจสอบว่า effects ชัดเจนจาก function signatures
5. หลีกเลี่ยง hidden effects

### 5. Refactor For Reduced Side Effects

ปรับปรุง code ให้ลด side effects

1. รัน `/refactor` เพื่อปรับปรุง code
2. แปลง impure functions เป็น pure เท่าที่ทำได้
3. ย้าย side effects ไปยัง boundary
4. แยก concerns ระหว่าง pure และ impure
5. รัน `/follow-immutability` สำหรับ immutability

### 6. Validate Side Effect Reduction

ทดสอบว่า side effects ลดลงเพียงพอ

1. รัน tests ทั้งหมดให้ผ่าน
2. ตรวจสอบว่า pure functions ทำงานได้ถูกต้อง
3. รัน `/run-lint` เพื่อตรวจสอบ code quality
4. ตรวจสอบว่า side effects ถูกจัดการอย่างชัดเจน
5. รัน `/run-verify` เพื่อยืนยัน side effect reduction

## Rules

### Pure Function Standards

- Core business logic ต้องเป็น pure functions
- Pure functions ต้องไม่มี side effects
- Pure functions ต้อง deterministic เมื่อ input เดียวกัน
- Pure functions ต้องไม่ mutate parameters หรือ global state

### Side Effect Identification

- ระบุ side effects ทั้งหมดใน codebase
- บันทึก side effects ใน documentation
- ตรวจสอบ hidden side effects
- Side effects ต้องชัดเจนและ predictable

### Separation Of Concerns

- แยก pure logic จาก impure operations
- ย้าย side effects ไปยัง boundary layers
- ใช้ dependency injection สำหรับ external dependencies
- Core domain ต้องไม่มี direct side effects

### Effect Management

- ใช้ monads หรือ effect systems ถ้าเหมาะสม
- ใช้ Result/Option types สำหรับ error handling
- ใช้ async/await สำหรับ asynchronous operations
- Effects ต้องถูกจัดการอย่างชัดเจน

### Type Safety

- Type signatures ต้องระบุ effects อย่างชัดเจน
- ใช้ effect types ถ้า language รองรับ
- หลีกเลี่ยง hidden effects
- Effects ต้องชัดเจนจาก signatures

## Expected Outcome

- Pure functions สำหรับ core business logic
- Side effects ที่จัดการอย่างชัดเจน
- Code ที่ predictable และ testable
- Separation ระหว่าง pure และ impure code
- Type signatures ที่ระบุ effects อย่างชัดเจน
