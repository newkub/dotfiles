---
title: Follow Gitignore
description: สร้างและจัดการ .gitignore ที่ root และ workspace โดยแจกจ่าย patterns ตาม responsibility
auto_execution_mode: 3
related:
  - /relocation
  - /edit-relative
---

## Goal

สร้าง .gitignore ที่ครอบคลุมโดยแจกจ่าย patterns ระหว่าง root และ workspace ตาม responsibility เพื่อป้องกัน commit ไฟล์ที่ไม่จำเป็น

## Scope

สร้างและจัดการ .gitignore สำหรับ projects และ monorepos ทั้งที่ root และแต่ละ workspace

## Execute

### 1. Read All Gitignore Files

อ่าน .gitignore ทั้งหมดที่มีอยู่เพื่อเข้าใจสถานะปัจจุบันก่อนแก้ไข

> Goal: รู้ patterns ที่มีอยู่ในทุก .gitignore ทุกระดับ

1. ค้นหาไฟล์ .gitignore ทั้งหมดใน project (root + workspace + subdirectories)
2. อ่าน .gitignore ทุกไฟล์พร้อมกัน
3. ถ้าไม่มี .gitignore ที่ root → ถือว่าเริ่มใหม่

### 2. Analyze Project

วิเคราะห์ tools และ workspaces เพื่อระบุ patterns ที่จำเป็น

> Goal: รู้ประเภทโปรเจกต์ tools และ workspace ที่ต้องมี .gitignore

1. ตรวจสอบ manifest files (package.json, Cargo.toml, go.mod, pyproject.toml)
2. ระบุ tools ที่ใช้จริงในแต่ละ workspace
3. สำหรับ monorepo → ระบุแต่ละ workspace และ tools เฉพาะ

### 3. Distribute Patterns

แจกจ่าย patterns ระหว่าง root และ workspace ตามหลักการ `/relocation` — shared ไป root, specific ไป workspace

> Goal: แต่ละ pattern อยู่ใน .gitignore ที่เหมาะสม ไม่ซ้ำกัน

1. ระบุ shared patterns (ใช้กับหลาย workspace) → ใส่ใน root .gitignore
2. ระบุ workspace-specific patterns (ใช้กับ workspace เดียว) → ย้ายไป .gitignore ของ workspace นั้น (ทำ `/relocation`)
3. สำหรับ monorepo → ใช้ recursive patterns ที่ root (เช่น `apps/*/node_modules/`)
4. เพิ่มเฉพาะ patterns ของ tools ที่ project ใช้จริง
5. ถ้า workspace ไม่มี patterns เฉพาะ → ไม่ต้องสร้าง .gitignore

### 4. Validate

ตรวจสอบว่า patterns ทำงานถูกต้องและไม่มีไฟล์ที่ไม่ควร commit ถูกติดตาม

> Goal: ทุก pattern ทำงานถูกต้อง ไม่มีไฟล์รั่ว

1. ตรวจสอบว่าไม่มี patterns ซ้ำกันระหว่าง root และ workspace
2. ทดสอบด้วย `git check-ignore <file>` สำหรับไฟล์ที่ควรถูก ignore
3. ตรวจสอบว่าไม่มีไฟล์ที่ไม่ควร commit ถูก tracked โดย Git
4. ทำ `/edit-relative` หากมี file operations

## Rules

### 1. Pattern Distribution

- Root .gitignore: shared patterns (dependencies, build, OS, IDE, logs, env, testing, temporary)
- Workspace .gitignore: workspace-specific patterns (framework outputs, generated files, platform artifacts)
- ห้ามซ้ำ patterns ระหว่าง root และ workspace — ถ้า root ครอบคลุมแล้ว → ไม่ต้องใส่ใน workspace
- ถ้า pattern ใช้กับหลาย workspace → ย้ายไป root ด้วย recursive pattern
- ถ้า pattern ใช้กับ workspace เดียว → ใส่ใน .gitignore ของ workspace นั้น

### 2. Selective Addition

- เพิ่มเฉพาะ patterns ที่ project ใช้จริง — ตรวจสอบ manifest files ว่ามี tools หรือไม่
- ถ้าไม่ใช้ tool → ไม่ต้องใส่ patterns ของ tool นั้น

### 3. Common Patterns

- Dependencies: `node_modules/`, `.pnp`, `.pnp.js`
- Build: `dist/`, `build/`, `.output/`, `*.tsbuildinfo`
- Build Tools: `.turbo/`, `.vite/`, `.swc/`, `.vinxi/`, `.solid/`
- Linter Cache: `.eslintcache`, `.prettiercache`, `.biome/`, `.oxlint/`
- Testing: `coverage/`, `test-results/`, `playwright-report/`
- Environment: `.env*`, `!.env.example`, `.dev.vars`, `*.local`
- Logs: `*.log`, `logs/`
- OS: `.DS_Store`, `Thumbs.db`, `desktop.ini`
- Temporary: `*.tmp`, `*.temp`, `.cache/`, `.**/temp/`
- IDE: `.vscode/`, `.idea/`, `*.sublime-*`, `*.swp`, `*.swo`

### 4. Monorepo Guidelines

- Root .gitignore สำหรับ shared patterns ที่ใช้ร่วมกันทุก workspace
- แต่ละ workspace มี .gitignore เฉพาะ patterns ที่ root ไม่ครอบคลุม
- ใช้ recursive patterns ที่ root (เช่น `apps/*/bun.lock`)
- ตัวอย่าง: `apps/mobile/android/` มี .gitignore สำหรับ Android artifacts, `apps/website/` มี .gitignore สำหรับ TanStack outputs

## Expected Outcome

- Root .gitignore มีเฉพาะ shared patterns
- แต่ละ workspace ที่มี patterns เฉพาะมี .gitignore ของตัวเอง
- ไม่มี patterns ซ้ำกันระหว่าง root และ workspace
- ไม่มีไฟล์ที่ไม่ควร commit ถูกติดตามโดย Git

