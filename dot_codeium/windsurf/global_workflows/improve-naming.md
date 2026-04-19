---
title: Improve Naming
description: ปรับปรุงการตั้งชื่อให้สอดคล้องกับ conventions
auto_execution_mode: 3
---

## Goal

ปรับปรุงการตั้งชื่อให้ชัดเจน สอดคล้อง และตาม conventions

## Execute

### 1. Analyze Naming

วิเคราะห์การตั้งชื่อปัจจุบัน

1. ตรวจสอบ file names ทั้งหมด
2. ตรวจสอบ type names ทั้งหมด
3. ตรวจสอบ constant names ทั้งหมด
4. ตรวจสอบ function names ทั้งหมด
5. ตรวจสอบ component names ทั้งหมด
6. ตรวจสอบ variable names ทั้งหมด

### 2. File Naming

ปรับปรุงการตั้งชื่อไฟล์

1. ใช้ `kebab-case` สำหรับไฟล์ทั่วไป
2. ใช้ `PascalCase` สำหรับ components
3. ใช้ `kebab-case` สำหรับ utilities
4. ใช้ `kebab-case` สำหรับ composables
5. ใช้ `kebab-case` สำหรับ types ที่อยู่ในไฟล์แยก
6. อัพเดท imports/exports ทั้งหมด

### 3. Type Naming

ปรับปรุงการตั้งชื่อ types

1. ใช้ `PascalCase` สำหรับ interfaces
2. ใช้ `PascalCase` สำหรับ type aliases
3. ใช้ `PascalCase` สำหรับ enums
4. ใช้ `PascalCase` สำหรับ classes
5. เพิ่ม prefix `I` สำหรับ interfaces (ถ้าจำเป็น)
6. เพิ่ม suffix `Type` สำหรับ type aliases (ถ้าจำเป็น)

### 4. Constant Naming

ปรับปรุงการตั้งชื่อ constants

1. ใช้ `UPPER_SNAKE_CASE` สำหรับ global constants
2. ใช้ `camelCase` สำหรับ local constants
3. ใช้ `PascalCase` สำหรับ enum members
4. จัดกลุ่ม constants ที่เกี่ยวข้อง
5. แยก constants ไปไฟล์ `constants/` ถ้ามีมาก

### 5. Error Naming

ปรับปรุงการตั้งชื่อ errors

1. ใช้ `PascalCase` พร้อม suffix `Error`
2. ใช้ `PascalCase` พร้อม suffix `Exception`
3. ตั้งชื่อที่บอก cause ชัดเจน
4. จัดกลุ่ม errors ตาม domain
5. แยก error types ไปไฟล์ `errors/` ถ้ามีมาก

### 6. Function Naming

ปรับปรุงการตั้งชื่อ functions

1. ใช้ `camelCase` สำหรับ functions
2. ใช้ verb นำหน้าเสมอ (get, set, create, update, delete)
3. ใช้ prefix `use` สำหรับ composables
4. ใช้ prefix `handle` สำหรับ event handlers
5. ใช้ prefix `is/has/can/should` สำหรับ booleans
6. ใช้ prefix `on` สำหรับ callbacks

### 7. Component Naming

ปรับปรุงการตั้งชื่อ components

1. ใช้ `PascalCase` สำหรับ component names
2. ใช้คำนามเดียว หรือ compound nouns
3. ใช้ suffix `UI` สำหรับ UI components (ถ้าจำเป็น)
4. ใช้ prefix `Base` สำหรับ base components (ถ้าจำเป็น)
5. ตั้งชื่อตาม function ไม่ใช่ implementation
6. ใช้ descriptive names ไม่ใช้ generic

### 8. Variable Naming

ปรับปรุงการตั้งชื่อ variables

1. ใช้ `camelCase` สำหรับ variables
2. ตั้งชื่อที่บอก purpose ชัดเจน
3. หลีกเลี่ยง abbreviations ยกเว้นที่รู้จักกันดี
4. ใช้ prefix `_` สำหรับ private members
5. ใช้ `$` สำหรับ refs ใน Vue (ถ้าจำเป็น)
6. หลีกเลี่ยง single-letter variables ยกเว้น loops

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

- File: `PascalCase.vue`, `kebab-case.ts`, `use-kebab-case.ts`
- Type: `PascalCase`, `IPascalCase`, `PascalCaseType`
- Constant: `UPPER_SNAKE_CASE` (global), `camelCase` (local)
- Error: `PascalCaseError`, `PascalCaseException`, `UPPER_SNAKE_CASE`
- Function: `camelCase` (verb), `useCamelCase`, `handleCamelCase`, `isCamelCase`, `onCamelCase`
- Component: `PascalCase`, `BasePascalCase`, `PascalCaseUI`, `PascalCaseLayout`
- Variable: `camelCase`, `_camelCase`, `$camelCase`, `camelCaseList`

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
