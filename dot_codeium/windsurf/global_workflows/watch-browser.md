---
title: Watch Browser
description: เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง
auto_execution_mode: 3
related_workflows:
  - /follow-agent-browser
  - /resolve-errors
---

## Goal

เปิดเบราว์เซอร์ด้วย `agent-browser` และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ errors อัตโนมัติ

## Scope

ใช้สำหรับ browser automation และ web testing ด้วย `agent-browser` CLI

## Execute

### 1. Run Typecheck

ทำ `/run-typecheck` ก่อนเริ่ม watch browser เพื่อให้แน่ใจว่าโค้ดผ่าน type check

### 2. Use Agent Browser

ทำตาม `/follow-agent-browser` สำหรับ browser automation และ configuration ทั้งหมด

### 3. Watch And Monitor

Monitor ตาม ## Rules ข้อ 1 และจัดการ errors ตาม ## Rules ข้อ 2

## Rules

### 1. Continuous Monitoring

Monitor อย่างต่อเนื่องและมีประสิทธิภาพ

- Monitor console messages และ errors อย่างต่อเนื่อง
- Monitor network requests และ responses
- ใช้ `snapshot` เพื่อดู accessibility tree อย่างต่อเนื่อง
- ใช้ `screenshot` เมื่อจำเป็นสำหรับ debugging

### 2. Error Handling

จัดการ errors ที่เกิดขึ้นอย่างถูกต้อง

- เมื่อเจอ error ต้องเรียก `/resolve-errors` ทันที
- ถ้า `daemon` error ให้ใช้ `browser-preview` แทน
- บันทึก error logs สำหรับ debugging
- ตรวจสอบ element availability ก่อน interact

## Expected Outcome

- Browser เปิดและ watch URL อย่างต่อเนื่อง
- Console และ network requests ถูก monitor อย่างต่อเนื่อง
- Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติ
- การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ
