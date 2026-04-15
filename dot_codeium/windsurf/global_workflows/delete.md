---
title: Delete
description: ลบไฟล์หรือ folder และอัพเดท references ทั้งหมด
auto_execution_mode: 3
---

## Goal

ลบไฟล์หรือ folder และอัพเดท references ทั้งหมดในโปรเจกต์

## Execute

### 1. Analyze References

1. ค้นหาทุก references ที่ใช้ไฟล์หรือ folder
2. ตรวจสอบ dependencies ที่เกี่ยวข้อง
3. บันทึก locations ทั้งหมดที่ต้องอัพเดท

### 2. Delete

1. ลบไฟล์หรือ folder
2. อัพเดททุก references ใน codebase
3. อัพเดท imports ทั้งหมด
4. อัพเดท barrel exports ถ้าจำเป็น

### 3. Verify

1. รัน `/run-verify` เพื่อตรวจสอบ
2. รัน `/run-test` เพื่อทดสอบ
3. ตรวจสอบว่าไม่มี broken references

## Rules

1. ตรวจสอบ references ทั้งหมดก่อน delete
2. อัพเดต references ทั้งหมดหลัง delete
3. ตรวจสอบว่าไม่มี circular dependencies เกิดขึ้น
4. ทำการ verify หลัง delete เสร็จ

## Expected Outcome

- ไฟล์หรือ folder ลบสำเร็จ
- References ทั้งหมดอัพเดตแล้ว
- ไม่มี broken references
- Tests ผ่านทั้งหมด