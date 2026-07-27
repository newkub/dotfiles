---
title: Review Folder Structure
description: Review folder structure ครอบคลุม project structure, directory organization, module boundaries, import paths และ package.json
auto_execution_mode: 3
related:
  - /scan-codebase
  - /deep-analyze-by-use-scripts
  - /validate
  - /report
  - /report-format-table
  - /suggest-next-action
  - /follow-import-export
---

## Goal

Review folder structure และ project organization quality ครอบคลุม directory organization, module boundaries, import paths, barrel exports, package.json requirements และ framework-specific structure

## Scope

file structure, directory organization, module boundaries, import paths, path aliases, barrel exports, file naming, package.json requirements, config files placement, และ framework-specific structure (Vite, Next.js, Nuxt.js, TypeScript, Monorepo)

## Execute

### 1. Prepare

เตรียม context ก่อนเริ่ม review

> Goal: เข้าใจ project structure และ framework ใน codebase

1. ทำ `/scan-codebase` เพื่อเข้าใจ filesystem structure
2. ระบุ project type: Vite, Next.js, Nuxt.js, TypeScript, Monorepo
3. ตรวจสอบ package.json fields: `name`, `description`, `scripts`, `type: "module"`

### 2. Deep Analyze

วิเคราะห์ folder structure อย่างลึกซึ้ง

> Goal: ครอบคลุมทุก folder structure dimension พร้อม health score

1. ทำ `/deep-analyze-by-use-scripts` เพื่อสร้าง `analyze-folder-structure.ts` ใน `.devin/scripts/analyze/`
2. Script ตรวจสอบ framework-specific structure:
   - **Vite**: `src/` source, `public/` static, `index.html`, `vite.config.ts`
   - **Next.js**: `app/` router, `components/`, `lib/`, `middleware.ts`, `next.config.js`
   - **Nuxt.js**: `pages/`, `components/`, `composables/`, `server/api/`, `middleware/`, `plugins/`
   - **TypeScript**: `src/`, `tests/`, `tsconfig.json`, strict mode, ESNext target
   - **Monorepo**: `packages/` หรือ `apps/`, workspace dependencies, consistent naming
3. Script ตรวจสอบ module boundaries, circular dependencies, และ import direction
4. Script ตรวจสอบ import paths, path aliases, relative vs absolute imports, และ barrel exports
5. Script ตรวจสอบ package.json: required fields, scripts (dev, build, lint, format), type: "module"
6. Script ตรวจสอบ config files placement: `tsconfig.json`, `biome.json`, `README.md` ที่ root
7. Script ตรวจสอบ structure quality: SRP, co-location, build output separation, scalability
8. Script คำนวณ folder structure health score และ output เป็น structured JSON

### 3. Validate Findings

ตรวจสอบว่า findings แต่ละอย่างถูกต้อง

> Goal: Findings ถูกต้องและจัดลำดับตาม severity

1. ทำ `/validate` สำหรับ validate issues แต่ละอย่าง
2. จัดลำดับการ validate ตาม severity

### 4. Report

รายงานผล review ในรูปแบบตาราง

> Goal: รายงาน findings พร้อม actionable recommendations

1. ทำ `/report` พร้อม `/report-format-table`
2. สร้างตาราง findings และ recommended actions
3. ทำ `/suggest-next-action`

## Rules

### 1. Severity Classification

- **Critical**: circular dependency, broken import path, missing module boundary, missing required package.json fields
- **High**: inconsistent file structure, deep relative imports, missing barrel export, missing config files, wrong type field
- **Medium**: suboptimal grouping, inconsistent import style, minor path issue, missing scripts
- **Low**: minor filesystem improvement, naming convention

### 2. Evidence-Based Findings

- ทุก finding ต้องมี file path และ line number

### 3. Review Independence

- ทำ review เท่านั้น ไม่แก้ไข code ระหว่าง review

## Expected Outcome

- รายงานตาราง findings พร้อม severity และ location
- รายงาน recommended actions พร้อม priority
- แนะนำ action ถัดไปผ่าน `/suggest-next-action`
