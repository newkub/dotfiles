---
title: Watch Browser
description: เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง
auto_execution_mode: 3
---

## Goal

เปิดเบราว์เซอร์ด้วย `agent-browser` และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ errors อัตโนมัติ

## Scope

ใช้สำหรับ browser automation และ web testing ด้วย `agent-browser` CLI

## Execute

### 1. Run Verify

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ดก่อนเปิด browser
2. ตรวจสอบว่า scan, typecheck, lint, และ test ผ่านทั้งหมม
3. ถ้ามี errors ให้แก้ไขจนกว่าจะผ่าน
4. รัน dev server หลังจาก verify ผ่าน

### 2. Use Agent Browser

ทำตาม `/agent-browser` สำหรับ browser automation

### 3. Watch And Monitor

Monitor ตาม ## Rules ข้อ 2 และ จัดการ errors ตาม ## Rules ข้อ 3

## Rules

### 1. Browser Configuration

ตั้งค่า browser configuration อย่างถูกต้อง

- ทำตาม `/agent-browser` สำหรับ browser configuration ทั้งหมด
- ใช้ `agent-browser` เท่านั้นในการจัดการเบราว์เซอร์
- ใช้ `--headed` เพื่อเปิด browser แบบมองเห็นหน้าต่าง
- ใช้ environment variables สำหรับ configuration ที่ซ้ำซ้อน

### 2. Continuous Monitoring

Monitor อย่างต่อเนื่องและมีประสิทธิภาพ

- Monitor console messages และ errors อย่างต่อเนื่อง
- Monitor network requests และ responses
- ใช้ `snapshot` เพื่อดู accessibility tree อย่างต่อเนื่อง
- ใช้ `screenshot` เมื่อจำเป็นสำหรับ debugging

### 3. Error Handling

จัดการ errors ที่เกิดขึ้นอย่างถูกต้อง

- เมื่อเจอ error ต้องเรียก `/resolve-errors` ทันที
- ถ้า `daemon` error ให้ใช้ `browser-preview` แทน
- บันทึก error logs สำหรับ debugging
- ตรวจสอบ element availability ก่อน interact

### 4. Performance

ปรับปรุง performance สำหรับ operations ต่อเนื่อง

- ใช้ `command chaining` && สำหรับ operations ต่อเนื่อง
- ใช้ `--session` สำหรับ isolated sessions
- ใช้ `--profile` สำหรับ persistent data
- ปิด sessions ที่ไม่ได้ใช้เพื่อประหยัด resources

## Expected Outcome

- Browser เปิดและ watch URL อย่างต่อเนื่อง
- Console และ network requests ถูก monitor อย่างต่อเนื่อง
- Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติ
- การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ
- Performance ถูกปรับปรุงอย่างต่อเนื่อง


