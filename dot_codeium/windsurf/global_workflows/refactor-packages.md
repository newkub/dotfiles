---
title: Refactor Packages
description: Refactor code ไปยัง packages เพื่อลด duplication และเพิ่ม reusability
auto_execution_mode: 3
---

## Goal

Refactor code ที่มี duplication ไปยัง existing packages หรือสร้าง new packages เพื่อให้ general และ reusable ได้กับ apps อื่นๆ

## Execute

### 1. Analyze Duplication

วิเคราะห์ code duplication ใน codebase

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. ทำ `/check-duplication` เพื่อตรวจสอบ code duplication
3. ระบุ functions, types, utilities ที่ใช้ซ้ำกัน
4. จัดกลุ่ม code ที่เกี่ยวข้องกัน

### 2. Identify Package Candidates

ระบุ code ที่ควร refactor เป็น packages

1. พิจารณา reusability ของแต่ละ code block
2. ตรวจสอบ dependencies ที่จำเป็น
3. ระบุ boundary ของแต่ละ package
4. ตัดสินใจว่าควรใช้ existing package หรือสร้าง new package

### 3. Create Refactor Plan

สร้างแผนการ refactor ในรูปแบบตาราง

1. สร้างตารางที่มี columns: Original Folder, Target Folder, Types, Priority, Dependencies, Risk Level, Description
2. จัดลำดับตาม priority
3. ระบุ dependencies ระหว่าง packages
4. กำหนดขั้นตอนการ migration

### 4. Execute Refactor

ทำการ refactor ตามแผนที่สร้างไว้

1. ทำตาม `/idea-refactor-packages` เพื่อสร้างแผนการ refactor
2. ย้าย code ไปยัง packages ตามลำดับ priority
3. ทำ `/update-reference` เพื่ออัพเดท imports
4. ทำ `/run-typecheck` หลังจากแต่ละ refactor

### 5. Verify And Test

ตรวจสอบและทดสอบการ refactor

1. รัน tests ทั้งหมดเพื่อยืนยันว่ายังทำงานได้
2. ตรวจสอบ imports และ exports
3. ทำ `/check-duplication` อีกครั้งเพื่อยืนยันการลด duplication

## Rules

### 1. Package Boundaries

กำหนด boundary ของแต่ละ package ให้ชัดเจน

- แต่ละ package ต้องมี single responsibility
- ห้ามมี circular dependencies ระหว่าง packages
- แต่ละ package ต้องสามารถ test แยกได้
- แต่ละ package ต้องมี API ที่ชัดเจน
- packages ต้อง general และ reusable ได้กับ apps อื่นๆ

### 2. Refactor Order

จัดลำดับการ refactor ตามความสำคัญ

- ทำ packages ที่เป็น dependencies ของ packages อื่นก่อน
- ทำ packages ที่มี impact สูงก่อน
- ทำ packages ที่ simple ก่อนเพื่อ build momentum
- ทำ packages ที่ critical path ก่อน

### 3. Migration Strategy

กลยุทธ์การ migrate code ไปยัง packages

- ทำตามตารางที่สร้างไว้เท่านั้น
- อัพเดท references ทั้งหมดเมื่อย้าย code
- ทำ `/update-reference` เสมอ
- ทำ `/run-typecheck` หลังจากแต่ละ refactor
- ใช้ existing packages ก่อนเมื่อเป็นไปได้

### 4. Package Structure

โครงสร้างของแต่ละ package ต้องชัดเจน

- มี `index.ts` สำหรับ re-exports
- มี `README.md` อธิบายการใช้งาน
- มี `package.json` พร้อม dependencies
- มี types ที่ชัดเจนและ export ออกมา
- มี examples หรือ documentation ถ้าจำเป็น

## Expected Outcome

- Code duplication ลดลงอย่างมีนัยสำคัญ
- Packages ที่ general และ reusable ได้กับ apps อื่นๆ
- Architecture ที่ดีขึ้นและ maintainable มากขึ้น
- Dependencies ที่ชัดเจนและไม่ซับซ้อน
- Functionality ทั้งหมดยังทำงานได้ปกติ