---
title: Watch Terminal
description: เปิดเบราว์เซอร์และ watch terminal ทุก 5 วินาที พร้อมจัดการ error อัตโนมัติ
auto_execution_mode: 3
related_workflows:
  - /resolve-errors
---

## Goal

Watch terminal ทุก 5 วินาที พร้อมจัดการ errors ที่เกิดขึ้นอัตโนมัติ

## Scope

ใช้เมื่อต้องการตรวจสอบและจัดการปัญหาใน development server อย่างต่อเนื่อง

## Execute

### 1. Pre-Check

ตรวจสอบสถานะ project:

1. ตรวจสอบว่าอยู่ใน project directory ที่ถูกต้อง
2. ตรวจสอบว่ามี development script ใน `package.json`
3. ตรวจสอบว่า dependencies ถูกติดตั้งครบถ้วน
4. ตรวจสอบว่า development server รันอยู่

### 2. Start Watch

เริ่ม watch terminal:

1. อ่าน terminal output ปัจจุบัน
2. ตรวจสอบ errors และ warnings ใหม่ๆ
3. ตรวจสอบ build status และ hot reload
4. รอ 5 วินาทีแล้วอ่านซ้ำ

### 3. Handle Errors

จัดการ errors ที่พบ:

1. ถ้าพบ errors ให้ทำ `/resolve-errors` ทันที
2. แก้ที่ root cause ไม่ใช่ symptoms
3. ยืนยันว่า errors ถูกแก้ไขอย่างสมบูรณ์
4. กลับไป watch terminal ต่อ

### 4. Verify

ตรวจสอบความถูกต้อง:

1. ตรวจสอบว่า terminal watch ทำงานทุก 5 วินาที
2. ยืนยันว่าสามารถตรวจจับและแก้ไข errors ใหม่ๆ ได้
3. ตรวจสอบว่า development server ทำงานปกติ

## Rules

### 1. Pre-Check Requirements

- ต้องรัน development server ก่อนเสมอ
- ต้องแก้ไข errors ที่พบก่อนดำเนินการต่อ
- ต้อง watch terminal ทุก 5 วินาทีต่อเนื่อง

### 2. Error Handling

- ทำ `/resolve-errors` สำหรับแก้ไข errors อัตโนมัติ
- ตรวจสอบ error logs จาก terminal
- แก้ไข root cause ไม่ใช่เพียง symptoms
- ยืนยันว่า errors ถูกแก้ไขอย่างสมบูรณ์

### 3. Terminal Monitoring

- Watch terminal ทุก 5 วินาที
- ตรวจจับ errors และ warnings ใหม่ๆ
- ตรวจสอบ build status
- ตรวจสอบ hot reload ทำงานได้

## Expected Outcome

- Development server รันอยู่เสมอ
- Errors ถูกตรวจจับและแก้ไขอัตโนมัติ
- Terminal ถูก watch ทุก 5 วินาทีต่อเนื่อง


