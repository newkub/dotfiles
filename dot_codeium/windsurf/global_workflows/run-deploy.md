---
title: Run Deploy
description: Deploy application ไปยัง platform ที่กำหนด
auto_execution_mode: 3
---

## Goal

Deploy application ไปยัง platform ที่กำหนดตามมาตรฐาน

## Execute

### 1. Verify

ตรวจสอบคุณภาพโค้ดก่อน deploy

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ด
2. ตรวจสอบว่า verify สำเร็จ
3. ตรวจสอบว่าไม่มี error หรือ warning ที่สำคัญ

### 2. Build Application

Build application สำหรับ deployment

1. ทำ `/run-build` เพื่อ build application
2. ตรวจสอบว่า build สำเร็จ
3. ตรวจสอบ artifacts ที่สร้าง

### 3. Deploy

Deploy application ตาม platform ที่ใช้

1. สำหรับ Vercel: ทำ `/deploy-to-vercel`
2. สำหรับ Cloudflare: ทำ `/deploy-to-cloudflare`
3. สำหรับ Railway: ทำ `/use-railway`
4. สำหรับ platform อื่น: ทำตาม workflow ที่เกี่ยวข้อง
5. ตรวจสอบว่า deploy สำเร็จ

### 4. Verify Deployment

ตรวจสอบว่า deployment ทำงานได้

1. เปิด URL ของ deployment
2. ตรวจสอบว่า application ทำงานได้
3. ตรวจสอบ logs ว่าไม่มี error
4. ทำ `/watch-browser` ถ้ามี URL

## Rules

### 1. Verify

- ต้อง verify สำเร็จก่อน build
- ใช้ `/run-verify` สำหรับ verify
- ไม่มี error หรือ warning ที่สำคัญ

### 2. Build

- ต้อง build สำเร็จก่อน deploy
- Artifacts ต้องถูกต้อง
- ใช้ `/run-build` สำหรับ build

### 3. Deploy

- ใช้ workflow ที่เหมาะสมกับ platform
- ต้อง deploy สำเร็จ
- ตรวจสอบ deployment status

### 4. Verification

- ต้องเปิด URL และตรวจสอบ
- Application ต้องทำงานได้
- ไม่มี error ใน logs
- ใช้ `/watch-browser` ถ้ามี URL

## Expected Outcome

- Application ถูก deploy สำเร็จ
- URL สามารถเข้าถึงได้
- Application ทำงานได้ปกติ
- ไม่มี error ที่เกิดขึ้น

