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
  - /resolve-errors
  - /refactor
  - /edit-relative
  - /plan
---

## Goal

ทำตาม execution guidelines ทุกครั้งเพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope

ใช้สำหรับทุก workspace ในการทำงานทุก task

## Execute

### 1. Prepare Workspace

ตั้งค่าและเตรียม workspace ก่อนเริ่ม task

1. ทำ `/follow-agents-md` ก่อนแก้ไขไฟล์สำหรับ task ใหม่
2. การทำงานกับไฟล์ทุกอย่างต้องทำ `/edit-relative`
3. ใช้ `"."` สำหรับ `/continue` หรือ `/try-again`

### 2. Read References

อ่าน references ก่อนเริ่มทำงาน

1. ทำ `/read-related-workflows` เพื่ออ่าน workflows ที่เกี่ยวข้องทั้งหมดก่อนเริ่มทำงาน
2. ทำ `/follow-workflows` เพื่ออ่านและทำตาม workflows ทั้ง global และ project
3. ทำ `/follow-skills` เพื่ออ่านและใช้ skills ที่เหมาะสมกับ task

### 3. Analyze And Plan

วิเคราะห์และวางแผนงาน

1. ใช้ `/use-scripts` สำหรับการวิเคราะห์
2. ทำ `/plan` ก่อนแก้ไขไฟล์จำนวนมาก
3. ถ้ามี error ให้ทำ `/resolve-errors` แก้เฉพาะสิ่งที่เกิดขึ้น ไม่แก้เกินความจำเป็น

### 4. Search Code

ค้นหา code patterns, symbols, หรือ references

1. ทำ `/code-search`

### 5. Write Code

เขียนและแก้ไข code ตามมาตรฐาน

1. ทำ `/refactor` ก่อนเขียน code
2. ทำ `/follow-architecture` เมื่อแก้ไข
3. Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
4. ยังทำไม่เสร็จให้ comment `// TODO`
5. ห้าม mock หรือ TODO โดยไม่จำเป็น

### 6. Iterate And Complete

ทำซ้ำจน implement เสร็จ

1. ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จ
2. กลับไปตรวจสอบ planning เรื่อยๆ

### 7. Report And Communicate

รายงานผลลัพธ์และสื่อสาร

1. ทำตาม `/report`
2. คุยกับผู้ใช้เป็นภาษาไทย กระชับ ตรงประเด็น

## Rules

### 1. Automation Standards

- ใช้ `Bun shell` สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ

### 2. Execution Consistency

- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน

### 3. File Limits

- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
- Execution ที่ให้ผลลัพธ์เหมือนกันทุกครั้งและคาดเดาได้
