---
title: Improve Error Handling
description: ปรับปรุง error handling ให้ consistent และมีประสิทธิภาพ
auto_execution_mode: 3
---

## Goal

ปรับปรุง error handling ให้ consistent และมีประสิทธิภาพตาม best practices

## Execute

### 1. Analyze Error Handling

วิเคราะห์ error handling ปัจจุบัน

1. ค้นหา try-catch blocks
2. วิเคราะห์ error propagation
3. ตรวจสอบ error logging
4. ระบุ unhandled errors
5. วิเคราะห์ error messages

### 2. Standardize Error Types

สร้าง error types ที่ standard

1. สร้าง custom error classes
2. สร้าง error codes ที่ consistent
3. สร้าง error types ตาม domains
4. สร้าง error factory functions
5. สร้าง error enums

### 3. Improve Error Logging

ปรับปรุง error logging

1. ใช้ structured logging
2. เพิ่ม error context
3. เพิ่ม stack traces
4. เพิ่ม request IDs
5. ใช้ error tracking service

### 4. Improve Error Propagation

ปรับปรุง error propagation

1. ใช้ async/await อย่างถูกต้อง
2. ใช้ error boundaries สำหรับ UI
3. ใช้ global error handlers
4. ใช้ middleware สำหรับ API errors
5. ใช้ circuit breakers สำหรับ external calls

### 5. Improve Error Messages

ปรับปรุง error messages

1. ใช้ messages ที่ user-friendly
2. เพิ่ม error codes สำหรับ debugging
3. เพิ่ม suggestions สำหรับการแก้ไข
4. แปล error messages สำหรับ i18n
5. ซ่อน sensitive information

### 6. Add Error Tests

เพิ่ม tests สำหรับ error handling

1. เขียน tests สำหรับ error cases
2. เขียน tests สำหรับ error boundaries
3. เขียน tests สำหรับ error logging
4. เขียน tests สำหรับ error recovery
5. เขียน tests สำหรับ error messages

### 7. Commit

ทำการ commit เฉพาะบรรทัดที่ workflow แก้ไป

1. ใช้ `/commit` (จะทำงานใน workflow mode โดยอัตโนมัติ)
2. ตรวจสอบว่า commit เสร็จสมบูรณ์
3. ตรวจสอบว่ามีเฉพาะบรรทัดที่ workflow แก้ไปถูก commit

## Rules

### Error Types

ใช้ error types ที่ consistent

- สร้าง custom error classes
- ใช้ error codes ที่ meaningful
- จัดกลุ่ม errors ตาม domains
- ใช้ inheritance สำหรับ error hierarchies
- ใช้ error factory functions

### Error Logging

บันทึก errors อย่างเหมาะสม

- ใช้ structured logging
- เพิ่ม context ที่ relevant
- ไม่บันทึก sensitive data
- ใช้ log levels ที่ถูกต้อง
- ใช้ error tracking services

### Error Propagation

ส่ง errors อย่างถูกต้อง

- ไม่ swallow errors โดยไม่จำเป็น
- ใช้ error boundaries สำหรับ UI
- ใช้ global error handlers
- ใช้ proper async error handling
- ใช้ circuit breakers สำหรับ external services

### Error Messages

ใช้ error messages ที่ชัดเจน

- ใช้ messages ที่ user-friendly
- ใช้ error codes สำหรับ debugging
- เพิ่ม suggestions สำหรับการแก้ไข
- แปล messages สำหรับ i18n
- ซ่อน sensitive information

### Error Testing

ทดสอบ error handling

- เขียน tests สำหรับ error cases
- เขียน tests สำหรับ error boundaries
- เขียน tests สำหรับ error recovery
- ใช้ mock errors ใน tests
- ทดสอบ error messages

## Expected Outcome

- Error handling ที่ consistent ทั่ว codebase
- Custom error types ที่ structured
- Error logging ที่ comprehensive
- Error propagation ที่ correct
- Error messages ที่ user-friendly
- Error tests ที่ครอบคลุม
- Commit เสร็จสมบูรณ์ตาม conventional commits
