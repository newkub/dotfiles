---
title: Improve Error Handling
description: ปรับปรุง error handling ด้วย error types, error boundaries, recovery strategies, และ user-friendly messages
auto_execution_mode: 3
related_workflows:
  - /improve-side-effect
  - /improve-logging
  - /improve-resilience
  - /follow-code-quality
  - /follow-software-engineering
---

## Goal

ปรับปรุง error handling ให้มี proper error types, recovery strategies, และ user-friendly messages ตาม best practices

## Scope

ใช้สำหรับปรับปรุง error handling ทั้ง server-side, client-side, และ CLI applications

## Execute

### 1. Audit Current Error Handling

ตรวจสอบ error handling ปัจจุบัน

- ค้นหา `try-catch` blocks ที่มี empty catch
- ค้นหา `catch (e)` ที่ไม่ใช้ `e`
- ค้นหา unhandled promise rejections
- ค้นหา error swallowing (catch โดยไม่ log หรือ rethrow)
- ค้นหา generic `catch (error)` โดยไม่มี type narrowing
- บันทึกผลเป็น baseline

### 2. Define Error Types

สร้าง error type hierarchy ที่ชัดเจน

- สร้าง base error class สำหรับ application
- สร้าง specific error types: `ValidationError`, `AuthError`, `NotFoundError`, `ConflictError`, `RateLimitError`, `ExternalServiceError`
- ใช้ error codes สำหรับ programmatic handling
- ใส่ context fields ใน error objects (requestId, userId, metadata)
- ใช้ discriminated unions สำหรับ error types

### 3. Implement Error Boundaries

เพิ่ม error boundaries สำหรับ graceful degradation

- สร้าง error boundaries สำหรับ UI components
- สร้าง error boundaries สำหรับ API routes
- สร้าง error boundaries สำหรับ background jobs
- แยก recoverable จาก non-recoverable errors
- แสดง fallback UI สำหรับ component errors
- ส่ง structured error response สำหรับ API errors

### 4. Add Recovery Strategies

เพิ่ม recovery strategies สำหรับ common errors

- ใช้ retry สำหรับ transient failures (network, timeout)
- ใช้ fallback สำหรับ degraded service
- ใช้ circuit breaker สำหรับ external services
- ใช้ graceful degradation สำหรับ non-critical features
- ใช้ queue สำหรับ failed operations ที่ต้อง retry ภายหลัง
- ทำ `/improve-resilience` สำหรับ resilience patterns

### 5. Improve Error Messages

ปรับปรุง error messages ให้ user-friendly

- แยก technical errors จาก user-facing messages
- ใช้ clear, actionable language สำหรับ user messages
- ไม่ leak technical details ไปยัง users
- ใช้ i18n สำหรับ error messages ถ้ารองรับหลายภาษา
- ให้ guidance สำหรับ recovery (เช่น "กรุณาลองอีกครั้ง")
- ทำ `/improve-i18n` สำหรับ multi-language errors

### 6. Centralize Error Handling

รวม error handling ให้เป็นระบบ

- สร้าง global error handler สำหรับ unhandled errors
- สร้าง error middleware สำหรับ API
- สร้าง error boundary component สำหรับ UI
- สร้าง error reporting service integration
- ไม่ duplicate error handling ในหลาย layers
- ทำ `/improve-logging` สำหรับ error logging

### 7. Validate Error Handling

ตรวจสอบ error handling หลังปรับปรุง

- ทดสอบ error scenarios ทั้งหมด
- ทดสอบ recovery strategies
- ทดสอบ error boundaries
- ทดสอบ user-facing error messages
- รัน `/run-test` สำหรับ error handling tests
- ทำ `/report-format-table` สำหรับ before-after comparison

## Rules

### 1. Error Type Hierarchy

ใช้ error type hierarchy ที่ชัดเจน

- สร้าง base `AppError` class
- สร้าง specific error types ที่ inherit จาก base
- ใส่ `code`, `message`, `statusCode`, `context` ในทุก errors
- ใช้ `instanceof` สำหรับ type narrowing
- ไม่ throw generic `Error` ใน application code

### 2. No Error Swallowing

ไม่ swallow errors

- ไม่ catch โดยไม่ log หรือ rethrow
- ไม่ catch โดยไม่ใช้ error variable
- ถ้า catch เพื่อ recovery ต้อง log ด้วย
- ใช้ `catch` เฉพาะเมื่อสามารถ handle ได้
- ไม่ใช้ `try-catch` แทน proper validation

### 3. User-Friendly Messages

แยก technical จาก user-facing messages

- User messages: clear, actionable, non-technical
- Technical details: log ไว้สำหรับ debugging
- ไม่ leak stack traces ไปยัง users
- ไม่ leak internal paths หรือ variable names
- ใช้ i18n keys สำหรับ user messages

### 4. Recovery First

พยายาม recover ก่อน fail

- Retry transient failures
- Fallback สำหรับ degraded service
- Graceful degradation สำหรับ non-critical features
- Queue สำหรับ delayed retry
- Fail fast สำหรับ non-recoverable errors

### 5. Error Propagation

ส่ง errors อย่างถูกต้อง

- ไม่ rethrow โดยไม่มี context เพิ่ม
- ใช้ `cause` field สำหรับ error chaining
- ไม่ wrap errors หลายชั้น
- ส่ง error type ที่เหมาะสมขึ้นไป
- Log ที่ catch point สูงสุดเท่านั้น

## Expected Outcome

- Error type hierarchy ชัดเจน
- Error boundaries ครอบคลุมทุก layers
- Recovery strategies สำหรับ common errors
- User-friendly error messages
- Error handling centralized และ consistent
- Error swallowing กำจัดหมด
- Error logging มี context เพียงพอ
- Before-after comparison report

## Common Mistakes

- Catch โดยไม่ log หรือ rethrow
- Throw generic `Error` แทน specific types
- Leak technical details ไปยัง users
- ไม่มี recovery strategy
- Duplicate error handling ในหลาย layers
- ไม่ใช้ `cause` สำหรับ error chaining

## Anti-Patterns

- `catch (e) {}` — empty catch block
- `catch (e) { console.log(e) }` — log โดยไม่ recover
- Throw `new Error("something")` แทน specific type
- แสดง stack trace ให้ user เห็น
- Nested try-catch หลายชั้นโดยไม่จำเป็น

## Tools

- `bun run scan` - ast-grep scan for error handling patterns
- `grep` - Search for empty catch blocks
- `bun run typecheck` - Type check error types
- `bun run test` - Run error handling tests

## References

- ทำ `/improve-side-effect` สำหรับ side effect isolation
- ทำ `/improve-logging` สำหรับ error logging
- ทำ `/improve-resilience` สำหรับ resilience patterns
- ทำ `/follow-code-quality` สำหรับ code quality
- ทำ `/follow-software-engineering` สำหรับ engineering principles
