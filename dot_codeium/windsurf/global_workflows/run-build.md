---
title: Run Build
description: รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts
auto_execution_mode: 3
- "/validate"
- "/run-typecheck"
- "/run-install"
- "/fix-error-warning"
---

## Purpose

รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts พร้อมตรวจสอบคุณภาพและแก้ไขปัญหา build errors

## Rules

### Build Order

รัน build ตามลำดับ:
1. Typecheck - ตรวจสอบ types ก่อน build
2. Install - ติดตั้ง dependencies
3. Clean - ลบ build artifacts เก่า
4. Build - รัน build command
5. Verify - ตรวจสอบ output

### Error Handling

- Typecheck ล้มเหลว: หยุดและแก้ไข errors ก่อน build
- Build ล้มเหลว: วิเคราะห์ error และแก้ไข
- Warning: บันทึกและพิจารณาแก้ไข

## Execute

1. Pre-build Error Fix
   - รัน `/fix-error-warning` เพื่อ fix ทั้ง errors และ warnings
   - ยืนยันไม่มี type errors, lint errors, หรือ test failures
   - ถ้ามี errors → รันซ้ำจนกว่าจะผ่าน

2. Typecheck
   - รัน `/run-typecheck`
   - ตรวจสอบ TypeScript types ทั้งหมด
   - ถ้ามี type errors → รัน `/fix-error-warning` ซ้ำ

3. Install Dependencies
   - รัน `/run-install`
   - ตรวจสอบ dependencies ครบถ้วน
   - อัพเดทถ้าจำเป็น

4. Clean Build Artifacts
   - ลบโฟลเดอร์ build/dist เก่า
   - ลบ cache ที่ไม่จำเป็น
   - ตรวจสอบว่าเริ่ม build สะอาด

5. Execute Build
   - รัน `bun run build` หรือ script ที่กำหนด
   - ติดตาม progress ของ build
   - บันทึกเวลาที่ใช้

6. Verify Output
   - ตรวจสอบ build artifacts ถูกสร้าง
   - ตรวจสอบ file size ที่เหมาะสม
   - verify production readiness

## Expected Outcome

- Build สำเร็จไม่มี errors
- Typecheck ผ่านทั้งหมด
- Build artifacts ถูกต้อง
- Output สามารถใช้งานได้จริง

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/fix-error-warning` - Fix ทั้ง errors และ warnings ก่อน build
- `/run-typecheck` - ตรวจสอบ types
- `/run-install` - ติดตั้ง dependencies
