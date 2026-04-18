---
title: Refactor Packages
description: Refactor packages structure ด้วย Clean Architecture
auto_execution_mode: 3
---

## Goal

Refactor packages structure ให้เป็นไปตาม Clean Architecture โดยแบ่งเป็น shared, interface, domain, application, infrastructure

## Execute

### 1. Analyze Current Structure

1. รัน `/analyze-project` เพื่อดูโครงสร้างปัจจุบัน
2. ตรวจสอบ `packages/framework` ที่มีอยู่
3. ระบุ dependencies ระหว่าง `packages/modules`
4. วิเคราะห์ code ที่ซ้ำซ้อน

### 2. Create New Structure

1. สร้าง `packages/shared` สำหรับ common types, utilities, traits ที่ใช้ร่วมกัน
2. สร้าง `packages/interface` สำหรับ abstractions และ contracts
3. สร้าง `packages/domain` สำหรับ business logic และ entities
4. สร้าง `packages/application` สำหรับ use cases และ orchestration
5. สร้าง `packages/infrastructure` สำหรับ external dependencies และ implementations

### 3. Move Code

1. ย้าย code ที่ควรอยู่ใน `shared`
2. ย้าย code ที่ควรอยู่ใน `interface`
3. ย้าย code ที่ควรอยู่ใน `domain`
4. ย้าย code ที่ควรอยู่ใน `application`
5. ย้าย code ที่ควรอยู่ใน `infrastructure`
6. ลบ code ที่ซ้ำซ้อนหลังจากย้าย
7. ตรวจสอบ circular dependencies หลังย้าย

### 4. Update References

1. อัพเดท dependencies ที่ต้องแก้ไข
2. อัพเดท module/namespace paths ทั้งหมด
3. สร้าง public entry points ใหม่
4. อัพเดท dependency configuration files (เช่น package.json, Cargo.toml, pom.xml)

### 5. Verify

1. รัน `/run-verify` เพื่อตรวจสอบว่าทุกอย่างยังทำงานได้
2. ตรวจสอบว่าไม่มี broken imports
3. ยืนยันว่าโครงสร้างใหม่สอดคล้องกับ Clean Architecture

## Rules

### 1. Package Organization

- `packages/shared`: จัดเก็บ common types, utilities, traits, constants ที่ใช้ร่วมกันทั้งโปรเจกต์
- `packages/interface`: จัดเก็บ abstractions, traits, protocols
- `packages/domain`: จัดเก็บ business logic, entities, value objects
- `packages/application`: จัดเก็บ use cases, orchestrators, services
- `packages/infrastructure`: จัดเก็บ implementations, external dependencies

### 2. Dependency Direction

- `shared` ต้องไม่ depend บน packages อื่น (เว้นแต่ external dependencies)
- `interface` ต้อง depend เฉพาะ `shared`
- `domain` ต้อง depend `shared` และ `interface`
- `application` ต้อง depend `shared`, `interface`, และ `domain`
- `infrastructure` ต้อง depend `shared`, `interface`, `domain`, และ `application`

### 3. Naming Conventions

- ใช้ชื่อที่สะท้อนหน้าที่ของ package
- ใช้ import/using alias สำหรับ cross-package references
- รักษา consistency กับโปรเจกต์

### 4. Public API

- แต่ละ package ต้องมี entry point สำหรับ exports
- entry point ต้อง exports เท่านั้น ไม่มี logic
- public API ต้องชัดเจนผ่าน public exports

## Expected Outcome

- โครงสร้าง packages ใหม่ตาม Clean Architecture
- code ย้ายไปยัง packages ที่ถูกต้อง
- module/namespace paths อัพเดทแล้ว
- functionality ทั้งหมดยังทำงานได้
- ไม่มี broken imports หรือ missing references
