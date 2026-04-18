---
title: Move
description: ย้ายไฟล์และอัพเดท reference
auto_execution_mode: 3
---

## Goal

ย้ายไฟล์ไปยังตำแหน่งใหม่และอัพเดท reference

## Execute

### 1. Move File

ย้ายไฟล์ไปยังตำแหน่งใหม่

1. ระบุไฟล์ที่ต้องย้าย
2. ย้ายไฟล์ไปยังตำแหน่งใหม่
3. ตรวจสอบว่าย้ายถูกต้อง

### 2. Update Reference

อัพเดท reference

1. รัน `/update-reference`
2. ตรวจสอบว่า references ถูกอัพเดท

## Rules

- ใช้ git สำหรับ file operations ถ้าเป็นไปได้
- ตรวจสอบว่าไม่มี data loss
- อัพเดท references หลังจากย้ายไฟล์

## Expected Outcome

- ไฟล์ถูกย้ายไปยังตำแหน่งใหม่
- References ถูกอัพเดท
- ไม่มี data loss