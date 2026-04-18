---
title: Use Packages
description: Analyze and integrate packages from workspaces with proper refactoring
auto_execution_mode: 3
---

## Goal

วิเคราะห์และนำ packages จาก workspaces มาใช้งานอย่างมีประสิทธิภาพ พร้อม refactoring ตามความเหมาะสม

## Execute

### 1. Analyze Source Workspaces

1. อ่าน package manifest เพื่อดูรายการ workspaces ทั้งหมด
2. รัน `/analyze-project` ใน workspace ที่สนใจ
3. อ่าน README.md เพื่อเข้าใจ features และ architecture
4. ตรวจสอบ compatibility ของ dependencies

### 2. Refactor Source Code

1. รัน `/update-readme` ของ workspace ที่จะนำมาใช้
2. ปรับปรุงโค้ดใน workspace ต้นทางให้เหมาะสม
3. แยก concerns ให้ชัดเจน
4. ทดสอบหลัง refactoring

### 3. Integrate Packages

1. ย้ายหรือ copy components/functions ที่ต้องการ
2. ปรับ imports และ dependencies
3. ใช้ import alias เสมอ
4. เริ่มจาก utilities และ shared components ก่อน
5. ตามด้วย domain-specific features
6. สุดท้ายคือ complex integrations

### 4. Apply and Clean

1. ค้นหาไฟล์ที่ควรใช้ packages ที่ integrate แล้ว
2. อัพเดท imports ในไฟล์ต่างๆ ให้ใช้ packages ใหม่
3. แทนที่โค้ดที่ซ้ำซ้อนด้วยการเรียกใช้ packages
4. ค้นหาไฟล์ที่มีโค้ดซ้ำซ้อน
5. ลบไฟล์ที่ไม่จำเป็นและซ้ำซ้อน
6. รัน `/update-reference` สำหรับไฟล์ที่ลบ

## Rules

### 1. Analysis Requirements

ต้องวิเคราะห์ workspace ต้นทางอย่างละเอียดก่อนนำมาใช้

- รัน `/analyze-project` ก่อนนำมาใช้เสมอ
- อ่าน README.md เพื่อเข้าใจ features
- รัน `/update-readme` ของ workspace ที่จะนำมาใช้ก่อน integrate
- ตรวจสอบ compatibility ของ dependencies

### 2. Refactoring Principles

Refactor ใน workspace ต้นทางก่อนนำมาใช้เพื่อให้โค้ดมีคุณภาพ

- Refactor ใน workspace ต้นทางก่อนนำมาใช้
- แยก concerns ให้ชัดเจน
- ใช้ import alias เสมอ
- ทดสอบหลัง refactoring

### 3. Integration Order

จัดลำดับการ integrate ตาม impact order เพื่อลดความเสี่ยง

- เริ่มจาก utilities และ shared components
- ตามด้วย domain-specific features
- สุดท้ายคือ complex integrations

### 4. File Operations

จัดการไฟล์อย่างเป็นระบบและอัพเดท references

- นำ packages ไปใช้ในไฟล์ต่างๆ ที่เกี่ยวข้อง
- ลบไฟล์ที่ซ้ำซ้อนหลังจาก integrate เสร็จ
- รัน `/update-reference` เมื่อลบไฟล์

## Expected Outcome

- เข้าใจโครงสร้างและ features ของทุก workspaces
- นำ packages มาใช้งานได้อย่างมีประสิทธิภาพ
- โค้ดถูก refactor ตามมาตรฐานก่อน integrate
- Packages ถูกนำไปใช้ในไฟล์ต่างๆ อย่างถูกต้อง
- ไฟล์ที่ซ้ำซ้อนถูกลบออกแล้ว
- ไม่มี code duplication 
