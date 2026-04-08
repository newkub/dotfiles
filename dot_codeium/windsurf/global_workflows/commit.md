---
title: Commit Guidelines
description: แนวทางการสร้าง commit ที่มีคุณภาพสูง ตามมาตรฐาน conventional commits
auto_execution_mode: 3
---

## Prompt

ใช้สำหรับสร้าง commit message ที่มีคุณภาพสูง อ่านง่าย และติดตามง่าย ตามมาตรฐาน conventional commits และ commit ให้หมดจนไม่มีเหลือ

## Execute

1. วิเคราะห์การเปลี่ยนแปลงในโปรเจกต์และระบุประเภทของแต่ละไฟล์

- ตรวจสอบ git status ดูไฟล์ที่มีการแก้ไข
- แยกประเภทการเปลี่ยนแปลงตาม conventional commit types

2. จัดเตรียมไฟล์และสร้าง commit message

- stage ไฟล์ที่เกี่ยวข้องกันเป็นชุด
- เลือก type และ scope ที่เหมาะสม
- เขียน subject ให้สื่อความหมายชัดเจน

3. ตรวจสอบและดำเนินการ commit

- อ่าน commit message ตรวจสอบความถูกต้อง
- ยืนยันว่าไฟล์ที่ stage ตรงกับ intention
- รัน git commit และตรวจสอบผลลัพธ์

## Rules

1. Conventional Commit Types

- feat: ฟีเจอร์ใหม่
- fix: แก้ไขบั๊ก
- docs: เปลี่ยนแปลงเอกสาร
- style: แก้ไข code style (formatting, semicolons, ไม่กระทบ logic)
- refactor: refactor code โดยไม่เพิ่ม feature หรือแก้บั๊ก
- perf: ปรับปรุง performance
- test: เพิ่มหรือแก้ไข tests
- chore: เปลี่ยนแปลง build process, dependencies, หรือ auxiliary tools

2. Commit Message Format

- `<type>(<scope>): <subject>`
- subject ไม่ต้องขึ้นต้นด้วยตัวพิมพ์ใหญ่
- subject ไม่ต้องจบด้วยจุด
- ใช้ภาษาอังกฤษหรือไทยให้สม่ำเสมอ

3. Scope (ถ้ามี)

- ระบุส่วนของโปรเจกต์ที่ถูกแก้ไข
- เช่น: api, ui, db, config, deps, auth, test, docs, ci, etc.

4. Subject Line

- สั้นกระชับไม่เกิน 72 ตัวอักษร
- สื่อความหมายชัดเจน
- ใช้ imperative mood (เช่น add ไม่ใช่ added)

5. Split Commits สำหรับไฟล์ใหญ่

- ถ้ามีการเปลี่ยนแปลงหลายส่วนในไฟล์เดียวกัน ให้แยกเป็น commit ย่อยๆ
- commit ทีละส่วนจนกว่าจะหมด ไม่มีเหลือ
- แต่ละ commit ควบคุม scope เดียว (เช่น refactor แยกจาก feature แยกจาก test)
- ใช้ `git add -p` หรือ `git add <specific-file>` เพื่อเลือกเฉพาะส่วนที่ต้องการ

6. Body (ถ้าจำเป็น)

- อธิบายเหตุผลและ context
- แยกจาก subject ด้วยบรรทัดว่าง
- ใช้ bullet points สำหรับหลายรายการ
