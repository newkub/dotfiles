---
title: Run Lint With Code Quality Check
description: Run lint with code quality check first
auto_execution_mode: 3
---

## Goal

ทำการตรวจสอบคุณภาพโค้ดและ refactor ก่อนการรัน lint เพื่อลดข้อผิดพลาดที่อาจเกิดขึ้นและเพิ่มประสิทธิภาพในการพัฒนา

## Execute

### 1. Run Format

1. ทำ `/run-format` เพื่อ format code ก่อน
2. รอให้ format เสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก format ให้แก้ไขก่อน

### 2. Run Code Quality Check

1. รัน `bun run lint` หรือ script ที่เทียบเท่าสำหรับตรวจสอบคุณภาพโค้ด
2. รอให้การตรวจสอบเสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก code quality check ให้แก้ไขก่อน

### 3. Run Lint

1. ทำ `/setup-config` เพื่อตรวจสอบ config
2. **ห้ามแก้ไข config ใดๆ**
3. **ห้ามใช้ ignore comments/attributes ทุกภาษา**
4. รัน lint ตามที่กำหนดไว้ใน config:
   - สำหรับ monorepo: รัน `bun run lint` หรือ `turbo lint`
   - สำหรับโปรเจกต์ทั่วไป: รัน lint command ตาม config

### 4. Fix Errors

1. รัน `/analyze-errors` เพื่อวิเคราะห์และจัดลำดับ errors ที่เกิดจาก lint
2. `/analyze-errors` จะตัดสินใจว่าควรไป workflow ไหนต่อ:
   - ถ้าเป็น cascade issues → `/debug-issue` → `/resolve-errors`
   - ถ้าเป็น isolated errors → `/resolve-errors`
3. ตรวจสอบว่าข้อผิดพลาดถูกแก้ไขหมดแล้ว
4. รัน lint อีกครั้งเพื่อยืนยัน

## Rules

- ต้องรัน code quality check ก่อนการรัน lint เสมอ
- ทำ `/setup-config` เพื่อตรวจสอบ config แต่ **ห้ามแก้ไข**
- **ห้ามใช้ ignore comments/attributes ทุกภาษา** แก้ปัญหาที่ source
- แก้ไขข้อผิดพลาดที่เกิดขึ้นจาก lint ก่อนดำเนินการต่อ

## Expected Outcome

โค้ดที่ผ่านการตรวจสอบคุณภาพและ lint โดยไม่มีข้อผิดพลาด พร้อมรายงานผลลัพธ์การรัน lint
