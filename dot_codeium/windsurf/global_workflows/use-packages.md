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

1. ปรับปรุงโค้ดใน workspace เป้าหมายให้เหมาะสม
2. ย้ายหรือ copy components/functions ที่ต้องการ
3. ปรับ imports และ dependencies

### 5. Verify Integration

1. รัน `/run-verify` เพื่อตรวจสอบว่าทำงานได้จริง
2. ทดสอบ functionality ที่นำมาใช้
3. ยืนยันว่าไม่มี breaking changes

## Rules

1. Analysis Requirements

- ต้องรัน `/analyze-project` ก่อนนำมาใช้เสมอ
- ต้องอ่าน README.md เพื่อเข้าใจ features
- ต้องตรวจสอบ compatibility ของ dependencies

2. Refactoring Guidelines

- Refactor ใน workspace ต้นทางก่อนนำมาใช้
- แยก concerns ให้ชัดเจน
- ใช้ import alias เสมอ
- ทดสอบหลัง refactoring

3. Integration Order

1. เริ่มจาก utilities และ shared components
2. ตามด้วย domain-specific features
3. สุดท้ายคือ complex integrations

4. Quality Checks

- รัน `/run-lint` หลัง integrate
- รัน `/run-typecheck` ตรวจสอบ types
- รัน `/run-test` ยืนยัน tests ผ่าน

## Expected Outcome

1. เข้าใจโครงสร้างและ features ของทุก workspaces
2. นำ packages มาใช้งานได้อย่างมีประสิทธิภาพ
3. โค้ดถูก refactor ตามมาตรฐานก่อน integrate
4. Integration ทำงานได้จริงโดยไม่มี errors 
