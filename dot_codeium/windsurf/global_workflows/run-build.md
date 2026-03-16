---
title: Run Build
description: สร้างโปรเจกต์และแก้ไขปัญหา build process อย่างเป็นระบบ พร้อมตรวจสอบคุณภาพและยืนยันความถูกต้อง
auto_execution_mode: 3
file-patterns:
  - "**/package.json"
  - "**/tsconfig.json"
  - "**/vite.config.*"
  - "**/nuxt.config.*"
  - "**/next.config.*"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/optimize-workflows"
    - "/connect-workflows"
  files:
    - "global_workflows/write-workflows.md"
---

## Purpose

รัน build process อย่างมีระบบเพื่อสร้าง production-ready artifacts พร้อมตรวจสอบและแก้ไขปัญหาที่เกิดขึ้นจนกว่าจะสำเร็จ 100%

## Scope

ใช้สำหรับ:

- สร้าง production build สำหรับโปรเจกต์
- แก้ไข build errors และ warnings ทั้งหมด
- ตรวจสอบความถูกต้องของ output
- รองรับโปรเจกต์ที่ใช้ Bun, Node.js, Vite, Nuxt, Next.js

ไม่รวม:

- การ deploy หรือ publish
- การ setup CI/CD pipelines
- การ optimize bundle size (ใช้ `/optimize-bundling-optimzation`)

## Inputs

| Input | Details |
|-------|-----------|
| Build Command | คำสั่ง build เช่น `bun run build`, `npm run build` |
| Project Type | Framework ที่ใช้ (Vite, Nuxt, Next.js, etc.) |
| Environment | Development, Staging, Production |

## Rules

| Category | Requirements |
|------|---------|
| **Zero Errors** | Build ต้องผ่านโดยไม่มี errors |
| **Zero Warnings** | แก้ไข warnings ทั้งหมดจนไม่เหลือ |
| **Repeatable** | Build ซ้ำได้แล้วต้องได้ผลเหมือนกัน |
| **Verification** | Run build ซ้ำเพื่อยืนยัน |

## Structure

### Directory Structure

```text
project/
├── dist/                    # Build output
├── node_modules/            # Dependencies
├── src/                     # Source code
├── package.json             # Build scripts
├── tsconfig.json            # TypeScript config
└── [framework-config]       # Framework specific config
```

### Phase Definitions

| Phase | Description | Main Activities | Order |
|-------|-------------|-----------------|-------|
| **Setup** | Prepare context | Read config, check dependencies | 1 |
| **Research** | Study build errors | Analyze error messages | 2 |
| **Analyze** | Find root causes | Identify error patterns | 3 |
| **Plan** | Plan fixes | Define fix sequence | 4 |
| **Execute** | Execute fixes | Apply solutions | 5 |
| **Verify** | Verify build | Run build, check output | 6 |
| **Review** | Review quality | Check warnings, size | 7 |
| **Finalize** | Close task | Confirm success | 8 |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบสิทธิ์**
  - มีสิทธิ์เขียนไฟล์ใน project directory
  - ตรวจสอบว่าไม่มี process build อื่นกำลังรัน

- 0.2 **ตรวจสอบ Dependencies**
  - มี Bun หรือ Node.js ติดตั้ง
  - Dependencies ติดตั้งครบถ้วน (`bun install` หรือ `npm install`)
  - Build script มีใน `package.json`

- 0.3 **อ่าน Global Rules**
  - อ่าน global rules ของโปรเจกต์ถ้ามี
  - เข้าใจ conventions ที่ใช้

### Phase 1: Setup

- 1.1 **เตรียม Context**
  - อ่าน `package.json` เพื่อดู build scripts
  - อ่าน framework config (vite.config, nuxt.config, etc.)
  - ตรวจสอบว่ามี build output directory หรือไม่

- 1.2 **กำหนด Scope**
  - ระบุ build command ที่จะใช้
  - กำหนด target environment
  - วางแผนลำดับการแก้ไขปัญหา

### Phase 2: Research

- 2.1 **ศึกษา Build Process**
  - รัน build ครั้งแรกเพื่อดู errors
  - บันทึก error messages และ stack traces
  - จัดหมวดหมู่ errors (Type, Import, Config, etc.)

- 2.2 **วิเคราะห์ Errors**
  - อ่าน error messages ให้เข้าใจ root cause
  - ค้นหา solutions ใน documentation
  - หา patterns ที่ซ้ำกัน

### Phase 3: Analyze

- 3.1 **วิเคราะห์โครงสร้าง**
  - ระบุไฟล์ที่มีปัญหา
  - วิเคราะห์ dependencies ที่ broken
  - ตรวจสอบ configuration issues

- 3.2 **วิเคราะห์ลำดับการแก้ไข**
  - จัดลำดับความสำคัญ (critical → warning)
  - กำหนด dependencies ระหว่าง fixes
  - วางแผน incremental fixes

### Phase 4: Plan

- 4.1 **วางแผน Fixes**
  - กำหนดลำดับการแก้ไข
  - เตรียม code changes ที่จำเป็น
  - วางแผน testing หลังแก้ไข

- 4.2 **วางแผน References**
  - ระบุ skills/workflows ที่ต้องใช้
  - เตรียม documentation สำหรับ complex fixes

### Phase 5: Execute

- 5.1 **เริ่มจาก /optimize-bundling-optimzation**
  - ใช้ `/optimize-bundling-optimzation` เพื่อ optimize bundling settings
  - ปรับปรุง build configuration

- 5.2 **Run Build และแก้ไข**
  - รัน build command
  - แก้ไข errors ทีละตัวจนไม่เหลือ
  - แก้ไข warnings ทั้งหมด
  - บันทึกการเปลี่ยนแปลง

- 5.3 **Verify Build Output**
  - ตรวจสอบว่า output files ถูกสร้าง
  - ตรวจสอบขนาดและความสมบูรณ์ของ output

### Phase 6: Verify

- 6.1 **Run Build ซ้ำ**
  - รัน build อีกครั้งเพื่อยืนยัน
  - ตรวจสอบว่าไม่มี errors/warnings เหลือ
  - ยืนยันว่า output สม่ำเสมอ

- 6.2 **ตรวจสอบ Output**
  - ตรวจสอบ build artifacts
  - ทดสอบว่า build output ใช้งานได้

### Phase 7: Review

- 7.1 **ตรวจสอบคุณภาพ**
  - ตรวจสอบ bundle size
  - ดูว่ามี unused code หรือไม่
  - ตรวจสอบ source maps (ถ้ามี)

- 7.2 **ใช้ /optimize-workflows**
  - ใช้ `/optimize-workflows` เพื่อปรับปรุง quality
  - ตรวจสอบ consistency

### Phase 8: Finalize

- 8.1 **ยืนยันความสำเร็จ**
  - Build ผ่านโดยไม่มี errors
  - Build ผ่านโดยไม่มี warnings
  - Output ใช้งานได้

- 8.2 **สรุปผลงาน**
  - สรุปสิ่งที่แก้ไข
  - ยืนยันว่า build ซ้ำได้
  - แจ้งให้ผู้ใช้ทราบว่าเสร็จสิ้น

## Outputs

| Output | Details |
|--------|-----------|
| Build Artifacts | Production-ready files in `dist/` หรือ output directory |
| Fixed Code | Source code ที่แก้ไขแล้ว |
| Build Log | บันทึก build process และ errors ที่แก้ไข |
| Success Confirmation | ยืนยันว่า build ผ่าน 100% |

## Expected Outcome

- Build ผ่านโดยไม่มี errors (exit code 0)
- Build ผ่านโดยไม่มี warnings
- Build ซ้ำได้แล้วได้ผลเหมือนกัน (deterministic)
- Output files ใช้งานได้จริง
- Source code อยู่ในสถานะที่ maintain ได้

## Reference

- `/optimize-workflows` - ปรับปรุง workflows
- `/connect-workflows` - เชื่อมโยง workflows
- `/optimize-bundling-optimzation` - Optimize bundling settings
- `@write-markdown` - แนวทางการเขียน Markdown
