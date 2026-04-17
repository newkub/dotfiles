---
title: Run Build
description: รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts
auto_execution_mode: 3
---

## Goal

รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts

## Execute

### 1. Optimize Build

1. ตรวจสอบ build configuration
2. optimize dependencies และ imports
3. ลบ unused code และ assets
4. ตั้งค่า build optimization options

### 2. Typecheck

1. รัน `bun run typecheck`
2. ตรวจสอบ TypeScript types ทั้งหมด
3. แก้ไข type errors ถ้ามี

### 3. Install Dependencies

1. รัน `bun install`
2. ตรวจสอบ dependencies ครบถ้วน
3. อัพเดทถ้าจำเป็น

### 4. Clean Build Artifacts

1. ลบโฟลเดอร์ build/dist เก่า
2. ลบ cache ที่ไม่จำเป็น
3. ตรวจสอบว่าเริ่ม build สะอาด

### 5. Execute Build

1. รัน `bun run build` หรือ script ที่กำหนด
2. ติดตาม progress ของ build
3. บันทึกเวลาที่ใช้

### 6. Verify Output

1. ตรวจสอบ build artifacts ถูกสร้าง
2. ตรวจสอบ file size ที่เหมาะสม
3. verify production readiness

## Rules

### 1. Build Order

- Optimize: optimize build ก่อนเริ่ม
- Typecheck: ตรวจสอบ types ก่อน build
- Install: ติดตั้ง dependencies
- Clean: ลบ build artifacts เก่า
- Build: รัน build command
- Verify: ตรวจสอบ output

### 2. Error Handling

- Typecheck ล้มเหลว: หยุดและแก้ไข errors ก่อน build
- Build ล้มเหลว: วิเคราะห์ error และแก้ไข
- Warning: บันทึกและพิจารณาแก้ไข

## Expected Outcome

- Build สำเร็จไม่มี errors
- Typecheck ผ่านทั้งหมด
- Build artifacts ถูกต้อง
- Output สามารถใช้งานได้จริง
