---
title: Edit Relative
description: อัปเดท references ทั้งหมดที่เกี่ยวข้องเมื่อมีการแก้ไขไฟล์
auto_execution_mode: 3
related_workflows:
  - /follow-content-quality
---

## Goal

อัปเดท references ทั้งหมดที่เกี่ยวข้องเมื่อมีการแก้ไข ย้าย หรือลบไฟล์

## Scope

ใช้สำหรับอัปเดท references เมื่อ:
- แก้ไขไฟล์ที่ถูกอ้างอิงจากไฟล์อื่น
- ย้ายไฟล์ไปยังตำแหน่งใหม่
- เปลี่ยนชื่อไฟล์
- ลบไฟล์ที่ถูกอ้างอิง
- เปลี่ยนชื่อ workflow หรือ skill

## Execute

### 1. Identify Changed Files

ระบุไฟล์ที่มีการเปลี่ยนแปลง

1. ระบุไฟล์ที่ถูกแก้ไข ย้าย เปลี่ยนชื่อ หรือลบจาก task ปัจจุบัน
2. รัน `git status --porcelain` เพื่อดูไฟล์ที่มีการเปลี่ยนแปลงทั้งหมด

### 2. Search For References

ค้นหา references ทั้งหมดที่เกี่ยวข้อง

1. ค้นหา references ด้วย `Grep` ใน codebase
2. ค้นหาชื่อไฟล์เก่าในทุกไฟล์
3. ค้นหา path เก่าในทุกไฟล์
4. ค้นหา import statements ที่อ้างถึงไฟล์เก่า
5. ค้นหา workflow references ที่อ้างถึง workflow เก่า

### 3. Update References

อัปเดท references ทั้งหมดที่พบ

**สำหรับการย้ายไฟล์:**
1. อัปเดท import paths ทั้งหมด
2. อัปเดท file path references ทั้งหมด
3. อัปเดท workflow references ทั้งหมด

**สำหรับการเปลี่ยนชื่อไฟล์:**
1. อัปเดท import statements ทั้งหมด
2. อัปเดท file name references ทั้งหมด
3. อัปเดท workflow references ทั้งหมด

**สำหรับการลบไฟล์:**
1. ลบ import statements ที่อ้างถึงไฟล์ที่ถูกลบ
2. ลบ references ที่อ้างถึงไฟล์ที่ถูกลบ
3. แก้ไข code ที่ใช้ไฟล์ที่ถูกลบ

**สำหรับการเปลี่ยนชื่อ workflow:**
1. อัปเดท workflow references ทั้งหมดใน codebase
2. อัปเดท workflow references ใน global workflows
3. อัปเดท workflow references ใน workspace workflows

### 4. Verify Updates

ตรวจสอบว่า references ถูกอัปเดทครบถ้วน

1. ค้นหา references เก่าอีกครั้งเพื่อยืนยันว่าไม่มีเหลือ
2. รัน linting เพื่อตรวจสอบว่าไม่มี errors
3. รัน typecheck เพื่อตรวจสอบว่าไม่มี type errors
4. รัน test เพื่อตรวจสอบว่าไม่มี test failures

## Rules

### Search Strategy

ค้นหา references อย่างครอบคลุม

- ค้นหาทั้ง absolute paths และ relative paths
- ค้นหาทั้งชื่อไฟล์และ extension
- ค้นหาทั้ง import statements และ string references
- ค้นหาในทุก file types (.ts, .js, .md, .json, etc.)

### Update Strategy

อัปเดท references อย่างถูกต้อง

- อัปเดททุก references ที่พบ ไม่เว้นแม้แต่ reference เดียว
- รักษาความสม่ำเสมอของ import style
- รักษาความสม่ำเสมอของ path format
- ตรวจสอบว่า updates ไม่ทำให้เกิด syntax errors

### Verification

ตรวจสอบความถูกต้องของ updates

- ตรวจสอบว่า references เก่าไม่มีเหลือ
- ตรวจสอบว่า references ใหม่ถูกต้อง
- ตรวจสอบว่า code ยังทำงานได้หลังจาก updates
- ตรวจสอบว่าไม่มี broken imports

## Expected Outcome

1. References ทั้งหมดถูกอัปเดทครบถ้วน
2. ไม่มี references เก่าเหลืออยู่
3. Code ยังทำงานได้หลังจาก updates
4. ไม่มี linting หรือ type errors
