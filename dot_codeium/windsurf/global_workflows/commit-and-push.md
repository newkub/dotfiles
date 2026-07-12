---
title: Commit And Push
description: Commit ไฟล์และ push ไปยัง remote repository
auto_execution_mode: 3
related:
  - /commit
  - /git-push
  - /edit-relative
---

## Goal

Commit ไฟล์และ push ไปยัง remote repository

## Scope

ใช้สำหรับ commit และ push การเปลี่ยนแปลงในทีเดียว โดยเป็น orchestrator ที่เรียก `/commit` และ `/git-push`

## Execute

### 1. Commit Changes

สร้าง commit สำหรับไฟล์ที่มีการเปลี่ยนแปลง

1. ทำตาม `/commit`
2. ตรวจสอบด้วย `git log --oneline -3` ว่า commit ถูกสร้างถูกต้อง

### 2. Push Changes

Push commits ไปยัง remote repository

1. ทำตาม `/git-push`
2. ตรวจสอบด้วย `git status` ว่า local และ remote sync กัน

### 3. Update References

อัปเดท references ทั้งหมดที่เกี่ยวข้อง

1. ทำตาม `/edit-relative`

## Rules

- ใช้เป็น orchestrator เท่านั้น รายละเอียดอยู่ใน `/commit` และ `/git-push`
- ถ้า push ถูก reject ให้หยุดและแจ้งผู้ใช้ ไม่ force push
- ถ้าเป็น monorepo ให้ทำ `/follow-monorepo` ก่อน commit

## Expected Outcome

1. Changes ถูก commit ตาม conventional commits
2. Changes ถูก push ไปยัง remote repository
3. Git history สะอาดและติดตามง่าย
