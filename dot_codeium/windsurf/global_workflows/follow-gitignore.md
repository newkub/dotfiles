---
title: Follow Gitignore
description: สร้างและจัดการ .gitignore ตามประเภทโปรเจกต์
auto_execution_mode: 3
---

## Goal

สร้าง .gitignore ที่ครอบคลุมตามประเภทโปรเจกต์เพื่อป้องกันการ commit ไฟล์ที่ไม่จำเป็น

## Execute

### 1. Check Existing Gitignore

1. รัน `test -f .gitignore` เพื่อตรวจสอบว่ามีไฟล์อยู่แล้วหรือไม่
2. ถ้ามีอยู่แล้ว ให้ตรวจสอบว่าครอบคลุมพอหรือไม่
3. ถ้ายังไม่มี ให้ดำเนินการสร้างใหม่

### 2. Analyze Project Type

1. ตรวจสอบโครงสร้างโปรเจกต์:
   - มี `package.json` หรือไม่ (Node.js project)
   - มี `Cargo.toml` หรือไม่ (Rust project)
   - มี `go.mod` หรือไม่ (Go project)
   - มี `pyproject.toml` หรือไม่ (Python project)
2. ใช้ `eza -la` เพื่อดูไฟล์ทั้งหมดในโปรเจกต์
3. ระบุไฟล์ที่ควร ignore ตามประเภทโปรเจกต์

### 3. Create Gitignore

1. สร้าง .gitignore ตามประเภทโปรเจกต์:

```gitignore
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
dist/
build/
.next/
.nuxt/

# TypeScript
*.tsbuildinfo

# Environment
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
*.log

# Rust
target/
Cargo.lock
**/*.rs.bk
.rustc_info.json
.cargo/

# OS
.DS_Store
Thumbs.db
desktop.ini

# IDE
.vscode/
.idea/
*.sublime-*
.vim/
*.swp
*.swo
*~
```

### 4. Validate Gitignore

1. ตรวจสอบว่า .gitignore ครอบคลุมไฟล์ที่ควร ignore
2. ทดสอบด้วย `git check-ignore <file>` สำหรับไฟล์ที่ควรถูก ignore
3. ตรวจสอบว่าไม่ ignore ไฟล์ที่จำเป็น

## Rules

### 1. File Structure

- ต้องมี .gitignore ที่ root ของ workspace เสมอ
- ใช้ `eza` ในการตรวจสอบไฟล์ที่ควร ignore

### 2. Coverage

- ครอบคลุมไฟล์ตามประเภทโปรเจกต์ (Node.js, Rust, อื่นๆ)
- ไม่ ignore ไฟล์ที่จำเป็นสำหรับ development

## Expected Outcome

- มี .gitignore ที่เหมาะสมกับประเภทโปรเจกต์
- ไม่มีไฟล์ที่ไม่ควร commit ถูกติดตามโดย Git
- โปรเจกต์สามารถทำงานได้ตามปกติหลังจาก ignore ไฟล์ที่ไม่จำเป็น
