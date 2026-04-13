---
title: Browser Watch Workflow
description: เปิดเบราว์เซอร์และ watch ต่อเรื่อยๆ ทุก 5 วินาที พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
---

## Goal

เปิดเบราว์เซอร์เพื่อ watch หน้าเว็บต่อเนื่องทุก 5 วินาที และจัดการ errors อัตโนมัติด้วย /fix-error

## Execute

### 1. Analyze Requirements

1. ตรวจสอบว่ามี URL ที่ต้องการ watch หรือไม่
2. ตรวจสอบว่า agent-browser พร้อมใช้งานด้วย `agent-browser --help`
3. วิเคราะห์ว่า URL ที่จะ watch มีลักษณะอย่างไร
4. ประเมินว่าต้องการ monitor อะไรบ้าง (console, network, UI)

### 2. Open Browser and Start Watch

1. เปิดเบราว์เซอร์ด้วย `agent-browser --headed open <url>` (ใช้ --headed เสมอ ไม่ใช้แบบ headless)
2. ตั้งค่าการ watch ทุก 5 วินาทีด้วย snapshot loop
3. เริ่ม monitoring console และ network requests
4. ตั้งค่า logging สำหรับบันทึกข้อมูลการ watch

### 3. Verify and Continue Monitoring

1. ตรวจสอบว่าเบราว์เซอร์เปิด URL ได้สำเร็จ
2. ยืนยันว่าการ watch ทำงานทุก 5 วินาทีตามที่ตั้งค่า
3. ถ้าเจอ error ให้เรียก /fix-error ทันที
4. ตรวจสอบว่าการแก้ error ไม่กระทบการ watch ต่อเนื่อง

## Rules

1. การจัดการเบราว์เซอร์
- ใช้ agent-browser เท่านั้นในการจัดการเบราว์เซอร์
- ต้องใช้ --headed เสมอ ไม่ใช้แบบ headless
- ห้ามปิดเบราว์เซอร์โดยเด็ดขาด

2. การ Watch
- ตั้งค่า watch ทุก 5 วินาทีต่อเนื่องไม่หยุด
- Monitor สถานะและ console messages อย่างต่อเนื่อง

3. การจัดการ Error
- เมื่อเจอ error ต้องเรียก /fix-error ทันที
- ตรวจสอบว่าการแก้ error ไม่กระทบการ watch ต่อเนื่อง

## Expected Outcome

1. Browser เปิดและ watch URL อย่างต่อเนื่องทุก 5 วินาที
2. Console และ network requests ถูก monitor อย่างต่อเนื่อง
3. Errors ที่เกิดขึ้นถูกแก้ไขอัตโนมัติด้วย /fix-error
4. การ watch ทำงานต่อเนื่องโดยไม่ขัดจังหวะ

