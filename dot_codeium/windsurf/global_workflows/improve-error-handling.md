---
title: Improve Error Handling
description: ปรับปรุง error handling และ resilience ครบวงจร
auto_execution_mode: 3
related_workflows:
  - /improve-codebase
  - /improve-monitoring
  - /improve-side-effect
---

## Goal

ปรับปรุง error handling และ resilience ครบวงจรเพื่อให้ระบบทนทานต่อข้อผิดพลาด

## Scope

ใช้สำหรับการตั้งค่า error boundaries, retry mechanisms, circuit breakers, และ graceful degradation

## Execute

### 1. Error Boundaries

ตั้งค่า error boundaries สำหรับ catch errors

1. ตั้งค่า error boundaries ใน React/Solid components
2. ตั้งค่า global error handler ใน server
3. ตั้งค่า error boundary สำหรับ async operations
4. แสดง error UI ที่เป็นมิตรกับผู้ใช้
5. Log errors ที่ถูก catch
6. ให้ผู้ใช้ recover จาก errors

### 2. Retry Mechanisms

ตั้งค่า retry mechanisms สำหรับ transient failures

1. ใช้ exponential backoff สำหรับ retries
2. ตั้งค่า max retry attempts
3. ตั้งค่า retry delay ที่เหมาะสม
4. Retry เฉพาะ errors ที่เป็น transient
5. ไม่ retry สำหรับ errors ที่เป็น permanent
6. ใช้ jitter สำหรับ avoid thundering herd

### 3. Circuit Breakers

ตั้งค่า circuit breakers สำหรับ prevent cascading failures

1. ใช้ circuit breaker pattern สำหรับ external services
2. ตั้งค่า failure threshold
3. ตั้งค่า timeout สำหรับ open state
4. ตั้งค่า half-open state สำหรับ testing
5. Fallback ไปยัง default response เมื่อ open
6. Monitor circuit breaker state

### 4. Graceful Degradation

ตั้งค่า graceful degradation สำหรับ maintain functionality

1. ปิด features ที่ไม่ critical เมื่อ load สูง
2. ใช้ cached data เมื่อ backend ล้ม
3. แสดง degraded UI เมื่อ features ไม่ available
4. Queue requests เมื่อ overload
5. Prioritize critical paths
6. แจ้งผู้ใช้เมื่อ system degraded

### 5. Error Tracking

ตั้งค่า error tracking สำหรับ monitor errors

1. ใช้ Sentry หรือ similar service
2. Track unhandled errors
3. Track error rates และ trends
4. Group similar errors
5. ตั้งค่า error alerts
6. Link errors กับ traces และ logs

### 6. Improve Side Effects

ปรับปรุงการจัดการ side effects

1. ทำ `/improve-side-effect` เพื่อจัดการ side effects ด้วย Effect-TS
2. Wrap error-prone operations ด้วย Effect-TS patterns
3. ใช้ `Effect.try` สำหรับ error handling
4. ใช้ `Effect.retry` สำหรับ transient failures

## Rules

### 1. Don't Swallow Errors

ไม่ควร swallow errors โดยไม่จัดการ

- Log errors ที่ถูก catch
- ไม่ใช้ empty catch blocks
- Propagate errors ที่ไม่สามารถ handle ได้
- ใช้ error types ที่เหมาะสม

### 2. User-Friendly Error Messages

แสดง error messages ที่เป็นมิตรกับผู้ใช้

- ไม่แสดง technical details ให้ผู้ใช้
- แสดง action items ที่ชัดเจน
- ใช้ภาษาที่ผู้ใช้เข้าใจ
- ให้ options สำหรับ recover

### 3. Idempotent Operations

ทำให้ operations เป็น idempotent

- Retry ไม่ควร cause side effects
- ใช้ unique IDs สำหรับ detect duplicates
- Design APIs ให้ idempotent
- Track processed requests

### 4. Timeout Configuration

ตั้งค่า timeouts อย่างระมัดระวัง

- ตั้งค่า timeout สำหรับ external calls
- ตั้งค่า timeout สำหรับ database queries
- ตั้งค่า timeout สำหรับ user operations
- ไม่ตั้ง timeout สั้นเกินไป
- ไม่ตั้ง timeout ยาวเกินไป

## Expected Outcome

- Errors ถูก catch และ handle อย่างเหมาะสม
- System ทนทานต่อ transient failures
- Cascading failures ถูกป้องกัน
- System ยังทำงานได้แม้ degraded
- Errors ถูก track และ monitor
- User experience ดีขึ้นเมื่อเกิด errors
