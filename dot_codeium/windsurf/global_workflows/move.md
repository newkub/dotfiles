---
description: ย้ายไฟล์แบบ safe move ด้วย PowerShell
auto_execution_mode: 3
---

## 1. Preparation

1. ตรวจสอบไฟล์ต้นทางมีอยู่จริง
- ใช้ Test-Path เพื่อตรวจสอบไฟล์ต้นทาง
- ยืนยัน path ถูกต้อง
2. ตรวจสอบโฟลเดอร์ปลายทาง
- ใช้ Test-Path เพื่อตรวจสอบโฟลเดอร์ปลายทาง
- สร้างโฟลเดอร์ถ้ายังไม่มี
3. ตรวจสอบไม่มีไฟล์ซ้ำที่ปลายทาง
- ใช้ Test-Path เพื่อตรวจสอบไฟล์ปลายทาง
- แจ้งเตือนถ้ามีไฟล์อยู่แล้ว
4. สำรองข้อมูลก่อนย้าย
- สร้าง backup folder ถ้าจำเป็น
- คัดลอกไฟล์ไปยัง backup ก่อน

## 2. Safe Move Operations

1. ย้ายไฟล์ด้วย Move-Item
- ใช้ -Force parameter เพื่อเขียนทับ
- ใช้ -ErrorAction Stop เพื่อหยุดถ้าเกิด error
2. ตรวจสอบผลลัพธ์การย้าย
- ใช้ Test-Path ตรวจสอบไฟล์ปลายทาง
- ยืนยันว่าไฟล์ต้นทางถูกลบ
3. จัดการ permissions
- คง permissions เดิมไว้
- ตรวจสอบ access rights
4. ทำความสะอาด
- ลบ temporary files
- อัพเดท metadata

## 3. Validation

1. ตรวจสอบไฟล์ต้นทางมีอยู่จริง
- Test-Path $sourcePath ต้องคืนค่า $true
- ตรวจสอบ file size และ attributes
2. ตรวจสอบโฟลเดอร์ปลายทางพร้อม
- Test-Path $destinationFolder ต้องคืนค่า $true
- ตรวจสอบ write permissions
3. ตรวจสอบไม่มีไฟล์ซ้ำ
- Test-Path $destinationPath ต้องคืนค่า $false
- หรือมีการ confirm จาก user
4. ตรวจสอบ backup เสร็จสิ้น
- Backup file มีอยู่ใน backup folder
- File size ตรงกับต้นฉบับ

## 4. Verification

1. ตรวจสอบไฟล์ย้ายสำเร็จ
- Test-Path $destinationPath ต้องคืนค่า $true
- Test-Path $sourcePath ต้องคืนค่า $false
2. ตรวจสอบความสมบูรณ์ของไฟล์
- File size ตรงกับต้นฉบับ
- File hash ตรงกัน (ถ้าจำเป็น)
3. ตรวจสอบ permissions ถูกต้อง
- Get-Acl $destinationPath แสดง permissions
- User มีสิทธิ์เข้าถึงไฟล์
4. ตรวจสอบการทำความสะอาด
- ไม่มี temporary files เหลืออยู่
- Log files ถูกสร้างถูกต้อง
