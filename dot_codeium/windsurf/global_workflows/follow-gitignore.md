---
title: Follow Gitignore
description: สร้างและจัดการ .gitignore ตามประเภทโปรเจกต์
auto_execution_mode: 3
---

## Goal

สร้าง .gitignore ที่ครอบคลุมตามประเภทโปรเจกต์เพื่อป้องกันการ commit ไฟล์ที่ไม่จำเป็น

## Execute

### 1. Check Existing Gitignore

- รัน `test -f .gitignore` เพื่อตรวจสอบว่ามีไฟล์อยู่แล้วหรือไม่
- ถ้ามีอยู่แล้ว ให้ตรวจสอบว่าครอบคลุมพอหรือไม่
- ถ้ายังไม่มี ให้ดำเนินการสร้างใหม่

### 2. Analyze Project Type

- ตรวจสอบโครงสร้างโปรเจกต์:
  - มี `package.json` หรือไม่ (Node.js project)
  - มี `Cargo.toml` หรือไม่ (Rust project)
  - มี `go.mod` หรือไม่ (Go project)
  - มี `pyproject.toml` หรือไม่ (Python project)
- ใช้ `eza -la` เพื่อดูไฟล์ทั้งหมดในโปรเจกต์
- ระบุไฟล์ที่ควร ignore ตามประเภทโปรเจกต์

### 3. Create Gitignore

- สร้าง .gitignore ตามประเภทโปรเจกต์:
  - **Node.js**: node_modules/, npm-debug.log*, yarn-debug.log*, yarn-error.log*, .env, .env.local, .env.development.local, .env.test.local, .env.production.local, dist/, build/, .next/, .nuxt/, .cache/
  - **Rust**: target/, Cargo.lock, **/*.rs.bk, .rustc_info.json, .cargo/
  - **General**: .DS_Store, Thumbs.db, *.log, .vscode/, .idea/, *.swp, *.swo, *~
  - **Build artifacts**: *.exe, *.dll, *.so, *.dylib, *.a
  - **IDE/Editor**: .vscode/, .idea/, *.sublime-*, .vim/
  - **OS**: .DS_Store, Thumbs.db, desktop.ini

### 4. Validate Gitignore

- ตรวจสอบว่า .gitignore ครอบคลุมไฟล์ที่ควร ignore
- ทดสอบด้วย `git check-ignore <file>` สำหรับไฟล์ที่ควรถูก ignore
- ตรวจสอบว่าไม่ ignore ไฟล์ที่จำเป็น

## Rules

- ต้องมี .gitignore ที่ root ของ workspace เสมอ
- ใช้ `eza` ในการตรวจสอบไฟล์ที่ควร ignore
- ครอบคลุมไฟล์ตามประเภทโปรเจกต์ (Node.js, Rust, อื่นๆ)
- ไม่ ignore ไฟล์ที่จำเป็นสำหรับ development

## Expected Outcome

- มี .gitignore ที่เหมาะสมกับประเภทโปรเจกต์
- ไม่มีไฟล์ที่ไม่ควร commit ถูกติดตามโดย Git
- โปรเจกต์สามารถทำงานได้ตามปกติหลังจาก ignore ไฟล์ที่ไม่จำเป็น
