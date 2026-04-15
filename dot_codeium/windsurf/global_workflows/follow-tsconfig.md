---
title: Follow TypeScript Config
description: ตั้งค่า TypeScript config สำหรับ Node.js, Bun, Nuxt, Monorepo, Vite ตาม best practices
auto_execution_mode: 3
---

## Goal

ตั้งค่า TypeScript config สำหรับ environments และ frameworks ต่างๆ ด้วย ESNext, strict type checking, path aliases และ performance optimizations

## Execute

### 1. Setup Module System

1. กำหนด ESNext modules
   - target: "ESNext"
   - module: "ESNext"
   - moduleResolution: "bundler"
   - lib: ["ESNext", "DOM"]
2. ติดตั้ง runtime types
   - @types/bun สำหรับ Bun
   - @types/node สำหรับ Node.js

### 2. Setup Monorepo

1. สร้าง root tsconfig.json ด้วย project references
2. สร้าง package tsconfig.json ที่ extends root
3. เปิดใช้ composite mode สำหรับทุก packages
4. ตั้งค่า path mapping สำหรับ cross-package imports

### 3. Enable Type Safety

1. เปิด strict mode: true
2. เพิ่ม advanced checks
   - exactOptionalPropertyTypes: true
   - noUncheckedIndexedAccess: true
   - noImplicitOverride: true
3. เปิด noImplicitReturns, noFallthroughCasesInSwitch

### 4. Setup Build Configs

1. สร้าง tsconfig.dev.json สำหรับ development
2. สร้าง tsconfig.build.json สำหรับ production
3. สร้าง tsconfig.test.json สำหรับ testing
4. ใช้ extends เพื่อลด redundancy

### 5. Setup Path Mapping

1. ตั้งค่า baseUrl: "./src"
2. กำหนด path aliases เช่น @/*, @/components/*
3. จับคู่กับ bundler alias configuration
4. สำหรับ monorepo: ตั้งค่า cross-package paths

### 6. Add Performance & Tooling

1. เปิด isolatedModules: true
2. เปิด incremental: true
3. เปิด skipLibCheck: true
4. เปิด resolvePackageJsonExports: true

### 7. Setup Config Layers

1. สร้าง tsconfig.base.json (base layer)
2. สร้าง tsconfig.json (app layer - extends base)
3. สร้าง tsconfig.build.json (build layer - extends app)
4. สร้าง tsconfig.test.json (test layer - extends app)

### 8. Setup Environment-Specific Configs

**Node.js Config:**
- ใช้ target ESNext และ moduleResolution bundler
- เพิ่ม @types/node ใน types

**Bun Config:**
- ใช้ target ESNext และ bun-types
- เพิ่ม assumeChangesOnlyAffectDirectDependencies: true

**Nuxt Config:**
- ใช้ project references เพื่อ extend Nuxt configs
- ตั้งค่า strict mode ใน nuxt.config.ts

**Vite + TanStack Config:**
- ใช้ jsx: "react-jsx"
- สร้าง tsconfig.node.json สำหรับ Vite config
- ตั้งค่า path aliases ใน vite.config.ts

### 9. Setup VSCode Configuration

1. ตั้งค่า .vscode/settings.json
2. เปิดใช้ inlay hints
3. ตั้งค่า auto-import และ path aliases
4. เปิดใช้ formatting และ linting อัตโนมัติ

### 10. Add Scripts

1. เพิ่ม typecheck: tsc --noEmit
2. เพิ่ม typecheck:build: tsc --build
3. เพิ่ม typecheck:watch: tsc --noEmit --watch
4. เพิ่ม lint:fix และ format scripts

### 11. Install Dependencies

1. Node.js: bun add -d typescript @types/node
2. Bun: bun add -d typescript @types/bun
3. Nuxt: bun add -d typescript @nuxt/typescript-build
4. Monorepo: bun add -d typescript @types/node turbo

## Rules

1. Frontmatter
   - title: Title Case ชัดเจน
   - description: กระชับไม่เกิน 100 ตัวอักษร
   - auto_execution_mode: 3 เท่านั้น

2. Structure
   - โครงสร้าง: ## Goal, ## Execute, ## Rules, ## Expected Outcome
   - ใช้ numbered list (1., 2., 3.)
   - ไฟล์ไม่เกิน 200 บรรทัด

3. Content
   - หัวข้อภาษาอังกฤษ Title Case
   - ใช้ ### N. Step Name ใน Execute
   - ภายในแต่ละขั้นตอนใช้ numbered list

4. Language
   - หัวข้อภาษาอังกฤษ Title Case
   - รายการใช้ภาษาไทย

5. Backticks
   - ใช้สำหรับ tools, commands, file paths, workflows

## Expected Outcome

- TypeScript config ตั้งค่าเรียบร้อยตาม environment
- Type safety สูงสุดด้วย strict mode
- Path aliases ตั้งค่าเรียบร้อย
- Performance optimizations เปิดใช้
- Build configs แยกกันชัดเจน
- VSCode integration ตั้งค่าเรียบร้อย
