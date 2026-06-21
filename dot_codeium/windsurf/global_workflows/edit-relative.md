---
title: Edit Relative
description: แก้ไขไฟล์ที่เกี่ยวข้องกับไฟล์ปัจจุบัน
auto_execution_mode: 3
---

## Goal

แก้ไขไฟล์ที่เกี่ยวข้องกับไฟล์ปัจจุบัน โดยค้นหาและอัพเดทไฟล์ที่ import, reference, หรืออยู่ใน directory เดียวกัน

## Scope

ใช้ workflow นี้เมื่อต้องแก้ไขไฟล์ที่เกี่ยวข้องกับไฟล์ปัจจุบัน เช่น:
- เปลี่ยนชื่อ function/class และต้องอัพเดททุกที่ที่ใช้
- แก้ไข interface และต้องอัพเดท implementations
- ย้ายไฟล์และต้องอัพเดท import paths
- แก้ไข shared types และต้องอัพเดททุกไฟล์ที่ใช้

## Execute

### 1. Identify Current File Context

อ่านไฟล์ปัจจุบันเพื่อเข้าใจ context และหาสิ่งที่ต้องแก้ไข

1. อ่านไฟล์ปัจจุบันด้วย `read_file`
2. วิเคราะห์ exports, imports, และ dependencies
3. ระบุสิ่งที่ต้องแก้ไข (function name, type, path, etc.)

### 2. Find Related Files

ค้นหาไฟล์ที่เกี่ยวข้องทั้งหมด

1. ใช้ `grep` เพื่อค้นหา imports ของไฟล์ปัจจุบัน
2. ใช้ `grep` เพื่อค้นหา references ของ exports จากไฟล์ปัจจุบัน
3. ค้นหาไฟล์ใน directory เดียวกันที่อาจมีความสัมพันธ์
4. ค้นหาไฟล์ใน parent directories ที่อาจ import ไฟล์ปัจจุบัน

### 3. Prioritize Changes

จัดลำดับความสำคัญของการแก้ไข

1. **High Priority**: ไฟล์ที่ import โดยตรงจากไฟล์ปัจจุบัน
2. **Medium Priority**: ไฟล์ที่ import จากไฟล์ที่ import ไฟล์ปัจจุบัน
3. **Low Priority**: ไฟล์ที่อยู่ใน directory เดียวกันแต่ไม่มี direct import

### 4. Apply Changes

แก้ไขไฟล์ตามลำดับความสำคัญ

1. แก้ไขไฟล์ปัจจุบันก่อน (ถ้าจำเป็น)
2. แก้ไขไฟล์ที่ import โดยตรง
3. แก้ไขไฟล์ที่ import แบบ indirect
4. ค้นหาและอัพเดท references ทั้งหมดด้วย `grep` และ `edit`

### 5. Validation

ตรวจสอบความถูกต้องของการแก้ไข

1. ตรวจสอบว่าทุก references ถูกอัพเดทแล้ว
2. ตรวจสอบว่าไม่มี broken imports
3. ตรวจสอบว่า code ยังทำงานได้ตามเดิม

## Rules

### 1. Search Strategy

ใช้ search patterns ที่เหมาะสมเพื่อค้นหา references ทั้งหมด

- ค้นหาด้วย exact matches ก่อน (เช่น `import { MyFunction } from`)
- ค้นหาด้วย partial matches ถ้า exact ไม่พบ
- ใช้ regex patterns สำหรับ complex cases
- ค้นหาทั้ง relative paths และ absolute paths

### 2. Edit Order

แก้ไขตามลำดับที่ปลอดภัยเพื่อป้องกัน circular dependencies

- แก้ไข source file ก่อน (ไฟล์ที่ export)
- แก้ไข consumer files หลังจากนั้น
- หลีกเลี่ยง circular dependencies โดยการแก้ไขตาม dependency graph

### 3. Quality Assurance

รักษาคุณภาพโค้ดหลังจากการแก้ไข

- รักษา consistency กับ codebase
- อัพเดท comments ถ้าจำเป็น
- อัพเดท type declarations ถ้ามี
- ตรวจสอบ naming conventions และ style

### 4. Execution Mode

ใช้ edit-only mode เพื่อป้องกันการรัน commands โดยไม่ได้ตั้งใจ

- ห้ามรัน `run_command` ใดๆ
- ห้ามรัน background process
- ห้ามเปิด `browser_preview`
- ใช้เฉพาะ file editing tools (`edit`, `multi_edit`, `write_to_file`, `read_file`)

## Expected Outcome

- ไฟล์ที่เกี่ยวข้องทั้งหมดถูกอัพเดทแล้ว
- ไม่มี broken imports หรือ references
- Code consistency ยังคงอยู่
- ไม่มี process หรือ terminal ถูกรัน

## Common Mistakes

ข้อผิดพลาดที่พบบ่อย:

- ลืมอัพเดทไฟล์ที่ import แบบ indirect
- แก้ไขไฟล์ในลำดับที่ผิด ทำให้เกิด circular issues
- ไม่ค้นหาไฟล์ใน parent directories
- ใช้ search patterns ที่ไม่ครอบคลุมพอ
- ลืมอัพเดท type declarations หรือ interface files
