---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

## Goal

กำหนดกฎและแนวทางการพัฒนาโปรเจกต์ที่ใช้กับทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

เตรียมความพร้อมก่อนเริ่มงาน

Definitions

- global rules: ไฟล์นี้ `c:\Users\Veerapong\.codeium\windsurf\memories\global_rules.md`
- global workflows: `C:\Users\Veerapong\.codeium\windsurf\global_workflows`
- mcp config: `C:\Users\Veerapong\.codeium\windsurf\mcp_config.json`

Communication Rules

- คุยกับผู้ใช้เป็นภาษาไทยเสมอ
- ให้คำตอบกระชับ ตรงประเด็น
- หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น
- ถ้า user prompt มีคำว่า "ต้อง", "ห้าม", "ไม่ใช้" ให้บันทึกสิ่งนั้นไปใน memories

Tool Preferences

- ใช้ `bun` แทน `npm` เสมอ
- ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `pwsh`

Workflow Shortcuts

- รัน `/watch-browser` ทันทีเมื่อได้รับ URL
- ทำ `/analyze-project` ก่อนเริ่มงานทุกครั้ง
- เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
- `"."` หมายถึงให้ทำ `/continue`

### 2. Analyze

วิเคราะห์โปรเจกต์และความต้องการก่อนเริ่มทำงาน

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. เมื่อได้รับ error ทำตาม `/fix-error`
3. วิเคราะห์ root cause ก่อนแก้ไข
4. เมื่อแก้ไขไม่ได้สักที ลอง `/learn-from-web`

### 3. Planning

วางแผนงานก่อนดำเนินการ

1. อ่าน `/improve-to-ready-code` ก่อน planning เสมอ
2. ใช้ `/plan` สำหรับการวางแผนงานครอบคล้ว
3. พยายามทำให้ `/make-real` เสมอ
4. เมื่อแก้ไขไฟล์ workflows ทำตาม `/follow-write-workflows`
5. เมื่อแก้ไขไฟล์ skills ทำตาม `/follow-write-skills`
6. เมื่อเพิ่ม global workflows ใหม่ ให้ match ไฟล์ใน global workflows แล้วดูว่าควรเพิ่มอะไรใน workflows ไหนอีกได้บ้าง

Workflow Execution Rules

- ทุก global workflows ที่ขึ้นต้นด้วย `run-` ให้ใช้ `/loop-until-complete` เสมอ
- ติดตามลำดับการทำงานตาม workflow ที่กำหนด
- ห้ามข้ามขั้นตอนใน workflow

### 4. Execute

ดำเนินการตามกฎที่กำหนดอย่างเคร่งครัด

1. อ่าน `/refactor` และ `/do-not` ก่อนเขียน code ทุกครั้ง
2. เมื่อ execute ต้องเปิด web ให้รัน `/watch-browser`
3. ทำ `/update-reference` เสมอสำหรับ file operations (project, global workflows, skills, global rules, etc.)
4. เมื่อเขียน code ทำตาม `/write-test` เสมอ
5. ไม่ mock, ไม่ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment `// MOCK` หรือ `// TODO` ชัดเจน
6. mock data ให้แยกออกไปในโฟลเดอร์ `mock/` แล้วนำมาใช้
7. ถ้าต้องทำ file operation หรือ analyze ไฟล์จำนวนมาก ให้ใช้ `/use-bun-scripts`
8. พิมพ์ `<prompt> <workflows>` เพื่อค้นหา global rules และทำตาม prompt + workflows

### 5. Reflex

ทำการ refactor หลังจาก execute เสร็จเสมอ

1. ทำ `/refactor` เสมอหลังจาก execute เสร็จ
2. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Report

สรุปและรายงานผล

1. ทำตาม `/report`
2. เมื่อจบ task ให้รัน `/suggest-next-action` เสมอ
