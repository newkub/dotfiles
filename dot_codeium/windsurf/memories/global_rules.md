---

title: Global Rules

description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace

auto_execution_mode: 3

---

## Goal

ทำตามกฎเหล่านี้ในทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Scope

ใช้สำหรับทุก workspace ในการพัฒนาโปรเจกต์

## Execute

### 1. Prepare

1. ทำ `/follow-agents-md` เสมอ
2. ทำ `/ship-code` เพื่อ ship code ครบวงจร
3. ตั้งค่า workspace ด้วย `/setup-tasks`
4. ดู reference ก่อน setup ด้วย `/follow-windsurf-global-workflows`
5. เปลี่ยน config หรือใช้ workflows `run-` ด้วย `/follow-config`
6. File operation ใดๆ ต้องทำ `/edit-relative`
7. `"."` = `/continue` หรือ `/try-again`

### 2. Analyze

1. ทำ `/analyze-project` ด้วย `/use-scripts`
2. เมื่อได้รับ error ทำตาม `/error`
3. ถ้า error มาจากคำสั่งที่ผู้ใช้รันเอง แก้ไขเฉพาะ error นั้น
4. ถ้าแค่ส่ง errors โดยไม่บอกอะไรเพิ่มเติม หรือไม่ได้เกิดจากการรัน workflows ให้ทำ `/only-fix-errors` เท่านั้น

### 3. Read Reference

1. เมื่อได้รับ user prompt อ่าน reference ก่อนเสมอ (workflows, skills, global rules)
2. วิเคราะห์และ planning ตาม reference
3. ลดเวลาโดยไม่ต้องค้นหาข้อมูลซ้ำ

### 4. Search Code

1. เมื่อต้องค้นหา code patterns, symbols, หรือ references ทำ `/search-code`
2. ใช้ `Grep` สำหรับ text search และ `find_by_name` สำหรับ file search
3. กำหนด scope ด้วย `type`, `glob`, หรือ `path`
4. วิเคราะห์และ verify ผลลัพธ์

### 5. Planning

1. แก้ไข workflows ด้วย `/follow-write-workflows`
2. แก้ไข skills ด้วย `/follow-write-skills`

### 6. Write

1. ก่อนเขียน code ทำ `/follow-principles-engineering`
2. แก้ไขอะไร ทำ `/follow-architecture`
3. แก้ไขไฟล์จำนวนมาก ทำ `/plan` ก่อน
4. Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
5. ยังทำไม่เสร็จ comment `// TODO`
6. ไม่ mock หรือ TODO โดย default

### 7. Reflex

1. ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จ
2. กลับไป check planning เรื่อยๆ

### 8. Report

1. ทำตาม `/report`
2. เมื่อจบ task รัน `/suggest-next-action`
3. คุยกับผู้ใช้เป็นภาษาไทย
4. คำตอบกระชับ ตรงประเด็น

## Rules

### 1. Tool Selection

เลือก tools ที่เหมาะสมสำหรับ automation

- ใช้ `Bun shell` สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ

### 2. Workspace Standards

รักษามาตรฐานในทุก workspace

- ทุก workspace ต้องมี scripts มาตรฐาน
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน
- ไม่ใช้คำสั่ง subjective หรือ ambiguous

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
