---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

กฎการเตรียมความพร้อม

1. อ่าน `/do-not` ก่อนเริ่มงานทุกครั้ง
2. ใช้ `bun` แทน `npm` เสมอ
3. ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `pwsh`
4. รัน `/watch-browser` ทันทีเมื่อได้รับ URL
5. ทำ `/analyze-project` ก่อนเริ่มงานทุกครั้ง
6. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
7. `"."` หมายถึงให้ทำ `/continue`
8. `"s."` หมายถึงให้ทำ `/use-bun-scripts`

### 2. Analyze

กฎการวิเคราะห์

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. เมื่อได้รับ error ทำตาม `/fix-error`
3. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`
4. วิเคราะห์ root cause ก่อนแก้ไข

### 3. Planning

กฎการวางแผน

1. ใช้ `/plan` สำหรับการวางแผนงานครอบคล้ว
2. เมื่อแก้ไขไฟล์ workflows ทำตาม `/follow-write-workflows`
3. เมื่อแก้ไขไฟล์ skills ทำตาม `/follow-write-skills`

### 4. Write

กฎการเขียนโค้ด

1. อ่าน `/do-not` ก่อนเขียน code ทุกครั้ง
2. เมื่อ execute ต้องเปิด web ให้รัน `/watch-browser`
3. ทำ `/update-reference` เสมอสำหรับ file operations
4. เมื่อเขียน code ทำตาม `/write-test` เสมอ
5. ถ้า mock ให้ comment `// MOCK` ชัดเจน ถ้ายังทำไม่เสร็จต้อง comment `// TODO`
6. mock data ห้ามเขียนในไฟล์เดียวกัน ต้องแยกไฟล์ไปในโฟลเดอร์ `mock/` แล้วนำไปใช้
7. ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment ชัดเจน
8. ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ
9. ถ้า file operation หรือ analyze ไฟล์จำนวนมาก ให้ใช้ `/use-bun-scripts`

### 5. Reflex

กฎการตรวจสอบ

1. ทำ `/run-typecheck` เสมอหลังจาก execute เสร็จ
2. ใช้ `/loop-until-complete` เพื่อทำซ้ำจนกว่าจะผ่าน
3. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Report

กฎการรายงาน

1. ทำตาม `/report`
2. เมื่อจบ task ให้รัน `/suggest-next-action` เสมอ
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
4. ให้คำตอบกระชับ ตรงประเด็น
5. หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น
