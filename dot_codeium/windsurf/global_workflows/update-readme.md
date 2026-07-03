---
title: Update Readme
description: สร้าง README.md ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์
auto_execution_mode: 3
related_workflows:
  - /deep-analyze
  - /all-workspaces
  - /follow-content-quality
  - /write-windsurf-global-workflows
---

## Goal

สร้าง `README.md` ที่มีเนื้อหาครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากการวิเคราะห์โปรเจกต์ สำหรับ root และ workspaces ใน monorepo

## Scope

ครอบคลุมการสร้าง `README.md` สำหรับ root และทุก workspace ใน monorepo

## Execute

### 1. Generate Changelog And Release

Generate changelog and release notes before creating README

1. ทำ `/gen-changelog` เพื่อสร้าง CHANGELOG.md
2. ทำ `/gen-release` เพื่อสร้าง RELEASE.md

### 2. Detect Project Type

Detect project type before writing README

1. อ่าน `package.json` หรือ `Cargo.toml` เพื่อดู type
2. ตรวจสอบ source code structure:
   - CLI/SDK: มี `bin/`, CLI commands, API exports, library exports
   - App: มี UI components, web app, mobile app, desktop app
3. ตรวจสอบ dependencies:
   - CLI/SDK: commander, yargs, typescript, build tools
   - App: react, vue, solid, UI frameworks, bundlers
4. กำหนด project type: `cli-sdk` หรือ `app`

### 3. Analyze And Write Root README

1. ทำ `/deep-analyze` เพื่อเก็บข้อมูลโปรเจกต์ root
2. อ่าน `manifest files`, `source code`, และ `config files`
3. เลือก template ตาม project type:
   - ใช้ CLI/SDK Template สำหรับ CLI หรือ SDK
   - ใช้ App Template สำหรับ web/mobile/desktop apps
4. เขียน README ตาม template ที่เลือก
5. `Configuration` อยู่ใน `Reference section`

### 4. Update Workspaces READMEs

1. ทำ `/all-workspaces` เพื่อ update README ทุก workspaces
2. ตรวจสอบ project type ของแต่ละ workspace
3. เลือก template ตาม project type ของ workspace
4. `Configuration` อยู่ใน `Reference section`
5. ไม่ต้องมี `License` และ `History sections` (ใช้ของ root)

### 5. Validate And Finalize

1. ทำ `/follow-content-quality` เพื่อตรวจสอบคุณภาพ
2. ตรวจสอบ workflows ที่อ้างอิงมีอยู่จริง
3. ใช้ `/update-references` หากมี file changes

## Rules

### 1. Section Formats

จัดรูปแบบ sections ตาม template มาตรฐาน:

- `Status Callout`: ด้านบนสุด - ใช้ `> 🚀` หรือ emoji ที่เหมาะสม
- `Hero Section`: Title, Description, Badges (ชิดซ้าย, รวม License MIT badge)
- `ANSI Art`: ASCII art banner ด้านบน Hero Section
- `Features`: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม icon จาก iconify
- `Key Concepts`: Markdown table 3 columns (Icon, Concept, Description) พร้อม icon จาก iconify
- `Tech Stack`: Markdown table 2 columns (Layer, Technology) พร้อม version
- `Quick Start`: Installation ด้วย numbered steps
- `Usage`: Markdown format พร้อม code blocks
- `Reference`: `<details>`/`<summary>` accordion สำหรับ subsections
- `Information`: Callout หลายอัน (TIP, IMPORTANT, WARNING, CAUTION, FAQ)
- `License`: Section แยกด้านล่างสุด พร้อม MIT badge

### 2. Content Standards

รักษาคุณภาพเนื้อหาตามมาตรฐาน:

- ใช้ข้อมูลจริงจาก `/analyze-project`
- Code examples ต้องรันได้จริง, มี comment อธิบาย
- ไม่ใช้ placeholder ยกเว้น banner image
- แต่ละ `## heading` ต้องมี description ใต้
- Callouts อยู่ใน section ที่เกี่ยวข้อง
- โดยเริ่มต้นไม่ต้องมี license/history ถ้าไม่มี tag release
- README.md: Headers และ Lists เป็นภาษาอังกฤษ
- Workflow: ใช้ภาษาไทย, ยกเว้นคำศัพท์เฉพาะทาง

### 3. Features Writing Standards

เขียน features ให้ละเอียดและครอบคลุม:

- Business-Focused: เขียน business value ไม่ใช่ technical details
- Description: อธิบาย feature อย่างชัดเจนว่าทำอะไร และทำงานอย่างไร
- Benefit: ระบุประโยชน์ที่เป็นคุณค่าต่อผู้ใช้จริงๆ
- Usage: ให้ตัวอย่างการใช้งานที่เป็นรูปธรรม และใช้งานได้จริง
- Coverage: ครอบคลุมทุก features หลักจากการวิเคราะห์ source code
- Icons: ใช้ icon จาก iconify ที่เหมาะสมกับแต่ละ feature
- No Generic: หลีกเลี่ยงคำอธิบายที่ generic หรือไม่ชัดเจน
- User-Centric: เน้นประโยชน์ต่อผู้ใช้ ไม่ใช่แค่ technical details

## Example Template

ใช้ template ตาม project type:

- CLI/SDK Template: มี Installation, CLI Usage, SDK Usage, API Reference
- App Template: มี Quick Start, Usage, Key Concepts, Tech Stack

ทั้งสอง template มี Features table, Key Concepts table, Reference, License sections

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- โครงสร้างสม่ำเสมอตาม template
- Code examples ถูกต้องและพร้อมใช้งาน
- Icons แสดงได้ถูกต้อง
