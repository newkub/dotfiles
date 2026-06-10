---
title: Improve Side Effect
description: ปรับปรุงการจัดการ side effects ให้เป็นระบบและทดสอบได้
auto_execution_mode: 3
related_workflows:
  - /follow-functional-core-imperative-shell
  - /follow-functional-programming
---

## Goal

ปรับปรุงการจัดการ side effects ให้เป็นระบบ แยก pure functions จาก side effects และทดสอบได้

## Scope

ใช้สำหรับปรับปรุง code ที่มี side effects ซับซ้อน หรือทดสอบยาก

## Execute

### 1. Identify Side Effects

1. ทำ `/search-code` เพื่อหา side effects:
   - I/O operations (file, network, database)
   - State mutations (global variables, external state)
   - DOM manipulations
   - Console logs, errors
   - Random values, timestamps
2. จัดกลุ่ม side effects ตามประเภท
3. วิเคราะห์ impact ของแต่ละ side effect

### 2. Separate Pure Functions

1. แยก business logic ที่ไม่มี side effects
2. ทำ `/refactor-to-functional` เพื่อแปลงเป็น pure functions
3. ย้าย pure functions ไปยัง modules แยก
4. ตรวจสอบว่า pure functions ไม่มี dependencies ภายนอก

### 3. Isolate Side Effects

1. ทำ `/follow-functional-core-imperative-shell` เพื่อแยก core จาก shell
2. สร้าง adapters สำหรับ external dependencies
3. ใช้ dependency injection สำหรับ side effects
4. กำหนด interfaces ชัดเจนสำหรับ side effects

### 4. Add Type Safety

1. ใช้ `Effect` types สำหรับ side effects
2. กำหนด return types ชัดเจน
3. ใช้ `Result` types สำหรับ error handling
4. ทำ `/improve-type-safety` เพื่อเพิ่ม type coverage

### 5. Add Testing

1. ทำ `/test-function` สำหรับ pure functions
2. ทำ `/test-integration` สำหรับ side effects
3. ใช้ mocks สำหรับ external dependencies
4. ตรวจสอบ coverage 100% สำหรับ pure functions

### 6. Document Side Effects

1. เพิ่ม comments สำหรับ side effects
2. บันทึก dependencies ภายนอก
3. อธิบาย error handling strategies
4. ทำ `/update-docs` เพื่ออัพเดท documentation

## Rules

### 1. Pure Function Principles

Pure functions ต้อง:

- ไม่มี side effects
- Return เหมือนกันเสมอสำหรับ input เดียวกัน
- ไม่มี hidden dependencies
- ไม่ mutate input parameters
- ทดสอบได้ง่าย

### 2. Side Effect Isolation

แยก side effects โดย:

- ใช้ dependency injection
- สร้าง adapters สำหรับ external services
- กำหนด interfaces ชัดเจน
- จำกัด scope ของ side effects
- ใช้ `async/await` สำหรับ async operations

### 3. Error Handling

จัดการ errors โดย:

- ใช้ `Result` types แทน exceptions
- กำหนด error types ชัดเจน
- Handle errors ใกล้ source
- ไม่ swallow errors
- Log errors อย่างเหมาะสม

### 4. State Management

จัดการ state โดย:

- ใช้ immutable data structures
- กำหนด state boundaries ชัดเจน
- ใช้ state management libraries (Redux, Pinia)
- หลีกเลี่ยง global state
- ใช้ unidirectional data flow

### 5. Testing Strategies

ทดสอบ side effects โดย:

- Mock external dependencies
- ใช้ test doubles (stubs, fakes, mocks)
- ทดสอบ pure functions แยกจาก side effects
- ใช้ integration tests สำหรับ side effects
- ตรวจสอบ edge cases

## Expected Outcome

- Pure functions แยกจาก side effects ชัดเจน
- Side effects ถูก isolate และทดสอบได้
- Code มี type safety สูง
- Test coverage ครบถ้วน
- Documentation ชัดเจน
- Code ง่ายต่อการ maintain
