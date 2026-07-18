---
title: Improve Naming
description: วิเคราะห์และปรับปรุง naming conventions ทั้ง code, API, database, files ให้ consistent และสื่อความหมาย
auto_execution_mode: 3
related:
  - /review-naming
  - /idea-improve-naming
  - /rename
  - /rename-to
  - /scan-codebase
  - /follow-best-practice
  - /edit-relative
  - /resolve-errors
  - /run-verify
  - /suggest-next-action
---

## Goal

วิเคราะห์และปรับปรุง naming conventions ใน codebase ให้ consistent, สื่อความหมาย และสอดคล้องกับ best practices

## Scope

ใช้สำหรับแก้ไข naming issues ที่ตรวจพบ: variables, functions, files, components, types, API endpoints, database tables/columns, CSS classes, constants — ไม่รวมการสร้างไอเดีย (ใช้ `/idea-improve-naming`) หรือ review เท่านั้น (ใช้ `/review-naming`)

## Execute

### 1. Analyze Naming Issues

วิเคราะห์ naming issues ใน codebase

> Goal: รู้ว่ามี naming issues อะไรบ้าง จัดลำดับตาม severity

1. parallel: ทำ `/scan-codebase` ∥ ทำ `/review-naming` — ระบุ inconsistencies, abbreviations ที่สับสน, ชื่อที่ไม่สื่อความหมาย
2. ค้นหา patterns: inconsistent casing, misleading names, non-standard abbreviations, mismatched conventions
3. จัดลำดับตาม severity: API/database naming > component/function naming > variable/file naming > CSS naming — ถ้าไม่มี issues → stop และ report

### 2. Research Conventions

ค้นหา naming best practices สำหรับ tech stack ที่ใช้

> Goal: รู้ conventions ที่ถูกต้องตามภาษาและ framework

1. ทำ `/follow-best-practice` สำหรับ naming conventions ของภาษาและ framework ที่ใช้
2. ระบุ framework-specific rules: SolidJS component (PascalCase), Drizzle table (snake_case), API endpoint (plural kebab-case)
3. ตรวจสอบว่า conventions สอดคล้องกับ linter rules ใน `biome.jsonc`

### 3. Fix Critical Naming Issues

แก้ไข naming issues ที่มีผลกระทบสูง

> Goal: API และ database naming consistent และสื่อความหมาย

1. แก้ API endpoint naming: plural vs singular, HTTP method usage, kebab-case consistency
2. แก้ database table/column naming: snake_case consistency, foreign key naming convention
3. แก้ component naming: PascalCase, descriptive names, prefix conventions
4. ใช้ `/rename` สำหรับ rename code identifiers ด้วย ast-grep — ใช้ `/rename-to` สำหรับ rename files/directories
5. ถ้า rename ทำให้เกิด errors → ทำ `/resolve-errors` ก่อนดำเนินต่อ

### 4. Fix Function And Variable Naming

แก้ไข function และ variable naming ที่ไม่สื่อความหมาย

> Goal: Function และ variable naming consistent อ่านเข้าใจง่าย

1. parallel: แก้ function naming (verb prefixes: get/fetch/load/retrieve) ∥ แก้ variable naming (camelCase consistency, ลด abbreviations)
2. แก้ async function naming: prefix ด้วย `async` หรือ suffix ด้วย `Async` ตาม convention
3. แก้ event handler naming: `on` prefix สำหรับ handlers, `handle` prefix สำหรับ internal handlers
4. แก้ boolean naming: `is/has/can/should` prefix consistency
5. ใช้ `/rename` สำหรับทุก identifier rename

### 5. Fix File And CSS Naming

แก้ไข file และ CSS naming conventions

> Goal: File และ CSS naming consistent ตาม file type

1. parallel: แก้ file naming (component: PascalCase, utility: camelCase, route: framework convention) ∥ แก้ CSS naming (BEM, utility classes, CSS variables)
2. แก้ file extension: `.tsx` สำหรับ components, `.ts` สำหรับ pure logic
3. แก้ prefix/suffix conventions: `use-*` สำหรับ composables, `*.server.ts` สำหรับ server-only
4. ใช้ `/rename-to` สำหรับ rename files — ทำ `/edit-relative` หลังทุกการ rename file

### 6. Validate And Report

ตรวจสอบผลลัพธ์และรายงาน

> Goal: Naming ดีขึ้น ผ่าน validation และมี report ชัดเจน

1. parallel: รัน `tsgo --noEmit` ∥ รัน `bunx biome lint` ∥ ทำ `/run-verify`
2. ทำ `/edit-relative` เพื่อตรวจสอบว่าไม่มี broken references
3. เทียบ before/after: inconsistent naming count, abbreviation count, misleading name count
4. ถ้า validation fail → ทำ `/resolve-errors` แล้ว retry (max 3 → stop/report)
5. รายงานเป็นตาราง: category | issues found | issues fixed | status — ทำ `/suggest-next-action`

## Rules

### 1. Naming Priority

- แก้ API และ database naming ก่อนเสมอ — impact สูงสุดต่อ contract และ backward compatibility
- แก้ component naming ก่อน function naming — component naming affect UX และ debugging
- ใช้ `/rename` สำหรับ code identifiers, `/rename-to` สำหรับ files/directories — ไม่ rename manual

### 2. Safety And Scope Control

- การ rename API endpoint และ database column ต้องมี dry run และ user confirmation ก่อนดำเนินการ
- ตรวจสอบว่าชื่อใหม่ไม่ซ้ำกับ identifier ที่มีอยู่ก่อน rename
- ถ้า rename ส่งผลกระทบ >10 ไฟล์ → ทำเป็น batches และ validate ทีละ batch
- ทำ `/edit-relative` หลังทุกการ rename file เพื่ออัปเดท references

### 3. High Impact Content

- ทุก bullet ต้องตอบได้ว่า "ถ้าไม่มีแล้วผลลัพธ์เปลี่ยนไหม" — ถ้าไม่เปลี่ยน → ลบ
- ห้าม TODO, MOCK, placeholder — ไม่เปลี่ยน naming โดยไม่ verify ผลกระทบ
- เปลี่ยนชื่อเมื่อชื่อปัจจุบันสับสน ไม่สื่อความหมาย หรือ inconsistent — ไม่เปลี่ยนเพราะเท่ห์อย่างเดียว

## Expected Outcome

- Naming conventions consistent ทั้ง code, API, database, files, CSS
- ไม่มี broken references หลัง rename
- Typecheck, lint, และ tests ผ่าน
- ตาราง report: category | issues found | issues fixed | status
