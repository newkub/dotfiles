---
title: Improve Dx
description: ปรับปรุง developer experience ครบวงจร
auto_execution_mode: 3
related_workflows:
  - improve-codebase
  - follow-config
---

## Goal

ปรับปรุง developer experience ครบวงจรเพื่อให้ทีมพัฒนาทำงานได้รวดเร็วและมีประสิทธิภาพ

## Scope

ใช้สำหรับการปรับปรุง build times, error messages, development tools, และ onboarding

## Execute

### 1. Build Performance

ปรับปรุง build performance

1. Optimize build configuration
2. ใช้ incremental builds
3. ใช้ cache สำหรับ dependencies
4. Parallelize build tasks
5. Reduce bundle size
6. Monitor build times

### 2. Error Messages

ปรับปรุง error messages ให้ชัดเจน

1. ใช้ custom error messages ที่เป็นประโยชน์
2. แสดง suggestions สำหรับ fix errors
3. Link errors ไปยัง documentation
4. ใช้ error codes สำหรับ easy reference
5. แสดง stack traces ที่ readable
6. ใช้ pretty error formats

### 3. Development Tools

ตั้งค่า development tools ที่ดี

1. ใช้ IDE integrations (VS Code extensions)
2. ตั้งค่า linting และ formatting อัตโนมัติ
3. ใช้ pre-commit hooks
4. ตั้งค่า auto-completion
5. ใช้ debug tools ที่ powerful
6. ตั้งค่า snippets สำหรับ common patterns

### 4. Hot Module Replacement

ตั้งค่า HMR สำหรับ fast development

1. ตั้งค่า HMR สำหรับ frontend
2. ตั้งค่า HMR สำหรับ styles
3. Preserve state ระหว่าง HMR
4. ตั้งค่า fast refresh
5. Monitor HMR performance
6. Fix HMR issues

### 5. Onboarding Documentation

สร้าง onboarding documentation ที่ชัดเจน

1. สร้าง README ที่ครบถ้วน
2. สร้าง setup guide ที่ step-by-step
3. สร้าง development guide
4. สร้าง contribution guide
5. สร้าง architecture documentation
6. สร้าง troubleshooting guide

### 6. Local Development

ปรับปรุง local development experience

1. ตั้งค่า local environment อัตโนมัติ
2. ใช้ Docker สำหรับ consistency
3. ตั้งค่า mock data สำหรับ development
4. ตั้งค่า seed data สำหรับ database
5. ใช้ hot reload สำหรับ backend
6. ตั้งค่า environment variables อัตโนมัติ

## Rules

### 1. Fast Feedback Loops

ทำให้ feedback loops เร็วที่สุด

- Build ควรใช้เวลา < 1 นาที
- Tests ควรรันเร็ว
- Linting ควรเร็ว
- HMR ควร instant
- ไม่ block developers ด้วย slow processes

### 2. Clear Error Messages

Error messages ต้อง actionable

- บอกสิ่งที่ผิด
- บอกวิธีแก้
- บอกที่มาของ error
- ใช้ภาษาที่เข้าใจง่าย
- ไม่ใช้ technical jargon ที่ไม่จำเป็น

### 3. Consistent Environment

ทำให้ environment สม่ำเสมอ

- ใช้ Docker สำหรับ consistency
- ตั้งค่า version pinning
- ใช้ same tools ข้าม team
- Document environment setup
- ใช้ CI/CD สำหรับ validation

### 4. Documentation First

เขียน documentation ก่อน

- Document ก่อน implement
- Keep documentation updated
- Use examples ใน documentation
- Document edge cases
- Document common tasks

## Expected Outcome

- Build times ลดลงอย่างมีนัยสำคัญ
- Error messages ชัดเจนและ actionable
- Development tools ทำงานได้ดี
- HMR ทำงานได้อย่างราบรื่น
- Onboarding เร็วขึ้น
- Local development ง่ายขึ้น
- Developer satisfaction สูงขึ้น
