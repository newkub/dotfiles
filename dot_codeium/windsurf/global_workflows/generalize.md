---
title: Generalize
description: ทำให้ code, patterns, หรือ implementations เป็น generic ทั่วไป
auto_execution_mode: 3
related_workflows:
  - /refactor
  - /improve-reuseables
  - /follow-best-practice
  - /dont-over-engineer
  - /use-scripts
  - /learn-from-pattern
---

## Goal

ทำให้สิ่งที่เฉพาะเจาะจง (specific) เป็น generic ทั่วไปเพื่อให้ reuse ได้กับหลาย use cases

## Scope

ใช้สำหรับ generalize code, functions, modules, components, configs, patterns, หรือ implementations ใดๆ ที่เฉพาะเจาะจงเกินไป

## Execute

### 1. Identify Specific Code

1. ระบุสิ่งที่ต้อง generalize (function, module, component, config, pattern, ฯลฯ)
2. ทำ `/analyze-project` เพื่อเข้าใจโครงสร้างและ dependencies
3. ระบุส่วนที่เฉพาะเจาะจง (hard-coded values, specific types, narrow parameters)
4. ระบุ use cases อื่นที่ควรใช้สิ่งนี้ได้แต่ปัจจุบันใช้ไม่ได้
5. บันทึก behavior ปัจจุบันเป็น baseline

### 2. Analyze Generalization Opportunities

1. ระบุ hard-coded values ที่ควรเป็น parameters หรือ options
2. ระบุ specific types ที่ควรเป็น generic types หรือ interfaces
3. ระบุ assumptions ที่จำกัด use cases
4. ระบุ dependencies ที่ coupling แน่นเกินไป
5. ถ้ามีไฟล์ที่ต้องวิเคราะห์มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts` สำหรับ batch analysis

### 3. Extract Parameters

1. แปลง hard-coded values เป็น parameters หรือ options
2. สร้าง default values สำหรับ parameters ใหม่
3. รักษา backward compatibility โดยใช้ optional parameters
4. ใช้ configuration objects สำหรับ parameters ที่มากกว่า 3 ตัว
5. ตั้งชื่อ parameters ให้สื่อความหมายและไม่ผูกกับ use case เฉพาะ

### 4. Abstract Types

1. แปลง specific types เป็น generic types หรือ interfaces
2. ใช้ `unknown` หรือ generic type parameters แทน `any`
3. สร้าง interfaces สำหรับ dependencies ที่ต้องการ abstract
4. ใช้ dependency injection สำหรับ external dependencies
5. ถ้า project ใช้ TypeScript ให้ทำตาม `/follow-typescript` สำหรับ generic type best practices

### 5. Decouple Dependencies

1. ทำ `/refactor` เพื่อแยก responsibilities
2. ลด coupling โดยใช้ interfaces หรือ abstract types
3. ย้าย side effects ไปส่วนที่ configurable ได้
4. แยก business logic จาก implementation details
5. ใช้ pure functions เมื่อเป็นไปได้

### 6. Validate Generalization

1. ตรวจสอบว่า use cases เดิมยังทำงานได้ถูกต้อง
2. ทดสอบกับ use cases ใหม่ที่คาดว่าจะรองรับ
3. รัน `/run-test` เพื่อยืนยันไม่มี regression
4. รัน `/run-typecheck` ถ้า project ใช้ TypeScript
5. ตรวจสอบว่าไม่ over-engineer โดยทำ `/dont-over-engineer`

### 7. Update References

1. อัพเดท callers ที่ใช้ code เดิมให้ใช้ generic version
2. อัพเดท documentation และ examples
3. ตรวจสอบว่าไม่มี broken references
4. ถ้ามี callers มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts` สำหรับ batch updates

### 8. Report

1. รัน `/report-format-table` เพื่อแสดง before/after ของการ generalize
2. รัน `/report-format-terminal` เพื่อแสดงสรุปการเปลี่ยนแปลง

## Rules

### 1. Preserve Backward Compatibility

- รักษา default values ให้ use cases เดิมยังทำงานได้
- ใช้ optional parameters สำหรับ parameters ใหม่
- ห้ามเปลี่ยน signature โดยไม่รักษา backward compatibility
- ถ้าต้อง breaking change ให้ deprecate ก่อนแล้วค่อยเปลี่ยน

### 2. Avoid Over-Engineering

- ทำ `/dont-over-engineer` เพื่อหลีกเลี่ยงการ generalize เกินความจำเป็น
- Generalize เฉพาะสิ่งที่มี use cases จริงตั้งแต่ 2 กรณีขึ้นไป
- ห้ามสร้าง abstraction ที่ไม่มีคนใช้
- เริ่มจาก minimal generalization ก่อน ขยายทีหลังเมื่อจำเป็น

### 3. Conditional Execution

- ถ้า project ใช้ TypeScript ให้ทำ `/follow-typescript` สำหรับ generic types
- ถ้ามีไฟล์ที่ต้องวิเคราะห์มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts`
- ถ้ามี callers มากกว่า 10 ไฟล์ ให้ใช้ `/use-scripts` สำหรับ batch updates
- ถ้าไม่มี use cases ใหม่ที่ต้องการ generalize ให้หยุด

### 4. Non-Duplication

- ใช้ `/refactor` สำหรับ refactoring ทั่วไป
- ใช้ `/improve-reuseables` สำหรับปรับปรุง reusability
- Workflow นี้เน้นเฉพาะการ generalize จาก specific → generic

### 5. Quality Assurance

- รัน `/run-test` หลัง generalize เพื่อยืนยันไม่มี regression
- รัน `/run-typecheck` ถ้า project ใช้ TypeScript
- ทำ `/follow-best-practice` สำหรับ context นั้นๆ
- ตรวจสอบว่า code ยังอ่านง่ายและเข้าใจได้

## Expected Outcome

- Code เป็น generic ที่รองรับหลาย use cases
- ไม่มี hard-coded values ที่ไม่จำเป็น
- ไม่มี regression ใน use cases เดิม
- ไม่มี over-engineering
- มีรายงาน before/after ของการ generalize
