---
title: Process Each File
description: ทำแต่ละ file จนครบ
auto_execution_mode: 3
---

## Goal

ทำแต่ละ file จนครบ

## Execute

### 1. List Files

1. ใช้ `find_by_name` หรือ `list_dir` เพื่อดู files ทั้งหมด
2. ระบุ pattern หรือ extension ที่ต้องการ

### 2. Process Each File

1. อ่าน file ด้วย `read_file`
2. แก้ไข file ด้วย `edit` หรือ `multi_edit`
3. ทำตาม workflow ที่เกี่ยวข้องกับแต่ละ file

### 3. Verify

1. ตรวจสอบว่าทุก file ได้รับการประมวลผลแล้ว
2. ตรวจสอบความถูกต้องของการแก้ไข

## Rules

### 1. File Discovery

- ใช้ `find_by_name` สำหรับค้นหาด้วย pattern
- ใช้ `list_dir` สำหรับดูทุก file ใน directory
- ระบุ extension หรือ pattern ที่ชัดเจน

### 2. Processing Order

- ทำตามลำดับที่เหมาะสมกับ dependencies
- ทำ file ที่เป็น foundation ก่อน
- หลีกเลี่ยง circular dependencies

### 3. Batch Operations

- อ่าน files แบบ parallel เมื่อเป็นไปได้
- แก้ไข files แบบ sequential เพื่อหลีกเลี่ยง conflicts
- ใช้ `multi_edit` สำหรับแก้ไขหลายจุดใน file เดียว

## Expected Outcome

- ทุก file ได้รับการประมวลผลครบถ้วน
- การแก้ไขเป็นไปตาม workflow ที่กำหนด
- ไม่มี file ที่ถูกข้าม