---
description: รัน lint และแก้ไขทุกอย่างให้ผ่านหมด (error, warning, message)
title: run-lint
auto_execution_mode: 3
---

## 1. Pre-Execution

1. ตรวจสอบสภาพแวดล้อมและเครื่องมือที่จำเป็น
   - ตรวจสอบว่ามี package.json อยู่ในโปรเจกต์
   - ยืนยันว่าติดตั้ง bun, biome, oxlint, dprint แล้ว
   - ตรวจสอบว่ามี lint script ใน package.json

2. ค้นหาข้อมูล lint best practices จาก internet (ถ้าจำเป็น)
   - ใช้ web search ค้นหา "biome lint best practices [current_year]"
   - ค้นหา "oxlint configuration guide [current_year]"
   - ค้นหา "rust lint rules recommendations [current_year]"
   - ศึกษาและนำมาปรับใช้กับโปรเจกต์

3. วิเคราะห์โครงสร้างโปรเจกต์ปัจจุบัน
   - ตรวจสอบว่าเป็น monorepo หรือ single package
   - ระบุประเภทของโปรเจกต์ (Rust, TypeScript, หรือ mixed)
   - ตรวจสอบไฟล์คอนฟิก lint ที่มีอยู่ (biome.json, .oxlintrc.json, etc.)

## 2. Main Operations

1. ตรวจสอบและตั้งค่า lint script ใน package.json
   - ยืนยันว่ามี lint script อยู่ใน package.json
   - ตรวจสอบคำสั่ง lint ที่กำหนด (biome lint --write && oxlint --fix --type-aware && tsc --noEmit)
   - ถ้าไม่มีให้สร้าง lint script ตามมาตรฐาน

2. รันคำสั่ง lint แบบแก้ไขทุกอย่าง
   ```bash
   bun run lint
   ```
   - รัน lint ตามที่ระบุใน package.json
   - ตรวจสอบผลลัพธ์ที่ได้
   - บันทึกข้อผิดพลาดที่พบ

3. รันคำสั่ง format เพิ่มเติม
   ```bash
   bun run format
   ```
   - รัน format ด้วย biome format --write และ dprint
   - ตรวจสอบว่าไม่มีปัญหาการจัดรูปแบบ

4. การแก้ไขข้อผิดพลาดทั้งหมด
   - **ระบุข้อผิดพลาดทั้งหมด**
     - ตรวจสอบ error ที่เกิดขึ้น
     - ตรวจสอบ warning ที่เหลืออยู่
     - ตรวจสอบ message หรือ suggestion ที่แนะนำให้ทำ
     - จัดลำดับความสำคัญของปัญหา (error > warning > message)
   
   - **แก้ไขปัญหาตามลำดับความสำคัญ**
     - แก้ไข error ร้ายแรงก่อนเป็นอันดับแรก
     - แก้ไข warning ที่เหลืออยู่ให้หมด
     - แก้ไข message หรือ suggestion ต่างๆ ให้ครบถ้วน
     - ถ้าต้องการ refactor ให้ทำตาม [refactor](/refactor)
   
   - **รันซ้ำจนกว่าจะไม่มีอะไรเหลือ**
     ```bash
     bun run lint
     bun run format
     ```
     - รันซ้ำจนกว่าจะไม่มี error, warning, message เหลืออยู่เลย
     - ทำวนไปจนกว่าผลลัพธ์จะ clean 100%

5. ค้นหาและแก้ไขปัญหาเฉพาะทาง (ถ้าจำเป็น)
   - ใช้ web search ค้นหา solutions สำหรับ error ที่ยากต่อการแก้ไข
   - ค้นหา "[error_message] solution biome rust"
   - ค้นหา "[warning_name] fix oxlint typescript"
   - ประยุกต์ใช้ solution ที่เหมาะสมกับโปรเจกต์

## 3. Validation

1. การตรวจสอบการรัน lint
   - ยืนยันว่า lint script มีอยู่ใน package.json
   - ยืนยันว่าคำสั่ง lint รันสำเร็จ
   - ยืนยันว่าไม่มี error เหลืออยู่

2. การตรวจสอบการแก้ไขข้อผิดพลาด
   - ยืนยันว่า error, warning, message ถูกระบุถูกต้อง
   - ยืนยันว่าการแก้ไขเรียงลำดับตามความสำคัญ
   - ยืนยันว่าไม่มีข้อผิดพลาดใหม่เกิดขึ้นหลังแก้ไข

3. การตรวจสอบขั้นสุดท้าย
   - ยืนยันว่าไม่มีข้อผิดพลาดและคำเตือนเหลืออยู่
   - ยืนยันว่าไม่มี message หรือ suggestion เหลืออยู่
   - รัน lint อีกครั้งเพื่อยืนยันว่า clean 100%
   - ตรวจสอบว่าผลลัพธ์แสดงผ่านทั้งหมด

## 4. Verification

1. การตรวจสอบการรัน lint
   - ยืนยันว่า lint command ทำงานได้
   - ตรวจสอบว่าไม่มี error ในการรัน
   - ตรวจสอบว่าไม่มี warning เหลืออยู่

2. การตรวจสอบการแก้ไข
   - ยืนยันว่าข้อผิดพลาดทั้งหมดถูกแก้ไข
   - ยืนยันว่า warning ทั้งหมดถูกแก้ไข
   - ยืนยันว่า message/suggestion ทั้งหมดถูกจัดการ
   - ตรวจสอบว่าโค้ดยังคงทำงานได้

3. การตรวจสอบขั้นสุดท้าย
   - ยืนยันว่า lint pass ทั้งหมด
   - ตรวจสอบว่าไม่มี warnings เหลืออยู่
   - ตรวจสอบว่าไม่มี messages เหลืออยู่
   - ยืนยันว่าโปรเจกต์พร้อมสำหรับ commit
