---
title: Watch Browser
description: เปิดเบราว์เซอร์ด้วย agent-browser และ watch หน้าเว็บต่อเนื่อง
auto_execution_mode: 3
url: https://agent-browser.dev
related_workflows:
  - /follow-agent-browser
  - /resolve-errors
  - /run-typecheck
---

## Goal

เปิดเบราว์เซอร์ด้วย `agent-browser` และ watch หน้าเว็บต่อเนื่อง พร้อมจัดการ errors อัตโนมัติ

## Scope

ใช้สำหรับ browser automation และ continuous monitoring ด้วย `agent-browser` CLI

## Execute

### 1. Run Typecheck

ทำ `/run-typecheck` ก่อนเริ่ม watch browser เพื่อให้แน่ใจว่าโค้ดผ่าน type check

### 2. Install And Verify Agent Browser

ติดตั้งและตรวจสอบ `agent-browser` ตาม `/follow-agent-browser` ข้อ 1

1. ตรวจสอบการติดตั้งด้วย `agent-browser --help`
2. ถ้าไม่ได้ติดตั้ง ให้ติดตั้งด้วย `npm install -g agent-browser`
3. ดาวน์โหลด Chrome ด้วย `agent-browser install`
4. ถ้าติดตั้งไม่ได้ ให้ใช้ `playwriter` skill หรือ `browser-preview` tool แทน

### 3. Open Browser

เปิด browser และ navigate ไปยัง URL ที่ต้องการ watch ตาม `/follow-agent-browser` ข้อ 2

1. ใช้ `agent-browser open <url> --headed` เพื่อเปิด browser แบบมองเห็นหน้าต่าง
2. ถ้าเปิดไม่ได้ ให้ใช้ `browser-preview` tool แทน

### 4. Watch And Monitor

Monitor ตาม ## Rules ข้อ 1 และจัดการ errors ตาม ## Rules ข้อ 2

## Rules

### 1. Continuous Monitoring

Monitor อย่างต่อเนื่องและมีประสิทธิภาพ ดูคำสั่งเต็มที่ `/follow-agent-browser` ข้อ 4

- ใช้ `agent-browser snapshot -i` เพื่อดู interactive elements และ refs อย่างต่อเนื่อง
- ใช้ `agent-browser snapshot` เพื่อดู full accessibility tree
- ใช้ `agent-browser screenshot` เมื่อจำเป็นสำหรับ debugging
- ใช้ `agent-browser screenshot --annotate` สำหรับ annotated screenshot พร้อม element labels
- ใช้ `agent-browser console` สำหรับดู console messages
- ใช้ `agent-browser errors` สำหรับดู page errors

### 2. Error Handling

จัดการ errors ตาม `/follow-agent-browser` ข้อ 5

- เมื่อเจอ error ต้องเรียก `/resolve-errors` ทันที
- ถ้า `daemon` error ให้ใช้ `browser-preview` tool แทน
- ถ้า `agent-browser` ไม่ติดตั้ง ให้ใช้ `playwriter` skill แทน
- บันทึก error logs ด้วย `agent-browser console` และ `agent-browser errors`
- ตรวจสอบ element availability ก่อน interact ด้วย `agent-browser wait @e1`

## Expected Outcome

- Browser เปิดและ watch URL อย่างต่อเนื่อง
- Console และ network requests ถูก monitor อย่างต่อเนื่อง
- Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติ
- การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ
