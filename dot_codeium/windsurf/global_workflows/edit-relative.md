---
title: Edit Relative
description: อัปเดท references ทั้งหมดเมื่อแก้ไข ย้าย หรือลบไฟล์ ครอบคลุมทุกตำแหน่ง
auto_execution_mode: 3
related:
  - /follow-content-quality
  - /write-global-workflows
  - /follow-consistency
---

## Goal

อัปเดท references ทั้งหมดที่เกี่ยวข้องเมื่อมีการแก้ไข ย้าย หรือลบไฟล์ ครอบคลุมทุกตำแหน่งที่เก็บ references

## Scope

ใช้สำหรับอัปเดท references เมื่อ:
- แก้ไขไฟล์ที่ถูกอ้างอิงจากไฟล์อื่น
- ย้ายไฟล์ไปยังตำแหน่งใหม่
- เปลี่ยนชื่อไฟล์
- ลบไฟล์ที่ถูกอ้างอิง
- เปลี่ยนชื่อ workflow หรือ skill

ครอบคลุมการค้นหาในทุกตำแหน่ง:
- Global workflows (`~/.codeium/windsurf/global_workflows/`)
- Global skills (`~/.codeium/windsurf/skills/`)
- Project codebase (source code, configs, docs)
- `.devin/rules/` ในแต่ละ workspace
- `AGENTS.md` ในแต่ละ workspace
- Workspace workflows (`.devin/workflows/`, `.windsurf/workflows/`)

## Execute

### 1. Identify Changed Files

ระบุไฟล์ที่มีการเปลี่ยนแปลง

1. ระบุไฟล์ที่ถูกแก้ไข ย้าย เปลี่ยนชื่อ หรือลบจาก task ปัจจุบัน
2. รัน `git status --porcelain` เพื่อดูไฟล์ที่มีการเปลี่ยนแปลงทั้งหมด
3. ระบุประเภทการเปลี่ยนแปลง: ย้าย เปลี่ยนชื่อ ลบ หรือแก้ไขเนื้อหา

### 2. Search For References

ค้นหา references ทั้งหมดที่เกี่ยวข้องในทุกตำแหน่ง

1. ค้นหาใน global workflows ด้วย `findstr` หรือ `Grep`
2. ค้นหาใน global skills ด้วย `findstr` หรือ `Grep`
3. ค้นหาใน project codebase ด้วย `Grep` หรือ `ast-grep`
4. ค้นหาใน `.devin/rules/` ของทุก workspace
5. ค้นหาใน `AGENTS.md` ของทุก workspace
6. ค้นหาใน workspace workflows (`.devin/workflows/`, `.windsurf/workflows/`)
7. ค้นหาชื่อไฟล์เก่า เส้นทางเก่า import statements และ workflow references

### 3. Update References

อัปเดท references ทั้งหมดที่พบตามประเภทการเปลี่ยนแปลง

**สำหรับการย้ายไฟล์:**
1. อัปเดท import paths ทั้งหมดใน codebase
2. อัปเดท file path references ทั้งหมดใน global workflows และ skills
3. อัปเดท workflow references ทั้งหมด

**สำหรับการเปลี่ยนชื่อไฟล์:**
1. อัปเดท import statements ทั้งหมดใน codebase
2. อัปเดท file name references ทั้งหมดใน global workflows และ skills
3. อัปเดท workflow references ทั้งหมด

**สำหรับการลบไฟล์:**
1. ลบ import statements ที่อ้างถึงไฟล์ที่ถูกลบ
2. ลบ references ทั้งหมดใน global workflows และ skills
3. แก้ไข code ที่ใช้ไฟล์ที่ถูกลบ

**สำหรับการเปลี่ยนชื่อ workflow หรือ skill:**
1. อัปเดท references ใน global workflows (`/old-name` → `/new-name`)
2. อัปเดท references ใน global skills
3. อัปเดท references ใน `AGENTS.md` ของทุก workspace
4. อัปเดท references ใน `.devin/rules/` ของทุก workspace
5. อัปเดท references ใน workspace workflows
6. อัปเดท references ใน project codebase

### 4. Verify Updates

ตรวจสอบว่า references ถูกอัปเดทครบถ้วน

1. ค้นหา references เก่าอีกครั้งในทุกตำแหน่งเพื่อยืนยันว่าไม่มีเหลือ
2. รัน linting เพื่อตรวจสอบว่าไม่มี errors
3. รัน typecheck เพื่อตรวจสอบว่าไม่มี type errors
4. รัน test เพื่อตรวจสอบว่าไม่มี test failures

## Rules

### 1. Search Strategy

ค้นหา references อย่างครอบคลุมในทุกตำแหน่ง

- ค้นหาทั้ง absolute paths และ relative paths
- ค้นหาทั้งชื่อไฟล์และ extension
- ค้นหาทั้ง import statements และ string references
- ค้นหาในทุก file types (.ts, .js, .md, .json, .yml, .jsonc, etc.)
- ค้นหาใน global workflows, global skills, codebase, `.devin/rules/`, `AGENTS.md`, workspace workflows

### 2. Update Strategy

อัปเดท references อย่างถูกต้อง

- อัปเดททุก references ที่พบ ไม่เว้นแม้แต่ reference เดียว
- รักษาความสม่ำเสมอของ import style
- รักษาความสม่ำเสมอของ path format
- ตรวจสอบว่า updates ไม่ทำให้เกิด syntax errors
- ถ้าเปลี่ยนชื่อ workflow ให้อัปเดททั้ง `title` และ `related_workflows` ในไฟล์ที่อ้างถึง

### 3. Verification

ตรวจสอบความถูกต้องของ updates

- ตรวจสอบว่า references เก่าไม่มีเหลือในทุกตำแหน่ง
- ตรวจสอบว่า references ใหม่ถูกต้อง
- ตรวจสอบว่า code ยังทำงานได้หลังจาก updates
- ตรวจสอบว่าไม่มี broken imports

## Expected Outcome

- References ทั้งหมดถูกอัปเดทครบถ้วนในทุกตำแหน่ง
- ไม่มี references เก่าเหลืออยู่
- Code ยังทำงานได้หลังจาก updates
- ไม่มี linting หรือ type errors
