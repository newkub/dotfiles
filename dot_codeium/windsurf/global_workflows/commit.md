---
title: Commit Guidelines
description: แนวทางการสร้าง commit ที่มีคุณภาพสูง ตามมาตรฐาน conventional commits
auto_execution_mode: 3
---

## Goal

สร้าง commit message ที่มีคุณภาพสูง อ่านง่าย และติดตามง่าย ตามมาตรฐาน conventional commits

## Execute

### 1. Check Lefthook Setup

ตรวจสอบและติดตั้ง lefthook ถ้ายังไม่มี

1. ตรวจสอบว่า `lefthook.yml` มีอยู่และไม่ว่างเปล่า
2. ถ้าไม่มีหรือว่างเปล่า: รัน `/follow-lefthook`
3. ตรวจสอบว่า `scripts/githooks/` มี TypeScript scripts ที่จำเป็น
4. รัน `bunx lefthook install` เพื่อติดตั้ง hooks

### 2. Determine Commit Scope

ตรวจสอบว่า `/commit` ถูกเรียกจาก workflow อื่นหรือรันโดยตรง

1. ตรวจสอบว่ามีไฟล์ workflows ที่ถูกแก้ไขใน git status
2. ถ้ามีไฟล์ workflows: commit เฉพาะไฟล์ใน `.windsurf/workflows/` และ `.windsurf/skills/`
3. ถ้าไม่มีไฟล์ workflows: commit ทุกไฟล์ที่มีการเปลี่ยนแปลง

### 3. Check Git Status

ตรวจสอบสถานะไฟล์ที่มีการเปลี่ยนแปลง

1. รัน `git status --porcelain` เพื่อดูไฟล์ที่มีการแก้ไข
2. จัดกลุ่มไฟล์ตามประเภทการเปลี่ยนแปลง (modified, new, deleted)
3. ตรวจสอบว่าไม่มีไฟล์ที่ไม่ควร commit (เช่น node_modules, .env)

### 4. Group Files by Scope

จัดกลุ่มไฟล์ตาม conventional commit scope

1. แยกไฟล์ตาม directory และ module (เช่น auth, booking, dashboard, shared)
2. จัดกลุ่มไฟล์ที่เกี่ยวข้องกันให้อยู่ใน commit เดียวกัน
3. ใช้ `git diff --stat` เพื่อดู overview ของการเปลี่ยนแปลง

### 5. Stage Files

จัดเตรียมไฟล์สำหรับ commit

1. ใช้ `git add <files>` หรือ `git add -p` เพื่อ stage ไฟล์ตาม scope
2. ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วน: ใช้ `git add -p` เพื่อ stage เฉพาะส่วนที่เกี่ยวข้อง
3. ตรวจสอบด้วย `git diff --cached` ว่าไฟล์ที่ stage ถูกต้อง

### 6. Determine Commit Type

เลือก conventional commit type ที่เหมาะสม

1. feat: ฟีเจอร์ใหม่หรือการเพิ่ม functionality
2. fix: แก้ไข bug
3. docs: เปลี่ยนแปลงเอกสารเท่านั้น
4. style: แก้ไข code style (formatting, semicolons) โดยไม่เปลี่ยน logic
5. refactor: refactor code โดยไม่เพิ่ม feature หรือแก้บั๊ก
6. perf: ปรับปรุง performance
7. test: เพิ่มหรือแก้ไข tests
8. chore: เปลี่ยนแปลง build process, dependencies, configuration

### 7. Write Commit Message

เขียน commit message ตาม conventional commits format

1. ใช้รูปแบบ `<type>(<scope>): <subject>`
2. subject สั้นกระชับไม่เกิน 72 ตัวอักษร
3. ใช้ imperative mood (เช่น add ไม่ใช่ added)
4. ไม่ขึ้นต้นด้วยตัวพิมพ์ใหญ่หรือจบด้วยจุด
5. เพิ่ม body ถ้าจำเป็นเพื่ออธิบาย context หรือเหตุผล

### 8. Execute Commit

ดำเนินการ commit

1. รัน `git commit -m "<message>"` หรือ `git commit` เพื่อเปิด editor
2. ตรวจสอบผลลัพธ์จาก git commit
3. ถ้ามี error: แก้ไขแล้วลองอีกครั้ง
4. ถ้าสำเร็จ: ทำซ้ำขั้นตอน 2-8 จนกว่าไม่มีไฟล์ที่ยังไม่ commit

### 9. Verify Commits

ตรวจสอบความถูกต้องของ commits

1. รัน `git log --oneline -5` เพื่อดู commits ล่าสุด
2. ตรวจสอบว่า commit messages สอดคล้องกับ conventional commits
3. ตรวจสอบว่าไม่มีไฟล์ที่ยังไม่ commit เหลืออยู่
4. รัน `git status` เพื่อยืนยันว่า working directory สะอาด

## Rules

1. Commit Message Format

- ใช้รูปแบบ `<type>(<scope>): <subject>`
- subject ไม่ต้องขึ้นต้นด้วยตัวพิมพ์ใหญ่หรือจบด้วยจุด
- สั้นกระชับไม่เกิน 72 ตัวอักษร
- ใช้ imperative mood (เช่น add ไม่ใช่ added)
- ใช้ภาษาอังกฤษหรือไทยให้สม่ำเสมอ

2. Commit Types

- feat: ฟีเจอร์ใหม่
- fix: แก้ไขบั๊ก
- docs: เปลี่ยนแปลงเอกสาร
- style: แก้ไข code style (formatting, semicolons)
- refactor: refactor code โดยไม่เพิ่ม feature หรือแก้บั๊ก
- perf: ปรับปรุง performance
- test: เพิ่มหรือแก้ไข tests
- chore: เปลี่ยนแปลง build process, dependencies

3. Scope (ถ้ามี)

- ระบุส่วนของโปรเจกต์ที่ถูกแก้ไข
- เช่น: api, ui, db, config, deps, auth, test, docs, ci

4. Split Commits

- แยก commit สำหรับการเปลี่ยนแปลงหลายส่วนในไฟล์เดียว
- commit ทีละส่วนจนกว่าจะหมด
- แต่ละ commit ควบคุม scope เดียว
- ใช้ `git add -p` หรือ `git add <file>` เพื่อเลือกเฉพาะส่วนที่ต้องการ

5. Body (ถ้าจำเป็น)

- อธิบายเหตุผลและ context
- แยกจาก subject ด้วยบรรทัดว่าง
- ใช้ bullet points สำหรับหลายรายการ

6. Workflow Context

- ถ้าถูกเรียกจาก workflow อื่น: commit เฉพาะไฟล์ workflows
- ถ้ารันโดยตรง: commit ทุกไฟล์ที่เปลี่ยนแปลงจนไม่มีเหลือ

## Expected Outcome

1. Commit messages ที่สอดคล้องกับ conventional commits
2. Git history ที่อ่านง่ายและติดตามง่าย
3. Commit แยกตาม scope อย่างเหมาะสม
4. ไม่มีไฟล์ที่ยังไม่ commit เหลืออยู่
