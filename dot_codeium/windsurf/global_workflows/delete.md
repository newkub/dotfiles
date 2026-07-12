---
title: Delete
description: ลบไฟล์หรือ folder และอัพเดท references ทั้งหมด
auto_execution_mode: 3
related:
  - /edit-relative
  - /update-references
---

## Goal

ลบไฟล์หรือ folder และอัพเดท references ทั้งหมดในโปรเจกต์

## Scope

ใช้สำหรับการลบไฟล์หรือ folder พร้อมอัพเดท references ทั้งหมดในโปรเจกต์

## Execute

### 1. Analyze References

ค้นหาและวิเคราะห์ references ทั้งหมด

- ค้นหาทุก references ที่ใช้ไฟล์หรือ folder (imports, exports, links)
- ตรวจสอบ dependencies ที่เกี่ยวข้อง (parent workflows, dependent files)
- บันทึก locations ทั้งหมดที่ต้องอัพเดท

### 2. Delete

ดำเนินการลบและอัพเดท

- ลบไฟล์หรือ folder
- อัพเดททุก references ใน codebase
- อัพเดท imports ทั้งหมด
- อัพเดท barrel exports ถ้าจำเป็น

## Rules

- ตรวจสอบ references ทั้งหมดก่อน delete
- อัพเดต references ทั้งหมดหลัง delete
- ตรวจสอบว่าไม่มี circular dependencies เกิดขึ้น

## Expected Outcome

- ไฟล์หรือ folder ลบสำเร็จ
- References ทั้งหมดอัพเดตแล้ว
- ไม่มี broken references
