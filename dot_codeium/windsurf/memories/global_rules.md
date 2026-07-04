---
title: Follow Execution
description: Execution guidelines สำหรับการทำงานทุก task ตามมาตรฐาน
auto_execution_mode: 3
related_workflows:
  - /follow-workflows
  - /follow-skills
  - /follow-agents-md
  - /read-related-workflows
  - /report
  - /use-scripts
  - /code-search
---

## Goal

ทำตาม execution guidelines ทุกครั้งเพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope

ใช้สำหรับทุก workspace ในการทำงานทุก task

## Execute

### 1. Prepare Workspace

ตั้งค่าและเตรียม workspace ก่อนเริ่ม task

- ทำ `/follow-agents-md` ก่อนแก้ไขไฟล์สำหรับ task ใหม่
- การทำงานกับไฟล์ทุกอย่างต้องทำ `/edit-relative`
- ใช้ `"."` สำหรับ `/continue` หรือ `/try-again`

### 2. Read References

อ่าน references ก่อนเริ่มทำงาน

- ทำ `/read-related-workflows` เพื่ออ่าน workflows ที่เกี่ยวข้องทั้งหมดก่อนเริ่มทำงาน
- ทำ `/follow-workflows` เพื่ออ่านและทำตาม workflows ทั้ง global และ project
- ทำ `/follow-skills` เพื่ออ่านและใช้ skills ที่เหมาะสมกับ task

### 3. Analyze And Plan

วิเคราะห์และวางแผนงาน

- ใช้ `/use-scripts` สำหรับการวิเคราะห์
- ทำ `/plan` ก่อนแก้ไขไฟล์จำนวนมาก
- แก้ไข error เฉพาะสิ่งที่เกิดขึ้น ไม่แก้เกินความจำเป็น

### 4. Search Code

ค้นหา code patterns, symbols, หรือ references

- ทำ `/code-search`

### 5. Write Code

เขียนและแก้ไข code ตามมาตรฐาน

- ทำ `/refactor` ก่อนเขียน code
- ทำ `/follow-architecture` เมื่อแก้ไข
- Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
- ยังทำไม่เสร็จให้ comment `// TODO`
- ห้าม mock หรือ TODO โดยไม่จำเป็น

### 6. Iterate And Complete

ทำซ้ำจน implement เสร็จ

- ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จ
- กลับไปตรวจสอบ planning เรื่อยๆ

### 7. Report And Communicate

รายงานผลลัพธ์และสื่อสาร

- ทำตาม `/report`
- คุยกับผู้ใช้เป็นภาษาไทย กระชับ ตรงประเด็น

## Rules

- ใช้ `Bun shell` สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน
- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
- Execution ที่ให้ผลลัพธ์เหมือนกันทุกครั้งและคาดเดาได้
