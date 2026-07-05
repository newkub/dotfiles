---
title: Run Build
description: รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts
auto_execution_mode: 3
related_workflows:
  - /optimize-build
  - /run-clean
  - /run-typecheck
---

## Goal

รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts

## Execute

### 1. Optimize Build

1. ทำ `/optimize-build` เพื่อปรับปรุง build configuration และลดขนาด output

### 2. Typecheck

1. ทำ `/run-typecheck` เพื่อตรวจสอบ TypeScript types
2. ถ้ามี type errors ให้ทำ `/resolve-errors`

### 3. Install Dependencies

1. รัน `bun install`
2. ตรวจสอบ dependencies ครบถ้วน

### 4. Clean Build Artifacts

1. ทำ `/run-clean` เพื่อลบ build artifacts และ cache เก่า

### 5. Execute Build

1. รัน `bun run build` หรือ script ที่กำหนด
2. บันทึกเวลาที่ใช้

### 6. Verify Output

1. ตรวจสอบ build artifacts ถูกสร้าง
2. ตรวจสอบ file size ที่เหมาะสม

### 7. Report

1. รัน `/report-format-terminal` เพื่อแสดงความคืบหน้า build
2. รัน `/report-format-table` เพื่อแสดง build metrics (time, size)
3. รัน `/report-format-table` เพื่อสรุปผลลัพธ์ build

## Rules

### 1. Build Order

- Optimize: ทำ `/optimize-build` ก่อนเริ่ม
- Typecheck: ทำ `/run-typecheck` ก่อน build
- Install: ติดตั้ง dependencies
- Clean: ทำ `/run-clean` เพื่อลบ artifacts เก่า
- Build: รัน build command
- Verify: ตรวจสอบ output

### 2. Error Handling

- Typecheck ล้มเหลว: ทำ `/resolve-errors` ก่อน build
- Build ล้มเหลว: ทำ `/resolve-errors` เพื่อแก้ไข
- Warning: บันทึกและพิจารณาแก้ไข

## Expected Outcome

- Build สำเร็จไม่มี errors
- Typecheck ผ่านทั้งหมด
- Build artifacts ถูกต้อง
- Output size และ build time ถูกปรับปรุง

