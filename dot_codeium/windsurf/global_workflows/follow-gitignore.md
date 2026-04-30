---
title: Follow Gitignore
description: สร้างและจัดการ .gitignore ตามประเภทโปรเจกต์
auto_execution_mode: 3
---

## Goal

สร้าง .gitignore ที่ครอบคลุมตามประเภทโปรเจกต์เพื่อป้องกันการ commit ไฟล์ที่ไม่จำเป็น

## Execute

### 1. Analyze Project

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. ตรวจสอบโครงสร้างโปรเจกต์ (package.json, Cargo.toml, go.mod, pyproject.toml)
3. ระบุประเภทโปรเจกต์และ tools ที่ใช้จริง

### 2. Create Gitignore

1. สร้าง .gitignore ที่ root ของ workspace
2. เพิ่ม patterns ตามประเภทโปรเจกต์ (ดู Rules)
3. เพิ่ม patterns ตาม tools ที่ใช้จริงเท่านั้น

ตัวอย่าง .gitignore:

```gitignore
# Dependencies
node_modules/

# Build
dist/
build/
.next/
.nuxt/

# TypeScript
*.tsbuildinfo

# Build Tools
.turbo/
.vite/
.swc/

# Linter Cache
.eslintcache
.prettiercache
.biome/
.oxlint/

# Environment
.env*

# Logs
*.log

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
```

### 3. Validate

1. ทำ `/follow-content-quality` เพื่อตรวจสอบคุณภาพเนื้อหา
2. ทดสอบด้วย `git check-ignore <file>`
3. ทำ `/update-reference` หากมี file operations

## Rules

### 1. File Structure

- ต้องมี .gitignore ที่ root ของ workspace เสมอ
- **Monorepo**: ต้องมี .gitignore แค่ที่ root เท่านั้น ห้ามมี .gitignore ใน sub-directories

### 2. Patterns by Project Type

- Node.js: node_modules/, .pnp, .pnp.js, npm/yarn logs
- Rust: target/, Cargo.lock (root only), **/*.rs.bk, .rustc_info.json
- Python: __pycache__/, *.pyc, .pytest_cache/, .venv/
- Go: bin/, *.sum
- Common: .env*, *.log, .DS_Store, Thumbs.db, desktop.ini

### 3. Patterns by Tools

- Build: dist/, build/, .next/, .nuxt/, .vite/, .turbo/, .swc/
- Framework: .svelte-kit/, .astro/, .remix/, .parcel-cache/
- Deployment: .vercel/, .netlify/, .wrangler/, .sst/, .amplify/, .firebase/
- Linter Cache: .eslintcache, .prettiercache, .biome/, .oxlint/, node_modules/.cache/
- TypeScript: *.tsbuildinfo
- IDE: .vscode/, .idea/, *.sublime-*, .vim/, *.swp, *.swo, *~

### 4. Monorepo Guidelines

- ใช้ .gitignore เดียวที่ root สำหรับทั้ง monorepo
- ใช้ patterns แบบ recursive (เช่น `apps/*/target/`, `packages/*/node_modules/`)
- สำหรับ Cargo.lock: track ที่ root แต่ ignore `apps/*/Cargo.lock` และ `packages/*/Cargo.lock`
- ห้ามมี .gitignore ใน apps/, packages/, หรือ sub-workspaces

### 5. Selective Addition

- เพิ่มเฉพาะ patterns ที่ project ใช้จริง
- ตรวจสอบ package.json หรือ Cargo.toml ว่ามี dependencies ของ tools หรือไม่
- ถ้าไม่ใช้ tool → ไม่ต้องใส่ patterns ของ tool นั้น

## Expected Outcome

- มี .gitignore ที่เหมาะสมกับประเภทโปรเจกต์
- ไม่มีไฟล์ที่ไม่ควร commit ถูกติดตามโดย Git
- โปรเจกต์สามารถทำงานได้ตามปกติหลังจาก ignore ไฟล์ที่ไม่จำเป็น
- Monorepo มี .gitignore เดียวที่ root ที่ครอบคลุมทุก sub-workspaces
