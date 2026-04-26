---
title: Use Packages
description: วิเคราะห์และแนะนำ packages จาก workspace ที่ควรนำมาใช้ในโปรเจกต์ปัจจุบัน
auto_execution_mode: 3
---

## Goal

วิเคราะห์ packages ที่มีอยู่ใน workspace และแนะนำ packages ที่เหมาะสมกับโปรเจกต์ปัจจุบัน

## Execute

### 1. Analyze Current Project

1. อ่าน `package.json`, `Cargo.toml`, หรือไฟล์จัดการ dependencies ที่เกี่ยวข้อง
2. วิเคราะห์ dependencies ที่มีอยู่ในโปรเจกต์ปัจจุบัน
3. ระบุประเภทโปรเจกต์ (web, backend, desktop, mobile, library, etc.)
4. ระบุภาษาและ framework ที่ใช้

### 2. Scan Workspace Packages

1. สำรวจโครงสร้าง workspace
2. อ่าน `package.json` หรือ `Cargo.toml` ของแต่ละ package
3. จัดกลุ่ม packages ตามประเภท:
   - UI Components
   - Utilities
   - Frameworks
   - Libraries
   - Tools
   - Integrations

### 3. Analyze Package Relevance

สำหรับแต่ละ package ใน workspace:

1. ตรวจสอบความเข้ากันได้กับโปรเจกต์:
   - ภาษาที่ใช้
   - Platform ที่รองรับ
   - Dependencies ที่ต้องการ
2. ประเมินประโยชน์:
   - ลด code duplication
   - เพิ่มประสิทธิภาพ
   - ปรับปรุง DX
3. ตรวจสอบสถานะ:
   - Version stability
   - Maintenance status
   - Documentation quality

### 4. Generate Recommendations

สร้างรายงานแนะนำ packages:

1. High Priority - Packages ที่ควรใช้ทันที:
   - แก้ปัญหาที่มีอยู่
   - ลด code duplication อย่างชัดเจน
   - เพิ่มประสิทธิภาพอย่างมีนัยสำคัญ

2. Medium Priority - Packages ที่ควรพิจารณา:
   - ปรับปรุง DX
   - เพิ่ม features ที่มีประโยชน์
   - มี trade-offs ที่ต้องพิจารณา

3. Low Priority - Packages ที่อาจไม่จำเป็น:
   - Over-engineering
   - ไม่เข้ากับ requirements
   - มี dependencies มากเกินไป

### 5. Provide Integration Guidance

สำหรับ packages ที่แนะนำ:

1. ระบุวิธีการติดตั้ง
2. ระบุวิธีการ configuration
3. ระบุ breaking changes ที่อาจเกิดขึ้น
4. ให้ตัวอย่างการใช้งาน
5. ระบุ dependencies ที่ต้องเพิ่ม

## Rules

### 1. Analysis Criteria

ประเมิน packages ตามเกณฑ์:

- Relevance: เข้ากับโปรเจกต์และ requirements
- Compatibility: ใช้ภาษาและ platform เดียวกัน
- Stability: Version stable และมีการ maintain
- Documentation: มี docs ครบถ้วน
- Adoption: มีการใช้งานจริงใน workspace
- Maintenance: มีการอัพเดตสม่ำเสมอ

### 2. Prioritization

จัดลำดับความสำคัญ:

1. Critical - แก้ปัญหาร้ายแรงหรือ security issues
2. High - ลด duplication หรือเพิ่มประสิทธิภาพอย่างชัดเจน
3. Medium - ปรับปรุง DX หรือเพิ่ม features
4. Low - Nice-to-have หรือ future consideration

### 3. Documentation

รายงานต้องประกอบด้วย:

- ชื่อ package และ version
- คำอธิบายสั้นๆ
- เหตุผลที่แนะนำ
- วิธีการติดตั้ง
- วิธีการใช้งาน
- Trade-offs และ considerations
- Breaking changes (ถ้ามี)

### 4. Context Awareness

พิจารณา context ของโปรเจกต์:

- ขนาดโปรเจกต์ (small, medium, large)
- ทีมขนาด (individual, small team, large team)
- Timeline (MVP, production, maintenance)
- Constraints (performance, security, compliance)

### 5. Avoid Over-Engineering

ไม่แนะนำ packages ที่:

- ซับซ้อนเกินความจำเป็น
- มี dependencies มากเกินไป
- ไม่มี clear benefit
- ไม่มีการ maintain

## Expected Outcome

- รายงาน packages ที่ควรใช้แบ่งตาม priority
- คำแนะนำ integration ที่ชัดเจน
- การวิเคราะห์ trade-offs
- ตัวอย่างการใช้งาน
- คำแนะนำเกี่ยวกับ migration path 