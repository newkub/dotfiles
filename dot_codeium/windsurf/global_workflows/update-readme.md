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
## Table of Contents
## Why
## Key Concept
## Features
## Built With
## Getting Started
## Installation
## Usage
## Configuration
## API Reference
## Contributing
## Support / FAQ
## License
```

**เรียงลำดับตามความสำคัญ:**
1. **Badges** - ใต้ title เลย (version, license, build status)
2. **Table of Contents** - ลิงก์ไปยังทุก section
3. **Why** - ทำไมต้องใช้
4. **Key Concept** - แนวคิดหลัก + preview
5. **Features** - รายการ features
6. **Built With** - tech stack ที่ใช้
7. **Getting Started** - เริ่มต้นใช้งานอย่างง่าย
8. **Installation** - วิธีติดตั้ง
9. **Usage** - ตัวอย่างการใช้งาน
10. **Configuration** - การตั้งค่า
11. **API Reference** - เอกสารอ้างอิง API
12. **Contributing** - วิธีร่วมพัฒนา
13. **Support / FAQ** - ช่องทางช่วยเหลือ
14. **License** - ใบอนุญาต

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

[![Version](https://img.shields.io/npm/v/package-name)](https://www.npmjs.com/package/package-name)
[![License](https://img.shields.io/npm/l/package-name)](./LICENSE)
[![Build Status](https://img.shields.io/github/actions/workflow/status/org/repo/ci.yml)](https://github.com/org/repo/actions)
[![Downloads](https://img.shields.io/npm/dm/package-name)](https://www.npmjs.com/package/package-name)
[![Coverage](https://img.shields.io/codecov/c/github/org/repo)](https://codecov.io/gh/org/repo)

Brief description from tech stack.

## Table of Contents

- [Why](#why)
- [Key Concept](#key-concept)
- [Features](#features)
- [Built With](#built-with)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [Support / FAQ](#support--faq)
- [License](#license)

## Why

Brief description of what this project does and why it exists.

## Key Concept

| Feature | Preview |
|---------|---------|
| ✨ Feature 1 - Short description | ![Preview](placeholder-image-url) |
| 🚀 Feature 2 - Short description | ![Preview](placeholder-image-url) |

*Note: For CLI/TUI tools, use `[/run-examples]` and capture screenshots to `public/assets`. For UI components, use `[/watch-browser]` and capture screenshots.*

## Features

| Feature | Benefit |
|---------|---------|
| ✨ Feature 1 | What user gains from this feature |
| 🚀 Feature 2 | What user gains from this feature |

## Built With

- [Vue 3](https://vuejs.org/) - Progressive JavaScript framework
- [Nuxt 3](https://nuxt.com/) - Vue framework for production
- [TypeScript](https://www.typescriptlang.org/) - Typed JavaScript
- [UnoCSS](https://unocss.dev/) - Atomic CSS engine

## Getting Started

### Prerequisites

- Node.js 18+ or Bun 1.0+
- Package manager (npm, yarn, pnpm, or bun)

### Quick Start

```bash
# Install
bun add package-name

# Basic usage
import { createApp } from 'package-name'
const app = createApp()
```

## Installation

```bash
bun install package-name
```

## Usage

```typescript
// Basic example
import { MyComponent } from 'package-name'

const app = useMyApp()
app.run()
```

### 4. Write Usage Section

เขียนตัวอย่างการใช้งานพื้นฐาน:

```markdown
## Usage

```typescript
// Import and use
import { useFeature } from 'package-name'

const result = useFeature({ option: true })
```
```

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
```

### 6. Write API Reference

ใช้ตารางสรุป - รวม CLI, Components, Programmatic API, Composables, Server API, Types ทั้งหมดไว้ในส่วนนี้

```markdown
## API Reference

### CLI Commands (if applicable)

| Command | Description | Example |
|---------|-------------|---------|
| `init` | Initialize project | `my-tool init` |
| `build` | Build application | `my-tool build` |

### Components (if applicable)

| Component | Props | Description |
|-----------|-------|-------------|
| `Button` | `variant`, `size`, `onClick` | Primary action button |
| `Card` | `hoverable`, `bordered` | Container component |

### Programmatic API (if applicable)

| Class/Module | Method | Params | Returns |
|--------------|--------|--------|---------|
| `Client` | `connect()` | `options: ConnectOptions` | `Connection` |
| `Worker` | `process()` | `task: Task` | `Result` |

### Composables (if applicable)

| Composable | Returns | Purpose |
|------------|---------|---------|
| `useModal()` | `{ open, close, isOpen }` | Modal state management |
| `useFetch()` | `{ data, pending, error }` | Data fetching |

### Server API (if applicable)

| Route | Method | Description |
|-------|--------|-------------|
| `/api/auth/login` | POST | User authentication |
| `/api/users` | GET | List users |

### Types

| Type | Fields | Purpose |
|------|--------|---------|
| `User` | `id`, `email`, `name` | User entity |
| `Config` | `apiKey`, `endpoint` | Configuration options |

### Utils/Helpers (if applicable)

| Util | Params | Returns | Purpose |
|------|--------|---------|---------|
| `formatDate()` | `date: Date`, `format: string` | `string` | Date formatting |
| `debounce()` | `fn: Function`, `delay: number` | `Function` | Debounce wrapper |
```

### 7. Write Contributing Section

```markdown
## Contributing

Contributions are welcome! Please read our [Contributing Guide](./CONTRIBUTING.md) for details on how to submit pull requests, report issues, and suggest improvements.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
```

### 8. Write Support / FAQ Section

```markdown
## Support / FAQ

**Q: How do I get help?**
A: Open an issue on GitHub or join our Discord community.

**Q: Is this production ready?**
A: Yes, used in production by multiple organizations.

### Support Channels

- 🐛 [Issues](https://github.com/org/repo/issues)
- 💬 [Discussions](https://github.com/org/repo/discussions)
- 📧 Email: support@example.com
```

### 9. Write License Section

```markdown
## License

MIT License - See [LICENSE](./LICENSE)
```

### 10. Validate and Verify

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

5. Key Concept Section
- ใช้ตาราง 2 columns: ซ้าย (Features + Description), ขวา (Preview/Screenshot)
- ใส่ emoji ในชื่อ feature
- Screenshot สำหรับ CLI/TUI: ใช้ `[/run-examples]` แล้ว capture ไป `public/assets`
- Screenshot สำหรับ UI: ใช้ `[/watch-browser]` แล้ว capture
- ถ้ายังไม่มี screenshot จริง ให้ใส่ placeholder URL (เช่น `https://via.placeholder.com/600x400?text=Feature+Preview`)

6. Section Ordering
- Badges อยู่ใต้ title เลย
- Table of Contents อยู่หลัง description
- Built With อยู่หลัง Features
- Getting Started อยู่ก่อน Installation
- Usage อยู่หลัง Installation
- Contributing อยู่หลัง API Reference
- Support / FAQ อยู่ก่อน License

7. Badges Format
- Version: `![Version](https://img.shields.io/npm/v/package-name)`
- License: `![License](https://img.shields.io/npm/l/package-name)`
- Build: `![Build](https://img.shields.io/github/actions/workflow/status/org/repo/ci.yml)`
- Downloads: `![Downloads](https://img.shields.io/npm/dm/package-name)`
- Coverage: `![Coverage](https://img.shields.io/codecov/c/github/org/repo)`

8. Simple Headings
- ใช้ `## Why` แทน `## Purpose`
- ใช้ `## Key Concept` สำหรับ feature preview
- ไม่ต้องมี `## CLI`, `## Components` แยก (รวมใน API Reference)

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
- Badges: Version, License, Build, Downloads, Coverage
- Table of Contents ลิงก์ไปยังทุก section
- Features มี emoji และ 2 columns: Feature, Benefit
- Built With: Tech stack ที่ใช้
- Getting Started: Prerequisites และ Quick Start
- Usage: ตัวอย่างการใช้งานพื้นฐาน
- Headings: Why, Key Concept, Features, Built With, Getting Started, Installation, Usage, Configuration, API Reference, Contributing, Support/FAQ, License
- API Reference รวม CLI, Components, Services, DTOs ทั้งหมด
- Contributing: วิธีร่วมพัฒนา
- Support / FAQ: ช่องทางช่วยเหลือ
- Code examples พร้อมใช้งานได้ทันที
