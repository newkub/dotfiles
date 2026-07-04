---
title: Git Push
description: Push commits ทั้ง root และ git submodules ไปยัง remote
auto_execution_mode: 3
related_workflows:
  - /commit-and-push
  - /refactor-commit
  - /watch-github-actions
---

## Goal

Push commits จาก local repository และ git submodules ไปยัง remote repository อย่างปลอดภัย

## Scope

ใช้สำหรับ push commits ไปยัง remote repository ทั้ง root และ git submodules

## Execute

### 1. Check Status

1. ทำ `git branch --show-current` เพื่อดู current branch
2. ทำ `git status` และ `git submodule status` เพื่อดูสถานะ
3. ทำ `git log --oneline origin/<branch>..HEAD` เพื่อดู commits ที่จะ push

### 2. Check Refactor Opportunity

ตรวจสอบว่าควร refactor commits ก่อน push ไหม

1. ทำ `git log --oneline origin/<branch>..HEAD` เพื่อดู commits ที่จะ push
2. ถ้ามี commits ที่ใหญ่เกินไปหรือหยาบเกินไป, แนะนำให้ทำ `/refactor-commit`
3. ถ้า commits มีคุณภาพดีแล้ว, ดำเนินการต่อไป push
4. ถ้าผู้ใช้ต้องการ refactor, ทำ `/refactor-commit` ก่อนแล้วกลับมาทำ push อีกครั้ง

### 3. Push Commits

// turbo
1. ทำ `git push origin <branch>` และ `git submodule foreach --recursive git push origin <branch>`
2. ถ้า push ถูก reject เพราะ remote มี commits ใหม่กว่า ให้หยุดและแจ้งผู้ใช้ (ไม่ force push)
3. ตรวจสอบว่าไม่มี error messages จาก git

### 4. Validate Push

1. ทำ `git log --oneline origin/<branch> -5` และ `git submodule foreach --recursive git log --oneline origin/<branch> -5`
2. ทำ `git status` เพื่อยืนยันว่า local และ remote sync กัน

### 5. Check GitHub Actions

1. ทำ `gh workflow list` เพื่อตรวจสอบว่ามี GitHub Actions ใน repository ไหม
2. ถ้ามี GitHub Actions ให้ทำ `/watch-github-actions` เพื่อตรวจสอบและรันจนกว่าจะผ่าน

## Rules

### 1. Safety

- ไม่ force push โดยไม่จำเป็น
- ถ้า push ถูก reject ให้หยุดและแจ้งผู้ใช้ ไม่ force push
- ต้องตรวจสอบว่า push สำเร็จจริง

### 2. Submodules

- ต้อง push ทั้ง root และ submodules เสมอ
- ใช้ `git submodule foreach --recursive` สำหรับ operations ทั้งหมด
- ตรวจสอบสถานะ submodules ก่อน push
- ตรวจสอบว่า submodules sync กับ remote

### 3. Verification

- ตรวจสอบว่าไม่มี error messages จาก git
- ยืนยันว่า commits ปรากฏบน remote repository
- ตรวจสอบว่า local และ remote sync กัน

## Expected Outcome

- Commits ถูก push ไปยัง remote repository สำเร็จ (ทั้ง root และ submodules)
- Local repository และ remote อยู่ในสถานะ sync กัน
- ทีมสามารถดู commits ใหม่บน remote ได้
- GitHub Actions ผ่านทั้งหมด

