---
title: Run Development Workflow
description: รัน development server และแก้ไขข้อผิดพลาดตามมาตรฐาน
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการรัน development server และแก้ไขข้อผิดพลาดที่เกิดขึ้น

## Rules

1. การตรวจสอบก่อนรัน

- ต้องตรวจสอบ main config ก่อนรัน dev server
- ถ้าไม่มี dev script ใน main config ต้องกำหนดให้
- ตรวจสอบว่า dependencies ที่จำเป็นถูกติดตั้งแล้ว
- ตรวจสอบว่า environment variables ที่จำเป็นถูกกำหนดแล้ว

2. การรันและแก้ไขข้อผิดพลาด

- ต้องแก้ไขข้อผิดพลาดทั้งหมดจนกว่าจะผ่าน
- รัน dev server ด้วยคำสั่งที่เหมาะสม (bun dev, npm run dev, cargo run, ฯลฯ)
- ติดตามและแก้ไขข้อผิดพลาดที่เกิดขึ้นทันที

3. การเปิดเบราว์เซอร์

- ถ้า run dev ที่ต้องเปิด URL ให้รัน `/watch-browser` เสมอ
- ตรวจสอบว่า dev server ทำงานได้จริงผ่าน browser

4. การตรวจสอบผลลัพธ์

- ตรวจสอบว่า dev server เริ่มต้นสำเร็จ
- ยืนยันว่าไม่มี critical errors ที่ขัดขวางการทำงาน
- ตรวจสอบว่า services ที่เกี่ยวข้องทำงานปกติ

## Execute

1. ตรวจสอบ main config และ dev script ว่ามีการกำหนดไว้หรือไม่
2. วิเคราะห์โปรเจกต์ structure และ dependencies เพื่อประเมินปัญหาที่อาจเกิดขึ้น
3. ดำเนินการรัน dev server ด้วยคำสั่งที่เหมาะสม
4. ติดตามและแก้ไขข้อผิดพลาดที่เกิดขึ้นทันทีจนกว่าจะผ่าน
5. ถ้าต้องเปิด URL ให้รัน `/watch-browser` เพื่อตรวจสอบผ่าน browser
6. ทดสอบเข้าถึง dev server และตรวจสอบว่า features หลักทำงานได้
7. ยืนยันว่าไม่มี runtime errors ใน console และ development environment พร้อมใช้งาน