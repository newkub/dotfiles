---
description: แก้ไขข้อผิดพลาดและคำเตือนจากการเฝ้าดูเบราว์เซอร์
title: watch-browser-and-fix
auto_execution_mode: 3
---

## 1. Pre-Execution

1. ตรวจสอบว่ามีเบราว์เซอร์ที่สามารถเข้าถึงได้
2. ยืนยันว่า MCP agent-browser พร้อมใช้งาน
3. ตรวจสอบว่าแอปพลิเคชันหรือเว็บไซต์กำลังทำงานอยู่
4. เตรียมเครื่องมือสำหรับ debugging และแก้ไขโค้ด

## 2. Main Operations

1. **เริ่มการเฝ้าดูเบราว์เซอร์**
   - เปิด browser preview ด้วย MCP agent-browser
   - ตั้งค่า URL ของแอปพลิเคชันที่ต้องการตรวจสอบ
   - เปิด console logs และ network monitoring

2. **ตรวจสอบ console สำหรับ errors และ warnings**
   - ดู JavaScript errors ใน console
   - ตรวจสอบ network requests ที่ล้มเหลว
   - หา resource loading issues
   - ตรวจสอบ CSS และ layout problems

3. **ระบุปัญหาและสาเหตุ**
   - บันทึก error messages ทั้งหมด
   - วิเคราะห์ stack traces
   - ตรวจสอบ source code ที่เกี่ยวข้อง
   - ระบุ dependencies ที่ขาดหายไป

4. **แก้ไขปัญหาตามลำดับความสำคัญ**
   - แก้ไข critical errors ที่ทำให้แอปไม่ทำงาน
   - จัดการ JavaScript errors และ exceptions
   - แก้ไข CSS และ layout issues
   - จัดการ warnings ที่ส่งผลกระทบต่อ performance

5. **ทดสอบการแก้ไข**
   - รีเฟรชเบราว์เซอร์หลังแก้ไขแต่ละปัญหา
   - ตรวจสอบว่า error หายไปจริง
   - ทดสอบฟังก์ชันการทำงานที่เกี่ยวข้อง
   - ยืนยันว่าไม่มีปัญหาใหม่เกิดขึ้น

## 3. Validation

1. **ตรวจสอบ console ว่าสะอาด**
   - ยืนยันว่าไม่มี JavaScript errors
   - ตรวจสอบว่าไม่มี critical warnings
   - ยืนยันว่าทุก resources โหลดสำเร็จ

2. **ทดสอบฟังก์ชันการทำงานหลัก**
   - ทดสอบ user interactions ทั้งหมด
   - ตรวจสอบ responsive design
   - ทดสอบ form submissions และ API calls
   - ยืนยันว่าแอปทำงานตามที่คาดหวัง

## 4. Verification

1. **ทดสอบข้ามเบราว์เซอร์**
   - ทดสอบบน Chrome, Firefox, Safari ถ้าจำเป็น
   - ตรวจสอบความเข้ากันได้ของ features
   - ยืนยันว่า user experience สม่ำเสมอ

2. **ตรวจสอบ performance**
   - ตรวจสอบ page load times
   - วิเคราะห์ network requests
   - ยืนยันว่าไม่มี memory leaks
   - ตรวจสอบว่า animations ทำงานได้ลื่นไหล

3. **สรุปผลการแก้ไข**
   - บันทึกรายการปัญหาที่แก้ไขแล้ว
   - ระบุสาเหตุของปัญหาแต่ละรายการ
   - บันทึกวิธีการแก้ไขที่ใช้
   - เตรียมข้อมูลสำหรับการทบทวนในอนาคต

