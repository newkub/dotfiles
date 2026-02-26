

---
description: กำหนดกฎการทำงานทั่วไป
title: global-rules
auto_execution_mode: 3
---

## High Priority Rules

### สื่อสาร

1. ใช้ภาษาไทยในการพูดคุย
2. พิมพ์ "." หมายถึง ให้ทำต่อ
   - พูดตรงๆ ไม่ยืดยาว
   - ถามถ้าสงสัยอะไร

### ห้าม

#### General Development Practices

- ห้ามรัน dev ถ้าไม่ได้สั่ง
- ห้ามใช้ debug ในโค้ด production (ใช้ logger แทน)
- ห้ามเขียน config/URL/secrets ในโค้ด
- ห้ามเชื่อ input ผู้ใช้โดยไม่ตรวจสอบ
- ห้ามใช้ any โดยไม่จำเป็น
- ห้ามเพิ่ม dependencies โดยไม่จำเป็น
- ห้าม duplicate code (refactor เป็น functions/modules)
- ห้ามใช้ magic numbers (กำหนด constants)
   - ใช้ best practices เสมอ
   - ทดสอบก่อน deploy

#### TypeScript Specific

- ห้าม comment เพื่อปิดปัญหา (// @ts-ignore, etc.)
- ห้ามใช้ CommonJS (ใช้ ESM)
- ห้ามใช้ eslint/prettier/npm
- ห้ามใช้ eslint-disable หรือ biome-ignore
   - ใช้ type safety เสมอ
   - หลีกเลี่ยง any

#### Database

- ห้ามใช้ query N+1 หรือไม่มี index
   - ใช้ index ให้เหมาะสม
   - หลีกเลี่ยง query ช้า

#### Performance

- ห้ามโหลด resource หนักโดยไม่มี lazy loading
   - ใช้เทคนิค optimization
   - ตรวจสอบ performance

#### Task Management

- ห้ามใช้ TODO comments ที่ไม่ติดตาม
   - ใช้ tools สำหรับจัดการงาน
   - จดงานให้ชัดเจน

## Medium Priority Rules

### จัดการแพ็คเกจ

1. ใช้ bun เท่านั้น
   - ติดตั้งและตั้งค่าแพ็คเกจต่างๆ
   - ค้นหาให้แน่ใจก่อน
   - อ่านเอกสารก่อนใช้
   - ตรวจสอบเวอร์ชันล่าสุด

### ตรวจสอบโครงสร้าง

1. ตรวจสอบโครงสร้างโฟลเดอร์ด้วยคำสั่ง `eza --tree --git-ignore`
   - ใช้คำสั่งนี้ก่อนทำงาน
   - ตรวจสอบไฟล์ที่เปลี่ยนแปลง

### จัดการไฟล์

1. ใช้ pwsh สำหรับจัดการไฟล์
2. ใช้ safe move สำหรับย้ายหรือเปลี่ยนชื่อไฟล์
3. อัปเดตการอ้างอิงเมื่อแก้ไขไฟล์
   - ใช้ path เต็มเสมอ
   - ตรวจสอบไฟล์ก่อนแก้ไข
4. automate แก้ไขไฟล์ด้วย /use-bun-scripts ถ้าเป็นไปตาม
5. ถ้าจะสร้าง scripts เพื่อทดสอบให้สร้างใน .windsurf/scripts

### จัดการตั้งค่า

1. ไม่ตั้งค่า ถ้าเป็นค่าเริ่มต้น
   - ตรวจสอบเอกสารหรือค่าเริ่มต้นก่อน
   - ใช้ค่าเริ่มต้นให้มากที่สุด
   - เปลี่ยนเฉพาะที่จำเป็น

### จัดการงาน

1. จด TODO สำหรับงานที่ยังไม่เสร็จ
2. จด error ไว้ แก้ทีหลัง
3. รัน /refactor ก่อนจบ task เสมอ
4. รัน /update-readme หลังงานเสร็จ
   - ใช้ todo list เพื่อติดตาม
   - แบ่งงานเป็นขั้นตอนเล็กๆ

## Low Priority Rules

### พัฒนา Vue

1. ทุกไฟล์ .vue ใช้ script setup lang ts
   - scripts อยู่ด้านบน template
   - ใช้ vueuse และ vue macros เสมอ
   - ใช้ composition API
   - เรียนรู้ Vue 3 features
