---
title: Refactor Packages
description: Refactor code from apps to existing or new packages to reduce duplication
auto_execution_mode: 3
---

## Goal

แยก code จาก apps ไปยัง packages เพื่อลดความซ้ำซ้อนและเพิ่ม reusability

## Execute

### 1. Analyze Apps

1. สำรวจทุก app ใน `apps/`
2. ระบุ code ที่ซ้ำซ้อนระหว่าง apps
3. ระบุ code ที่สามารถ reuse ได้
4. จัดกลุ่ม code ตาม functionality

### 2. Check Existing Packages

1. ตรวจสอบ packages ที่มีอยู่ใน `nuxt-modules/packages/`
2. เปรียบเทียบ code ที่ซ้ำซ้อนกับ packages ที่มีอยู่
3. ระบุ code ที่สามารถย้ายไป existing packages ได้
4. ระบุ code ที่ต้องสร้าง new packages

### 3. Move to Existing Packages

1. ย้าย code ไปยัง existing packages ที่เหมาะสม
2. อัพเดท imports ใน apps ให้ใช้จาก packages
3. ลบ code เดิมจาก apps

### 4. Create New Packages

1. สร้าง new packages สำหรับ code ที่ไม่มี package เหมาะสม
2. ตั้งชื่อ package ตาม functionality
3. ย้าย code ไปยัง new packages
4. อัพเดท imports ใน apps
5. ลบ code เดิมจาก apps

### 5. Verify No Duplication

1. ตรวจสอบว่าไม่มี code ซ้ำซ้อนระหว่าง apps และ packages
2. ตรวจสอบว่า apps ใช้ packages แทน code ซ้ำ

## Rules

### 1. Package Structure

- ใช้ `nuxt-modules/packages/` สำหรับ packages
- ตั้งชื่อ package ตาม functionality เช่น `auth-workos`, `ui`, `composables`
- แต่ละ package มี Single Responsibility

### 2. Refactoring Priority

- ย้ายไป existing packages ก่อน
- สร้าง new packages เฉพาะที่จำเป็น
- ย้าย code ที่มีการใช้งานหลาย app ก่อน

### 3. Import Updates

- อัพเดท imports ในทุก app ที่ใช้ code
- ใช้ import alias ถ้ามี
- ตรวจสอบว่า imports ถูกต้อง

### 4. Dependencies

- อัพเดท dependencies ใน packages
- อัพเดท dependencies ใน apps
- ลบ dependencies ที่ไม่ได้ใช้

## Expected Outcome

- Code ใน apps ไม่ซ้ำซ้อนกับ packages
- Apps ใช้ packages แทน code ซ้ำ
- Packages มี Single Responsibility ชัดเจน