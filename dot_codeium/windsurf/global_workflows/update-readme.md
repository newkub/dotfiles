---
title: Update Readme
description: สร้าง README.md ที่มีเนื้อหาครบถ้วนด้วยข้อมูลจากการวิเคราะห์โปรเจกต์จริง
auto_execution_mode: 3
related_workflows:
  - /analyze-project
  - /all-workspaces
  - /content-quality
  - /update-docs
  - /example-readme
---

## Goal

สร้าง `README.md` ที่มีเนื้อหาครบถ้วนด้วยข้อมูลจากการวิเคราะห์โปรเจกต์จริง โดยไม่มี placeholders สำหรับทั้ง root และ workspaces ใน monorepo

## Scope

ครอบคลุมการสร้าง `README.md` สำหรับ root และทุก workspace ใน monorepo

## Execute

### 1. Analyze And Write Root README

1. ทำ `/analyze-project` เพื่อเก็บข้อมูลโปรเจกต์ root
2. อ่าน `manifest files`, `source code`, และ `config files`
3. เขียน `required sections`, `usage`, และ `hero section` ตามมาตรฐาน
4. `Configuration` ให้อยู่ใน `Reference section`

### 2. Update Workspaces READMEs

1. ทำ `/all-workspaces` เพื่อ update `README` ทุก workspaces
2. `Configuration` อยู่ใน `Reference section`
3. ไม่ต้องมี `License` และ `History sections` (ใช้ของ root)

### 3. Validate And Finalize

1. ใช้ `/content-quality` เพื่อตรวจสอบคุณภาพ
2. ตรวจสอบ `workflows` ที่อ้างอิงมีอยู่จริง
3. ใช้ `/update-reference` หากมี `file changes`

## Rules

### 1. Section Formats

จัดรูปแบบ sections ตามมาตรฐาน:

- `Status Callout`: ด้านบนสุด (หลัง title) - ใช้ `> [!WARNING]` ถ้ายังไม่พร้อม, ใช้ `> [!SUCCESS]` ถ้าพร้อมใช้งาน
- `Hero Section`: Title, Description, Badges (ชิดซ้าย, รวม License MIT badge)
- `Key Concepts`: `<details>`/`<summary>` accordion (Key Concepts, Principles, FAQs, Best Practices, Information)
- `Features`: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม icon จาก iconify - เขียน features ของ project จริงๆ จากการวิเคราะห์
- `Quick Start`: Installation ด้วย numbered steps
- `Usage`: Markdown format พร้อม code blocks
- `Reference`: Markdown table 3 columns พร้อม Config Options, Commands, HTTP Endpoints, GraphQL - เขียนเมื่อมี
- `License`: Section แยกด้านล่าง Notes พร้อม MIT badge
- `History`: Star history widget (เฉพาะเมื่อมี tag release)

### 2. Example Structure

โครงสร้าง `README.md` ตัวอย่าง:

```markdown
# Project Name

> [!WARNING]
> This project is currently in development and not yet ready for production use.

Simple project description.

![Framework](https://img.shields.io/badge/Framework-version-color)
![License](https://img.shields.io/badge/License-MIT-green)

<details>
<summary>Key Concepts</summary>

| Icon | Concept | Benefit |
|------|---------|---------|
| Icon | Concept | Benefit |

</details>

<details>
<summary>Principles</summary>

| Icon | Principle | User Impact |
|------|-----------|-------------|
| Icon | Principle | User Impact |

</details>

<details>
<summary>FAQs</summary>

| Question | Answer |
|----------|--------|
| Question | Answer |

</details>

<details>
<summary>Best Practices</summary>

- Practice 1
- Practice 2

</details>

<details>
<summary>Information</summary>

> [!IMPORTANT]
> - Important 1
> - Important 2

> [!WARNING]
> - Warning 1
> - Warning 2

> [!CAUTION]
> - Caution 1
> - Caution 2

</details>

## Features

| Icon | Feature | Description | Benefit | Usage |
|------|----------|-------------|---------|-------|
| Icon | Feature | Description | Benefit | Usage |

## Quick Start

### Installation

1. Step 1
2. Step 2

### Deployment

Deploy command

## Usage

### Feature Name

Description with code block

```typescript
// Code example
```

## Reference

### Configuration

#### config-file

Configuration description

```toml
config content
```

#### Config Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| option | type | default | option description |

### Commands

| Command | Description |
|---------|-------------|
| command | description |

### HTTP Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/endpoint | endpoint description |

### GraphQL

(ถ้ามี GraphQL API)

#### GraphQL Schema

```graphql
type Query {
  # Query fields
}

type Mutation {
  # Mutation fields
}
```

#### GraphQL Queries

| Query | Description | Returns |
|-------|-------------|---------|
| query | query description | return type |

#### GraphQL Mutations

| Mutation | Description | Returns |
|----------|-------------|---------|
| mutation | mutation description | return type |

### Other References

(ถ้ามี reference อื่นๆ เช่น SDK, libraries, หรือ external documentation)

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

- ✓ Commercial use, Distribution, Modification, Private use
- ⓘ License and copyright notice
- ✕ Liability, Warranty

```

```

### 2. Content And Language Standards

รักษาคุณภาพเนื้อหา:

- ใช้ข้อมูลจริงจาก `/analyze-project`
- `Code examples` ต้องรันได้จริง, มี comment อธิบาย
- ไม่ใช้ placeholder ยกเว้น banner image
- ตั้งชื่อ `Usage Methods` ตาม interface หลัก
- แต่ละ ## heading ต้องมี description ใต้
- `Callouts` อยู่ใน section ที่เกี่ยวข้องกับเนื้อหานั้นๆ
- โดยเริ่มต้นไม่ต้องมี license/history ถ้าไม่มี tag release
- `README.md`: Headers และ Lists เป็นภาษาอังกฤษ
- Workflow: ใช้ภาษาไทย, ยกเว้นคำศัพท์เฉพาะทาง

### 3. Features Writing Standards

เขียน features ให้ละเอียดและครอบคลุม:

- **Description**: อธิบาย feature อย่างชัดเจนว่าทำอะไร และทำงานอย่างไร
- **Benefit**: ระบุประโยชน์ที่เป็นคุณค่าต่อผู้ใช้จริงๆ (ไม่ใช่แค่ feature list)
- **Usage**: ให้ตัวอย่างการใช้งานที่เป็นรูปธรรม และใช้งานได้จริง
- **Coverage**: ครอบคลุมทุก features หลักของ project จากการวิเคราะห์ source code
- **Icons**: ใช้ icon จาก iconify ที่เหมาะสมกับแต่ละ feature
- **No Generic**: หลีกเลี่ยงคำอธิบายที่ generic หรือไม่ชัดเจน
- **User-Centric**: เน้นประโยชน์ต่อผู้ใช้ ไม่ใช่แค่ technical details

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน ไม่มี placeholder
- โครงสร้างสม่ำเสมอตาม section formats
- Code examples ถูกต้องและพร้อมใช้งาน
- Icons แสดงได้ถูกต้อง

