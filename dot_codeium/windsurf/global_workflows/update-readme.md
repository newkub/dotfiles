---
title: Update README
description: Create comprehensive README.md files with actual project analysis data
auto_execution_mode: 3
---

## Goal

สร้าง README.md ที่มีเนื้อหาครบถ้วนด้วยข้อมูลจากการวิเคราะห์โปรเจกต์จริง โดยไม่มี placeholders

## Execute

### 1. Prepare Analysis

1. รัน `/analyze-project` เพื่อเก็บข้อมูลโปรเจกต์
2. อ่าน `README.md` ปัจจุบันเพื่อดูสิ่งที่ต้องอัพเดท
3. บันทึก `dependencies` และ `file structure`

### 2. Gather Project Information

1. อ่าน manifest files: `package.json`, `Cargo.toml`, `pyproject.toml`
2. ใช้ `list_dir` ดูโครงสร้าง `src/`, `apps/`, `packages/`
3. อ่าน source code เพื่อเข้าใจ `features`
4. อ่าน config files เพื่อดูตัวเลือกการตั้งค่า

### 3. Write Core Sections

1. เขียน required sections: Title, Why, When, Key Concept, Principles, Features, Installation, Usage, Configuration, Reference, License
2. เขียน optional sections ตามความเหมาะสม

### 4. Write Usage Section

1. เขียน usage ตาม interface หลักของโปรเจกต์ (CLI, Programmatic API, Browser Extension)
2. ใช้ format: `Method N: Usage via [Interface]`
3. สร้าง subsections สำหรับแต่ละ feature ภายใน method นั้นๆ

### 5. Validate Content

1. ตรวจสอบว่าใช้ข้อมูลจริงจากการวิเคราะห์
2. ยืนยัน code examples ถูกต้องและรันได้
3. ตรวจสอบว่าไม่มี placeholder หรือ broken links

## Rules

### 1. Section Formats

จัดรูปแบบ sections ตามมาตรฐาน:

| Section | Columns | Icons |
|---------|---------|-------|
| Why | 2 (Problem, Solution) | ไม่มี |
| When | 3 (Icon, Use Case, Description) | column แรก |
| Key Concept | 3 (Icon, Concept, Mental Model) | column แรก |
| Principles | 3 (Icon, Principle, Rule) | column แรก |
| Features | 4 (Icon, Feature, Description, Benefit) | column แรก |
| License | MIT License + See LICENSE.md | ไม่มี |

ห้ามมี Key Points: ใน License section

### 2. Icon Standards

ใช้ Iconify API:

```
![name](https://api.iconify.design/mdi:icon-name.svg?color=%23HEX_COLOR)
```

- Icons อยู่ใน column แรกของตารางเท่านั้น
- ห้ามใช้ icons ใน description หรือ column อื่น
- เลือกสีให้เหมาะสมกับเนื้อหา
- หา icon จาก https://icon-sets.iconify.design/mdi/

### 3. Content Standards

รักษาคุณภาพเนื้อหา:
- ใช้ข้อมูลจริงจาก `/analyze-project`
- Code examples ต้องรันได้จริง
- ไม่ใช้ placeholder
- Code block มี comment อธิบาย

### 4. Usage Naming

ตั้งชื่อ Usage Methods ตาม interface:

| Bad | Good |
|-----|------|
| Usage via Web Mode | Method 1: Usage via CLI |
| Usage via Effect Chaining | Method 2: Usage via Programmatic API |
| Usage via Export | (รวมใน CLI method) |
| Usage via Theme System | (รวบรวมใน section ที่เหมาะสม) |

- ใช้ชื่อ interface หลัก: CLI, Programmatic API, Terminal, Website, Browser Extension
- ห้ามใช้ชื่อ feature, API ย่อย, หรือ options เป็น method name
- ถ้าเป็นทางเข้าถึงเดียวกัน ให้รวมเป็น method เดียว

### 5. Language Standards

ใช้ภาษาที่ถูกต้อง:
- README.md: Headers และ Lists เป็นภาษาอังกฤษ
- Workflow: ใช้ภาษาไทย
- ยกเว้นคำศัพท์เฉพาะทาง

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- โครงสร้างสม่ำเสมอตาม section formats
- Code examples ถูกต้องและพร้อมใช้งาน
- Links ทั้งหมดใช้งานได้
