---
title: Every Folder
description: ประมวลผลหรือวิเคราะห์ทุกโฟลเดอร์ในโปรเจกต์อย่างเป็นระบบ
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการประมวลผลหรือวิเคราะห์ทุกโฟลเดอร์ในโปรเจกต์อย่างเป็นระบบและครอบคลุม

## Execute

1. Discover All Folders

- ใช้ fd หรือ find เพื่อ list ทุกโฟลเดอร์ในโปรเจกต์
- ยกเว้นโฟลเดอร์ที่ไม่จำเป็น (node_modules, .git, dist, etc.)
- จัดกลุ่มโฟลเดอร์ตามระดับชั้น
- สร้าง directory tree overview

2. Analyze Folder Structure

- วิเคราะห์ organization ของแต่ละโฟลเดอร์
- ระบุ naming conventions
- หา inconsistencies ใน structure
- ประเมิน coupling และ cohesion

3. Process Folders

- ทำการแก้ไข structure ที่จำเป็น
- สร้างโฟลเดอร์ที่ขาดหายไป
- ย้ายไฟล์ให้อยู่ในโฟลเดอร์ที่เหมาะสม
- ใช้ git mv สำหรับการย้าย

4. Verify Results

- ตรวจสอบว่าทุกโฟลเดอร์ถูกประมวลผล
- ยืนยันว่าไม่มี broken imports หรือ references
- ทดสอบการทำงานหลัง restructure
- สร้างรายงานสรุป

## Rules

1. Systematic Approach

- ประมวลผลโฟลเดอร์จาก root ไป leaves
- ไม่ข้ามโฟลเดอร์ใดโฟลเดอร์หนึ่ง
- Document changes อย่างสม่ำเสมอ
- Handle circular dependencies

2. Batch Processing

- จัดกลุ่มโฟลเดอร์ตาม level
- ประมวลผลทีละ batch
- รีสตาร์ทจากจุดที่ค้างได้
- Monitor side effects

3. Safety First

- สำรองก่อน restructure
- Test บน subset ก่อน full run
- ใช้ git ติดตามการเปลี่ยนแปลง
- มี rollback plan

4. Documentation

- บันทึกโฟลเดอร์ที่แก้ไขทั้งหมด
- Document new structure
- สร้าง before/after comparison
- Update README ถ้าจำเป็น

## Expected Outcome

- ทุกโฟลเดอร์ในโปรเจกต์ถูกวิเคราะห์และ/หรือปรับปรุง
- โครงสร้างโฟลเดอร์เป็นระเบียบและ consistent
- ไม่มี broken references หรือ imports
- รายงานสรุปผลการทำงาน