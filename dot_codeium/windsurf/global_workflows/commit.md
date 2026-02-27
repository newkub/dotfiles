---
description: commit จน conventional commit ให้หมด
title: commit-conventional
---

## 1. เช็ค .gitignore

1. ตรวจสอบไฟล์ .gitignore มีอยู่และกำหนดเหมาะสม
   - รัน `eza --tree --git-ignore` ดูไฟล์ที่ควรถูก ignore
   - ปรับปรุง .gitignore ถ้าจำเป็น

## 2. ตรวจสอบสถานะ

1. รัน git status ตรวจสอบ changes

   ```bash
   git status --porcelain
   ```

   - ดู file changes ที่มีอยู่
   - ถ้าไม่มี changes ให้หยุด

## 3. แยก commit

1. ถ้ามี file change มาก
   - แยกเป็นกลุ่มตามหมวดหมู่
   - หมวดหมู่: feat, fix, refactor, docs, style, test, chore

2. commit แต่ละกลุ่ม
   - เลือก files ในกลุ่ม

   ```bash
   git add [files]
   ```

   ```bash
   git commit -m "feat: add new feature"
   ```

   - ตัวอย่าง conventional commit types:
     - `feat:` new feature
     - `fix:` bug fix
     - `docs:` documentation
     - `refactor:` code refactor
     - `style:` formatting
     - `test:` testing
     - `chore:` maintenance

## 4. ทำจนหมด

1. ทำซ้ำขั้นตอน 1-3 จนไม่มี file change เหลือ
   - ตรวจสอบ git status อีกครั้ง
   - ถ้ายังมี changes ให้ทำต่อ
