---
title: Git Push
description: Push commits ทั้ง root และ git submodules ไปยัง remote
auto_execution_mode: 3
related:
  - /commit-and-push
  - /refactor-commit
  - /watch-github-actions
  - /open-web
  - /follow-gitignore
---

## Goal

Push commits จาก local repository และ git submodules ไปยัง remote repository อย่างปลอดภัย

## Scope

ใช้สำหรับ push commits ไปยัง remote repository ทั้ง root และ git submodules

## Execute

### 1. Check Status And Commits

- ทำ `git branch --show-current`, `git status`, และ `git submodule status` เพื่อดูสถานะปัจจุบัน
- ทำ `git log --oneline origin/<branch>..HEAD` เพื่อดู commits ที่จะ push
- ถ้า commits ใหญ่หรือหยาบเกินไป แนะนำให้ทำ `/refactor-commit` ก่อน push

### 2. Push

- ทำ `git push origin <branch>` และ `git submodule foreach --recursive git push origin <branch>`
- ถ้า push ถูก reject ให้หยุดและแจ้งผู้ใช้ ไม่ force push

### 3. Validate

- ทำ `git log --oneline origin/<branch> -5` เพื่อยืนยันว่า commits ปรากฏบน remote แล้ว
- ทำ `git status` เพื่อยืนยันว่า local และ remote sync กัน

### 4. Check GitHub Actions

- ทำ `gh workflow list` เพื่อตรวจสอบว่ามี GitHub Actions ใน repo ไหม
- ถ้ามี ให้ทำ `/watch-github-actions` เพื่อตรวจสอบและรันจนกว่าจะผ่าน

### 5. Setup GitHub Repo Metadata

ตั้งค่า repository metadata ให้ครบถ้วนหลังสร้าง repo หรือ push ครั้งแรก

1. ทำ `gh repo edit --description "<description>"` เพื่อตั้ง repo description
2. ทำ `gh repo edit --homepage "<homepage-url>"` เพื่อตั้ง homepage link
3. ทำ `gh repo edit --add-topic <topic>` เพื่อเพิ่ม topics (เช่น `typescript`, `bun`, `monorepo`, `solidjs`, `mcp`)
4. ตรวจสอบว่า `package.json` มี `repository`, `homepage`, `bugs`, `license` fields ครบ
5. ถ้าเป็น public repo ให้ตั้ง `--enable-issues=true` และ `--enable-wiki=false` (ใช้ docs แทน)
6. ทำ `gh repo edit --default-branch main` เพื่อตั้ง default branch

### 6. Open Repo

- ทำ `git remote get-url origin` เพื่อดู remote URL
- แปลง SSH URL เป็น HTTPS URL แล้วทำ `/open-web` เพื่อเปิด repo ใน browser

### 7. Ensure Repository Ready (Optional)

ทำเฉพาะเมื่อ `git` แจ้ง error ว่าไม่มี repository หรือไม่มี remote

- ถ้าไม่มี `.git` ให้ทำ `git init`, `git add -A`, `git commit -m "Initial commit"`, และทำ `/follow-gitignore`
- ถ้าไม่มี remote ให้ทำ `gh repo create <repo-name> --private --source=. --remote=origin --push` โดยใช้ชื่อโฟลเดอร์เป็น repo name

## Rules

### 1. Repository Initialization

- เป็น optional step ทำเฉพาะเมื่อ `git` แจ้ง error
- ถ้าไม่มี remote ให้สร้างด้วย `gh repo create` และเป็น `--private` เบื้องต้น
- ใช้ชื่อโฟลเดอร์ปัจจุบันเป็น repo name อัตโนมัติ
- ทำ `/follow-gitignore` หลัง `git init` เพื่อให้แน่ใจว่า `.gitignore` ครบถ้วน

### 2. Safety

- ไม่ force push โดยไม่จำเป็น
- ถ้า push ถูก reject ให้หยุดและแจ้งผู้ใช้ ไม่ force push

### 3. Submodules

- ต้อง push ทั้ง root และ submodules เสมอ
- ใช้ `git submodule foreach --recursive` สำหรับ operations ทั้งหมด

### 4. GitHub Repo Metadata

- ตั้งค่า metadata ทุกครั้งหลังสร้าง repo ใหม่หรือ push ครั้งแรก
- ใช้ `gh repo edit` สำหรับทุก metadata operation
- ตรวจสอบ `package.json` มี `repository`, `homepage`, `bugs`, `license` ครบ
- ใช้ topics ที่เกี่ยวข้องกับ tech stack จริง (ไม่ใส่ generic topics)
- ถ้าเป็น public repo ให้ตั้ง `--enable-issues=true` และ `--enable-wiki=false`
- ตั้ง default branch เป็น `main` เสมอ

## Expected Outcome

- Repository พร้อม push แม้ยังไม่มี `.git` หรือ remote
- Commits ถูก push ไปยัง remote สำเร็จ (ทั้ง root และ submodules)
- Local และ remote sync กัน
- GitHub Actions ผ่านทั้งหมด
- Repo เปิดใน browser อัตโนมัติหลัง push สำเร็จ

