---
title: Run Dev
description: รัน development server และแก้ไขข้อผิดพลาด
auto_execution_mode: 3
---

## Goal

รัน development server และแก้ไขข้อผิดพลาดที่เกิดขึ้น

## Execute

### 1. Check Configuration

1. ตรวจสอบ main config และ dev script ว่ามีการกำหนดไว้หรือไม่
2. ถ้าไม่มี dev script ใน main config ต้องกำหนดให้
3. ตรวจสอบว่า dependencies ที่จำเป็นถูกติดตั้งแล้ว
4. ตรวจสอบว่า environment variables ที่จำเป็นถูกกำหนดแล้ว

### 2. Run Dev Server

1. ดำเนินการรัน dev server ด้วยคำสั่งที่เหมาะสม (bun dev, npm run dev, cargo run)
2. ถ้ามี errors ให้รัน `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ
3. `/analyze-errors` จะตัดสินใจว่าควรไป workflow ไหนต่อ:
   - ถ้าเป็น cascade issues → `/debug-issue` → `/resolve-errors`
   - ถ้าเป็น isolated errors → `/resolve-errors`
4. ติดตามและแก้ไขข้อผิดพลาดที่เกิดขึ้นทันทีจนกว่าจะผ่าน
5. ตรวจสอบว่า dev server เริ่มต้นสำเร็จ

### 3. Open Browser and Watch (ถ้าจำเป็น)

1. ถ้า run dev ที่ต้องเปิด URL ให้เลือก:
   - ถ้าต้องการตรวจสอบผ่าน browser automation → รัน `/watch-browser`
   - ถ้าต้องการเปิดใน browser เท่านั้น → รัน `/open-web`
   - ถ้าต้องการ watch terminal ทุก 5 วินาที → รัน `/watch-terminal`
2. ตรวจสอบว่า dev server ทำงานได้จริงผ่าน browser
3. ทดสอบเข้าถึง dev server และตรวจสอบว่า features หลักทำงานได้

### 4. Verify

1. ยืนยันว่าไม่มี critical errors ที่ขัดขวางการทำงาน
2. ตรวจสอบว่า services ที่เกี่ยวข้องทำงานปกติ
3. ยืนยันว่าไม่มี runtime errors ใน console
4. ตรวจสอบว่า development environment พร้อมใช้งาน

### 5. Report

1. รัน `/report-format-terminal` เพื่อวาด terminal output ด้วย ANSI codes
2. รัน `/report-format-table` เพื่อจัดรูปแบบตาราง
3. แสดงผลลัพธ์ที่จัดรูปแบบแล้ว

## Rules

- ใช้คำสั่งที่เหมาะสมกับ runtime (bun dev, npm run dev, cargo run)
- ติดตามและแก้ไขข้อผิดพลาดทันทีจนกว่าจะผ่าน
- ตรวจสอบว่า dev server เริ่มต้นสำเร็จก่อนเปิด browser

## Expected Outcome

- Development server ทำงานได้
- ไม่มี critical errors
- Features หลักทำงานได้
