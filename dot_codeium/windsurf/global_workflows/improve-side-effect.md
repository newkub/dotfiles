---
title: Improve Side Effect
description: ปรับปรุงการจัดการ side effects ด้วย separation และ error handling
auto_execution_mode: 3
related_workflows:
  - /improve-testability
  - /follow-clean-architecture
  - /follow-event-driven
---

## Goal

ปรับปรุงการจัดการ side effects ด้วยการแยก concerns และ error handling ที่ชัดเจน

## Scope

ใช้สำหรับปรับปรุงการจัดการ side effects ทั้ง `I/O operations`, `async operations`, และ `state mutations`

## Execute

### 1. Identify Side Effects

ระบุ side effects ทั้งหมดใน codebase

- ทำ `/analyze-codebase` เพื่อหา side effects
- ค้นหา `I/O operations` (`API calls`, `database`, `file system`)
- ค้นหา `async operations` ที่ไม่มี error handling
- ค้นหา `state mutations` ที่ไม่ชัดเจน
- ค้นหา `global state` และ `singletons`

### 2. Separate Side Effects

แยก side effects จาก pure logic

- ทำ `/follow-clean-architecture`
- ย้าย `I/O operations` ไปยัง shell layer
- แยก `async operations` จาก sync logic
- แยก `state mutations` จาก pure functions
- ทำให้ core layer ไม่มี side effects

### 3. Improve Error Handling

ปรับปรุง error handling สำหรับ side effects

- เพิ่ม `try-catch` สำหรับ async operations
- ใช้ `Result types` หรือ error boundaries
- จัดการ `network errors` อย่างเหมาะสม
- จัดการ `timeout` และ `retry logic`
- ใช้ proper error types และ messages

### 4. Manage Async Operations

จัดการ async operations อย่างเป็นระบบ

- ใช้ `async/await` อย่างถูกต้อง
- จัดการ `race conditions`
- ใช้ `cancellation tokens` สำหรับ long-running operations
- จัดการ `concurrent operations`
- ใช้ proper loading states

### 5. Isolate State Mutations

แยก state mutations ออกจาก pure logic

- ใช้ `immutable data structures`
- ทำ state updates อย่างชัดเจนและ predictable
- ใช้ state management patterns ตามภาษาที่ใช้
- จัดการ side effects ใน `effect hooks` หรือ `middlewares`
- ทำให้ state changes traceable ได้

### 6. Add Logging And Observability

เพิ่ม logging สำหรับ side effects

- Log `I/O operations` ทั้งหมด
- Log errors และ exceptions
- Log state changes
- Log async operation lifecycles
- ใช้ `structured logging`

### 7. Verify Side Effect Management

ตรวจสอบว่า side effects จัดการถูกต้อง

- ทดสอบว่า pure functions ไม่มี side effects
- ทดสอบ error handling ครอบคลุม
- ทดสอบ async operations จัดการถูกต้อง
- ทดสอบ state mutations predictable
- ทำ `/run-test` สำหรับ side effect tests

## Rules

### 1. Explicit Side Effects

ทำให้ side effects ชัดเจนและ visible

- Side effects ต้องอยู่ใน functions ที่ชัดเจน
- ตั้งชื่อ functions ให้บ่งบอก side effects
- หลีกเลี่ยง hidden side effects
- Document side effects ใน comments

### 2. Error Handling

จัดการ errors สำหรับ side effects ทั้งหมด

- `Async operations` ต้องมี error handling
- `I/O operations` ต้องมี error handling
- ใช้ proper error types
- จัดการ edge cases ทั้งหมด
- ให้ feedback ที่ชัดเจนแก่ users

### 3. Isolation

แยก side effects ออกจาก pure logic

- Pure functions ต้องไม่มี side effects
- Side effects ต้องอยู่ใน layer ที่แยก
- ทำให้ side effects testable ได้
- ทำให้ side effects mockable ได้

### 4. Observability

ทำให้ side effects observable ได้

- Log side effects ทั้งหมด
- Track async operation states
- Monitor error rates
- Track performance metrics
- ใช้ `distributed tracing` ถ้าจำเป็น

### 5. Testing Strategies

ทดสอบ side effects อย่างเป็นระบบ

- ทดสอบ side effects ด้วย mocking
- ทดสอบ error scenarios
- ทดสอบ race conditions
- ทดสอบ timeout และ retry logic
- ทำ `/write-test` สำหรับ side effect tests

### 6. Performance Considerations

พิจารณา performance สำหรับ side effects

- Batch `I/O operations`
- Debounce/throttle side effects
- Cache results สำหรับ expensive operations
- Optimize concurrent operations
- ทำ `/improve-performance` สำหรับ optimization

### 7. Security Considerations

พิจารณา security สำหรับ side effects

- Validate inputs ก่อน `I/O operations`
- Sanitize data ก่อน state mutations
- Handle sensitive data อย่างปลอดภัย
- Rate limiting สำหรับ external calls
- ทำ `/improve-security` สำหรับ security hardening

## Expected Outcome

- Side effects แยกจาก pure logic ทั้งหมด
- Error handling ครอบคลุมสำหรับ side effects
- Async operations จัดการอย่างเป็นระบบ
- State mutations ชัดเจนและ predictable
- Logging ครอบคลุมสำหรับ side effects
- Code ง่ายต่อการ debug
- Code ง่ายต่อการ test
- Error rates ลดลง
- Performance ดีขึ้น
