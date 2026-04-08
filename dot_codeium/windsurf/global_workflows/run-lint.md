---
description: Run lint with code quality check first
---

## Prompt

ใช้ workflow นี้เมื่อต้องการรัน lint โดยจะทำการตรวจสอบคุณภาพโค้ดก่อนการรัน lint เพื่อให้แน่ใจว่าโค้ดอยู่ในสถานะที่ดีที่สุด

## Purpose

ทำการตรวจสอบคุณภาพโค้ดและ refactor ก่อนการรัน lint เพื่อลดข้อผิดพลาดที่อาจเกิดขึ้นและเพิ่มประสิทธิภาพในการพัฒนา

## Rules

- ต้องเรียกใช้ `/run-check` ก่อนการรัน lint เสมอ
- ตรวจสอบว่าโปรเจกต์มีการตั้งค่า lint ให้ดี
- แก้ไขข้อผิดพลาดที่เกิดขึ้นจาก lint

## Execute

1. Run Code Quality Check
   - เรียกใช้ `/run-check` เพื่อตรวจสอบและปรับปรุงคุณภาพโค้ดก่อน
   - รอให้การตรวจสอบเสร็จสิ้นก่อนดำเนินการต่อ

2. Run Lint
   - ตรวจสอบว่าโปรเจกต์มีการตั้งค่า lint ใน main config
   - ถ้าไม่มีให้ทำการตั้งค่า lint ตามภาษาที่ใช้
   - รัน lint ตามที่กำหนดไว้ใน config

3. Fix Errors
   - รัน `/fix-errors` เพื่อแก้ไขข้อผิดพลาดที่เกิดจาก lint
   - ตรวจสอบว่าข้อผิดพลาดถูกแก้ไขหมดแล้ว

## Expected Outcome

โค้ดที่ผ่านการตรวจสอบคุณภาพและ lint โดยไม่มีข้อผิดพลาด พร้อมรายงานผลลัพธ์การรัน lint

## Reference

- `/run-check` workflow
- `/fix-errors` workflow
- Lint configuration files (biome.jsonc, .eslintrc, Cargo.toml, etc.)
