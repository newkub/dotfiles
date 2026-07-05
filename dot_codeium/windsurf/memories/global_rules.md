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
- ถ้ามี error ให้ทำ `/resolve-errors`

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

- กลับไปตรวจสอบ planning เรื่อยๆ

### 7. Report And Communicate

รายงานผลลัพธ์และสื่อสาร

- ทำตาม `/report`
- สื่อสารตาม Rules ที่เกี่ยวกับ Communication

## Rules

- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ระบุลำดับการทำงานชัดเจน
- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด
- Global workflows อาจเขียนสำหรับ ecosystem เฉพาะ (เช่น `Bun`, `Node.js`, `Deno`)
- ถ้า project ใช้ ecosystem อื่น ให้ใช้ `libs`, `tools`, `commands` ของ ecosystem นั้นๆ ที่เหมาะสม
- แปลง tool equivalents อัตโนมัติ (เช่น `bunx` → `npx`, `bun test` → `vitest`, `Bun.file` → `fs/promises`)
- ตรวจสอบ `package.json`, `Cargo.toml`, `go.mod`, ฯลฯ เพื่อระบุ ecosystem ก่อน execute
- ถ้า workflow อ้างถึง tool เฉพาะ ecosystem ให้หา equivalent ของ ecosystem ปัจจุบันแทน
- คุยกับผู้ใช้เป็นภาษาไทย กระชับ ตรงประเด็น
- ไม่เริ่มตอบด้วย acknowledgment phrases (เช่น "You're absolutely right!", "Great idea!")
- รายงานผลลัพธ์เป็น bullet points สั้นๆ ไม่ใช่ paragraphs ยาว
- ไม่ต้องถามผู้ใช้ ให้ทำตามที่แนะนำเลย ยกเว้นกรณีที่มีความเสี่ยงสูง (เช่น ลบไฟล์สำคัญ,  deploy production)
- แก้ที่ root cause ไม่ใช่ symptoms
- ใช้ minimal upstream fixes ไม่ใช่ downstream workarounds
- ห้ามแก้เกินความจำเป็น (no over-fixing)
- ถ้าไม่แน่ใจใน root cause ให้ debug ก่อน ไม่เดาสุ่มแก้
- ทำตาม existing style ของ codebase ไม่เปลี่ยน style เอง
- ห้ามลบหรือเพิ่ม comments โดยไม่จำเป็น
- ห้ามเปลี่ยน code ที่ไม่เกี่ยวข้องกับ task (no unrelated changes)
- ถ้าเป็นไฟล์ใหม่ให้สร้างเฉพาะที่จำเป็น ไม่สร้างไฟล์รบกวน workspace

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
- Execution ที่ให้ผลลัพธ์เหมือนกันทุกครั้งและคาดเดาได้
- ใช้ tools และ libs ของ ecosystem นั้นๆ ได้อย่างเหมาะสม
- แก้ปัญหาที่ root cause ไม่ใช่ symptoms
