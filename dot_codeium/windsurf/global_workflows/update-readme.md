---
title: Update README
description: Create comprehensive README.md files with actual project analysis data without placeholders
auto_execution_mode: 3
---

## Goal

Create comprehensive README.md files with actual project analysis data without placeholders.

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

สร้าง sections ด้วยข้อมูลจริงจากการวิเคราะห์:

**Required:** `Title`, `Why`, `When`, `Key Concept`, `Principles`, `Features`, `Installation`, `Usage`, `Configuration`, `Reference`, `License`

**Optional:** `Integrations`, `Architecture`, `Performance`, `Migration`, `Showcase`, `Packages`, `Release Notes`, `FAQs`

**Structure Rule:** README.md ต้องมีโครงสร้างเฉพาะ sections ที่ระบุข้างต้นเท่านั้น ห้ามเพิ่ม sections อื่นๆ นอกเหนือจากที่ระบุ

### 3.1 Why Section Format

จัดรูปแบบ Why section เป็นตาราง 3 columns:
- **Column 1:** `Icon` - Iconify icon พร้อม color: `![name](https://api.iconify.design/mdi:icon-name.svg?color=%23ff6b6b)`
- **Column 2:** `Problem` - ปัญหาที่ต้องการแก้ไข
- **Column 3:** `Solution` - วิธีแก้ปัญหาของ package
- แสดงปัญหาและวิธีแก้แบบจับคู่กัน
- **Important:** Icons ต้องอยู่เฉพาะใน column แรกเท่านั้น ห้ามใช้ใน description หรือ column อื่น

ตัวอย่าง format:

```markdown
## Why

| Icon | Problem | Solution |
|------|---------|----------|
| ![config](https://api.iconify.design/mdi:file-multiple.svg?color=%23ff6b6b) | Task configurations scattered across formats | Unified loader with auto-format detection |
| ![slow](https://api.iconify.design/mdi:timer-sand.svg?color=%23ffd93d) | Slow repetitive task execution | Built-in local and remote caching system |
```

### 3.2 When Section Format

จัดรูปแบบ When section เป็นตาราง 2 columns:
- **Column 1:** `Icon` - Iconify icon พร้อม color
- **Column 2:** `Use Case` - สถานการณ์ที่ควรใช้ package พร้อมคำอธิบายสั้นๆ
- **Important:** Icons ต้องอยู่เฉพาะใน column แรกเท่านั้น ห้ามใช้ใน description หรือ column อื่น

ตัวอย่าง format:

```markdown
## When

| Icon | Use Case |
|------|----------|
| ![pipeline](https://api.iconify.design/mdi:pipeline.svg?color=%234ecdc4) | **Build pipelines** - Run build, test, lint tasks with dependencies |
| ![dev](https://api.iconify.design/mdi:code-tags.svg?color=%2345b7d1) | **Development workflows** - Watch mode, auto-rebuild, hot reload |
```

### 3.3 Key Concept Section Format

จัดรูปแบบ Key Concept section พร้อม `(Why + Rules)`:
- ใช้ Iconify API สำหรับ icons พร้อม color: `![name](https://api.iconify.design/mdi:icon-name.svg?color=%23ff6b6b)`
- แสดงแนวคิดหลักพร้อม icon
- ใช้ตาราง 3 columns: `Icon`, `Concept`, `Rule` (Icon เป็น column แรก)
- อธิบายว่าทำไมต้องใช้แนวคิดนี้ และกฎที่ต้องปฏิบัติ
- **Important:** Icons ต้องอยู่เฉพาะใน column แรกเท่านั้น ห้ามใช้ใน description หรือ column อื่น

ตัวอย่าง format:

```markdown
## Key Concept (Why + Rules)

![architecture](https://api.iconify.design/mdi:folder-cog.svg?color=%236c5ce7) **Clean Architecture 2** principles:

| Icon | Concept | Rule |
|------|---------|------|
| ![pure](https://api.iconify.design/mdi:function-variant.svg?color=%2300b894) | **Pure Functions** | No side effects |
| ![immutable](https://api.iconify.design/mdi:lock-outline.svg?color=%23d63031) | **Immutability** | All types readonly |
```

### 3.4 Principles Section Format

จัดรูปแบบ Principles section พร้อม `(What + Mental Models)`:
- ใช้ Iconify API สำหรับ icons พร้อม color
- ใช้ตาราง 3 columns: `Icon`, `Principle`, `Mental Model` (Icon เป็น column แรก)
- แสดงหลักการทำงานและ mental model ที่ใช้คิด
- **Important:** Icons ต้องอยู่เฉพาะใน column แรกเท่านั้น ห้ามใช้ใน description หรือ column อื่น

ตัวอย่าง format:

```markdown
## Principles (What + Mental Models)

| Icon | Principle | Mental Model |
|------|-----------|--------------|
| ![compose](https://api.iconify.design/mdi:puzzle.svg?color=%23e17055) | **Composition** | Build from small functions |
| ![failfast](https://api.iconify.design/mdi:alert-circle-outline.svg?color=%23d63031) | **Fail Fast** | Validate early |
```

### 4. Write Usage Section

เขียน usage ตาม usecase จริงของโปรเจกต์ แบ่งเป็น subsections ตาม usecase แต่ละอัน:
- ใช้ naming convention: `Method 1: Usage via XXX`, `Method 2: Usage via XXX`, ...
- XXX คือประเภทการใช้งาน เช่น Programmatic API, CLI, Website, Configuration File, etc.
- ทุก API usage ที่เกี่ยวข้องกับ method เดียวกัน ต้องอยู่ภายใน subsection เดียวกัน
- อย่าแยก API usage ที่เกี่ยวข้องกันออกเป็น subsection ต่างหาก

### 4.1 Installation, Usage Format

จัดรูปแบบ Installation, Usage ตามมาตรฐาน:
- แสดง manifest file (package.json/Cargo.toml) ใน code block
- แสดง terminal commands ใน code block อีกอันพร้อม comment
- เรียงลำดับตามการดำเนินการจริง

ตัวอย่าง format:

```json
// package.json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  }
}
```

```bash
# Terminal commands
# Install dependencies
bun install

# Run in development mode (Chrome/Edge)
bun run dev

# Run in development mode (Firefox)
bun run dev:firefox
```

### 5. Write Configuration Section

ใช้ code block (`YAML/JSON`) หรือตารางสั้นๆ สำหรับ `library constants`

### 6. Write API Reference

เขียนแค่ `public API` หลักๆ ใช้ตาราง 3 col (`name`, `description`, `benefit`) และ grouping ตามประเภท

### 7. Write License Section

ระบุ `license type` ชัดเจน, เพิ่ม link ไปยัง `LICENSE.md`, ใช้ภาษาอังกฤษกระชับ
- ใช้รูปแบบ: `MIT License` ตามด้วย `See LICENSE.md for full license` ที่ด้านล่าง
- ห้ามมี `Key Points:` หรือ bullet points เพิ่มเติม

### 8. Write Optional Sections

เขียน optional sections ตามความเหมาะสม:

**Release Notes:** ตาราง 6 col (`Version`, `Date`, `Type`, `Category`, `Breaking`, `Changes`)
**FAQs:** ตาราง 2 col (`Question`, `Answer`)
**Architecture:** ASCII art แสดง `workflow diagrams`
**Performance:** รัน benchmark จริงๆ แล้ว report ผล
**Migration:** แบ่งเป็น migration จาก tools ต่างๆ
**Showcase:** bullet หรือ card format
**Packages:** ตาราง 2 col (`Name`, `Description`)

### 9. Validate and Verify

1. ตรวจสอบว่าทุก section ใช้ข้อมูลจริงจากโปรเจกต์
2. ยืนยันว่า code examples ถูกต้องและ runnable ได้
3. ตรวจสอบว่าไม่มี placeholder
4. ตรวจสอบว่าทุก link ใช้งานได้ (external และ internal)

## Rules

### 1. Frontmatter Standards

ตั้งค่า frontmatter ให้ถูกต้อง:
- title: Title Case สื่อความหมายชัดเจน
- description: กระชับไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3 เท่านั้น
- ห้ามเพิ่ม field อื่นโดยไม่จำเป็น

### 2. Structure & Format

รักษาโครงสร้างและ format ให้สม่ำเสมอ:
- โครงสร้าง: `## Goal`, `## Execute`, `## Rules`, `## Expected Outcome`
- ใช้ numbered list (1., 2., 3.) เรียงตาม flow การทำงาน
- Bullet points ชิดซ้าย ใช้ dash (-)
- เขียนกระชับ ตรงประเด็น
- ไฟล์ไม่เกิน 200 บรรทัด

### 3. Language Standards

ใช้ภาษาที่ถูกต้อง:
- หัวข้อภาษาอังกฤษ Title Case
- รายการใช้ภาษาไทย
- ยกเว้นคำศัพท์เฉพาะทาง

### 4. Content Standards

รักษาคุณภาพเนื้อหา:
- ใช้ข้อมูลจริงจาก `/analyze-project`
- Code examples ต้อง runnable ได้จริง
- ไม่ใช้ placeholder

### 4.1 Code Block Standards

จัดรูปแบบ code blocks ตามมาตรฐาน:
- ทุก code block ต้องมี comment อธิบาย
- ใช้ ```diff เมื่อแสดงการเปลี่ยนแปลง

ตัวอย่าง format:

```bash
# Install dependencies
bun install

# Run development server
bun run dev
```

```diff
# Configure UnoCSS in vite.config.ts
import { defineConfig } from 'vite'
import unocss from 'unocss/vite'

export default defineConfig({
-  plugins: []
+  plugins: [unocss()]
})
```

### 5. Features Format

จัดรูปแบบ features ตามมาตรฐาน:
- ใช้ตาราง 4 col: `Icon`, `Feature`, `Description`, `Benefit` (Icon เป็น column แรก)
- ใช้ Iconify API สำหรับ icons พร้อม color: `![name](https://api.iconify.design/mdi:icon-name.svg?color=%23ff6b6b)`
- หา icon ที่เหมาะสมกับ feature จาก https://icon-sets.iconify.design/mdi/

### 6. Integrations Format

จัดรูปแบบ integrations ตามมาตรฐาน:
- เป็น optional section
- ใช้ bullet format แสดง integrations ที่รองรับ
- แต่ละ integration ให้ระบุชื่อและคำอธิบายสั้นๆ

### 7. Reference Format

จัดรูปแบบ Reference ตามมาตรฐาน:
- แบ่งเป็น subsections: `API Reference` (ถ้ามี), `CLI Reference` (ถ้ามี), `xxx Reference` (ถ้ามี)
- เขียนแค่ usage API หลักๆ
- ใช้ตาราง 3 col: `name`, `description`, `benefit`
- Grouping ตามประเภท
- col แรก link ไปยังไฟล์จริงๆ (ถ้ามี)

### 8. License Format

จัดรูปแบบ License ตามมาตรฐาน:
- ระบุ license type ชัดเจน
- เพิ่ม link ไปยัง `LICENSE.md`
- เพิ่ม bullet points สำคัญๆ เกี่ยวกับสิทธิ์และเงื่อนไข (optional)
- ใช้ภาษาอังกฤษกระชับ

### 9. Optional Sections Format

จัดรูปแบบ optional sections ตามมาตรฐาน:
- CHANGELOG: ตาราง 3 col (`Version`, `Date`, `Changes`)
- FAQs: ตาราง 2 col (`Question`, `Answer`)
- Architecture: ASCII art แสดง workflow diagrams
- Performance: ต้อง run benchmark จริงๆ
- Migration: แบ่งเป็น migration จาก tools ต่างๆ
- Showcase: bullet หรือ card format
- Packages: ตาราง 2 col (`Name`, `Description`)

### 10. Link Validation

ตรวจสอบความถูกต้องของ links:
- ตรวจสอบว่าทุก link ใน README.md ใช้งานได้
- External links ต้องเข้าถึงได้จริง
- Internal links ต้องเชื่อมโยงถูกต้อง
- แก้ไขหรือลบ links ที่ไม่ใช้งานได้

### 11. Markdown Links

ใช้ markdown link อย่างถูกต้อง:
- External references: ใช้ markdown link เสมอ
- Internal references: ใช้ markdown link เสมอ

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- Features มี emoji และเป็นตาราง 4 col
- Getting Started, Installation, Usage: แสดง manifest file และ terminal commands ใน code blocks
- API Reference เขียนแค่ interface หลักๆ ในรูปแบบตาราง 3 col (name, description, benefit)
- License: License section พร้อม link
- Code examples พร้อมใช้งานได้ทันที
- Links ทั้งหมดใช้งานได้
- Optional sections: Integrations, Architecture, Performance, Migration, Showcase, Packages, Release Notes, FAQs
