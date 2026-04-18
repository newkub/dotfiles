---
title: Use Packages
description: Analyze and integrate packages from workspaces with proper refactoring
auto_execution_mode: 3
---

## Goal

วิเคราะห์และนำ packages จาก workspaces มาใช้งานอย่างมีประสิทธิภาพ พร้อม refactoring ตามความเหมาะสม

## Execute

### 1. Analyze Workspaces

1. อ่าน package manifest เพื่อดูรายการ workspaces ทั้งหมด
2. ใช้ `list_dir` ตรวจสอบโครงสร้างแต่ละ workspace
3. อ่าน README.md ของแต่ละ workspace เพื่อเข้าใจ features

### 2. Deep Analysis

1. รัน `/analyze-project` ในแต่ละ workspace ที่สนใจ
2. บันทึก tech stack, dependencies, และ architecture ที่ใช้
3. ระบุส่วนที่สามารถนำมาใช้งานได้

### 3. Evaluate Integration

1. เปรียบเทียบกับโปรเจกต์ปัจจุบัน
2. ระบุส่วนที่ต้อง refactoring ก่อนนำมาใช้
3. กำหนดลำดับการ integrate

### 4. Refactor and Integrate

1. ปรับปรุงโค้ดใน workspace ต้นทางให้เหมาะสม
2. ย้ายหรือ copy components/functions ที่ต้องการ
3. ปรับ imports และ dependencies

### 5. Apply to Files

1. ค้นหาไฟล์ที่ควรใช้ packages ที่ integrate แล้ว
2. อัพเดท imports ในไฟล์ต่างๆ ให้ใช้ packages ใหม่
3. แทนที่โค้ดที่ซ้ำซ้อนด้วยการเรียกใช้ packages
4. ตรวจสอบว่าการใช้งานถูกต้องและเหมาะสม

### 6. Remove Duplicate Files

1. ค้นหาไฟล์ที่มีโค้ดซ้ำซ้อนกับ packages ที่ integrate แล้ว
2. วิเคราะห์ว่าไฟล์ใดสามารถลบได้โดยไม่กระทบการทำงาน
3. ลบไฟล์ที่ไม่จำเป็นและซ้ำซ้อน
4. รัน `/update-reference` สำหรับไฟล์ที่ลบ

## Rules

### 1. Analysis Requirements

- รัน `/analyze-project` ก่อนนำมาใช้เสมอ
- อ่าน README.md เพื่อเข้าใจ features
- รัน `/update-readme` ของ workspace ที่จะนำมาใช้ก่อน integrate
- ตรวจสอบ compatibility ของ dependencies

### 2. Refactoring Principles

- Refactor ใน workspace ต้นทางก่อนนำมาใช้
- แยก concerns ให้ชัดเจน
- ใช้ import alias เสมอ
- ทดสอบหลัง refactoring

### 3. Integration Order

- เริ่มจาก utilities และ shared components
- ตามด้วย domain-specific features
- สุดท้ายคือ complex integrations

### 4. File Operations

- นำ packages ไปใช้ในไฟล์ต่างๆ ที่เกี่ยวข้อง
- ลบไฟล์ที่ซ้ำซ้อนหลังจาก integrate เสร็จ
- รัน `/update-reference` เมื่อลบไฟล์

## Expected Outcome

1. เข้าใจโครงสร้างและ features ของทุก workspaces
2. นำ packages มาใช้งานได้อย่างมีประสิทธิภาพ
3. โค้ดถูก refactor ตามมาตรฐานก่อน integrate
4. Packages ถูกนำไปใช้ในไฟล์ต่างๆ อย่างถูกต้อง
5. ไฟล์ที่ซ้ำซ้อนถูกลบออกแล้ว
6. ไม่มี code duplication 
