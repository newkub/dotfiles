---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

1. ทำ `/check-architecture` เพื่อดูโครงสร้างโปรเจกต์ก่อนเสมอ
2. ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `pwsh`
3. ใช้ `/use-import-alias` เสมอ
4. รัน `/watch-browser` ทันทีเมื่อได้รับ URL
5. ทำ `/analyze-project` ด้วย `/use-bun-shell` ก่อนเริ่มงานทุกครั้ง
6. แต่ละ workspace ต้องทำตาม `/setup-tasks` เพื่อตั้งค่า scripts มาตรฐาน
7. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
8. `"."` หมายถึงให้ทำ `/continue`
9. `"s."` หมายถึงให้ทำ `/use-bun-scripts`

### 2. Analyze

1. ทำ `/check-architecture` เพื่อดูโครงสร้างโปรเจกต์ก่อนเสมอ
2. ทำ `/analyze-project` ด้วย `/use-bun-shell` เพื่อดูภาพรวมโปรเจกต์
3. เมื่อได้รับ error ทำตาม `/fix-error`
4. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`
5. วิเคราะห์ root cause ก่อนแก้ไข

### 3. Planning

1. ใช้ `/plan` สำหรับการวางแผนงานครอบคล้ว
2. เมื่อแก้ไขไฟล์ workflows ทำตาม `/follow-write-workflows`
3. เมื่อแก้ไขไฟล์ skills ทำตาม `/follow-write-skills`

### 4. Write

1. อ่าน `/do-not` ก่อนเขียน code ทุกครั้ง
2. เมื่อ execute ต้องเปิด web ให้รัน `/watch-browser`
3. ทำ `/update-reference` เสมอสำหรับ file operations
4. เมื่อเขียน code ทำตาม `/write-test` เสมอ
5. ถ้า mock ให้ comment `// MOCK` ชัดเจน ถ้ายังทำไม่เสร็จต้อง comment `// TODO`
6. mock data ห้ามเขียนในไฟล์เดียวกัน ต้องแยกไฟล์ไปในโฟลเดอร์ `mock/` แล้วนำไปใช้
7. ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment ชัดเจน
8. ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ
9. ห้ามใช้ `npx` ให้ใช้ `bunx` แทนเสมอ
10. README.md ให้ทำตาม `/update-readme` เสมอ

### 5. Reflex

1. ใช้ `/loop-until-complete` เพื่อทำซ้ำจนกว่าจะผ่าน
2. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Report

1. ทำตาม `/report`
2. เมื่อจบ task ให้รัน `/suggest-next-action` เสมอ
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
4. ให้คำตอบกระชับ ตรงประเด็น
5. หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น

