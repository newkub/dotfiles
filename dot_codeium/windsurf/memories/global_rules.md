---
title: Global Rules
description: กฎหลักที่ต้องปฏิบัติตามในทุกการทำงาน สำหรับ AI assistant
auto_execution_mode: 3
file-patterns:
  - "**/*.md"
---

## Prerequisites

- AI assistant ต้องโหลด memory นี้ก่อนเริ่มทำงาน
- ใช้งานในทุก workspace ของผู้ใช้

## 3.1 Precondition

- ต้องอ่าน skill ที่เกี่ยวข้องกับงานที่จะทำก่อนเสมอ
- AI assistant ต้องโหลด memory นี้ก่อนเริ่มทำงาน
- ใช้งานในทุก workspace ของผู้ใช้

## 3.2 Prepare

- ตรวจสอบว่าเข้าใจกฎทั้งหมดก่อนเริ่มงาน
- ยืนยันว่ากำลังใช้ภาษาไทยในการตอบกลับ
- อ่าน skill ที่เกี่ยวข้องกับงานนั้นๆ

## 3.3 Execute

1. **คุยกับผู้ใช้เป็นภาษาไทย**
   - ตอบทุกคำถามและคำสั่งเป็นภาษาไทย
   - ใช้ภาษาที่เป็นทางการแต่เข้าใจง่าย

2. **อ่าน skills ก่อนทำงานทุกครั้ง**
   - ก่อนเริ่มงานใดๆ ให้อ่าน skill ที่เกี่ยวข้องกับงานนั้นก่อนเสมอ
   - ใช้ `@skill-name` เพื่อโหลด skill ที่ต้องการ
   - ทำความเข้าใจหลักการและกฎใน skill นั้นๆ

3. **ใช้ bun เท่านั้น ไม่ใช้ npm**
   - คำสั่งถูกต้อง: `bun install`, `bun run dev`, `bun create`
   - ห้ามใช้: `npm install`, `npm run`, `npx`

4. **Vue component format**
   - ใช้ `script setup lang="ts"`
   - script ต้องอยู่ด้านบน template
   ```vue
   <script setup lang="ts">
   // scripts อยู่ด้านบน
   </script>
   
   <template>
     <!-- template อยู่ด้านล่าง -->
   </template>
   ```

5. **ทำความเข้าใจคำสั่งลัด**
   - ถ้าผู้ใช้พิมพ์ `.` หมายถึง "ทำต่อ" หรือ "continue"

6. **แก้ไขไฟล์ใน global_workflows**
   - ทุกครั้งที่แก้ไขไฟล์ใน `C:/Users/Veerapong/.codeium/windsurf/global_workflows`
   - ต้องทำตาม `@write-workflows`

7. **ติดตั้ง dependencies**
   - ทุกครั้งที่ติดตั้ง dependencies ให้ `@write-agents`

8. **ดูไฟล์ใกล้เคียงก่อนสร้างใหม่**
   - ตรวจสอบไฟล์ที่มีอยู่ในโฟลเดอร์เป้าหมาย
   - สร้างให้มีรูปแบบคล้ายกับไฟล์ที่มีอยู่

9. **ตรวจสอบ @file-patterns**
   - ก่อนสร้างหรือแก้ไขไฟล์ ให้ตรวจสอบ `@file-patterns`

10. **อัพเดท relative reference paths**
    - ทุกครั้งที่แก้ไขไฟล์ ให้ตรวจสอบและแก้ไข relative reference path ด้วย

11. **ใช้ bun scripts สำหรับ bulk operations**
    - พยายามใช้ `/use-bun-scripts` สำหรับการทำงานที่ซ้ำๆ หรือจำนวนมาก

## 3.4 Validate

- [ ] ตอบเป็นภาษาไทยทุกครั้ง
- [ ] อ่าน skill ที่เกี่ยวข้องก่อนเริ่มงาน
- [ ] ใช้ bun ไม่ใช้ npm
- [ ] Vue component มี script อยู่ด้านบน template
- [ ] แก้ไข relative paths เมื่อมีการย้าย/แก้ไขไฟล์
- [ ] ตรวจสอบว่าทำตาม file patterns ที่กำหนด

## 3.5 Verify

- [ ] ยืนยันว่าทุกกฎถูกปฏิบัติตาม
- [ ] ตรวจสอบว่าไม่มี error จากการไม่ได้อ่าน skill
- [ ] ตรวจสอบความสอดคล้องของผลลัพธ์