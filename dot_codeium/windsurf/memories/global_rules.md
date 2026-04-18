---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Definitions

- global rules หมายถึงไฟล์นี้ `c:\Users\Veerapong\.codeium\windsurf\memories\global_rules.md`
- global workflows หมายถึง `C:\Users\Veerapong\.codeium\windsurf\global_workflows`
- mcp หมายถึง `C:\Users\Veerapong\.codeium\windsurf\mcp_config.json`

## Execute

### 1. Prepare

เตรียมความพร้อมก่อนเริ่มงาน

1. ใช้ bun แทน npm เสมอ
2. ใช้ git สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ pwsh
3. รัน `/watch-browser` ทันทีเมื่อได้รับ URL
4. ทำ `/analyze-project` ก่อนเริ่มงานทุกครั้ง
5. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
6. "." หมายถึงให้ทำ `/continue`
7. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน

### 2. Analyze

วิเคราะห์โปรเจกต์และความต้องการก่อนเริ่มทำงาน

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. ใช้ `/write-ast-grep-rules` เพื่อตรวจสอบ code patterns ด้วย AST-based matching
3. ทำตาม `/fix-error` เมื่อได้รับ error
4. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`

### 3. Planning

วางแผนงานก่อนดำเนินการ

1. ใช้ `/plan` สำหรับการวางแผนงานครอบคล้ว
2. พยายามทำให้ `/make-real` ในทุกๆเลย
3. ทำตาม `/follow-write-workflows` เมื่อแก้ไขไฟล์ workflows
4. ทำตาม `/follow-write-skills` เมื่อแก้ไขไฟล์ skills

### 4. Execute

ดำเนินการตามกฎที่กำหนดอย่างเคร่งครัด

1. อ่าน `/refactor` และ `/do-not` ก่อนเขียน code ทุกครั้ง แล้วนำตามนั้น
2. รัน `/watch-browser` เมื่อ execute ต้องเปิด web
3. ทำ `/update-reference` เสมอสำหรับ file operations ไม่ว่าจะทำที่ใดๆ เช่น project, global workflows, skills, global rules, etc.
4. ทำตาม `/write-test` เสมอเมื่อเขียน code
5. ไม่ mock, ไม่ TODO โดย default แต่ถ้าจำเป็นจริงๆ ต้อง comment `// MOCK` หรือ `// TODO`
6. mock data ให้แยกออกไปในโฟลเดอร์ `mock/` แล้วนำมาใช้
7. ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ

### 5. Reflex

ทำการ refactor หลังจาก execute เสร็จเสมอ

1. ทำ `/refactor` เสมอหลังจาก execute เสร็จ
2. กลับไป check ข้อ 2 planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Documentation

อัพเดทเอกสารให้สอดคล้องกับการเปลี่ยนแปลง

1. ใช้ `/update-readme` ถ้ามีการเปลี่ยนแปลงที่ต้องอัพเดทเอกสาร
2. ใช้ `/write-docs` สำหรับสร้างหรืออัพเดทเอกสารประกอบโครงสร้างโปรเจกต์

### 7. Report

สรุปและรายงานผล

1. ทำตาม `/report`
2. เมื่อจบ task หลัง commit ให้รัน `/suggest-next-action` เสมอ

## Rules

### 1. Communication

กฎการสื่อสารกับผู้ใช้

- คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
- ให้คำตอบกระชับ ตรงประเด็น
- หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น
- ถ้า user prompt มีคำว่า "ต้อง", "ห้าม", "ไม่ใช้" ให้บันทึกสิ่งนั้นไปใน memories ด้วย

### 2. Development Workflow

ขั้นตอนการพัฒนาตามลำดับที่กำหนด

- ทำตามลำดับ: Prepare -> Analyze -> Planning -> Execute -> Reflex -> Documentation -> Report
- อ่าน `/refactor` และ `/do-not` ก่อนเขียน code ทุกครั้ง
- ทำตาม `/write-test` เสมอเมื่อเขียน code
- ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment ชัดเจน

### 3. File Operations

การจัดการไฟล์และการอัพเดท references

- ใช้ git สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ pwsh
- ทำ `/update-reference` เสมอสำหรับ file operations ไม่ว่าจะทำที่ใดๆ เช่น project, global workflows, skills, global rules, etc.
- ทุกครั้งที่เปิด url ให้ใช้ `/watch-browser` เสมอ

### 4. Setup

การตั้งค่าและเตรียมความพร้อม

- เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
- ทำตาม `/follow-write-workflows` เมื่อแก้ไขไฟล์ workflows
- ทำตาม `/follow-write-skills` เมื่อแก้ไขไฟล์ skills

### 5. Error Handling

การจัดการและแก้ไขข้อผิดพลาด

- ทำตาม `/fix-error` เมื่อได้รับ error
- เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`
- วิเคราะห์ root cause ก่อนแก้ไข

### 6. Quality Assurance

การรับประกันคุณภาพและการตรวจสอบ

- ทำ `/refactor` เสมอหลังจาก execute เสร็จ
- กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว
- พยายามทำให้ `/make-real` ในทุกๆเลย
- ก่อนจบทุกครั้ง ต้องรัน `/run-verify` เสมอ

### 7. AST-based Analysis

การวิเคราะห์ code ด้วย AST-based matching

- ใช้ `/write-ast-grep-rules` เพื่อตรวจสอบ code patterns ด้วย AST-based matching
- สร้าง rules จาก AGENTs.md ทุกไฟล์ในโปรเจกต์
- ใช้ meta variables ($VAR) สำหรับ capture AST nodes
- เขียน test cases สำหรับ rules (valid และ invalid)
- รัน `ast-grep test` เพื่อ verify rules
- รัน `ast-grep scan` เพื่อ test กับ codebase

### 8. Workflow Execution

การดำเนินการตาม workflows ที่กำหนด

- ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ
- ติดตามลำดับการทำงานตาม workflow ที่กำหนด
- ห้ามข้ามขั้นตอนใน workflow

## Expected Outcome

- global_rules.md ที่มีโครงสร้างสม่ำเสมอ
- Rules อยู่ใน standalone Rules section
- สอดคล้องกับ `/follow-write-workflows`
