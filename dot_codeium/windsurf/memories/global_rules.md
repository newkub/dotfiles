---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

เตรียมความพร้อมก่อนเริ่มงาน

1. ใช้ git สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ pwsh
2. รัน `/watch-browser` ทันทีเมื่อได้รับ URL
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
4. "." หมายถึงให้ทำ `/continue`
5. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน

### 2. Analyze

วิเคราะห์โปรเจกต์และความต้องการก่อนเริ่มทำงาน

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. ทำตาม `/fix-error` เมื่อได้รับ error
3. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`

### 3. Planning

วางแผนงานก่อนดำเนินการ

1. พยายามทำให้ `/make-real` ในทุกๆเลย
2. ทำตาม `/follow-write-workflows` เมื่อแก้ไขไฟล์ workflows
3. ทำตาม `/follow-write-skills` เมื่อแก้ไขไฟล์ skills

### 4. Execute

ดำเนินการตามกฎที่กำหนดอย่างเคร่งครัด

1. อ่าน `/refactor` และ `/do-not` ก่อนเขียน code ทุกครั้ง แล้วนำตามนั้น
2. รัน `/watch-browser` เมื่อ execute ต้องเปิด web
3. ทำ `/update-reference` เสมอสำหรับ file operations
4. ไม่ mock, ไม่ TODO โดย default แต่ถ้าจำเป็นจริงๆ ต้อง comment `// MOCK` หรือ `// TODO`

### 5. Reflex

ทำการ refactor หลังจาก execute เสร็จเสมอ

1. ทำ `/refactor` เสมอหลังจาก execute เสร็จ
2. กลับไป check ข้อ 2 planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Commit

บันทึกการเปลี่ยนแปลงหลังจากทำงานเสร็จ

1. ใช้ `/commit` เมื่อจบ plan ที่วางไว้ตามข้อ 3

### 7. Documentation

อัพเดทเอกสารให้สอดคล้องกับการเปลี่ยนแปลง

1. ใช้ `/update-readme` ถ้ามีการเปลี่ยนแปลงที่ต้องอัพเดทเอกสาร
2. ใช้ `/update-docs` สำหรับสร้างหรืออัพเดทเอกสารประกอบโครงสร้างโปรเจกต์

### 8. Report

สรุปและรายงานผล

1. ทำตาม `/reporting`
