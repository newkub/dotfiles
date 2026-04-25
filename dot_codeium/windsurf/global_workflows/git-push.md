---
title: Git Push
description: Push commits ทั้ง root และ git submodules ไปยัง remote
auto_execution_mode: 3
---

## Goal

Push commits จาก local repository และ git submodules ไปยัง remote repository อย่างปลอดภัย

## Execute

### 1. Check Status

1. ทำตาม `git status` เพื่อดูสถานะ local repository
2. ทำตาม `git submodule status` เพื่อดูสถานะ submodules
3. ทำตาม `git log --oneline origin/HEAD..HEAD` เพื่อดู commits ที่จะ push
4. ตรวจสอบว่ามี commits ที่ต้องการ push หรือไม่

### 2. Analyze Situation

1. ทำตาม `git fetch origin` เพื่ออัพเดทข้อมูล remote
2. ทำตาม `git submodule foreach --recursive git fetch origin` เพื่ออัพเดท submodules
3. วิเคราะห์ว่ามี commits บน remote ที่ local ไม่มีหรือไม่
4. ประเมินว่าจะมี conflicts หรือไม่

### 3. Pull Changes

1. ทำตาม `git pull --rebase` ก่อน push เสมอ (ถ้ามี commits บน remote)
2. ทำตาม `git submodule foreach --recursive git pull --rebase origin` สำหรับ submodules
3. แก้ไข conflicts ถ้ามี (rebase ใหม่จนกว่าจะผ่าน)
4. ตรวจสอบว่าไม่มี conflicts เหลืออยู่

### 4. Push Commits

1. ทำตาม `git push origin <branch>` เพื่อ push root repository
2. ทำตาม `git submodule foreach --recursive git push origin` เพื่อ push submodules
3. รอให้ push เสร็จสมบูรณ์
4. ตรวจสอบว่าไม่มี error messages จาก git

### 5. Validate Push

1. ทำตาม `git log --oneline origin/HEAD -5` เพื่อตรวจสอบ commits บน remote
2. ทำตาม `git submodule foreach --recursive git log --oneline origin/HEAD -5` สำหรับ submodules
3. ทำตาม `git status` เพื่อยืนยันว่า local และ remote sync กัน
4. ตรวจสอบว่า commits ที่ push ถูกต้องครบถ้วน

### 6. Check GitHub Actions

1. ทำตาม `/run-github-actions` เพื่อตรวจสอบและรัน GitHub Actions จนกว่าจะผ่าน

## Rules

### 1. Safety

- ต้อง pull ก่อน push เสมอเพื่อตรวจสอบ conflicts
- ถ้ามี conflicts ต้องแก้ไขก่อน push
- ไม่ push force โดยไม่จำเป็น
- ต้องตรวจสอบว่า push สำเร็จจริง

### 2. Submodules

- ต้อง push ทั้ง root และ submodules เสมอ
- ใช้ `git submodule foreach --recursive` สำหรับ operations ทั้งหมด
- ตรวจสอบสถานะ submodules ก่อน push
- ตรวจสอบว่า submodules sync กับ remote

### 3. Verification

- ตรวจสอบว่าไม่มี error messages จาก git
- ยืนยันว่า commits ปรากฏบน remote repository
- ตรวจสอบว่าไม่มี conflicts เหลืออยู่
- ตรวจสอบว่า local และ remote sync กัน

## Expected Outcome

- Commits ถูก push ไปยัง remote repository สำเร็จ (ทั้ง root และ submodules)
- Local repository และ remote อยู่ในสถานะ sync กัน
- ไม่มี conflicts เหลืออยู่
- ทีมสามารถดู commits ใหม่บน remote ได้
- GitHub Actions ผ่านทั้งหมด
