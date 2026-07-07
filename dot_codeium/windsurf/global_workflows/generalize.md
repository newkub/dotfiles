---
title: Generalize
description: ทำให้ code หรือ patterns เป็น generic เพื่อ reuse กับหลาย use cases
auto_execution_mode: 3
related_workflows:
  - /refactor
  - /dont-over-engineer
  - /use-scripts
  - /learn-from-code-pattern
---

## Goal

ทำให้สิ่งที่เฉพาะเจาะจงเป็น generic เพื่อ reuse ได้กับหลาย use cases

## Scope

ใช้สำหรับ generalize code, functions, modules, components, configs, หรือ patterns

## Execute

### 1. Identify And Analyze

1. ระบุสิ่งที่ต้อง generalize และ use cases ใหม่ที่ต้องการ
2. ระบุ hard-coded values, specific types, และ assumptions ที่จำกัด use cases
3. ถ้ามีไฟล์มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts` สำหรับ batch analysis

### 2. Generalize

1. แปลง hard-coded values เป็น parameters พร้อม default values
2. แปลง specific types เป็น generic types หรือ interfaces
3. ลด coupling ด้วย dependency injection หรือ interfaces
4. ใช้ configuration objects สำหรับ parameters ที่มากกว่า 3 ตัว

### 3. Validate And Update

1. ตรวจสอบว่า use cases เดิมยังทำงานได้
2. รัน `/run-test` และ `/run-typecheck` ถ้ามี
3. อัปเดต callers และ documentation
4. ถ้ามี callers มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts`

## Rules

- รักษา backward compatibility ด้วย optional parameters และ default values
- ทำ `/dont-over-engineer` — generalize เฉพาะที่มี use cases จริง 2 กรณีขึ้นไป
- ถ้า project ใช้ TypeScript ให้ทำ `/follow-typescript` สำหรับ generic types
- ใช้ `/refactor` สำหรับ refactoring ทั่วไป ไม่ใช่ generalize
- ถ้าไม่มี use cases ใหม่ที่ต้องการ generalize ให้หยุด

## Expected Outcome

- Code เป็น generic ที่รองรับหลาย use cases
- ไม่มี regression ใน use cases เดิม
- ไม่มี over-engineering
