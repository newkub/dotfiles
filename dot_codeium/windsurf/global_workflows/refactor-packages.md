---
description: refactor โค้ดเข้า packages ที่มีอยู่ให้มากที่สุด เพื่อลดความซ้ำซ้อน
title: refactor-packages
---

## 1. Analyze Existing Packages

1. สำรวจ packages ที่มีอยู่ทั้งหมด
   - ดูโครงสร้างใน `packages/` ทั้งหมด
   - วิเคราะห์ single responsibility ของแต่ละ package
   - จดความสามารถและฟีเจอร์ของแต่ละ package

2. ตรวจสอบโค้ดที่จะ refactor
   - หาส่วนที่สามารถใช้ packages ที่มีอยู่แทนได้
   - ตรวจสอบ dependencies ระหว่าง packages ปัจจุบัน
   - หาความซ้ำซ้อนในโค้ดที่สามารถรวมเข้า package เดียว

## 2. Prioritize Using Existing Packages

1. ใช้ packages ที่มีอยู่ให้มากที่สุดก่อนสร้างใหม่
   - ตรวจสอบว่ามี package ไหนทำหน้าที่นี้อยู่แล้วหรือไม่
   - พยายาม refactor ให้เข้ากับ package ที่มีอยู่
   - หลีกเลี่ยงการสร้าง package ใหม่ถ้ามี package เก่าทำได้

2. รวมฟังก์ชันที่คล้ายกัน
   - ย้ายโค้ดเข้า packages ที่มีอยู่แทนสร้างใหม่
   - ใช้ prefix-core packages เพื่อรวมฟังก์ชันทั่วไป
   - จัดการ dependencies ให้ชี้ไปที่ packages ที่มีอยู่

## 3. Create New Packages Only When Necessary

1. สร้าง package ใหม่เฉพาะกรณีจำเป็น
   - เมื่อไม่มี package ที่มีอยู่ทำหน้าที่นี้
   - เมื่อฟังก์ชันมีความจำเพาะและแยกจาก packages อื่นชัดเจน
   - ต้องมีการวิเคราะห์และอนุมัติก่อนสร้าง

## 4. Refactor and Consolidate

1. ย้ายโค้ดเข้า packages ที่เหมาะสม
   - แยกตาม domain และ responsibility ที่ชัดเจน
   - รวมฟังก์ชันที่ซ้ำซ้อนเข้าด้วยกัน
   - ใช้ re-export pattern ผ่าน prefix-core packages

2. จัดการ dependencies
   - อัพเดท imports ให้ชี้ไปที่ packages ที่มีอยู่
   - ตั้งค่า workspace dependencies ให้ถูกต้อง
   - ลบ dependencies ที่ไม่จำเป็น

## 5. Verify and Optimize

1. ตรวจสอบโครงสร้าง packages
   - แต่ละ package มี single responsibility ชัดเจน
   - ไม่มีความซ้ำซ้อนระหว่าง packages
   - ใช้ packages ที่มีอยู่อย่างมีประสิทธิภาพ

2. ทดสอบการทำงาน
   - รัน build ตรวจสอบทุก workspace
   - ตรวจสอบ imports ทั้งหมดว่าถูกต้อง
   - ยืนยันว่าไม่มีฟังก์ชันที่ซ้ำซ้อน

