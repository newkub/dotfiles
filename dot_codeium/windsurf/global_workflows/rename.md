---
title: Rename
description: เปลี่ยนชื่อไฟล์หรือโฟลเดอร์และอัปเดท references ทั้งหมด
auto_execution_mode: 3
related_workflows:
  - /follow-file-operation
  - /update-references
---

## Goal

เปลี่ยนชื่อไฟล์หรือโฟลเดอร์และอัปเดท references ทั้งหมดใน codebase

## Scope

Rename ไฟล์หรือโฟลเดอร์พร้อมอัปเดท imports, exports, และ references ทั้งหมด

## Execute

### 1. Prepare Rename

เตรียมการ rename ไฟล์หรือโฟลเดอร์

1. ระบุไฟล์หรือโฟลเดอร์ที่จะ rename
2. ระบุชื่อใหม่ที่ต้องการ
3. ตรวจสอบว่าชื่อใหม่ไม่ขัดแย้งกับ naming conventions
4. ตรวจสอบว่าไม่มีไฟล์ชื่อเดียวกันอยู่แล้ว

### 2. Search References

ค้นหา references ทั้งหมดของไฟล์ที่จะ rename

1. ค้นหา imports ที่อ้างอิงถึงไฟล์เดิม
2. ค้นหา exports ที่ถูกอ้างอิงจากไฟล์อื่น
3. ค้นหา references ใน config files
4. ค้นหา references ใน documentation
5. ค้นหา references ใน test files

### 3. Rename File

เปลี่ยนชื่อไฟล์หรือโฟลเดอร์

1. ใช้ `git mv` สำหรับ rename ไฟล์ (ถ้าใช้ git)
2. ใช้ `pwsh` สำหรับ rename ไฟล์ (ถ้าไม่ใช้ git)
3. ตรวจสอบว่า rename สำเร็จ
4. ตรวจสอบว่าไฟล์เดิมถูกลบแล้ว

### 4. Update References

อัปเดท references ทั้งหมด

1. ทำ `/edit-relative` เพื่ออัปเดท references ทั้งหมด
2. อัปเดท import paths ในไฟล์ที่อ้างอิง
3. อัปเดท export paths ในไฟล์ที่ export
4. อัปเดท config files ที่เกี่ยวข้อง
5. อัปเดท documentation ที่เกี่ยวข้อง

### 5. Validate Changes

ตรวจสอบการเปลี่ยนแปลง

1. รัน typecheck เพื่อตรวจสอบ
2. รัน lint เพื่อตรวจสอบ
3. รัน tests เพื่อตรวจสอบ
4. ตรวจสอบว่าไม่มี broken references

## Rules

### 1. Naming Conventions

กฎการตั้งชื่อ:

- ใช้ naming conventions ที่เหมาะสมกับภาษาและ project
- ใช้ชื่อที่สื่อความหมายชัดเจน
- หลีกเลี่ยงชื่อที่สับสน
- ใช้ kebab-case สำหรับไฟล์ (Vue, HTML, CSS)
- ใช้ PascalCase สำหรับ components (Vue, React)
- ใช้ camelCase สำหรับ utilities (JavaScript, TypeScript)

### 2. Git Best Practices

การใช้ git สำหรับ rename:

- ใช้ `git mv` แทนการลบและสร้างใหม่
- Git จะตรวจจับ rename อัตโนมัติ
- รักษาประวัติของไฟล์
- รักษา blame history

### 3. Reference Updates

การอัปเดท references:

- ค้นหา references ทั้งหมดก่อน rename
- อัปเดททุก references ที่พบ
- ตรวจสอบ case sensitivity ของ paths
- ตรวจสอบ absolute paths และ relative paths

### 4. Validation

ตรวจสอบการเปลี่ยนแปลง:

- รัน typecheck หลังจาก rename
- รัน lint หลังจาก rename
- รัน tests หลังจาก rename
- ตรวจสอบว่าไม่มี broken references

## Expected Outcome

- [ ] ไฟล์หรือโฟลเดอร์ถูก rename สำเร็จ
- [ ] References ทั้งหมดถูกอัปเดท
- [ ] ไม่มี broken imports
- [ ] ไม่มี broken exports
- [ ] Config files ถูกอัปเดท
- [ ] Documentation ถูกอัปเดท
- [ ] Test files ถูกอัปเดท
- [ ] Typecheck ผ่าน
- [ ] Lint ผ่าน
- [ ] Tests ผ่าน

## Common Mistakes

ข้อผิดพลาดที่พบบ่อย:

- ไม่ค้นหา references ก่อน rename
- ไม่ใช้ `git mv` สำหรับ rename ไฟล์
- ไม่อัปเดท references ทั้งหมด
- ไม่ตรวจสอบ naming conventions
- ไม่ตรวจสอบด้วย typecheck
- ไม่ตรวจสอบด้วย lint
- ไม่ตรวจสอบด้วย tests

## Anti-Patterns

รูปแบบที่ควรหลีกเลี่ยง:

- ❌ Rename ไฟล์โดยไม่อัปเดท references
- ❌ ใช้ชื่อที่ไม่สอดคล้องกับ conventions
- ❌ ไม่ค้นหา references ทั้งหมม
- ❌ ไม่ตรวจสอบด้วย typecheck
- ❌ ไม่ตรวจสอบด้วย lint
- ❌ ไม่อัปเดท documentation

