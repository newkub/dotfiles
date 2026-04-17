---
title: Run Lint With Code Quality Check
description: Run lint with code quality check first
auto_execution_mode: 3
---

## Goal

ทำการตรวจสอบคุณภาพโค้ดและ refactor ก่อนการรัน lint เพื่อลดข้อผิดพลาดที่อาจเกิดขึ้นและเพิ่มประสิทธิภาพในการพัฒนา

## Execute

### 1. Run Code Quality Check

1. รัน `bun run lint` หรือ script ที่เทียบเท่าสำหรับตรวจสอบคุณภาพโค้ด
2. รอให้การตรวจสอบเสร็จสิ้นก่อนดำเนินการต่อ
3. ถ้ามีข้อผิดพลาดจาก code quality check ให้แก้ไขก่อน

### 2. Run Lint

1. ตรวจสอบว่าโปรเจกต์มีการตั้งค่า lint ใน main config
2. ถ้าไม่มีให้ทำการตั้งค่า lint ตามภาษาที่ใช้
3. รัน lint ตามที่กำหนดไว้ใน config:
   - สำหรับ monorepo: รัน `bun run lint` หรือ `turbo lint`
   - สำหรับโปรเจกต์ทั่วไป: รัน lint command ตาม config

### 3. Fix Errors

1. รัน `/fix-error` เพื่อแก้ไขข้อผิดพลาดที่เกิดจาก lint
2. ตรวจสอบว่าข้อผิดพลาดถูกแก้ไขหมดแล้ว
3. รัน lint อีกครั้งเพื่อยืนยัน

## Rules

- ต้องรัน code quality check ก่อนการรัน lint เสมอ
- ตรวจสอบว่าโปรเจกต์มีการตั้งค่า lint ให้ดี
- แก้ไขข้อผิดพลาดที่เกิดขึ้นจาก lint ก่อนดำเนินการต่อ

## Expected Outcome

โค้ดที่ผ่านการตรวจสอบคุณภาพและ lint โดยไม่มีข้อผิดพลาด พร้อมรายงานผลลัพธ์การรัน lint
