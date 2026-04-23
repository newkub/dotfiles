---
title: Git Push
description: ทำการ push commits ไปยัง remote repository
auto_execution_mode: 3
---

## Goal

Push commits จาก local repository ไปยัง remote repository อย่างปลอดภัย

## Rules

- ต้อง pull ก่อน push เสมอเพื่อตรวจสอบ conflicts
- ถ้ามี conflicts ต้องแก้ไขก่อน push
- ต้องตรวจสอบว่า push สำเร็จจริง
- ไม่ push force โดยไม่จำเป็น

## Execute

### 1. Check Status

1. ทำตาม `git status` เพื่อดูสถานะ local repository
2. ทำตาม `git log --oneline origin/HEAD..HEAD` เพื่อดู commits ที่จะ push
3. ตรวจสอบว่ามี commits ที่ต้องการ push หรือไม่

### 2. Analyze Situation

1. ทำตาม `git fetch origin` เพื่ออัพเดทข้อมูล remote
2. วิเคราะห์ว่ามี commits บน remote ที่ local ไม่มีหรือไม่
3. ประเมินว่าจะมี conflicts หรือไม่

### 3. Push Commits

1. ทำตาม `git pull --rebase` ก่อน push เสมอ (ถ้ามี commits บน remote)
2. แก้ไข conflicts ถ้ามี (rebase ใหม่จนกว่าจะผ่าน)
3. ทำตาม `git push origin <branch>` เพื่อ push commits
4. รอให้ push เสร็จสมบูรณ์

### 4. Validate Push

1. ตรวจสอบว่าไม่มี error messages จาก git
2. ยืนยันว่า commits ปรากฏบน remote repository
3. ตรวจสอบว่าไม่มี conflicts เหลืออยู่

### 5. Verify Result

1. ทำตาม `git log --oneline origin/HEAD -5` เพื่อตรวจสอบ commits บน remote
2. ทำตาม `git status` เพื่อยืนยันว่า local และ remote sync กัน
3. ตรวจสอบว่า commits ที่ push ถูกต้องครบถ้วน

### 6. Check GitHub Actions

1. ทำตาม `/run-github-actions` เพื่อตรวจสอบและรัน GitHub Actions จนกว่าจะผ่าน

## Expected Outcome

- Commits ถูก push ไปยัง remote repository สำเร็จ
- Local repository และ remote อยู่ในสถานะ sync กัน
- ไม่มี conflicts เหลืออยู่
- ทีมสามารถดู commits ใหม่บน remote ได้
- GitHub Actions ผ่านทั้งหมด
