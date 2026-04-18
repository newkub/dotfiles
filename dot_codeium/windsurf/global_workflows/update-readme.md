---
description: Create comprehensive README.md files with actual project analysis data without placeholders
auto_execution_mode: 3
---

## Goal

Create comprehensive README.md files with actual project analysis data without placeholders.

## Execute

### 1. Prepare Analysis

1. รัน `/analyze-project` เพื่อเก็บข้อมูลโปรเจกต์
2. อ่าน `README.md` ปัจจุบันเพื่อดูสิ่งที่ต้องอัพเดท
3. บันทึก tech stack, dependencies, และ file structure

### 2. Gather Project Information

1. อ่าน manifest files: `package.json`, `Cargo.toml`, `pyproject.toml`
2. ใช้ `list_dir` ดูโครงสร้าง `src/`, `apps/`, `packages/`
3. อ่าน source code เพื่อเข้าใจ features
4. อ่าน config files เพื่อดูตัวเลือกการตั้งค่า

### 3. Write Core Sections

สร้าง sections ด้วยข้อมูลจริงจากการวิเคราะห์:

**Required Headings:**
```
# project-name
## Why
## Key Concept
## Features
## Built With
## Getting Started
## Installation
## Usage
## Configuration
## API Reference
## License
```

**Section Order:**
1. Title
2. Why
3. Key Concept
4. Features (table 3 col: features, description, benefit)
5. Built With
6. Getting Started
7. Installation
8. Usage
9. Configuration
10. API Reference (bullet format, no table)
11. License

### 4. Write Usage Section

เขียน usage ตาม usecase จริงของโปรเจกต์ แบ่งเป็น subsections ตาม usecase แต่ละอัน

### 5. Write Configuration Section

ใช้ code block (YAML/JSON) หรือตารางสั้นๆ สำหรับ library constants

### 6. Write API Reference

เขียนแค่ API ของ interface หลักๆ เท่านั้น ใช้ bullet format:

```markdown
## API Reference

### @wrikka/cli-builder
- `CLIController`, `CommandController`, `HelpController`
- `CommandBuilder` - Fluent API for commands
- `loadSpec()`, `parse()` - Core functions
- `CLIValidationService`, `CommandParsingService`, `PromptValidationService`

### @wrikka/cli-completions
- `createBashAdapter()`, `createZshAdapter()`, `createFishAdapter()`, `createPowerShellAdapter()`
- `runCompleter()`, `generateBashOutput()`, `generateZshOutput()`, `generateFishOutput()`, `generatePowerShellOutput()`

### @wrikka/cli-tui-prompt
- `TUIPromptController`
- `TextInputHandler`, `SelectInputHandler`, `ConfirmInputHandler`
- `BaseTUIRenderer`, `TextPromptRenderer`, `SelectPromptRenderer`, `ConfirmPromptRenderer`
- `TUIKeyboardHandler`
```

### 7. Write License Section

### 8. Validate and Verify

1. ตรวจสอบว่าทุก section ใช้ข้อมูลจริงจากโปรเจกต์
2. ยืนยันว่า code examples ถูกต้องและ runnable ได้
3. ตรวจสอบว่าไม่มี placeholder

## Rules

### 1. Frontmatter Standards
- title: Title Case สื่อความหมายชัดเจน
- description: กระชับไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3 เท่านั้น
- ห้ามเพิ่ม field อื่นโดยไม่จำเป็น

### 2. Structure & Format
- โครงสร้าง: ## Goal, ## Execute, ## Rules, ## Expected Outcome
- ใช้ numbered list (1., 2., 3.) เรียงตาม flow การทำงาน
- Bullet points ชิดซ้าย ใช้ dash (-)
- เขียนกระชับ ตรงประเด็น
- ไฟล์ไม่เกิน 200 บรรทัด

### 3. Language Standards
- หัวข้อภาษาอังกฤษ Title Case
- รายการใช้ภาษาไทย
- ยกเว้นคำศัพท์เฉพาะทาง

### 4. Content Standards
- ใช้ข้อมูลจริงจาก `/analyze-project`
- Code examples ต้อง runnable ได้จริง
- ไม่ใช้ placeholder

### 5. Features Format
- ใช้ตาราง 3 col: features, description, benefit
- เพิ่ม emoji ใน column features

### 6. API Reference Format
- เขียนแค่ interface หลักๆ
- ใช้ bullet format ไม่ใช้ตาราง

### 7. No Badges
- ไม่ต้องมี badges ด้านบน

### 8. No Contributing/Support Sections
- ไม่ต้องมี Contributing และ Support sections

### 9. No Examples Section
- ไม่ต้องมี Examples section ใน README
- เขียนเป็น list แล้ว link ไป examples/

### 10. Markdown Links
- External references: ใช้ markdown link เสมอ
- Internal references: ใช้ markdown link เสมอ

## Expected Outcome

- README.md ที่มีเนื้อหาครบถ้วน
- Features มี emoji และเป็นตาราง 3 col
- Built With: Tech stack ที่ใช้
- Getting Started: Prerequisites และ Quick Start
- API Reference เขียนแค่ interface หลักๆ ในรูปแบบ bullet
- License: License section
- Code examples พร้อมใช้งานได้ทันที
