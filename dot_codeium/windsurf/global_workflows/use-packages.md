---
title: Use Packages
description: นำ packages ย่อยๆ มาใช้งานอย่างมีประสิทธิภาพ
auto_execution_mode: 3
---

## Goal

นำ packages ย่อยๆ มาใช้งานอย่างมีประสิทธิภาพ เพื่อ:
- เพิ่ม reusability ของ code
- ลด code duplication
- ทำให้ code มี modularity สูงขึ้น
- ใช้ packages ที่มีอยู่แล้วอย่างเต็มประสิทธิภาพ

## Execute

### 1. Analyze Available Packages

1. อ่าน package manifest เพื่อดูรายการ packages ย่อยๆ ทั้งหมด
2. รัน `/analyze-project` เพื่อดูภาพรวม packages
3. อ่าน README.md ของ packages ที่สนใจ
4. ตรวจสอบ compatibility ของ dependencies
5. วิเคราะห์ public API ของ packages

### 2. Integrate Packages

1. ย้ายหรือ copy components/functions ที่ต้องการ
2. ปรับ imports และ dependencies
3. ใช้ import alias เสมอ
4. เริ่มจาก utilities และ shared components ก่อน
5. ตามด้วย domain-specific features
6. สุดท้ายคือ complex integrations

### 3. Apply Packages

1. ค้นหาไฟล์ที่ควรใช้ packages ที่ integrate แล้ว
2. อัพเดท imports ในไฟล์ต่างๆ ให้ใช้ packages ใหม่
3. แทนที่โค้ดที่ซ้ำซ้อนด้วยการเรียกใช้ packages
4. ค้นหาไฟล์ที่มีโค้ดซ้ำซ้อน
5. ลบไฟล์ที่ไม่จำเป็นและซ้ำซ้อน
6. รัน `/update-reference` สำหรับไฟล์ที่ลบ

## Rules

### 1. Analysis Requirements

ต้องวิเคราะห์ packages ย่อยๆ อย่างละเอียดก่อนนำมาใช้

- รัน `/analyze-project` ก่อนนำมาใช้เสมอ
- อ่าน README.md เพื่อเข้าใจ features
- ตรวจสอบ compatibility ของ dependencies
- วิเคราะห์ public API ของ packages

### 2. Integration Order

จัดลำดับการ integrate ตาม impact order เพื่อลดความเสี่ยง

- เริ่มจาก utilities และ shared components
- ตามด้วย domain-specific features
- สุดท้ายคือ complex integrations

### 3. File Operations

จัดการไฟล์อย่างเป็นระบบและอัพเดท references

- นำ packages ไปใช้ในไฟล์ต่างๆ ที่เกี่ยวข้อง
- ลบไฟล์ที่ซ้ำซ้อนหลังจาก integrate เสร็จ
- รัน `/update-reference` เมื่อลบไฟล์

## Expected Outcome

- เข้าใจโครงสร้างและ features ของ packages ย่อยๆ
- นำ packages ย่อยๆ มาใช้งานได้อย่างมีประสิทธิภาพ
- Packages ถูกนำไปใช้ในไฟล์ต่างๆ อย่างถูกต้อง
- ไฟล์ที่ซ้ำซ้อนถูกลบออกแล้ว
- ไม่มี code duplication 
