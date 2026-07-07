---
title: Improve Debugging
description: ทำให้โค้ด debug ง่ายด้วย logging, error messages, และ clear naming
auto_execution_mode: 3
related_workflows:
  - /follow-workflows
  - /follow-code-quality
  - /improve-error-handling
  - /improve-side-effect
  - /follow-debugging
---

## Goal

ทำให้โค้ด debug ง่ายด้วย logging ที่มี context, error messages ที่ชัดเจน, และ naming ที่เข้าใจง่าย

## Scope

ใช้สำหรับปรับปรุง debuggability ของ functions, modules, และ error handling

## Execute

### 1. Analyze Debuggability

วิเคราะห์ debuggability ปัจจุบัน

1. ตรวจสอบ logging statements ทั้งหมด
2. ตรวจสอบ error messages ทั้งหมด
3. ตรวจสอบ naming conventions
4. ตรวจสอบ code complexity และ nesting

### 2. Improve Logging

ปรับปรุง logging

1. เพิ่ม context ใน logging statements
2. ใช้ structured logging
3. ใช้ log levels ที่เหมาะสม (debug, info, warn, error)
4. ใส่ timestamps และ correlation IDs
5. หลีกเลี่ยง logging ที่ซ้ำซ้อน

### 3. Improve Error Messages

ปรับปรุง error messages

1. เขียน error messages ที่ชัดเจนและเป็นประโยค
2. ใส่ context ที่เกี่ยวข้องใน error messages
3. ระบุสาเหตุและวิธีแก้ไข
4. ใช้ typed error classes
5. หลีกเลี่ยง generic error messages

### 4. Improve Naming

ปรับปรุง naming conventions

1. ใช้ชื่อที่บ่งบอกถึง purpose
2. ใช้ verbs สำหรับ functions
3. ใช้ nouns สำหรับ variables และ types
4. หลีกเลี่ยง abbreviations ที่ไม่ชัดเจน
5. ใช้ consistent naming patterns

### 5. Reduce Complexity

ลดความซับซ้อนของโค้ด

1. ลด nesting levels
2. แยก functions ที่ยาว
3. ใช้ early returns
4. หลีกเลี่ยง nested conditionals
5. ใช้ guard clauses

### 6. Improve Side Effects

ปรับปรุงการจัดการ side effects

1. ทำ `/improve-side-effect` เพื่อจัดการ side effects ด้วย Effect-TS
2. Wrap logging ด้วย `Effect.sync`
3. ลบ `console.log` ที่ไม่จำเป็น
4. ใช้ structured logging library

### 7. Verify Debuggability

ตรวจสอบผลลัพธ์

1. ทำ `/run-lint` และ `/run-typecheck`
2. ทำ `/run-test` เพื่อตรวจสอบคุณภาพ
3. ทำ `/report-format-table` สำหรับสรุปผลลัพธ์

## Rules

### 1. Logging Best Practices

- Logging ทุกครั้งต้องมี context
- ใช้ structured logging เสมอ
- ใช้ log levels ที่เหมาะสม
- หลีกเลี่ยง logging ที่ซ้ำซ้อน
- ใส่ correlation IDs สำหรับ distributed systems

### 2. Error Message Guidelines

- Error messages ต้องชัดเจนและเป็นประโยค
- ต้องระบุสาเหตุและวิธีแก้ไข
- ต้องมี context ที่เกี่ยวข้อง
- ใช้ typed error classes
- หลีกเลี่ยง generic error messages

### 3. Naming Conventions

- ชื่อต้องบ่งบอกถึง purpose
- ใช้ verbs สำหรับ functions
- ใช้ nouns สำหรับ variables และ types
- หลีกเลี่ยง abbreviations ที่ไม่ชัดเจน
- ใช้ consistent naming patterns

### 4. Code Complexity

- ลด nesting levels สูงสุด 3 levels
- แยก functions ที่ยาวกว่า 50 บรรทัด
- ใช้ early returns
- หลีกเลี่ยง nested conditionals
- ใช้ guard clauses

### 5. Self-Documenting Code

- ชื่อต้องบ่งบอกถึง behavior
- หลีกเลี่ยง comments ที่ไม่จำเป็น
- ใช้ meaningful variable names
- ใช้ descriptive function names
- เขียน code ที่อ่านง่าย

## Expected Outcome

- Code ที่ debug ง่าย
- Logging ที่มี context ครบถ้วน
- Error messages ที่ชัดเจนและมีประโยชน์
- Naming ที่เข้าใจง่ายและ consistent
- Code complexity ที่ต่ำ
- Functions ที่สั้นและ clear
- Minimal nesting
- Self-documenting code
