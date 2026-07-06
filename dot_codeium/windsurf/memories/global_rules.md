---
title: Global Rules
description: Execution guidelines สำหรับการทำงานทุก task ตามมาตรฐาน
auto_execution_mode: 3
related_workflows:
  - /follow-workflows
  - /follow-skills
  - /read-related-workflows
  - /follow-architecture
  - /follow-content-quality
  - /report
  - /use-scripts
  - /code-search
  - /resolve-errors
  - /refactor
  - /edit-relative
  - /plan
  - /realize-implementation
  - /update-dot-devin
  - /loop-until-complete
  - /run-check
---

## Goal

ทำตาม execution guidelines ทุกครั้งเพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope

ใช้สำหรับทุก workspace ในการทำงานทุก task

## Execute

### 1. Prepare Workspace

ตั้งค่าและเตรียม workspace ก่อนเริ่ม task

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
- ถ้าไฟล์ชื่อขึ้นต้นด้วย `analyze-` ให้ทำ `/deep-analyze-with-use-scripts`
- ถ้ามี error ให้ทำ `/resolve-errors`

### 4. Search Code

ค้นหา code patterns, symbols, หรือ references

- ทำ `/code-search`

### 5. Write Code

เขียนและแก้ไข code ตามมาตรฐาน

- ทำ `/refactor` ก่อนเขียน code
- ทำ `/follow-architecture` เมื่อแก้ไข
- ถ้าแก้ไขไฟล์มากกว่า 10 ไฟล์ ให้ทำ `/use-scripts`
- Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
- ยังทำไม่เสร็จให้ comment `// TODO`
- ห้าม mock หรือ TODO โดยไม่จำเป็น

### 6. Iterate And Complete

ทำซ้ำจน implement เสร็จ

- กลับไปตรวจสอบ planning เรื่อยๆ
- ทำ `/loop-until-complete` เมื่องานต้อง verify จนกว่าจะผ่านเงื่อนไข
- ทำ `/realize-implementation` หลังเสร็จงานเสมอ
- ถ้ามีการเปลี่ยนแปลง package manifest ให้ทำ `/update-dot-devin` เสมอ
- ทำ `/run-check` หลังจาก task เสมอ

### 7. Report And Communicate

รายงานผลลัพธ์และสื่อสาร

- ทำตาม `/report`
- รายงานผลเป็น bullet points สั้นๆ ในภาษาไทย
- ไม่เริ่มตอบด้วย acknowledgment phrases
- ไม่ถามผู้ใช้ยกเว้นกรณีเสี่ยงสูง

## Rules

### Execution Consistency

- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง ระบุลำดับการทำงานชัดเจน
- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด

### Ecosystem Detection

- ตรวจสอบ `package.json`, `Cargo.toml`, `go.mod` เพื่อระบุ ecosystem
- แปลง tool equivalents อัตโนมัติ (เช่น `bunx` → `npx`, `bun test` → `vitest`)

### Communication

- คุยกับผู้ใช้เป็นภาษาไทย กระชับ ตรงประเด็น
- ไม่เริ่มตอบด้วย acknowledgment phrases
- รายงานผลเป็น bullet points สั้นๆ
- ไม่ถามผู้ใช้ยกเว้นกรณีเสี่ยงสูง
- ถ้าผู้ใช้บอกว่า "ขอ idea" ให้ทำ `/request-idea`

### Code Quality

- แก้ที่ root cause ไม่ใช่ symptoms ใช้ minimal upstream fixes
- ห้ามแก้เกินความจำเป็น ถ้าไม่แน่ใจให้ debug ก่อน
- ทำตาม existing style ของ codebase
- ห้ามเปลี่ยน code ที่ไม่เกี่ยวข้อง
- ห้ามลบหรือเพิ่ม comments โดยไม่จำเป็น
- สร้างไฟล์ใหม่เฉพาะที่จำเป็น

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
- ใช้ tools และ libs ของ ecosystem นั้นๆ ได้อย่างเหมาะสม
