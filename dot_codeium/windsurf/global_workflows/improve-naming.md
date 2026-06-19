---
title: Improve Naming
description: ปรับปรุง naming ตาม context และความหมายที่ชัดเจน ไม่ใช่เพียง conventions
auto_execution_mode: 3
related_workflows:
  - /follow-code-quality
  - /follow-rename
---

## Goal

ปรับปรุง naming ให้สื่อความหมายตาม context และ domain ที่เหมาะสม ไม่ใช่เพียงตาม conventions

## Scope

ใช้สำหรับปรับปรุง naming ของ files, functions, variables, types, components ทั้งหมด

## Execute

### 1. Analyze Context And Domain

วิเคราะห์ context และ domain ของ naming

1. สำรวจ naming patterns ทั่ว codebase
2. ระบุ domain-specific terms และ business logic
3. ตรวจสอบว่าชื่อสื่อความหมายตาม context หรือไม่
4. ค้นหาชื่อที่ generic แต่ควรเป็น domain-specific
5. ตรวจสอบชื่อที่ไม่สื่อความหมายใน context ปัจจุบัน

### 2. Apply Context-Aware Naming

ใช้ naming ตาม context และ domain

1. Files: ทำ `/follow-rename` สำหรับ rename ไฟล์
   - Vue components: `PascalCase.vue` (domain-specific)
   - TypeScript files: `kebab-case.ts` (domain-specific)
   - TSX files: `PascalCase.tsx` (domain-specific)
   - Composables: `camelCase.ts` (action-specific)
2. Types: `PascalCase`, `IPascalCase`, `PascalCaseType` (domain-specific)
3. Constants: `UPPER_SNAKE_CASE` (global), `camelCase` (local context)
4. Errors: `PascalCaseError`, `PascalCaseException` (context-specific)
5. Functions: `camelCase` (verb + context), `useCamelCase`, `handleCamelCase`, `isCamelCase`, `onCamelCase`
6. Components: `PascalCase`, `BasePascalCase`, `PascalCaseUI`, `PascalCaseLayout` (domain-specific)
7. Variables: `camelCase`, `_camelCase`, `$camelCase`, `camelCaseList` (context-specific)

### 3. Validate Changes

ตรวจสอบการเปลี่ยนแปลง

1. รัน typecheck เพื่อตรวจสอบ
2. รัน lint เพื่อตรวจสอบ
3. รัน tests เพื่อตรวจสอบ
4. ตรวจสอบว่าชื่อสื่อความหมายตาม context

## Rules

### 1. Use Existing Workflows

ใช้ workflows ที่มีอยู่ก่อนเขียนใหม่

- ทำ `/follow-code-quality` สำหรับ clear naming principles
- ทำ `/follow-rename` สำหรับ rename ไฟล์และอัปเดท references

### 2. Context-Aware Naming

เน้น context และ domain มากกว่า conventions

- ใช้ domain-specific terms แทน generic names
- ชื่อต้องสื่อความหมายใน context ที่ใช้
- หลีกเลี่ยง abbreviations ที่ไม่ชัดเจนใน domain
- ใช้ conventions เป็น baseline แต่ปรับตาม context
- ตรวจสอบว่าชื่อเข้าใจได้โดยไม่ต้องดู implementation

### 3. Naming Conventions

รวม naming conventions ทั้งหมด

- File: `PascalCase.vue`, `kebab-case.ts`, `PascalCase.tsx`, `camelCase.ts`
- Type: `PascalCase`, `IPascalCase`, `PascalCaseType`
- Constant: `UPPER_SNAKE_CASE` (global), `camelCase` (local)
- Error: `PascalCaseError`, `PascalCaseException`, `UPPER_SNAKE_CASE`
- Function: `camelCase` (verb), `useCamelCase`, `handleCamelCase`, `isCamelCase`, `onCamelCase`
- Component: `PascalCase`, `BasePascalCase`, `PascalCaseUI`, `PascalCaseLayout`
- Variable: `camelCase`, `_camelCase`, `$camelCase`, `camelCaseList`

## Expected Outcome

- Naming สื่อความหมายตาม context และ domain
- ชื่อที่เข้าใจได้โดยไม่ต้องดู implementation
- Consistency ตาม conventions แต่ปรับตาม context
- Typecheck ผ่าน
- Lint ผ่าน
- Tests ผ่าน
