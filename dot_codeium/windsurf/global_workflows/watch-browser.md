---
title: Browser Watch Workflow
description: เปิดเบราว์เซอร์และ watch ต่อเรื่อยๆ ทุก 5 วินาที พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการเปิดเบราว์เซอร์เพื่อ watch หน้าเว็บต่อเรื่อยๆ และต้องการให้จัดการ error อัตโนมัติถ้าเจอปัญหา

## Execute

1. วิเคราะห์ความต้องการและสภาพแวดล้อมก่อนเริ่ม watch
- ตรวจสอบว่ามี URL ที่ต้องการ watch หรือไม่
- ตรวจสอบว่า agent-browser พร้อมใช้งานด้วย `agent-browser --help`
- วิเคราะห์ว่า URL ที่จะ watch มีลักษณะอย่างไร
- ประเมินว่าต้องการ monitor อะไรบ้าง (console, network, UI)

2. ดำเนินการเปิดเบราว์เซอร์และเริ่ม watch
- เปิดเบราว์เซอร์ด้วย `agent-browser --headed open <url>` (ใช้ --headed เสมอ ไม่ใช้แบบ headless)
- ตั้งค่าการ watch ทุก 5 วินาทีด้วย snapshot loop
- เริ่ม monitoring console และ network requests
- ตั้งค่า logging สำหรับบันทึกข้อมูลการ watch

3. ตรวจสอบการทำงานและดำเนินการต่อเนื่อง
- ตรวจสอบว่าเบราว์เซอร์เปิด URL ได้สำเร็จ
- ยืนยันว่าการ watch ทำงานทุก 5 วินาทีตามที่ตั้งค่า
- ถ้าเจอ error ให้เรียก /fix-error ทันที
- ตรวจสอบว่าการแก้ error ไม่กระทบการ watch ต่อเนื่อง

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

