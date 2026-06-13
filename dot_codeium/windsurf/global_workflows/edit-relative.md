---
title: Edit Relative
description: แก้ไขไฟล์ที่เกี่ยวข้องทั้งหมดเมื่อทำ file operation
auto_execution_mode: 3
related_workflows:
  - /update-references
---

## Goal

เมื่อทำ file operation ใดๆ ให้แก้ไขไฟล์ที่เกี่ยวข้องทั้งหมด

## Scope

ครอบคลุมการอัปเดตไฟล์ที่เกี่ยวข้องเมื่อทำ file operations (edit, create, delete, move, rename)

## Execute

### 1. Identify File Operation

ระบุ file operation ที่ทำ

1. ระบุไฟล์ที่ถูกแก้ไข/สร้าง/ลบ
2. ระบุประเภท operation (`edit`, `create`, `delete`, `move`, `rename`)
3. ระบุเนื้อหาที่เปลี่ยนแปลง

### 2. Find Related Files

ค้นหาไฟล์ที่เกี่ยวข้อง

1. ค้นหา imports ที่อ้างอิงถึงไฟล์ที่เปลี่ยนแปลง
2. ค้นหา exports ที่ถูกอ้างอิงจากไฟล์อื่น
3. ค้นหา references ใน config files
4. ค้นหา references ใน documentation
5. ค้นหา references ใน test files
6. ค้นหา references ใน global workflows
7. ค้นหา references ใน skills

### 3. Update Related Files

แก้ไขไฟล์ที่เกี่ยวข้อง

1. อัปเดต import paths ในไฟล์ที่อ้างอิง
2. อัปเดต export paths ในไฟล์ที่ export
3. อัปเดต config files ที่เกี่ยวข้อง
4. อัปเดต documentation ที่เกี่ยวข้อง
5. อัปเดต test files ที่เกี่ยวข้อง

### 4. Validate Changes

ตรวจสอบการเปลี่ยนแปลง

1. ตรวจสอบว่า imports ถูกต้อง
2. ตรวจสอบว่า exports ถูกต้อง
3. ตรวจสอบว่า config files ถูกต้อง
4. รัน typecheck เพื่อตรวจสอบ
5. รัน lint เพื่อตรวจสอบ

## Rules

### 1. File Operation Types

ประเภท file operation:

- **Edit**: แก้ไขเนื้อหาไฟล์
- **Create**: สร้างไฟล์ใหม่
- **Delete**: ลบไฟล์
- **Move**: ย้ายไฟล์ไปที่อื่น
- **Rename**: เปลี่ยนชื่อไฟล์

### 2. Related File Types

ประเภทไฟล์ที่ต้องตรวจสอบ:

- **Import files**: ไฟล์ที่ import จากไฟล์ที่เปลี่ยนแปลง
- **Export files**: ไฟล์ที่ export จากไฟล์ที่เปลี่ยนแปลง
- **Config files**: config files ที่อ้างอิงถึงไฟล์
- **Documentation**: README, docs ที่อ้างอิงถึงไฟล์
- **Test files**: test files ที่ทดสอบไฟล์ที่เปลี่ยนแปลง

### 3. Update Strategies

กลยุทธ์การอัปเดต:

- ใช้ search tools สำหรับค้นหา references
- ใช้ absolute paths สำหรับความชัดเจน
- อัปเดตทุก references ที่พบ
- ตรวจสอบทุกไฟล์ที่เปลี่ยนแปลง

### 4. Validation

ตรวจสอบการเปลี่ยนแปลง:

- รัน typecheck หลังจากอัปเดต
- รัน lint หลังจากอัปเดต
- รัน tests หลังจากอัปเดต
- ตรวจสอบว่าไม่มี broken references

## Expected Outcome

- ไฟล์ที่เกี่ยวข้องทั้งหมดถูกอัปเดต
- ไม่มี broken imports
- ไม่มี broken exports
- Config files ถูกอัปเดต
- Documentation ถูกอัปเดต
- Test files ถูกอัปเดต
- Typecheck ผ่าน
- Lint ผ่าน
- Tests ผ่าน
