---
title: Run Dev
description: รัน development server และแก้ไขข้อผิดพลาด
auto_execution_mode: 3
---

## Goal

รัน development server และแก้ไขข้อผิดพลาดที่เกิดขึ้น

## Scope

ครอบคลุมการตรวจสอบ configuration รัน development server และแก้ไข runtime errors

## Execute

### 1. Run Format

1. ทำ `/run-format` เพื่อ format code ก่อน
2. รอให้ format เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก format ให้แก้ไขก่อน

### 2. Check Configuration

1. ตรวจสอบ main config และ dev script ว่ามีการกำหนดไว้หรือไม่
2. ถ้าไม่มี dev script ใน main config ต้องกำหนดให้
3. ตรวจสอบว่า dependencies ที่จำเป็นถูกติดตั้งแล้ว
4. ตรวจสอบว่า environment variables ที่จำเป็นถูกกำหนดแล้ว

### 3. Run Dev Server

1. ดำเนินการรัน dev server ด้วยคำสั่งที่เหมาะสม (bun dev, npm run dev, cargo run)
2. ถ้ามี errors ให้รัน `/follow-analyze-errors` เพื่อวิเคราะห์และจัดลำดับ
3. `/follow-analyze-errors` จะตัดสินใจว่าควรไป workflow ไหนต่อ:
   - ถ้าเป็น cascade issues → `/debug-issue` → `/resolve-errors`
   - ถ้าเป็น isolated errors → `/resolve-errors`
4. ติดตามและแก้ไขข้อผิดพลาดที่เกิดขึ้นทันทีจนกว่าจะผ่าน
5. ตรวจสอบว่า dev server เริ่มต้นสำเร็จ

### 4. Open Browser (ถ้าจำเป็น)

1. ถ้า run dev ที่ต้องเปิด URL ให้รัน `/watch-browser` เพื่อตรวจสอบผ่าน browser
2. ตรวจสอบว่า dev server ทำงานได้จริงผ่าน browser
3. ทดสอบเข้าถึง dev server และตรวจสอบว่า features หลักทำงานได้

### 5. Verify

1. ยืนยันว่าไม่มี critical errors ที่ขัดขวางการทำงาน
2. ตรวจสอบว่า services ที่เกี่ยวข้องทำงานปกติ
3. ยืนยันว่าไม่มี runtime errors ใน console
4. ตรวจสอบว่า development environment พร้อมใช้งาน

## Rules

### 1. Pre-run Checks

- ต้องตรวจสอบ main config ก่อนรัน dev server
- ต้องแก้ไขข้อผิดพลาดทั้งหมดจนกว่าจะผ่าน

### 2. Error Handling

- ติดตามและแก้ไขข้อผิดพลาดที่เกิดขึ้นทันที

### 3. Browser Testing

- ถ้า run dev ที่ต้องเปิด URL ให้รัน `/watch-browser` เสมอ

## Expected Outcome

- Development server ทำงานได้
- ไม่มี critical errors
- Features หลักทำงานได้
