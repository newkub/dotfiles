---
title: Watch Terminal
description: เปิดเบราว์เซอร์และ watch terminal ทุก 5 วินาที พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
---

## Goal

เปิดเบราว์เซอร์และ watch terminal ทุก 5 วินาที พร้อมจัดการ errors ที่เกิดขึ้นอัตโนมัติ

## Scope

ใช้เมื่อต้องการตรวจสอบและจัดการปัญหาใน development server อย่างต่อเนื่อง

## Execute

1. ตรวจสอบสถานะ project และ environment
   - ตรวจสอบว่าอยู่ใน project directory ที่ถูกต้อง
   - ตรวจสอบว่ามี development script ใน `package.json`
   - ตรวจสอบว่า dependencies ถูกติดตั้งครบถ้วน

2. วิเคราะห์สถานะปัจจุบัน
   - วิเคราะห์ว่ามี errors หรือ warnings อยู่ในปัจจุบันหรือไม่
   - ตรวจสอบว่า development server สามารถรันได้หรือไม่
   - ประเมินว่าต้องการแก้ไขปัญหาอะไรก่อนเริ่ม watch

3. ดำเนินการตามขั้นตอน
   - รัน development server ด้วย `/run-dev`
   - แก้ไข errors ที่พบด้วย `/resolve-errors`
   - เปิดเบราว์เซอร์เพื่อดูผลลัพธ์
   - เริ่มการ watch terminal ทุก 5 วินาที

4. ตรวจสอบความถูกต้อง
   - ตรวจสอบว่า development server รันสำเร็จ
   - ยืนยันว่า errors ถูกแก้ไขหมดแล้ว
   - ตรวจสอบว่าเบราว์เซอร์แสดงผลลัพธ์ถูกต้อง

5. ยืนยันผลลัพธ์สุดท้าย
   - ตรวจสอบว่า terminal watch ทำงานทุก 5 วินาที
   - ยืนยันว่าสามารถตรวจจับและแก้ไข errors ใหม่ๆ ได้
   - ตรวจสอบว่าเบราว์เซอร์แสดงการเปลี่ยนแปลงแบบ real-time

## Rules

### 1. Pre-Check Requirements

ตรวจสอบสิ่งที่ต้องมีก่อนเริ่ม

- ต้องรัน development server ก่อนเสมอ
- ต้องแก้ไข errors ที่พบก่อนดำเนินการต่อ
- ต้องเปิดเบราว์เซอร์เพื่อดูผลลัพธ์
- ต้อง watch terminal ทุก 5 วินาทีต่อเนื่อง

### 2. Error Handling

จัดการ errors ที่เกิดขึ้น

- ใช้ `/resolve-errors` สำหรับแก้ไข errors อัตโนมัติ
- ตรวจสอบ error logs จาก terminal
- แก้ไข root cause ไม่ใช่เพียง symptoms
- ยืนยันว่า errors ถูกแก้ไขอย่างสมบูรณ์

### 3. Terminal Monitoring

ตรวจสอบ terminal อย่างต่อเนื่อง

- Watch terminal ทุก 5 วินาที
- ตรวจจับ errors และ warnings ใหม่ๆ
- ตรวจสอบ build status
- ตรวจสอบ hot reload ทำงานได้

### 4. Browser Verification

ตรวจสอบผลลัพธ์ในเบราว์เซอร์

- เปิดเบราว์เซอร์เพื่อดูผลลัพธ์
- ตรวจสอบว่าการเปลี่ยนแปลงแสดงแบบ real-time
- ตรวจสอบ console errors ในเบราว์เซอร์
- ยืนยันว่า features ทำงานได้ตามที่คาดหวัง

## Expected Outcome

Development environment ที่ทำงานได้อย่างต่อเนื่อง
- Development server รันอยู่เสมอ
- Errors ถูกตรวจจับและแก้ไขอัตโนมัติ
- เบราว์เซอร์แสดงผลลัพธ์แบบ real-time
- Terminal ถูก watch ทุก 5 วินาทีต่อเนื่อง


