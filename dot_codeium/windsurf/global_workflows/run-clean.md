---
title: Run Clean
description: Clean build artifacts และ cache เพื่อเริ่มต้นใหม่
auto_execution_mode: 3
related_workflows:
  - /run-build
---

## Goal

Clean build artifacts และ cache เพื่อเริ่มต้นใหม่

## Execute

### 1. Clean Build Artifacts

1. ลบโฟลเดอร์ `dist`, `build`, `out`
2. ลบ `.next`, `.nuxt`, `.output` ตาม framework
3. ลบ compiled files ทั้งหมด

### 2. Clean Cache

1. ลบ `node_modules/.cache`
2. ลบ `.turbo`, `.cache`
3. ลบ framework-specific cache
4. ลบ TypeScript cache

### 3. Clean Dependencies

1. ลบ `node_modules` ถ้าจำเป็น
2. ลบ lock files ถ้าจำเป็น
3. ลบ package manager cache

### 4. Clean Temporary Files

1. ลบ `.DS_Store`, `Thumbs.db`
2. ลบ log files
3. ลบ temporary directories
4. ลบ coverage reports เก่า

### 5. Clean Git

1. รัน `git clean -fdx` เพื่อลบ untracked files
2. รัน `git gc` เพื่อ optimize repository
3. ลบ stale branches ถ้าจำเป็น

### 6. Reinstall Dependencies

1. รัน `bun install` หรือ package manager ที่ใช้
2. ตรวจสอบว่า dependencies ติดตั้งสำเร็จ
3. รัน build เพื่อทดสอบ

## Rules

### 1. Clean Scope

- Clean เฉพาะสิ่งที่จำเป็น
- Backup ข้อมูลสำคัญก่อน clean
- อย่าลบ source code หรือ config files

### 2. Dependency Reinstall

- Reinstall dependencies เฉพาะเมื่อจำเป็น
- ใช้ lock files เพื่อความสม่ำเสมอ
- ตรวจสอบ package manager compatibility

### 3. Git Safety

- ตรวจสอบ git status ก่อน clean
- Commit หรือ stash changes ที่สำคัญ
- ใช้ `--dry-run` ก่อน `git clean`

## Expected Outcome

- Build artifacts ถูกลบทั้งหมด
- Cache ถูกลบทั้งหมด
- Temporary files ถูกลบ
- Git repository ถูก optimize
- Dependencies ติดตั้งใหม่อย่างถูกต้อง
- Build ทำงานได้หลัง clean
