---
title: Refactor Packages
description: ปรับปรุงคุณภาพโค้ดใน packages ตาม best practices
auto_execution_mode: 3
---

## Goal

ปรับปรุงโครงสร้างและคุณภาพโค้ดใน packages ให้เป็นไปตามมาตรฐาน

## Execute

### 1. Analyze Packages

1. ตรวจสอบ dependencies ทั้งหมดใน packages
2. วิเคราะห์ dependencies ที่ไม่ได้ใช้หรือเก่า
3. ตรวจสอบ code duplication ระหว่าง packages
4. วิเคราะห์ coupling ระหว่าง packages

### 2. Refactor Code

1. ลบ dependencies ที่ไม่ได้ใช้
2. อัพเดท dependencies เป็น version ล่าสุด
3. ย้าย shared code ไปที่ shared packages
4. ปรับปรุง structure ตาม architecture ที่เหมาะสม

### 3. Update References

1. อัพเดท import paths ทั้งหมด
2. อัพเดท exports ใน package.json
3. อัพเดท TypeScript configurations
4. อัพเดท documentation

### 4. Validate

1. รัน type checking ทั้งหมด
2. รัน linting ทั้งหมด
3. รัน tests ทั้งหมด
4. ตรวจสอบ build process

## Rules

### 1. Dependencies

- ใช้ `/update-dependencies` สำหรับอัพเดท dependencies
- ตรวจสอบ security vulnerabilities ก่อนอัพเดท
- ทำทีละ package เพื่อความปลอดภัย

### 2. Code Structure

- ทำตาม `/follow-architecture` ที่เหมาะสมกับขนาด
- ใช้ import alias แทน relative paths
- แยก business logic จาก infrastructure

### 3. Refactoring

- ทำตาม `/refactor` สำหรับการปรับปรุงโค้ด
- ทำตาม `/improve-code` สำหรับการปรับปรุงครบวงจร
- ทำตาม `/relocation` สำหรับการย้ายไฟล์

### 4. Validation

- ต้องผ่าน type checking ทั้งหมด
- ต้องผ่าน linting ทั้งหมด
- ต้องผ่าน tests ทั้งหมด
- ต้อง build สำเร็จ

## Expected Outcome

- Packages มี dependencies ที่ clean และเป็นปัจจุบัน
- Code structure เป็นไปตามมาตรฐาน
- ไม่มี code duplication ระหว่าง packages
- ทุกอย่างผ่าน validation
