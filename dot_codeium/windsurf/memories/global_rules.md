---
title: Follow Execution
description: Execution guidelines สำหรับการทำงานทุก task ตามมาตรฐาน
auto_execution_mode: 3
related_workflows:
  - /ship-run
  - /follow-workflows
  - /follow-skills
  - /follow-content-quality
  - /follow-config
  - /follow-agents-md
  - /search-code
  - /plan
  - /loop-until-complete
  - /report
  - /suggest-next-action
---

## Goal

ทำตาม execution guidelines ทุกครั้งเพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope

ใช้สำหรับทุก workspace ในการทำงานทุก task

## Execute

### 1. Prepare Workspace

ตั้งค่าและเตรียม workspace ก่อนเริ่ม task

- ทำ `/ship-run` เพื่อ ship code ครบวงจร ทดสอบคุณภาพ และรัน development server
- ดู tech stack ด้วย `/follow-my-tech-stack`
- เปลี่ยน config หรือใช้ workflows `run-` ด้วย `/follow-config`
- File operation ใดๆ ต้องทำ `/edit-relative`
- `"."` = `/continue` หรือ `/try-again`
- ก่อนแก้ไขไฟล์สำหรับ task ใหม่ ทำ `/follow-agents-md` เสมอ

### 2. Read References

อ่าน references ก่อนเริ่มทำงาน

- ทำ `/follow-workflows` เพื่ออ่านและทำตาม workflows ทั้ง global และ project
- ทำ `/follow-skills` เพื่ออ่านและใช้ skills ที่มีอยู่ตามที่เหมาะสม
- ทำ `/read-related-workflows` เพื่ออ่านและสรุป workflows ที่เกี่ยวข้องแบบ recursive

### 3. Analyze And Plan

วิเคราะห์และวางแผนงาน

- เวลา analyze อะไร ให้ใช้ `/use-bun-shell` + `/use-ast-grep` เสมอ
- ทำ `/analyze-project` ด้วย `/use-scripts`
- เมื่อได้รับ error ทำตาม `/error`
- ถ้า error มาจากคำสั่งที่ผู้ใช้รันเอง แก้ไขเฉพาะ error นั้น
- ถ้าแค่ส่ง errors โดยไม่บอกอะไรเพิ่มเติม หรือไม่ได้เกิดจากการรัน workflows ให้ทำ `/only-fix-errors` เท่านั้น
- แก้ไขไฟล์จำนวนมาก ทำ `/plan` ก่อน

### 4. Search Code

ค้นหา code patterns, symbols, หรือ references

- เมื่อต้องค้นหา code patterns, symbols, หรือ references ทำ `/search-code`
- ใช้ `Grep` สำหรับ text search และ `find_by_name` สำหรับ file search
- กำหนด scope ด้วย `type`, `glob`, หรือ `path`

### 5. Write Code

เขียนและแก้ไข code ตามมาตรฐาน

- ก่อนเขียน code ทำ `/follow-principles-engineering`
- แก้ไขอะไร ทำ `/follow-architecture`
- Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
- ยังทำไม่เสร็จ comment `// TODO`
- ไม่ mock หรือ TODO โดย default
- ถ้าเขียน .md ให้ดู `/use-markdown` เพื่อใช้ format ที่เหมาะสม

### 6. Iterate And Complete

ทำซ้ำจน implement เสร็จ

- ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จ
- กลับไป check planning เรื่อยๆ

### 7. Report And Communicate

รายงานผลลัพธ์และสื่อสาร

- ทำตาม `/report`
- เมื่อจบ task รัน `/suggest-next-action`
- คุยกับผู้ใช้เป็นภาษาไทย
- คำตอบกระชับ ตรงประเด็น

## Rules

- ทำตาม `/follow-content-quality` สำหรับคุณภาพเนื้อหา
- ใช้ `Bun shell` สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ
- ทุก workspace ต้องมี scripts มาตรฐาน
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน
- ไม่ใช้คำสั่ง subjective หรือ ambiguous
- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด
- ถ้าไฟล์ยาวเกิน 250 บรรทัด ให้ refactor และ grouping ให้เหมาะสม

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
