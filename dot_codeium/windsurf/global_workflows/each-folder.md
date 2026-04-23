---
title: Process Each Folder
description: ทำแต่ละ folder จนครบ
auto_execution_mode: 3
---

## Goal

ทำแต่ละ folder จนครบ

## Execute

### 1. List Folders

1. ใช้ `find_by_name` หรือ `list_dir` เพื่อดู folders ทั้งหมด
2. ระบุ pattern หรือ depth ที่ต้องการ

### 2. Process Each Folder

1. อ่าน folder ด้วย `list_dir`
2. ประมวลผล folder ตาม workflow ที่เกี่ยวข้อง
3. ทำตาม workflow ที่เกี่ยวข้องกับแต่ละ folder

### 3. Verify

1. ตรวจสอบว่าทุก folder ได้รับการประมวลผลแล้ว
2. ตรวจสอบความถูกต้องของการประมวลผล

## Rules

### 1. Folder Discovery

- ใช้ `find_by_name` สำหรับค้นหาด้วย pattern
- ใช้ `list_dir` สำหรับดูทุก folder ใน directory
- ระบุ MaxDepth หรือ pattern ที่ชัดเจน

### 2. Processing Order

- ทำตามลำดับที่เหมาะสมกับ dependencies
- ทำ folder ที่เป็น foundation ก่อน
- หลีกเลี่ยง circular dependencies

### 3. Batch Operations

- อ่าน folders แบบ parallel เมื่อเป็นไปได้
- ประมวลผล folders แบบ sequential เพื่อหลีกเลี่ยง conflicts

## Expected Outcome

- ทุก folder ได้รับการประมวลผลครบถ้วน
- การประมวลผลเป็นไปตาม workflow ที่กำหนด
- ไม่มี folder ที่ถูกข้าม