---
title: Watch Terminal Workflow
description: เปิดเบราว์เซอร์และ watch ต่อเรื่อยๆ ทุก 5 วินาที พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
follow:
- "/run-dev"
- "/fix-error"
---

## Prompt

ใช้ workflow นี้เมื่อต้องการเปิดเบราว์เซอร์เพื่อดูผลลัพธ์และ watch terminal ทุกๆ 5 วินาที พร้อมจัดการ errors ที่เกิดขึ้นอัตโนมัติ

## Purpose

ช่วยให้สามารถตรวจสอบและจัดการปัญหาใน development server ได้อย่างต่อเนื่องโดยการ watch terminal ทุก 5 วินาทีและแก้ไข errors อัตโนมัติ

## Rules

- ต้องรัน development server ก่อนเสมอ
- ต้องแก้ไข errors ที่พบก่อนดำเนินการต่อ
- ต้องเปิดเบราว์เซอร์เพื่อดูผลลัพธ์
- ต้อง watch terminal ทุก 5 วินาทีต่อเนื่อง

## Execute

1. check : ตรวจสอบสถานะ project และ environment
   - ตรวจสอบว่าอยู่ใน project directory ที่ถูกต้อง
   - ตรวจสอบว่ามี development script ใน package.json
   - ตรวจสอบว่า dependencies ถูกติดตั้งครบถ้วน

2. analyze : วิเคราะห์สถานะปัจจุบันและปัญหาที่อาจเกิดขึ้น
   - วิเคราะห์ว่ามี errors หรือ warnings อยู่ในปัจจุบันหรือไม่
   - ตรวจสอบว่า development server สามารถรันได้หรือไม่
   - ประเมินว่าต้องการแก้ไขปัญหาอะไรก่อนเริ่ม watch

3. action : ดำเนินการตามขั้นตอน
   - รัน development server ด้วย /run-dev
   - แก้ไข errors ที่พบด้วย /fix-error
   - เปิดเบราว์เซอร์เพื่อดูผลลัพธ์
   - เริ่มการ watch terminal ทุก 5 วินาที

4. validate : ตรวจสอบความถูกต้องของการดำเนินการ
   - ตรวจสอบว่า development server รันสำเร็จ
   - ยืนยันว่า errors ถูกแก้ไขหมดแล้ว
   - ตรวจสอบว่าเบราว์เซอร์แสดงผลลัพธ์ถูกต้อง

5. verify : ยืนยันผลลัพธ์สุดท้าย
   - ตรวจสอบว่า terminal watch ทำงานทุก 5 วินาที
   - ยืนยันว่าสามารถตรวจจับและแก้ไข errors ใหม่ๆ ได้
   - ตรวจสอบว่าเบราว์เซอร์แสดงการเปลี่ยนแปลงแบบ real-time

6. review : ทบทวนผลลัพธ์และกระบวนการเพื่อความมั่นใจ
   - ตรวจสอบอีกครั้งว่า watch system ทำงานได้ตามที่คาดหวัง
   - ยืนยันว่าไม่มีปัญหาที่ถูกมองข้าม
   - ตรวจสอบว่า workflow สามารถจัดการ errors ได้อย่างมีประสิทธิภาพ

## Expected Outcome

Development environment ที่ทำงานได้อย่างต่อเนื่อง:
- Development server รันอยู่เสมอ
- Errors ถูกตรวจจับและแก้ไขอัตโนมัติ
- เบราว์เซอร์แสดงผลลัพธ์แบบ real-time
- Terminal ถูก watch ทุก 5 วินาทีต่อเนื่อง

