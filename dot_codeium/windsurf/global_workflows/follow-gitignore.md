---
description: สร้างและตั้งค่า .gitignore สำหรับทุก workspace
---

# Follow Gitignore Workflow

## Purpose

- ทุก workspace ต้องมี .gitignore
- ใช้ `eza` เพื่อเช็คว่าอะไรควรใส่ใน `.gitignore` บ้าง
- สร้าง .gitignore ที่ครอบคลุมตามประเภทโปรเจกต์

## Rules

- ต้องมี .gitignore ที่ root ของ workspace เสมอ
- ใช้ `eza` ในการตรวจสอบไฟล์ที่ควร ignore
- ครอบคลุมไฟล์ตามประเภทโปรเจกต์ (Node.js, Rust, อื่นๆ)
- ไม่ ignore ไฟล์ที่จำเป็นสำหรับ development

## Execute

### 1. check : ตรวจสอบว่ามี .gitignore อยู่แล้วหรือไม่
- รัน `test -f .gitignore` เพื่อตรวจสอบ
- ถ้ามีอยู่แล้ว ให้ตรวจสอบว่าครอบคลุมพอหรือไม่
- ถ้ายังไม่มี ให้ดำเนินการสร้างใหม่

### 2. analyze : วิเคราะห์ประเภทโปรเจกต์และไฟล์ที่ควร ignore
- ตรวจสอบโครงสร้างโปรเจกต์:
  - มี `package.json` หรือไม่ (Node.js project)
  - มี `Cargo.toml` หรือไม่ (Rust project)
  - มี `go.mod` หรือไม่ (Go project)
  - มี `pyproject.toml` หรือไม่ (Python project)
- ใช้ `eza -la` เพื่อดูไฟล์ทั้งหมดในโปรเจกต์
- ระบุไฟล์ที่ควร ignore ตามประเภทโปรเจกต์

### 3. create : สร้างหรืออัพเดท .gitignore
- สร้าง .gitignore ตามประเภทโปรเจกต์:
  - **Node.js**: node_modules/, npm-debug.log*, yarn-debug.log*, yarn-error.log*, .env, .env.local, .env.development.local, .env.test.local, .env.production.local, dist/, build/, .next/, .nuxt/, .cache/
  - **Rust**: target/, Cargo.lock, **/*.rs.bk, .rustc_info.json, .cargo/
  - **General**: .DS_Store, Thumbs.db, *.log, .vscode/, .idea/, *.swp, *.swo, *~
  - **Build artifacts**: *.exe, *.dll, *.so, *.dylib, *.a
  - **IDE/Editor**: .vscode/, .idea/, *.sublime-*, .vim/
  - **OS**: .DS_Store, Thumbs.db, desktop.ini

### 4. validate : ตรวจสอบ .gitignore ที่สร้าง
- ตรวจสอบว่า .gitignore ครอบคลุมไฟล์ที่ควร ignore
- ทดสอบด้วย `git check-ignore <file>` สำหรับไฟล์ที่ควรถูก ignore
- ตรวจสอบว่าไม่ ignore ไฟล์ที่จำเป็น

## Expected Outcome

- มี .gitignore ที่เหมาะสมกับประเภทโปรเจกต์
- ไม่มีไฟล์ที่ไม่ควร commit ถูกติดตามโดย Git
- โปรเจกต์สามารถทำงานได้ตามปกติหลังจาก ignore ไฟล์ที่ไม่จำเป็น
