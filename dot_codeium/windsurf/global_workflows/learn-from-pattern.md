---
title: Learn from Pattern
description: เรียนรู้จาก patterns ที่พบใน codebase, competitors, หรือ real-world implementations
auto_execution_mode: 3
related_workflows:
  - /learn
  - /learn-from-web
  - /code-search
  - /scan-codebase
  - /use-ast-grep
  - /generalize
  - /follow-best-practice
  - /deep-research
---

## Goal

สกัดความรู้และ reusable patterns จาก code ที่มีอยู่, competitors, หรือ real-world implementations เพื่อนำมาประยุกต์ใช้ใน project

## Scope

ใช้สำหรับเรียนรู้จาก patterns ที่พบใน codebase ปัจจุบัน, code ของ competitors, open-source projects, หรือ implementations จริง เพื่อสกัดและประยุกต์ใช้

## Execute

### 1. Define Pattern Target

กำหนดเป้าหมายการเรียนรู้:

1. ระบุประเภท pattern ที่ต้องการเรียนรู้ (architecture, design, code, UX, data flow)
2. ระบุแหล่งที่จะศึกษา: codebase ปัจจุบัน, competitor code, open-source project, หรือ reference implementation
3. กำหนดระดับความลึก: overview, intermediate, deep
4. ระบุ context ที่ต้องการนำ pattern ไปใช้

### 2. Discover Patterns

ค้นหา patterns จากแหล่งที่กำหนด:

1. ทำ `/code-search` เพื่อค้นหา code patterns ใน codebase ปัจจุบัน
2. ทำ `/scan-codebase` เพื่อ scan หา recurring structures
3. ทำ `/use-ast-grep` สำหรับ AST-based pattern discovery
4. ถ้าศึกษาจาก open-source ให้ทำ `/deep-research` เพื่อหา reference projects
5. ถ้าศึกษาจาก competitor ให้ทำ `/bench-competitors` เพื่อวิเคราะห์ patterns ของคู่แข่ง

### 3. Extract And Document Patterns

สกัดและจัดทำเอกสาร patterns ที่พบ:

1. จัดกลุ่ม patterns ตามประเภท (structural, behavioral, creational)
2. บันทึกแต่ละ pattern พร้อม: ชื่อ, คำอธิบาย, code example, use case, pros/cons
3. ระบุ context ที่ pattern เหมาะสมและไม่เหมาะสม
4. บันทึก variations และ alternative approaches
5. ระบุ anti-patterns ที่เกี่ยวข้องเพื่อหลีกเลี่ยง

### 4. Validate Patterns

ตรวจสอบความถูกต้องและความเข้ากันได้:

1. ตรวจสอบว่า pattern สอดคล้องกับ `/follow-best-practice` ของ tech stack ที่ใช้
2. เปรียบเทียบกับ official documentation โดยทำ `/learn-from-web`
3. ตรวจสอบ version compatibility กับ project ปัจจุบัน
4. ทดสอบ pattern กับ use case จริงใน project
5. ตรวจสอบว่า pattern ไม่ขัดกับ existing architecture

### 5. Apply Patterns

นำ patterns ไปใช้ใน project:

1. ทำ `/generalize` เพื่อทำให้ pattern เป็น generic สำหรับ reuse
2. ปรับ pattern ให้เข้ากับ project context และ conventions
3.  implement ในที่ที่เหมาะสม โดยทำตาม `/follow-architecture`
4. ถ้าต้องแก้ไขไฟล์มากกว่า 10 ไฟล์ ให้ทำ `/use-scripts` สำหรับ batch transformations
5. รัน `/run-check` เพื่อตรวจสอบคุณภาพหลัง implement

### 6. Document And Share

จัดทำเอกสารและแชร์ความรู้:

1. สร้าง pattern documentation ใน `docs/development/patterns/`
2. เขียน examples สำหรับแต่ละ pattern โดยทำ `/write-examples`
3. อัปเดท `AGENTS.md` ถ้า pattern เป็น project-wide convention
4. แชร์กับทีมผ่าน documentation หรือ code review

## Rules

### Pattern Discovery

- ใช้ `/code-search` สำหรับค้นหา patterns ใน codebase
- ใช้ `/use-ast-grep` สำหรับ AST-based structural pattern matching
- ใช้ `/scan-codebase` สำหรับ quick pattern scanning
- ค้นหาทั้ง positive patterns (ดี) และ anti-patterns (ไม่ดี)

### Pattern Documentation

- แต่ละ pattern ต้องมี: ชื่อ, คำอธิบาย, code example, use case, pros/cons
- ระบุ context ที่เหมาะสมและไม่เหมาะสม
- บันทึก variations และ alternatives
- ใช้ภาษาที่เข้าใจง่าย ไม่ใช่ academic terminology

### Validation Standards

- ทำ `/learn-from-web` เพื่อ cross-reference กับ official docs
- ทำ `/follow-best-practice` เพื่อตรวจสอบมาตรฐาน
- ทดสอบ pattern กับ use case จริงก่อน adopt
- ตรวจสอบ version compatibility เสมอ

### Application Discipline

- ทำ `/generalize` เพื่อทำให้ reusable และไม่ specific เกินไป
- ปรับ pattern ให้เข้ากับ project context ไม่ copy ตรงๆ
- ถ้าต้องแก้ไขไฟล์มากกว่า 10 ไฟล์ ให้ทำ `/use-scripts`
- รัน `/run-check` หลัง implement เสมอ

### Non-Duplication

- ใช้ `/learn` สำหรับเรียนรู้ concept หรือ tool ทั่วไป
- ใช้ `/learn-from-web` สำหรับเรียนรู้จาก official documentation
- ใช้ `/follow-request-pattern` สำหรับเขียน pattern rules จากข้อมูลที่ให้มา
- Workflow นี้เน้นเฉพาะการสกัดและประยุกต์ใช้ patterns จาก real-world code

## Expected Outcome

- Patterns ที่สกัดได้จาก code จริง พร้อม documentation
- Code examples และ use cases ที่ชัดเจน
- Patterns ที่ validated กับ official docs และ best practices
- การนำ patterns ไปใช้จริงใน project พร้อม quality checks
- Pattern library สำหรับทีมใน `docs/development/patterns/`
