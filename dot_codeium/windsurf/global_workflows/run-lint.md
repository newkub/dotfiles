---
description: รัน lint และแก้ไข error ตาม config file และ framework
trigger: manual
instruction:
  - ทำตาม /follow-config-file
  - ทำตาม /follow-framework
  - ทำ /sumarize หลังจากเสร็จงาน
---

# การรัน Lint และแก้ไข Error

## Phase 1: เตรียมการ (Preparation)

### 1. ตรวจสอบ Config File
- อ่าน config file ที่เกี่ยวข้อง (เช่น .oxlintrc.json, dprint.json)
- ตรวจสอบว่ามี lint tool ที่กำหนดไว้หรือไม่
- ตรวจสอบว่ามี script สำหรับรัน lint ใน package.json หรือไม่

### 2. ตรวจสอบ Dependencies
- ตรวจสอบว่า lint tool ที่ต้องใช้ถูกติดตั้งแล้ว
- หากยังไม่ติดตั้ง ให้ติดตั้งก่อนรัน lint

---

## Phase 2: รัน Lint (Execution)

### 3. รัน Lint Command
- รันคำสั่ง lint ตามที่กำหนดใน config file
- รอดูผลลัพธ์จาก lint tool
- บันทึก error และ warning ที่พบ

### 4. วิเคราะห์ผลลัพธ์
- จัดกลุ่ม error ตามประเภท (syntax, type, style, etc.)
- จัดลำดับความสำคัญของ error (critical > major > minor)
- ระบุไฟล์ที่มีปัญหา

---

## Phase 3: แก้ไข Error (Fix)

### 5. ตรวจสอบ Framework
- ทำตาม /follow-framework เพื่อระบุ framework ที่ใช้
- ตรวจสอบว่ามี framework ใดๆ ที่เกี่ยวข้องกับไฟล์ที่มี error
- ทำตาม workflow ของ framework ที่พบ

### 6. แก้ไข Error
- แก้ไข error ตามลำดับความสำคัญ (critical > major > minor)
- หลีกเลี่ยงการใช้ pattern กลุ่ม *-ignore เพื่อกลบปัญหา

---
