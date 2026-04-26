---
title: Edit Relative
description: แก้ไขไฟล์ที่เกี่ยวข้องและอัพเดท references ทั้งหมด
auto_execution_mode: 3
---

## Goal

แก้ไขไฟล์ที่เกี่ยวข้องกับ context ปัจจุบันและอัพเดท references ทั้งหมดในโปรเจกต์

## Execute

### 1. Analyze Context

1. ระบุไฟล์ที่ต้องแก้ไขจาก context ปัจจุบัน
2. ค้นหา references ทั้งหมดที่เกี่ยวข้อง
3. ตรวจสอบ dependencies ที่ได้รับผลกระทบ
4. บันทึก locations ที่ต้องอัพเดท

### 2. Edit Files

1. แก้ไขไฟล์ที่ระบุ
2. อัพเดท references ทั้งหมดใน codebase
3. อัพเดท imports ถ้าจำเป็น
4. อัพเดท barrel exports ถ้าจำเป็น

### 3. Update References

1. รัน `/update-reference`
2. ตรวจสอบว่า references ถูกอัพเดท
3. ตรวจสอบว่าไม่มี broken references

## Rules

- ตรวจสอบ references ทั้งหมดก่อนแก้ไข
- อัพเดท references หลังจากแก้ไขไฟล์
- ตรวจสอบว่าไม่มี circular dependencies เกิดขึ้น
- ใช้ git สำหรับ file operations ถ้าเป็นไปได้

## Expected Outcome

- ไฟล์แก้ไขสำเร็จ
- References ทั้งหมดอัพเดทแล้ว
- ไม่มี broken references