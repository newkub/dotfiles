---
title: Commit
description: Commit ไฟล์ที่มีการเปลี่ยนแปลงตามมาตรฐาน conventional commits
auto_execution_mode: 3
related_workflows:
  - /follow-gitignore
  - /follow-lefthook
  - /follow-config
  - /update-project
---

## Goal

Commit ไฟล์ที่มีการเปลี่ยนแปลงตามมาตรฐาน conventional commits โดยรองรับ split commit ตามประเภทของการเปลี่ยนแปลง

## Scope

ใช้สำหรับ commit ไฟล์ที่มีการเปลี่ยนแปลง โดย:
- Split Commit: แยก commit ตามประเภทของไฟล์ (docs, config, code, etc.)
- Single Commit: commit เฉพาะไฟล์ที่ task แก้ไป
- ใช้ `git add <files>` หรือ `git add -p` เสมอ ไม่ใช้ `git add .`

## Execute

### 1. Setup Prerequisites

ตรวจสอบและตั้งค่า prerequisites ก่อน commit

1. ทำตาม `/follow-gitignore` สำหรับ .gitignore
2. ทำตาม `/follow-lefthook` สำหรับ Git hooks
3. ทำตาม `/follow-config` สำหรับ configuration

### 2. Update Project

อัปเดต project documentation และ configuration ก่อน commit (ถ้า commit ทั้งหมด)

1. ทำตาม `/update-project` เพื่ออัปเดต .devin structure, README, AGENTS.md, และ documentation
2. Stage ไฟล์ที่ถูกอัปเดตด้วย `git add <files>`
3. ตรวจสอบด้วย `git diff --cached` ว่าไฟล์ถูก stage ถูกต้อง

### 3. Categorize Changes

จัดกลุ่มไฟล์ที่มีการเปลี่ยนแปลงตามประเภท

1. รัน `git status --porcelain` เพื่อดูไฟล์ที่มีการแก้ไขทั้งหมด
2. รัน `Get-ChildItem -Recurse -File | Sort-Object LastWriteTime -Descending | Select-Object -First 10` (Windows) หรือ `find . -type f -printf '%T@ %p\n' | sort -n | tail -10` (Unix) เพื่อดูไฟล์ที่ถูกแก้ล่าสุดตามเวลา
3. จัดกลุ่มไฟล์ตามประเภท:
   - docs: README.md, docs/, *.md
   - config: package.json, tsconfig.json, biome.jsonc, .gitignore, lefthook.yml
   - code: src/, lib/, packages/
   - test: test/, *.test.ts, *.spec.ts
   - chore: scripts/, tools/, build files
4. ระบุไฟล์ที่ task แก้ไปจาก context สำหรับ single commit mode

### 4. Review File Changes

ดู actual changes ของไฟล์ที่จะ commit เพื่อให้ commit message ตรงมากขึ้น

1. รัน `git diff` เพื่อดู changes ที่ยังไม่ได้ commit
2. รัน `git diff --cached` เพื่อดู changes ที่ staged แล้ว
3. รัน `git diff <file>` เพื่อดู changes ของไฟล์เฉพาะ
4. วิเคราะห์ changes เพื่อเข้าใจสิ่งที่เปลี่ยนแปลงจริงๆ

### 5. Stage Changes By Category

Stage ไฟล์ตามประเภทสำหรับ split commit

สำหรับ Split Commit (แนะนำ):
1. Stage ไฟล์ตามประเภททีละกลุ่ม
2. ใช้ `git add -p` ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วน
3. ตรวจสอบด้วย `git diff --cached` ว่าไฟล์ที่ stage ถูกต้อง

สำหรับ Single Commit (เฉพาะไฟล์ที่ task แก้ไป):
1. ระบุไฟล์ที่ task แก้ไปจาก context
2. ใช้ `git add <files>` เพื่อ stage เฉพาะไฟล์ที่ task แก้ไป
3. ใช้ `git add -p` ถ้าไฟล์มีการเปลี่ยนแปลงหลายส่วน
4. ตรวจสอบด้วย `git diff --cached` ว่าเฉพาะส่วนที่ task แก้ไปถูก stage

### 6. Determine Commit Type

เลือก conventional commit type ที่เหมาะสม

1. ดู Rules ส่วน Commit Types

### 7. Write Commit Message

เขียน commit message ตาม conventional commits format

1. ดู Rules ส่วน Commit Message Format และ Body

### 8. Execute Commit

ดำเนินการ commit

1. รัน `git commit -m "<message>"` หรือ `git commit`
2. ตรวจสอบผลลัพธ์จาก git commit
3. ถ้ามี error: แก้ไขแล้วลองอีกครั้ง

### 9. Verify Commits

ตรวจสอบความถูกต้องของ commits

1. รัน `git log --oneline -5` เพื่อดู commits ล่าสุด
2. ตรวจสอบว่า commit messages สอดคล้องกับ conventional commits
3. ตรวจสอบว่าไม่มีไฟล์ที่ยังไม่ commit เหลืออยู่ (สำหรับ commit ทั้งหมด)
4. รัน `git status` เพื่อยืนยันว่า working directory สะอาด (สำหรับ commit ทั้งหมด)

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

### Body

อธิบายเหตุผลและ context เพิ่มเติม

- อธิบายเหตุผลและ context
- แยกจาก subject ด้วยบรรทัดว่าง
- ใช้ bullet points สำหรับหลายรายการ

## Expected Outcome

1. Commit messages ที่สอดคล้องกับ conventional commits
2. Git history ที่อ่านง่ายและติดตามง่าย
3. Commits แยกตามประเภทของไฟล์ (docs, config, code, test, chore)
4. ไฟล์ที่มีการเปลี่ยนแปลงถูก commit ตามที่ต้องการ
5. Working directory สะอาด (สำหรับ commit ทั้งหมด)
