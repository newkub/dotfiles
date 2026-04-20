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
3. บันทึก `tech stack`, `dependencies`, และ `file structure`

### 2. Gather Project Information

1. อ่าน manifest files: `package.json`, `Cargo.toml`, `pyproject.toml`
2. ใช้ `list_dir` ดูโครงสร้าง `src/`, `apps/`, `packages/`
3. อ่าน source code เพื่อเข้าใจ `features`
4. อ่าน config files เพื่อดูตัวเลือกการตั้งค่า

### 3. Write Core Sections

สร้าง sections ด้วยข้อมูลจริงจากการวิเคราะห์:

**Required:** `Title`, `Why`, `Key Concept`, `Features`, `Tech Stack`, `Getting Started`, `Installation`, `Usage`, `Configuration`, `API Reference`, `License`

**Optional:** `Integrations`, `Architecture`, `Performance`, `Migration`, `Showcase`, `Packages`, `Release Notes`, `FAQs`

### 4. Write Usage Section

เขียน usage ตาม usecase จริงของโปรเจกต์ แบ่งเป็น subsections ตาม usecase แต่ละอัน

### 5. Write Configuration Section

ใช้ code block (`YAML/JSON`) หรือตารางสั้นๆ สำหรับ `library constants`

### 6. Write API Reference

เขียนแค่ `public API` หลักๆ ใช้ตาราง 3 col (`name`, `description`, `benefit`) และ grouping ตามประเภท

### 7. Write License Section

ระบุ `license type` ชัดเจน, เพิ่ม link ไปยัง `LICENSE.md`, ใช้ภาษาอังกฤษกระชับ

### 8. Write Optional Sections

เขียน optional sections ตามความเหมาะสม:

**Release Notes:** ตาราง 6 col (`Version`, `Date`, `Type`, `Category`, `Breaking`, `Changes`)
**FAQs:** ตาราง 2 col (`Question`, `Answer`)
**Architecture:** ASCII art แสดง `workflow diagrams`
**Performance:** รัน benchmark จริงๆ แล้ว report ผล
**Migration:** แบ่งเป็น migration จาก tools ต่างๆ
**Showcase:** bullet หรือ card format
**Packages:** ตาราง 2 col (`Name`, `Description`)

### 9. Write Skills Section

รวม Skills เข้าไปใน Getting Started section:

```markdown
## Getting Started

### Skills
ดู skills ที่เกี่ยวข้องใน `.skills/` ของ project
```

### 10. Validate and Verify

1. ตรวจสอบว่าทุก section ใช้ข้อมูลจริงจากโปรเจกต์
2. ยืนยันว่า code examples ถูกต้องและ runnable ได้
3. ตรวจสอบว่าไม่มี placeholder
4. ตรวจสอบว่าทุก link ใช้งานได้ (external และ internal)
5. ตรวจสอบว่ามี skills ที่เกี่ยวข้องใน `.skills/` ถ้าไม่มีให้สร้างตาม `/follow-write-skills`

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

### 5. Features Format

จัดรูปแบบ features ตามมาตรฐาน:
- ใช้ตาราง 3 col: `features`, `description`, `benefit`
- เพิ่ม emoji ใน column features

### 6. Tech Stack Format

จัดรูปแบบ tech stack ตามมาตรฐาน:
- ใช้ตาราง 3 col: `category`, `technology`, `description`
- จัดเรียงตาม category (`Framework`, `Database`, `UI`, `Deployment`, etc.)
- เพิ่ม emoji ใน column category
- Technology เป็น markdown link ไปยัง website

### 7. Integrations Format

จัดรูปแบบ integrations ตามมาตรฐาน:
- เป็น optional section
- ใช้ bullet format แสดง integrations ที่รองรับ
- แต่ละ integration ให้ระบุชื่อและคำอธิบายสั้นๆ

### 8. API Reference Format

จัดรูปแบบ API Reference ตามมาตรฐาน:
- เขียนแค่ interface หลักๆ
- ใช้ตาราง 3 col: `name`, `description`, `benefit`
- Grouping ตาม API types (`Components`, `Composables`, `Functions`, etc.)
- col แรก link ไปยังไฟล์จริงๆ

### 9. License Format

จัดรูปแบบ License ตามมาตรฐาน:
- ระบุ license type ชัดเจน
- เพิ่ม link ไปยัง `LICENSE.md`
- เพิ่ม bullet points สำคัญๆ เกี่ยวกับสิทธิ์และเงื่อนไข (optional)
- ใช้ภาษาอังกฤษกระชับ

### 10. Optional Sections Format

จัดรูปแบบ optional sections ตามมาตรฐาน:
- CHANGELOG: ตาราง 3 col (`Version`, `Date`, `Changes`)
- FAQs: ตาราง 2 col (`Question`, `Answer`)
- Architecture: ASCII art แสดง workflow diagrams
- Performance: ต้อง run benchmark จริงๆ
- Migration: แบ่งเป็น migration จาก tools ต่างๆ
- Showcase: bullet หรือ card format
- Packages: ตาราง 2 col (`Name`, `Description`)

### 11. Link Validation

ตรวจสอบความถูกต้องของ links:
- ตรวจสอบว่าทุก link ใน README.md ใช้งานได้
- External links ต้องเข้าถึงได้จริง
- Internal links ต้องเชื่อมโยงถูกต้อง
- แก้ไขหรือลบ links ที่ไม่ใช้งานได้

### 12. Skills Creation

สร้าง skills ตามมาตรฐาน:
- ตรวจสอบว่ามี skills ที่เกี่ยวข้องใน `.skills/`
- ถ้าไม่มี สร้าง skills ตาม `/follow-write-skills`
- ใช้โครงสร้างโฟลเดอร์: `project/`, `core/`, `api/`, `rules/`, `patterns/`
- สร้าง SKILL.md พร้อมตารางสรุปเนื้อหา
- เชื่อมโยง skills ใน Getting Started section

### 13. Markdown Links

ใช้ markdown link อย่างถูกต้อง:
- External references: ใช้ markdown link เสมอ
- Internal references: ใช้ markdown link เสมอ

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- Features มี emoji และเป็นตาราง 3 col
- Tech Stack มีตาราง 3 col (category, technology, description) พร้อม emoji และ link
- Getting Started: Prerequisites, Quick Start และ Skills
- API Reference เขียนแค่ interface หลักๆ ในรูปแบบตาราง 3 col (name, description, benefit)
- License: License section พร้อม link
- Code examples พร้อมใช้งานได้ทันที
- Links ทั้งหมดใช้งานได้
- Skills ที่เกี่ยวข้องถูกสร้างใน `.skills/`
- Optional sections: Integrations, Architecture, Performance, Migration, Showcase, Packages, Release Notes, FAQs
