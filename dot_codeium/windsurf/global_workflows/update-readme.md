---
title: Update Readme
description: Create comprehensive README.md with real project data, CLI accordion, and complete API coverage
auto_execution_mode: 3
---

## Goal

Create comprehensive README.md files with complete structure from Introduction to License using actual project analysis data without placeholders.

## Execute

### 1. Prepare Analysis

1. รัน `/analyze-project` เพื่อเก็บข้อมูลโปรเจกต์
2. อ่าน `README.md` ปัจจุบันเพื่อดูสิ่งที่ต้องอัพเดท
3. บันทึก tech stack, dependencies, และ file structure

### Required Headings

README.md ต้องมี headings ตามนี้เท่านั้น:

```
# project-name
## Purpose
## Features
## Installation
## CLI / Components / Programmable API
## Configuration
## API Reference
## License
```

### 2. Gather Project Information

1. อ่าน manifest files: `package.json`, `Cargo.toml`, `pyproject.toml`
2. ใช้ `list_dir` ดูโครงสร้าง `src/`, `apps/`, `packages/`
3. อ่าน source code เพื่อเข้าใจ features
4. อ่าน config files เพื่อดูตัวเลือกการตั้งค่า

### 3. Write Core Sections

สร้าง sections ด้วยข้อมูลจริงจากการวิเคราะห์:

**Format:**

```markdown
# project-name

Brief description from tech stack.

## Purpose

Brief description of what this project does and why it exists.

## Features

| Feature | Benefit |
|---------|---------|
| Feature 1 | What user gains from this feature |

## Installation
```bash
bun install package-name
```

### 4. Write Entry Section

เลือก heading ตามประเภท:
- `## CLI` - สำหรับ CLI tools
- `## Components` - สำหรับ UI components
- `## Programmable API` - สำหรับ libraries

```markdown
## CLI

```bash
# Install
npm install -g my-tool

# Basic usage
my-tool init
my-tool build
```

| Command | Description |
|---------|-------------|
| `init` | Initialize project |
| `build` | Build application |

## Components

```tsx
import { Button } from 'my-ui';

<Button variant="primary">Click me</Button>
```

| Component | Props |
|-----------|-------|
| `Button` | `variant`, `size`, `onClick` |

## Programmable API

```rust
use my_lib::Client;

let client = Client::new("api-key");
let result = client.process().await?;
```

| Method | Params | Returns |
|--------|--------|---------|
| `process()` | `input: Data` | `Result<Output>` |


### 5. Write Configuration

ใช้ code block (ไม่ใช่ตาราง):

```markdown
## Configuration

```yaml
# config.yaml
name: my-app
version: 1.0.0
options:
  verbose: true
```

หรือถ้าเป็น library constants:

| Constant | Value | Description |
|----------|-------|-------------|
| `DEFAULT_TIMEOUT` | `30s` | Default timeout |
```

### 6. Write API Reference

ใช้ตารางสรุป 

```markdown
## API Reference

### Services

| Service | Method | Params | Returns |
|---------|--------|--------|---------|
| `Orchestrator` | `create()` | `CreateRequest` | `Application` |
| `Repository` | `find()` | `id: string` | `Entity \| null` |

### DTOs

| DTO | Fields | Purpose |
|-----|--------|---------|
| `CreateRequest` | `name`, `version` | Create app |
| `GenerateRequest` | `target`, `format` | Generate code |
```

### 7. Write License Section

```markdown
## License

MIT License - See [LICENSE](./LICENSE)
```

### 8. Validate and Verify

1. ตรวจสอบว่าทุก section ใช้ข้อมูลจริงจากโปรเจกต์
2. ยืนยันว่า code examples ถูกต้องและ runnable ได้
3. ตรวจสอบว่าไม่มี placeholder
4. ตรวจสอบว่า `README.md` render ถูกต้อง

## Rules

1. Frontmatter Standards
- title: Title Case สื่อความหมายชัดเจน
- description: อธิบายงานและ scope กระชับไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3 เท่านั้น
- ห้ามเพิ่ม field อื่นโดยไม่จำเป็น

2. Structure & Format
- โครงสร้างต้องเป็น: ## Goal, ## Execute, ## Rules, ## Expected Outcome
- ใช้ numbered list (1., 2., 3.) เรียงตาม flow การทำงาน
- Bullet points ชิดซ้าย ไม่ indent ใช้ dash (-)
- เขียนให้กระชับ ตรงประเด็น ไม่วกวน
- อ่านง่าย เข้าใจได้ทันทีโดยไม่ต้องอ่านซ้ำ
- แต่ละ workflow file ต้องยาวไม่เกิน 200 บรรทัด

3. Language Standards
- หัวข้อ (Headers) ใช้ภาษาอังกฤษ Title Case
- รายการแต่ละข้อ (numbered lists, bullet points) ใช้ภาษาไทย
- ยกเว้นคำศัพท์เฉพาะทาง เช่น tool names, file names, commands

4. Content Standards
- เขียนด้วยภาษาอังกฤษที่เข้าใจง่าย ไม่ใช้ศัพท์เทคนิคที่ซับซ้อนเกินไป
- ใช้ข้อมูลจริงจากการ `/analyze-project` ไม่สมมติเนื้อหา
- Code examples ต้อง runnable ได้จริง ไม่ใช้ pseudo-code
- ไม่ใช้ placeholder เช่น `{...}`, `Feature 1`, `Description`

5. Usage Section (เลือก heading ตามประเภท)
- **CLI Tool**: ใช้ `## CLI`
- **UI Components**: ใช้ `## Components`  
- **Library**: ใช้ `## Programmable API`
- เขียน entry point หลัก + ตารางสรุป

6. Simple Headings
- ใช้ชื่อ heading ที่เข้าใจง่าย: CLI, Components, Programmable API
- ไม่ต้องซับซ้อน ไม่ต้องมีคำยาก

7. Configuration Format
- ใช้ **code block** (YAML/JSON) ไม่ใช่ตารางละเอียด
- หรือใช้ตารางสั้นๆ ถ้าเป็น library constants

8. API Reference Format
- ใช้ **ตารางสรุป** (Service, Method, Params, Returns)
- ไม่ต้องเขียนโค้ดรายละเอียด
- ระบุแค่ signature หลักๆ

9. Code and Tables
- ใช้ backticks สำหรับ code, commands, file paths, functions
- Tables must have headers and consistent columns
- Use syntax highlighting: ```typescript, ```bash, ```rust

10. File References
- Internal links: `[Package Name](./packages/pkg-name)`
- License link: `[LICENSE](./LICENSE)` หรือ `[LICENSE](../../LICENSE)`
- ใช้ relative paths จากไฟล์ README.md

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน
- Features มี 2 columns: Feature, Benefit
- Headings ง่ายๆ: Purpose, CLI/Components/Programmable API
- ไม่มี Contributing section
- Code examples พร้อมใช้งานได้ทันที
