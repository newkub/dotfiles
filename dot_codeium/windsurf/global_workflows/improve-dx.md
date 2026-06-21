---
title: Improve DX
description: ปรับปรุง Developer Experience ครบวงจร
auto_execution_mode: 3
related_workflows:
  - /improve-documentation
  - /improve-config
  - /improve-type-safety
  - /improve-readability
  - /improve-error-handling
  - /follow-examples
---

## Goal

ปรับปรุง Developer Experience ให้นักพัฒนาใช้งานง่าย มีประสิทธิภาพ และเข้าใจได้เร็ว

## Scope

ใช้สำหรับปรับปรุง DX ของ libraries, frameworks, และ tools ทั้งใน monorepo และ single workspace

## Execute

### 1. Analyze Current DX

วิเคราะห์ DX ปัจจุบัน

1. ทำ `/analyze-project` เพื่อดูโครงสร้างและ quality
2. อ่าน `README.md` และ documentation ทั้งหมด
3. ทดลองใช้งาน API หรือ features หลัก
4. ตรวจสอบ error messages และ TypeScript types
5. ดู examples และ templates ที่มี

### 2. Improve Documentation

ปรับปรุง documentation

- ทำ `/improve-documentation` ครบวงจร
- เพิ่ม quick start guide ที่ชัดเจน
- เพิ่ม API reference ที่ครบถ้วน
- เพิ่ม examples สำหรับ use cases ทั่วไป
- เพิ่ม troubleshooting guide

### 3. Improve Configuration

ปรับปรุง configuration

- ทำ `/improve-config` ครบวงจร
- ทำให้ configuration มี default values ที่ดี
- ทำให้ configuration มี validation ที่ชัดเจน
- เพิ่ม configuration examples
- เพิ่ม environment variable documentation

### 4. Improve Type Safety

ปรับปรุง TypeScript support

- ทำ `/improve-type-safety` ครบวงจร
- เพิ่ม type definitions ที่ครบถ้วน
- เพิ่ม JSDoc comments สำหรับ public APIs
- ทำให้ types มี inference ที่ดี
- เพิ่ม type examples ใน documentation

### 5. Improve Error Messages

ปรับปรุง error messages

- ทำให้ error messages ชัดเจนและ actionable
- เพิ่ม suggestions สำหรับการแก้ไข
- เพิ่ม links ไปยัง documentation ที่เกี่ยวข้อง
- เพิ่ม error codes สำหรับ debugging
- เพิ่ม error handling examples

### 6. Improve Examples

ปรับปรุง examples

- ทำ `/follow-examples` เพื่อเขียน examples ครอบคลุม
- เพิ่ม examples สำหรับ use cases ทั่วไป
- เพิ่ม examples สำหรับ edge cases
- ทำให้ examples สามารถ copy-paste ได้
- เพิ่ม examples ใน documentation

### 7. Improve Tooling

ปรับปรุง tooling

- ตรวจสอบ scripts ใน `package.json` ครบถ้วน
- เพิ่ม scripts สำหรับ common tasks
- ทำให้ dev server รันเร็ว
- ทำให้ build process ชัดเจน
- เพิ่ม CLI help ที่ดี

### 8. Improve Readability

ปรับปรุง readability

- ทำ `/improve-readability` ครบวงจร
- ทำให้ code อ่านง่าย
- เพิ่ม comments สำหรับ logic ที่ซับซ้อน
- ใช้ naming ที่ชัดเจน
- ทำให้ structure สมเหตุสมผล

## Rules

### 1. Developer Centric

เน้นประสบการณ์ของนักพัฒนา

- คิดจาก perspective ของนักพัฒนา
- ทำให้งานง่ายที่สุด
- ลด friction ในการใช้งาน
- ทำให้ learning curve ต่ำ

### 2. Documentation First

เน้น documentation ก่อน

- Document ก่อน implement
- Document ทุก public API
- Document ทุก configuration option
- Document ทุก error ที่เป็นไปได้

### 3. Type Safety

เน้น TypeScript support

- ทำให้ types ครบถ้วน
- ทำให้ types มี inference ที่ดี
- ทำให้ types มี documentation
- ทำให้ types มี examples

### 4. Error Clarity

เน้น error messages ที่ชัดเจน

- Error messages ต้องบอกสาเหตุ
- Error messages ต้องบอกวิธีแก้
- Error messages ต้องมี examples
- Error messages ต้องมี links

### 5. Examples Coverage

เน้น examples ที่ครอบคลุม

- Examples สำหรับ use cases ทั่วไป
- Examples สำหรับ edge cases
- Examples ที่ copy-paste ได้
- Examples ใน documentation

### 6. Tooling Quality

เน้น tooling ที่ดี

- Scripts ครบถ้วน
- Dev server รันเร็ว
- Build process ชัดเจน
- CLI help ดี

## Expected Outcome

- Documentation ครบถ้วนและอ่านง่าย
- Configuration ง่ายและมี defaults ที่ดี
- TypeScript support ครบถ้วน
- Error messages ชัดเจนและ actionable
- Examples ครอบคลุม use cases
- Tooling ที่ดีและใช้งานง่าย
- Developer experience ดีขึ้นอย่างเห็นได้ชัด
