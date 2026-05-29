---
title: Update Readme
description: สร้าง README.md ที่มีเนื้อหาครบถ้วนด้วยข้อมูลจากการวิเคราะห์โปรเจกต์จริง
auto_execution_mode: 3
related_workflows:
  - /analyze-project
  - /follow-content-quality
  - /update-docs
  - /example-readme
---

## Goal

สร้าง README.md ที่มีเนื้อหาครบถ้วนด้วยข้อมูลจากการวิเคราะห์โปรเจกต์จริง โดยไม่มี placeholders สำหรับทั้ง root และ workspaces ใน monorepo

## Scope

ครอบคลุมการสร้าง README.md สำหรับ root และทุก workspace ใน monorepo

## Execute

### 1. Analyze Root Project

1. ทำ `/analyze-project` เพื่อเก็บข้อมูลโปรเจกต์ root
2. อ่าน manifest files และ source code เพื่อเข้าใจ features
3. อ่าน config files เพื่อดูตัวเลือกการตั้งค่า

### 2. Write Root README

1. เขียน required sections ตามมาตรฐาน
2. เขียน usage ตาม interface หลักของโปรเจกต์
3. เพิ่ม hero section
4. Configuration ให้อยู่ใน Reference section

### 3. Analyze Workspaces

1. ระบุ workspaces ทั้งหมดจาก workspace configuration
2. ทำ `/analyze-project` สำหรับแต่ละ workspace
3. อ่าน manifest files และ source code ของแต่ละ workspace

### 4. Write Workspace READMEs

1. เขียน required sections ตามมาตรฐานสำหรับแต่ละ workspace
2. เขียน usage ตาม interface หลักของ workspace
3. Configuration ให้อยู่ใน Reference section
4. ไม่ต้องมี License และ History sections (ใช้ของ root)

### 5. Validate And Finalize

1. ใช้ `/follow-content-quality` เพื่อตรวจสอบคุณภาพ
2. ตรวจสอบ workflows ที่อ้างอิงมีอยู่จริง
3. ใช้ `/update-reference` หากมี file changes

## Rules

### 1. Section Formats

จัดรูปแบบ sections ตามมาตรฐาน:

- Hero Section: Title, Subtitle, Description, Badges, Navigation
- Features: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม icon จาก iconify และ color (ใช้ HTML img tag: `<img src="https://api.iconify.design/lucide:icon-name.svg?color=%23hexcode" width="18" height="18">`)
- Key Concepts: Callout พร้อม `<details>`/`<summary>` accordion สำหรับ Key Concepts table (3 columns: Icon, Concept, Benefit), Principles table (3 columns: Icon, Principle, User Impact), FAQs table (2 columns), Best Practices - ทั้งหมดอยู่ใน NOTE callout เดียวกันเป็น accordion โดยไม่มี icon ใน heading - เน้นเขียนสำหรับ user คนใช้งาน ไม่ใช่ developer
- Quick Start: Installation ด้วย numbered steps
- Usage: Markdown format พร้อม code blocks และ description
- Reference: Markdown table 3 columns พร้อม Options table และ Commands tables
- Notes: Callouts (Tip, Important, Warning, Caution) พร้อม bullet points 4 อันข้างในแต่ละ callout (ใช้ `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`)
- License: Section แยกด้านล่าง Notes (เฉพาะเมื่อมี tag release)
- History: Star history widget (เฉพาะเมื่อมี tag release)

### 2. Content Standards

รักษาคุณภาพเนื้อหา:

- ใช้ข้อมูลจริงจาก `/analyze-project`
- Code examples ต้องรันได้จริง
- ไม่ใช้ placeholder ยกเว้น banner image
- Code block มี comment อธิบาย
- ตั้งชื่อ Usage Methods ตาม interface หลัก (CLI, Git Integration, Shell Completion)
- แต่ละ ## heading ต้องมี description ใต้
- Notes, Important, Warning, Caution อยู่ใน Notes section เป็น callouts แยก
- โดยเริ่มต้นไม่ต้องมี license ถ้าไม่ได้มี tag release อะไร
- โดยเริ่มต้นไม่ต้องมี history ถ้าไม่ได้มี tag release อะไร

### 3. Language Standards

ใช้ภาษาที่ถูกต้อง:

- README.md: Headers และ Lists เป็นภาษาอังกฤษ
- Workflow: ใช้ภาษาไทย
- ยกเว้นคำศัพท์เฉพาะทาง

## Expected Outcome

- [ ] README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- [ ] โครงสร้างสม่ำเสมอตาม section formats
- [ ] Code examples ถูกต้องและพร้อมใช้งาน
- [ ] Icons แสดงได้ถูกต้อง
- [ ] License section มีเฉพาะเมื่อมี tag release
- [ ] History section มีเฉพาะเมื่อมี tag release

## Common Mistakes

ข้อผิดพลาดที่พบบ่อย:

- ใช้ placeholder แทนข้อมูลจริง
- ใช้ชื่อ method ผิด (ใช้ feature name แทน interface name)
- ลืมเพิ่ม Configuration ใน Reference section
- ใช้ icons ใน column ที่ไม่ใช่ column แรก
- FAQs อยู่ใน Notes callout แทนที่จะเป็น section แยก
- เพิ่ม License section แม้ไม่มี tag release
- เพิ่ม History section แม้ไม่มี tag release
- Note callouts ไม่มี color

## Anti-Patterns

รูปแบบที่ไม่ควรทำ:

- ❌ ใช้ placeholder ใน README.md
- ❌ สร้าง Configuration section แยกจาก Reference
- ❌ ตั้งชื่อ Usage Methods ตาม feature name
- ❌ ใช้ icons ใน description column
- ❌ เพิ่ม License section แม้ไม่มี tag release
- ❌ เพิ่ม History section แม้ไม่มี tag release
- ❌ รวม FAQs ไว้ใน Notes callout
- ❌ Note callouts ไม่มี color
