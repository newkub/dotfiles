---
title: Rename
description: เปลี่ยนชื่อ identifier ใน code ด้วย ast-grep และอัปเดท references ทั้งหมด
auto_execution_mode: 3
url: https://ast-grep.github.io/guide/rewrite-code.html
related:
  - /use-ast-grep
  - /edit-relative
  - /scan-codebase
  - /resolve-errors
  - /run-verify
---

## Goal

เปลี่ยนชื่อ identifier (variable, function, type, class, interface, enum) ใน code ด้วย ast-grep และอัปเดท references ทั้งหมดอย่างปลอดภัย

## Scope

Rename code identifiers ด้วย ast-grep AST-based pattern matching — ไม่รวม rename ไฟล์หรือโฟลเดอร์ (ใช้ `/rename-to`)

## Execute

### 1. Identify Rename Target

ระบุ identifier ที่จะ rename และ scope ของการเปลี่ยนแปลง

> Goal: รู้ชื่อเดิม ชื่อใหม่ ประเภท identifier และภาษา

1. ระบุ identifier เดิมและชื่อใหม่ที่ต้องการ
2. ระบุประเภท: variable, function, type, class, interface, enum, property
3. ระบุ language: TypeScript, JavaScript, Rust, Python, etc.
4. ตรวจสอบว่าชื่อใหม่ไม่ขัดแย้งกับ identifier ที่มีอยู่แล้ว
5. ถ้าชื่อใหม่ซ้ำกับ identifier ที่มีอยู่ → stop และ report

### 2. Search All References

ค้นหา references ทั้งหมดของ identifier เดิมก่อน rename

> Goal: รู้จำนวนและตำแหน่ง references ทั้งหมด

1. ใช้ `ast-grep run -p '$OLD_NAME' --lang <lang> <path>` เพื่อค้นหาทุก occurrence
2. ใช้ `grep_search` สำหรับค้นหาใน config files, markdown, และ non-code files
3. จำแนก references: definition, call site, type annotation, import/export
4. บันทึกจำนวน references ที่พบเพื่อ verify หลัง rename
5. ถ้าไม่พบ references → stop และ report

### 3. Rename With Ast-grep

ใช้ ast-grep สำหรับ rename identifier ทั้ง definition และ usage

> Goal: ทุก occurrence ของ identifier เดิมถูกแทนที่ด้วยชื่อใหม่

1. ใช้ `--rewrite` flag สำหรับ ad-hoc rename แบบเร็ว:
   ```sh
   ast-grep run -p 'oldName' --rewrite 'newName' --lang ts <path>
   ```
2. ใช้ `--interactive` flag เพื่อ review ทุก change ก่อน apply:
   ```sh
   ast-grep run -p 'oldName' --rewrite 'newName' --lang ts -i <path>
   ```
3. สำหรับ rename ที่ต้อง match เฉพาะประเภท (เช่น function เท่านั้น) ให้สร้าง YAML rule:
   ```yaml
   id: rename-function
   language: TypeScript
   rule:
     pattern: oldName($$$ARGS)
   fix: newName($$$ARGS)
   ```
4. สำหรับ rename ที่ต้อง match หลายรูปแบบพร้อมกัน ใช้ YAML doc separator (`---`) เพื่อ define หลาย rules ในไฟล์เดียว:
   ```yaml
   id: rename-def
   language: TypeScript
   rule:
     pattern: function oldName($$$ARGS) { $$$BODY }
   fix: function newName($$$ARGS) { $$$BODY }
   ---
   id: rename-call
   language: TypeScript
   rule:
     pattern: oldName($$$ARGS)
   fix: newName($$$ARGS)
   ```
5. รัน `ast-grep scan --config <rule.yml> --update` เพื่อ apply ทุก rules
6. ถ้า ast-grep ไม่ match บางกรณี → ใช้ `edit` หรือ `multi_edit` แก้ manually

### 4. Update Non-Code References

อัปเดท references ในไฟล์ที่ ast-grep ไม่ครอบคลุม

> Goal: ไม่มี broken references ในทุกประเภทไฟล์

1. ทำ `/edit-relative` เพื่ออัปเดท references ใน config files, markdown, JSON, YAML
2. ค้นหาด้วย `grep_search` อีกครั้งเพื่อยืนยันว่าไม่มีชื่อเดิมเหลือ
3. อัปเดท documentation ที่อ้างอิง identifier เดิม
4. อัปเดท test files ที่อ้างอิง identifier เดิม
5. อัปเดท comments ที่อ้างอิง identifier เดิม

### 5. Validate Changes

ตรวจสอบว่า rename สมบูรณ์และไม่ทำลาย code

> Goal: Code ทำงานได้ ไม่มี broken references

1. รัน `grep_search` ค้นหาชื่อเดิมอีกครั้ง → ต้องไม่พบ (ยกเว้นใน git history หรือ comments ที่ไม่เกี่ยวข้อง)
2. รัน typecheck: `tsgo --noEmit` หรือ `bun run typecheck`
3. รัน lint: `biome lint` หรือ `bun run lint`
4. รัน tests: `bun run test` หรือ `vitest run`
5. ถ้า validation ไม่ผ่าน → ทำ `/resolve-errors` และ fix จนผ่าน (max 3 ครั้ง → stop/report)

## Rules

### 1. Ast-grep First

ใช้ ast-grep เป็นเครื่องมือหลักสำหรับ rename:

- ใช้ `--rewrite` flag สำหรับ ad-hoc rename แบบเร็ว
- ใช้ YAML rule กับ `fix` field สำหรับ rename ที่ซับซ้อนหรือต้อง match เฉพาะประเภท
- ใช้ `--interactive` flag เมื่อต้อง review ทุก change ก่อน apply
- ใช้ meta-variables (`$OLD`, `$$$ARGS`) เพื่อ capture และ replay ใน fix
- ใช้ `transform` สำหรับ case conversion (เช่น camelCase → PascalCase)
- อ้างอิง `/use-ast-grep` สำหรับการใช้งาน ast-grep โดยละเอียด

### 2. Match All Occurrence Types

Rename ต้องครอบคลุมทุกรูปแบบการใช้งาน:

- **Function**: definition, call site, type reference, import/export
- **Variable**: declaration, usage, destructuring, reassignment
- **Type/Interface**: definition, type annotation, generic parameter, import/export
- **Class**: definition, instantiation, type reference, import/export
- **Enum**: definition, member access, import/export
- **Property**: definition, access, destructuring, optional chaining

### 3. Safety And Scope Control

ป้องกันการ rename ผิดตัว:

- ใช้ `kind: identifier` ใน rule เพื่อจำกัดเฉพาะ identifier nodes
- ใช้ `constraints` เพื่อกรองเฉพาะ identifier ที่ต้องการ
- ใช้ `files` และ `ignores` ใน rule เพื่อจำกัด scope
- ตรวจสอบว่าชื่อใหม่ไม่ซ้ำกับ identifier ที่มีอยู่ก่อน rename
- ใช้ `--interactive` เมื่อไม่แน่ใจว่า match ถูกต้องทุกตัว

### 4. YAML Rule For Complex Rename

ใช้ YAML rule เมื่อ ad-hoc `--rewrite` ไม่เพียงพอ:

- ใช้ YAML doc separator (`---`) เพื่อ define หลาย rules ในไฟล์เดียว
- แยก rule สำหรับ definition และ call site อย่างชัดเจน
- ใช้ `transform` สำหรับ case conversion หรือ string manipulation
- ใช้ `rewriters` สำหรับ nested transformation
- เก็บ rule ไว้ใน `rules/` หา้งต้องการ reuse

### 5. Validation Checklist

ตรวจสอบหลัง rename ทุกครั้ง:

- ค้นหาชื่อเดิมด้วย `grep_search` → ต้องไม่พบใน code files
- Typecheck ผ่าน
- Lint ผ่าน
- Tests ผ่าน
- จำนวน references ใหม่ตรงกับจำนวน references เดิมที่บันทึกไว้

## Expected Outcome

- identifier ถูก rename สมบูรณ์ในทุก occurrence
- ไม่มี broken references ใน code, config, และ docs
- Typecheck, lint, และ tests ผ่าน
- ประวัติการ rename สามารถ track ผ่าน git diff
