---
title: Improve Naming
description: ปรับปรุงการตั้งชื่อให้สอดคล้องกับ conventions
auto_execution_mode: 3
---

## Goal

ปรับปรุงการตั้งชื่อให้ชัดเจน สอดคล้อง และตาม conventions

## Execute

### 1. Analyze Naming

วิเคราะห์การตั้งชื่อปัจจุบันด้วย Bun scripts

1. สร้าง Bun script ใน `scripts/temp/analyze-naming.ts` สำหรับ:
   - ตรวจสอบ file names ทั้งหมด
   - ตรวจสอบ type names ทั้งหมด
   - ตรวจสอบ constant names ทั้งหมด
   - ตรวจสอบ function names ทั้งหมด
   - ตรวจสอบ component names ทั้งหมด
   - ตรวจสอบ variable names ทั้งหมด
2. รัน script ด้วย `bun run scripts/temp/analyze-naming.ts`
3. สรุปผลการ analyze ทั้งหมม
4. ลบ script หลังใช้งาน

### 2. File Naming

ปรับปรุงการตั้งชื่อไฟล์

1. ใช้ `snake_case.rs` สำหรับ Rust files
2. ใช้ `kebab-case.md` สำหรับ documentation files
3. อัพเดท imports/exports ทั้งหมด (mod declarations, use statements)

### 3. Type Naming

ปรับปรุงการตั้งชื่อ types

1. ใช้ `PascalCase` สำหรับ structs
2. ใช้ `PascalCase` สำหรับ enums
3. ใช้ `PascalCase` สำหรับ traits
4. ใช้ `PascalCase` สำหรับ type aliases

### 4. Constant Naming

ปรับปรุงการตั้งชื่อ constants

1. ใช้ `SCREAMING_SNAKE_CASE` สำหรับ const และ static
2. ใช้ `PascalCase` สำหรับ enum variants
3. จัดกลุ่ม constants ที่เกี่ยวข้อง
4. แยก constants ไปไฟล์ `constants/` ถ้ามีมาก

### 5. Error Naming

ปรับปรุงการตั้งชื่อ errors

1. ใช้ `PascalCase` พร้อม suffix `Error`
2. ตั้งชื่อที่บอก cause ชัดเจน
3. จัดกลุ่ม errors ตาม domain
4. แยก error types ไปไฟล์ `errors/` ถ้ามีมาก

### 6. Function Naming

ปรับปรุงการตั้งชื่อ functions

1. ใช้ `snake_case` สำหรับ functions
2. ใช้ verb นำหน้าเสมอ (get, set, create, update, delete)
3. ใช้ prefix `is/has/can/should` สำหรับ booleans
4. ใช้ prefix `on` สำหรับ callbacks

### 7. Component Naming

ปรับปรุงการตั้งชื่อ components (Rust ใช้ struct/module แทน)

1. ใช้ `PascalCase` สำหรับ struct/module names
2. ใช้คำนามเดียว หรือ compound nouns
3. ใช้ suffix `UI` สำหรับ UI components (ถ้าจำเป็น)
4. ใช้ prefix `Base` สำหรับ base components (ถ้าจำเป็น)
5. ตั้งชื่อตาม function ไม่ใช่ implementation
6. ใช้ descriptive names ไม่ใช้ generic

### 8. Variable Naming

ปรับปรุงการตั้งชื่อ variables

1. ใช้ `snake_case` สำหรับ variables
2. ตั้งชื่อที่บอก purpose ชัดเจน
3. หลีกเลี่ยง abbreviations ยกเว้นที่รู้จักกันดี
4. ใช้ prefix `_` สำหรับ unused variables
5. หลีกเลี่ยง single-letter variables ยกเว้น loops

## Rules

### 1. Universal Naming Principles

หลักการทั่วไปที่ใช้ได้กับทุกภาษา

- ชื่อบอก purpose ชัดเจน (what it does, not how)
- ใช้ domain language ที่ถูกต้อง
- หลีกเลี่ยง abbreviations ยกเว้นที่รู้จักกันดี
- ตั้งชื่อตาม business concepts
- รักษา consistency ทั้ง codebase
- ชื่อสั้นแต่ชัดเจน
- ใช้คำเชิงบวก (is_valid) ไม่ใช่เชิงลบ

### 2. Language-Specific Conventions

ใช้ conventions ตามภาษาที่ใช้

- ทำตาม style guide ของภาษา
- ทำตาม conventions ของ community
- ใช้ linter ที่เหมาะสม

### 3. Naming Conventions

ใช้ conventions ที่ถูกต้องสำหรับแต่ละประเภท

- File: `snake_case.rs`, `kebab-case.md`
- Type: `PascalCase` (struct, enum, trait, type alias)
- Constant: `SCREAMING_SNAKE_CASE` (const, static), `PascalCase` (enum variants)
- Error: `PascalCaseError`
- Function: `snake_case` (verb), `is_snake_case`, `on_snake_case`
- Component: `PascalCase`, `BasePascalCase`, `PascalCaseUI`
- Variable: `snake_case`, `_snake_case`

### 4. Consistency And Updates

รักษา consistency และอัพเดท references

- ใช้ conventions เดียวกันทั้ง project
- อัพเดท references ทั้งหมดเมื่อเปลี่ยนชื่อ
- ตรวจสอบ imports/exports ทั้งหมด
- รัน linting และ type checking หลังเปลี่ยนชื่อ

## Expected Outcome

- File names สอดคล้องกับ conventions
- Type names สอดคล้องกับ conventions
- Constant names สอดคล้องกับ conventions
- Error names สอดคล้องกับ conventions
- Function names สอดคล้องกับ conventions
- Component names สอดคล้องกับ conventions
- Variable names สอดคล้องกับ conventions
- Consistency สูงทั่วทั้ง codebase
- Code อ่านง่ายและ maintainable
