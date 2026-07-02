---
title: Watch Browser
description: เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง
auto_execution_mode: 3
related_workflows:
  - /follow-agent-browser
  - /run-verify
  - /resolve-errors
---

## Goal

เปิดเบราว์เซอร์ด้วย `agent-browser` และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ errors อัตโนมัติ

## Scope

ใช้สำหรับ watch และ monitor หน้าเว็บต่อเนื่องด้วย `agent-browser` CLI หลังจาก verify ผ่าน

## Execute

### 1. Run Verify

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ดก่อนเปิด browser
2. ตรวจสอบว่า scan, typecheck, lint, และ test ผ่านทั้งหมม
3. ถ้ามี errors ให้แก้ไขจนกว่าจะผ่าน
4. รัน dev server หลังจาก verify ผ่าน

### 2. Open Browser

1. ทำ `/follow-agent-browser` สำหรับ installation และ usage guidelines
2. เปิดเบราว์เซอร์ด้วย `agent-browser --headed open <url>`
3. ใช้ `command chaining` && สำหรับ operations ต่อเนื่อง
4. ถ้า `daemon` error ให้ `agent-browser close --all` แล้วเปิดใหม่ หรือใช้ `browser-preview` แทน

### 3. Watch And Monitor

1. ใช้ `agent-browser snapshot -i` เพื่อดู interactive elements และ `@eN` refs
2. ใช้ `agent-browser network requests` เพื่อ monitor network requests
3. ใช้ `agent-browser screenshot --annotate` เพื่อ capture annotated screenshot
4. Re-snapshot ทุกครั้งหลัง page change เพราะ refs เปลี่ยนทุกครั้ง
5. จัดการ errors ที่เกิดขึ้นด้วย `/resolve-errors`

## Rules

### 1. Browser Configuration

ทำตาม `/follow-agent-browser`

- ใช้ `agent-browser` เท่านั้นในการจัดการเบราว์เซอร์
- ใช้ `--headed` เพื่อเปิด browser แบบมองเห็นหน้าต่าง
- ใช้ `--session` สำหรับ isolated sessions

### 2. Watch Strategy

- ใช้ `snapshot -i` แทน `snapshot` เต็มเพื่อลด token
- Re-snapshot ทุกครั้งหลัง page change
- ใช้ `network requests` เพื่อ monitor API calls
- ใช้ `screenshot --annotate` เพื่อ capture พร้อม numbered labels

### 3. Error Handling

- เมื่อเจอ error ต้องเรียก `/resolve-errors` ทันที
- ถ้า `daemon` error ให้ `agent-browser close --all` แล้วเปิดใหม่
- ถ้ายังไม่ได้ ให้ใช้ `browser-preview` แทน

## Expected Outcome

- Browser เปิดและ watch URL อย่างต่อเนื่อง
- Console และ network requests ถูก monitor อย่างต่อเนื่อง
- Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติ
- การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ


