---
title: Commit Guidelines
description: แนวทางการสร้าง commit ตามมาตรฐาน conventional commits
auto_execution_mode: 3
---

## Goal

สร้าง commit message ตามมาตรฐาน conventional commits

## Execute

### 1. Determine Commit Mode

ตรวจสอบว่า `/commit` ถูกเรียกจาก workflow อื่นหรือรันโดยตรง

1. ตรวจสอบ context ว่าถูกเรียกจาก workflow อื่น (เช่น `/refactor`, `/make-real`, `/ship-run`, `/enhance-codebase`)
2. ถ้าถูกเรียกจาก workflow: ใช้ workflow mode
3. ถ้ารันโดยตรง: ใช้ standalone mode

### 2. Setup Gitignore

ตรวจสอบและตั้งค่า .gitignore ให้ครอบคลุม

1. ทำตาม `/follow-gitignore`

### 3. Workflow Mode

Commit เฉพาะบรรทัดที่ workflow แก้ไป

1. ระบุไฟล์และบรรทัดที่ workflow แก้ไปจาก context
2. ใช้ `git add -p` เพื่อ stage เฉพาะบรรทัดที่ workflow แก้ไป
3. ตรวจสอบด้วย `git diff --cached` ว่าเฉพาะส่วนที่ workflow แก้ไปถูก stage
4. ข้ามไปขั้นตอนที่ 9 Execute Commit

### 4. Standalone Mode

Commit all ทั้งหมดจนไม่มีเหลือ

1. รัน `git status --porcelain` เพื่อดูไฟล์ที่มีการแก้ไขทั้งหมด
2. จัดกลุ่มไฟล์ตามประเภทการเปลี่ยนแปลง
3. ตรวจสอบว่าไม่มีไฟล์ที่ไม่ควร commit

### 5. Group Files by Scope

จัดกลุ่มไฟล์ตาม conventional commit scope

1. แยกไฟล์ตาม directory และ module
2. จัดกลุ่มไฟล์ที่เกี่ยวข้องกันให้อยู่ใน commit เดียวกัน
3. ใช้ `git diff --stat` เพื่อดู overview ของการเปลี่ยนแปลง
4. Split commits ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วนหรือหลาย scopes

### 6. Stage Files

จัดเตรียมไฟล์สำหรับ commit

1. ใช้ `git add <files>` หรือ `git add -p` เพื่อ stage ไฟล์ตาม scope
2. ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วน: ใช้ `git add -p` เพื่อ stage เฉพาะส่วนที่เกี่ยวข้อง
3. ตรวจสอบด้วย `git diff --cached` ว่าไฟล์ที่ stage ถูกต้อง

### 7. Determine Commit Type

เลือก conventional commit type ที่เหมาะสม

1. ดู Rules ส่วน Commit Types

### 8. Write Commit Message

เขียน commit message ตาม conventional commits format

1. ดู Rules ส่วน Commit Message Format และ Body

### 9. Execute Commit

ดำเนินการ commit

1. รัน `git commit -m "<message>"` หรือ `git commit`
2. ตรวจสอบผลลัพธ์จาก git commit
3. ถ้ามี error: แก้ไขแล้วลองอีกครั้ง
4. ถ้าสำเร็จและเป็น standalone mode: ทำซ้ำขั้นตอน 4-9
5. ถ้าสำเร็จและเป็น workflow mode: จบการทำงาน

### 10. Verify Commits

ตรวจสอบความถูกต้องของ commits

1. รัน `git log --oneline -5` เพื่อดู commits ล่าสุด
2. ตรวจสอบว่า commit messages สอดคล้องกับ conventional commits
3. ตรวจสอบว่าไม่มีไฟล์ที่ยังไม่ commit เหลืออยู่
4. รัน `git status` เพื่อยืนยันว่า working directory สะอาด

## Rules

### Commit Message Format

ใช้รูปแบบ conventional commits

- ใช้รูปแบบ `<type>(<scope>): <subject>`
- subject ไม่ต้องขึ้นต้นด้วยตัวพิมพ์ใหญ่หรือจบด้วยจุด
- สั้นกระชับไม่เกิน 72 ตัวอักษร
- ใช้ imperative mood (เช่น add ไม่ใช่ added)
- ใช้ภาษาอังกฤษหรือไทยให้สม่ำเสมอ

### Commit Types

เลือก type ที่เหมาะสมกับการเปลี่ยนแปลง

- feat: ฟีเจอร์ใหม่
- fix: แก้ไขบั๊ก
- docs: เปลี่ยนแปลงเอกสาร
- style: แก้ไข code style
- refactor: refactor code โดยไม่เพิ่ม feature หรือแก้บั๊ก
- perf: ปรับปรุง performance
- test: เพิ่มหรือแก้ไข tests
- chore: เปลี่ยนแปลง build process, dependencies

### Scope

ระบุส่วนของโปรเจกต์ที่ถูกแก้ไข

- ระบุส่วนของโปรเจกต์ที่ถูกแก้ไข
- เช่น: api, ui, db, config, deps, auth, test, docs, ci

### Split Commits

แยก commit สำหรับการเปลี่ยนแปลงหลายส่วน

- แยก commit สำหรับการเปลี่ยนแปลงหลายส่วนในไฟล์เดียว
- commit ทีละส่วนจนกว่าจะหมด
- แต่ละ commit ควบคุม scope เดียว
- ใช้ `git add -p` หรือ `git add <file>` เพื่อเลือกเฉพาะส่วนที่ต้องการ

### Body

อธิบายเหตุผลและ context เพิ่มเติม

- อธิบายเหตุผลและ context
- แยกจาก subject ด้วยบรรทัดว่าง
- ใช้ bullet points สำหรับหลายรายการ

### Workflow Mode

ใช้เมื่อถูกเรียกจาก workflow อื่น

- ใช้เมื่อถูกเรียกจาก workflow อื่น (เช่น `/refactor`, `/make-real`, `/ship-run`, `/enhance-codebase`)
- Commit เฉพาะบรรทัดที่ workflow แก้ไป (ใช้ `git add -p`)
- ไม่ commit ไฟล์อื่นๆ ที่ไม่ได้ถูกแก้ไปโดย workflow

### Standalone Mode

ใช้เมื่อรัน `/commit` เดียวๆ

- ใช้เมื่อรัน `/commit` เดียวๆ
- Commit all ทั้งหมดจนไม่มีเหลือ
- Split commits ได้ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วนหรือหลาย scopes
- ใช้ `git add -p` เพื่อ stage เฉพาะส่วนที่ต้องการในแต่ละ commit

## Expected Outcome

1. Commit messages ที่สอดคล้องกับ conventional commits
2. Git history ที่อ่านง่ายและติดตามง่าย
3. Commit แยกตาม scope อย่างเหมาะสม
4. ไม่มีไฟล์ที่ยังไม่ commit เหลืออยู่
