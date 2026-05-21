---
title: Refactor Packages
description: Refactor packages ให้มี single responsibility และโครงสร้างที่เหมาะสม
auto_execution_mode: 3
---

## Goal

Refactor packages ใน monorepo ให้มี single responsibility และโครงสร้างที่เหมาะสม

## Execute

### 1. Analyze Current Structure

วิเคราะห์โครงสร้าง packages ปัจจุบัน

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. วิเคราะห์ dependencies ระหว่าง packages
3. ระบุ packages ที่มี multiple responsibilities
4. ระบุ code ที่ซ้ำซ้อนระหว่าง packages
5. วิเคราะห์ coupling และ cohesion ของแต่ละ package

### 2. Planning

วางแผนการ refactor packages

1. ทำ `/plan` เพื่อวางแผนการ refactor ครบถ้วน
2. ระบุ packages ที่จะ merge, split, หรือ create ใหม่
3. จัดลำดับ refactor ตาม dependency direction
4. รอยืนยันจาก user ก่อนเริ่มทำ

### 3. Create Foundation Packages

สร้าง foundation packages ก่อนถ้าจำเป็น

1. สร้าง shared types packages สำหรับ common types
2. สร้าง utils packages สำหรับ common utilities
3. สร้าง adapter packages สำหรับ external dependencies
4. ทำ `/setup-tasks` สำหรับ packages ใหม่

### 4. Refactor Existing Packages

Refactor packages ที่มีอยู่ให้มี single responsibility

1. ทำ `/refactor-safe` เพื่อ refactor แต่ละ package อย่างปลอดภัย
2. ย้าย code ที่ไม่เกี่ยวข้องไปยัง packages ที่เหมาะสม
3. ทำ `/follow-barral-export` สำหรับ packages ที่มี exports หลายอย่าง
4. ทำ `/update-reference` เพื่ออัพเดท references ระหว่าง packages

### 5. Merge Redundant Packages

รวม packages ที่ซ้ำซ้อนหรือมี responsibilities ที่ใกล้เคียง

1. ระบุ packages ที่มี responsibilities ซ้ำกัน
2. ทำ `/merge` เพื่อรวม packages
3. ลบ packages เดิมที่ไม่ใช้แล้ว
4. ทำ `/update-reference` เพื่ออัพเดท references

### 6. Validate And Test

ตรวจสอบและทดสอบการ refactor

1. ทำ `/run-typecheck` เพื่อตรวจสอบ type safety
2. ทำ `/run-test` เพื่อทดสอบ functionality
3. ทำ `/run-build` เพื่อตรวจสอบ build
4. ตรวจสอบ dependencies ระหว่าง packages

## Rules

### 1. Single Responsibility Principle

แต่ละ package ต้องมี single responsibility ชัดเจน

- หนึ่ง package ทำหนึ่งเรื่องเท่านั้น
- ไม่ผสม concerns ที่แตกต่างกันใน package เดียว
- ตั้งชื่อ package ให้สะท้อนถึง responsibility
- แยก domain logic จาก infrastructure concerns

### 2. Dependency Direction

กำหนดทิศทาง dependencies ที่ชัดเจน

- Foundation packages ไม่มี dependency กับ packages อื่น
- High-level packages พึ่งพา low-level packages เท่านั้น
- ไม่มี circular dependencies ระหว่าง packages
- ใช้ import alias ตาม `/use-import-alias`

### 3. Package Granularity

กำหนดขนาดของ packages ที่เหมาะสม

- ไม่ split packages เล็กเกินไป (over-engineering)
- ไม่รวม packages ใหญ่เกินไป (monolith)
- balance ระหว่าง cohesion และ coupling
- พิจารณา reusability และ maintainability

### 4. Code Organization

จัดระเบียบ code ภายในแต่ละ package

- ใช้ barrel exports สำหรับ public APIs
- เก็บ internal code ใน private directories
- แยก concerns ภายใน package ตาม Clean Architecture
- ใช้ consistent naming conventions

## Expected Outcome

### Package Structure

- แต่ละ package มี single responsibility ชัดเจน
- Dependencies ระหว่าง packages มีทิศทางที่ชัดเจน
- ไม่มี circular dependencies
- Package granularity เหมาะสมกับ project

### Code Quality

- ลด code duplication ระหว่าง packages
- High cohesion ภายในแต่ละ package
- Low coupling ระหว่าง packages
- Consistent organization ทั่วทั้ง monorepo

### Maintainability

- ง่ายต่อการ locate code
- ง่ายต่อการเพิ่ม features
- ง่ายต่อการทดสอบ
- ง่ายต่อการ refactor ในอนาคต