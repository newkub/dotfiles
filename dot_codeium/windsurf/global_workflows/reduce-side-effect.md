---
title: Reduce Side Effects
description: แยก pure functions จาก side effects เพื่อเพิ่ม testability และ maintainability
auto_execution_mode: 3
---

## Goal

แยก business logic จาก side effects เพื่อให้ code สามารถ test ได้ง่ายขึ้นและ maintain ได้ดีขึ้น

## Execute

### 1. Analyze Functions

วิเคราะห์ functions ทั้งหมดใน codebase

1. ค้นหา functions ที่มี side effects (I/O, database calls, network requests, mutations)
2. ค้นหา pure functions (functions ที่ไม่มี side effects)
3. ระบุ functions ที่ผสมกันระหว่าง pure logic และ side effects

### 2. Extract Pure Logic

แยก business logic ออกจาก side effects

1. สร้าง pure functions สำหรับ business logic
2. ย้าย calculations, validations, transformations ไปยัง pure functions
3. ให้แน่ใจว่า pure functions ไม่มี dependencies ภายนอก

### 3. Isolate Side Effects

แยก side effects ออกเป็น functions เฉพาะ

1. สร้าง functions สำหรับ I/O operations เท่านั้น
2. สร้าง functions สำหรับ database operations เท่านั้น
3. สร้าง functions สำหรับ network requests เท่านั้น
4. ให้แน่ใจว่า side effect functions ไม่มี business logic

### 4. Use Dependency Injection

ใช้ dependency injection สำหรับ side effects

1. สร้าง interfaces สำหรับ side effect operations
2. Inject dependencies แทนการ hardcode
3. ใช้ mock implementations สำหรับ testing

### 5. Write Tests for Pure Functions

เขียน tests สำหรับ pure functions

1. เขียน unit tests สำหรับทุก pure function
2. ใช้ property-based testing สำหรับ functions ที่มี logic ซับซ้อน
3. ให้แน่ใจว่า tests ครอบคลุม edge cases

### 6. Write Tests for Side Effects

เขียน tests สำหรับ side effect functions

1. เขียน integration tests สำหรับ side effect operations
2. ใช้ mocks หรือ stubs สำหรับ external dependencies
3. เขียน E2E tests สำหรับ critical user flows

### 7. Validate Separation

ตรวจสอบการแยก concerns

1. ตรวจสอบว่า pure functions ไม่มี side effects
2. ตรวจสอบว่า side effect functions ไม่มี business logic
3. ตรวจสอบว่า dependency injection ใช้งานได้ถูกต้อง

## Rules

### 1. Pure Functions

Pure functions ต้องเป็น deterministic และไม่มีผลข้างเคียง

- Pure functions ต้องไม่มี side effects
- Pure functions ต้อง return ค่าเดิมเสมอเมื่อได้ input เดิม
- Pure functions ต้องไม่ mutate input parameters

### 2. Side Effect Isolation

แยก side effects ออกจาก business logic อย่างชัดเจน

- Side effect functions ต้องทำ I/O เท่านั้น
- Side effect functions ต้องไม่มี business logic
- Side effect functions ต้องสามารถ mock ได้ง่าย

### 3. Dependency Injection

ใช้ dependency injection เพื่อเพิ่ม testability และ flexibility

- ห้าม hardcode dependencies
- ใช้ interfaces สำหรับ abstractions
- ให้แน่ใจว่าสามารถ inject mocks ได้

### 4. Testing

เขียน tests ครอบคลุมทั้ง pure functions และ side effects

- Pure functions ต้องมี unit tests
- Side effects ต้องมี integration tests
- Critical flows ต้องมี E2E tests

## Expected Outcome

- Business logic แยกจาก side effects อย่างชัดเจน
- Pure functions สามารถ test ได้ง่ายด้วย unit tests
- Side effects สามารถ mock ได้ง่ายสำหรับ testing
- Codebase มี testability สูงขึ้น
- Maintainability ดีขึ้นด้วยการแยก concerns
