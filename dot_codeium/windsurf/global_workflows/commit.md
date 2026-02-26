---
description: commit จน conventional commit ให้หมด
---

## 0. เช็ค .gitignore

1. ตรวจสอบว่าไฟล์ .gitignore มีอยู่และกำหนดเหมาะสม
   - ใช้คำสั่ง `eza --tree --git-ignore` เพื่อดูไฟล์ที่ควรถูก ignore
   - ปรับปรุง .gitignore ถ้าจำเป็น

## 1. ตรวจสอบสถานะ

1. รันคำสั่งตรวจสอบ git status

   ```bash
   git status --porcelain
   ```

   - ดู file changes ที่มีอยู่
   - ถ้าไม่มี changes ให้หยุด

## 2. แยก commit

1. ถ้ามี file change มาก
   - แยกเป็นกลุ่มตามหมวดหมู่
   - หมวดหมู่: feat, fix, refactor, docs, style, test, chore

2. commit แต่ละกลุ่ม
   - เลือก files ในกลุ่ม
   - git add [files]
   - git commit -m "feat: add new feature"
   - ตัวอย่าง conventional commit types:
     - `feat:` new feature
     - `fix:` bug fix
     - `docs:` documentation
     - `refactor:` code refactor
     - `style:` formatting
     - `test:` testing
     - `chore:` maintenance

## 3. ทำจนหมด

1. ทำซ้ำขั้นตอน 1-2 จนไม่มี file change เหลือ
   - ตรวจสอบ git status อีกครั้ง
   - ถ้ายังมี changes ให้ทำต่อ
