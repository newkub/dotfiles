---
title: Run Deploy
description: Deploy application ตาม platform ที่ใช้
auto_execution_mode: 3
---

## Goal

Deploy application ไปยัง platform ที่กำหนดตามมาตรฐาน

## Execute

### 1. Check Platform

1. ตรวจสอบ platform ที่ใช้ (Vercel, Cloudflare, Railway, ฯลฯ)
2. ตรวจสอบ configuration ครบถ้วน
3. ตรวจสอบ environment variables
4. ตรวจสอบ authentication tokens

### 2. Verify

1. ทำ `/run-verify` เพื่อตรวจสอบคุณภาพโค้ด
2. ตรวจสอบว่า verify สำเร็จ
3. ตรวจสอบว่าไม่มี error หรือ warning ที่สำคัญ

### 3. Build Application

1. ทำ `/run-build` เพื่อ build application
2. ตรวจสอบว่า build สำเร็จ
3. ตรวจสอบ artifacts ที่สร้าง

### 4. Deploy

1. สำหรับ Vercel: ทำ `/deploy-to-vercel`
2. สำหรับ Cloudflare: ทำ `/deploy-to-cloudflare`
3. สำหรับ Railway: ทำ `/use-railway`
4. สำหรับ platform อื่น: ทำตาม workflow ที่เกี่ยวข้อง
5. ตรวจสอบว่า deploy สำเร็จ

### 5. Verify Deployment

1. เปิด URL ของ deployment
2. ตรวจสอบว่า application ทำงานได้
3. ตรวจสอบ logs ว่าไม่มี error
4. ทำ `/watch-browser` ถ้ามี URL

## Rules

### 1. Platform Configuration

- ต้องตรวจสอบ platform ก่อน deploy
- Configuration ต้องครบถ้วน
- Environment variables ต้องถูกต้อง
- Authentication tokens ต้องมี

### 2. Verify

- ต้อง verify สำเร็จก่อน build
- ใช้ `/run-verify` สำหรับ verify
- ไม่มี error หรือ warning ที่สำคัญ

### 3. Build

- ต้อง build สำเร็จก่อน deploy
- Artifacts ต้องถูกต้อง
- ใช้ `/run-build` สำหรับ build

### 4. Deploy

- ใช้ workflow ที่เหมาะสมกับ platform
- ต้อง deploy สำเร็จ
- ตรวจสอบ deployment status

### 5. Verification

- ต้องเปิด URL และตรวจสอบ
- Application ต้องทำงานได้
- ไม่มี error ใน logs
- ใช้ `/watch-browser` ถ้ามี URL

## Expected Outcome

- Application ถูก deploy สำเร็จ
- URL สามารถเข้าถึงได้
- Application ทำงานได้ปกติ
- ไม่มี error ที่เกิดขึ้น
