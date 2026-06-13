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

- ทำ `/ship-run` เพื่อ ship code ครบวงจร ทดสอบคุณภาพ และรัน development server
  - อ่าน `/ship-run` ให้ครบรวมถึงใน workflows ที่เชื่อม (`/ship-code`, `/run-verify`, `/run-dev`)
  - ทำตามนั้นให้ครบทุกครั้ง
- ตั้งค่า workspace ด้วย `/follow-tasks`
- ดู reference ก่อน setup ด้วย `/follow-windsurf-global-workflows`
- ดู tech stack ด้วย `/follow-my-tech-stack`
- เปลี่ยน config หรือใช้ workflows `run-` ด้วย `/follow-config`
- File operation ใดๆ ต้องทำ `/edit-relative`
- `"."` = `/continue` หรือ `/try-again`
- ก่อนแก้ไขไฟล์สำหรับ task ใหม่ ทำ `/follow-agents-md` เสมอ

### 2. Analyze

- เวลา analyze อะไร ให้ใช้ `/use-bun-shell` + `/use-ast-grep` เสมอ
- ทำ `/analyze-project` ด้วย `/use-scripts`
- เมื่อได้รับ error ทำตาม `/error`
- ถ้า error มาจากคำสั่งที่ผู้ใช้รันเอง แก้ไขเฉพาะ error นั้น
- ถ้าแค่ส่ง errors โดยไม่บอกอะไรเพิ่มเติม หรือไม่ได้เกิดจากการรัน workflows ให้ทำ `/only-fix-errors` เท่านั้น

### 3. Read Reference

- เมื่อได้รับ user prompt อ่าน reference ก่อนเสมอ (workflows, skills, global rules)
- ทำ `/read-related-workflows` เพื่ออ่านและสรุป workflows ที่เกี่ยวข้องแบบ recursive
- วิเคราะห์และ planning ตาม reference
- ลดเวลาโดยไม่ต้องค้นหาข้อมูลซ้ำ

### 4. Search Code

- เมื่อต้องค้นหา code patterns, symbols, หรือ references ทำ `/search-code`
- ใช้ `Grep` สำหรับ text search และ `find_by_name` สำหรับ file search
- กำหนด scope ด้วย `type`, `glob`, หรือ `path`
- วิเคราะห์และ verify ผลลัพธ์

### 5. Planning

- แก้ไข workflows ด้วย `/write-windsurf-global-workflows`
- แก้ไข skills ด้วย `/write-windsurf-skills`
- เมื่อสร้าง global workflow ใหม่ ถ้าสามารถนำไปใช้ใน global workflows อื่นได้ให้ทำเลย

### 6. Write

- ก่อนเขียน code ทำ `/follow-principles-engineering`
- แก้ไขอะไร ทำ `/follow-architecture`
- แก้ไขไฟล์จำนวนมาก ทำ `/plan` ก่อน
- Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
- ยังทำไม่เสร็จ comment `// TODO`
- ไม่ mock หรือ TODO โดย default
- ถ้าเขียน .md ให้ดู `/use-markdown` เพื่อใช้ format ที่เหมาะสม

### 7. Reflex

- ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จ
- กลับไป check planning เรื่อยๆ

### 8. Report

- ทำตาม `/report`
- เมื่อจบ task รัน `/suggest-next-action`
- คุยกับผู้ใช้เป็นภาษาไทย
- คำตอบกระชับ ตรงประเด็น

## Rules

### 1. Tool Selection

- ใช้ `Bun shell` สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ

### 2. Workspace Standards

- ทุก workspace ต้องมี scripts มาตรฐาน
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน
- ไม่ใช้คำสั่ง subjective หรือ ambiguous

### 3. File Standards

- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด
- ถ้าไฟล์ยาวเกิน 250 บรรทัด ให้ refactor และ grouping ให้เหมาะสม

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
