---
title: Git Push
description: Push commits ทั้ง root และ git submodules ไปยัง remote
auto_execution_mode: 3
related_workflows:
  - /watch-github-actions
---

## Goal

Push commits จาก local repository และ git submodules ไปยัง remote repository อย่างปลอดภัย

## Scope

ใช้สำหรับ push commits ไปยัง remote repository ทั้ง root และ git submodules

## Execute

### 1. Check Status

1. ทำ `git status` และ `git submodule status` เพื่อดูสถานะ
2. ทำ `git log --oneline origin/HEAD..HEAD` เพื่อดู commits ที่จะ push

### 2. Pull Changes

1. ทำ `git fetch origin` และ `git submodule foreach --recursive git fetch origin`
2. ทำ `git pull --rebase` และ `git submodule foreach --recursive git pull --rebase origin`
3. แก้ไข conflicts ถ้ามี (rebase ใหม่จนกว่าจะผ่าน)

### 3. Push Commits

1. ทำ `git push origin <branch>` และ `git submodule foreach --recursive git push origin`
2. ตรวจสอบว่าไม่มี error messages จาก git

### 4. Validate Push

1. ทำ `git log --oneline origin/HEAD -5` และ `git submodule foreach --recursive git log --oneline origin/HEAD -5`
2. ทำ `git status` เพื่อยืนยันว่า local และ remote sync กัน

### 5. Check GitHub Actions

1. ทำ `gh workflow list` เพื่อตรวจสอบว่ามี GitHub Actions ใน repository ไหม
2. ถ้ามี GitHub Actions ให้ทำ `/watch-github-actions` เพื่อตรวจสอบและรันจนกว่าจะผ่าน

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

