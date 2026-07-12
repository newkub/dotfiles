---
title: Update Readme
description: สร้าง README.md ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์
auto_execution_mode: 3
related:
  - /analyze-project
  - /all-workspaces
  - /follow-content-quality
  - /write-global-workflows
  - /use-lang-en
---

## Goal

สร้าง `README.md` ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์ สำหรับ root และ workspaces ใน monorepo

## Scope

ครอบคลุมการสร้าง `README.md` สำหรับ root และทุก workspace ใน monorepo

## Execute

### 1. Prepare

1. ทำ `/gen-changelog` และ `/gen-release` ถ้ามี tag release
2. อ่าน `package.json` ตรวจสอบ project type: `cli-sdk` หรือ `app`

### 2. Write Root README

1. ทำ `/analyze-project` เพื่อเก็บข้อมูล root
2. อ่าน `manifest files`, `source code`, `config files`
3. เขียน README ตาม template ด้านล่าง

### 3. Update Workspaces READMEs

1. ทำ `/all-workspaces` เพื่อ update README ทุก workspaces
2. ไม่ต้องมี `License` section (ใช้ของ root)

### 4. Validate

1. ทำ `/follow-content-quality` เพื่อตรวจสอบคุณภาพ
2. ใช้ `/update-references` หากมี file changes

## Rules

### 1. Section Order And Format

จัดเรียง sections ตามลำดับต่อไปนี้:

- `Status Callout`: ด้านบนสุด - ใช้ `> 🚀` หรือ emoji ที่เหมาะสม
- `Hero Section`: Title, Description, Badges (ชิดซ้าย, รวม License MIT badge)
- `## Quick Start`: numbered steps ด้านบน, แต่ละ step มี heading + description ก่อน codeblock
- `## Features`: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม colored icon จาก iconify CDN
- `## Usage`: `### filename.ts` heading + code block เท่านั้น
- `## Project`: `<details>`/`<summary>` accordion ลำดับ Goal, Scope, When To Use, Key Concepts, Core Principles, Best Practices
- `## API References`: `<details>`/`<summary>` accordion สำหรับ subsections พร้อม Markdown table (ไม่มี file structure)
- `## Development`: `<details>`/`<summary>` accordion ลำดับ Tech Stack, How It Work, Architecture, Scripts, Workflows, Skills
- `## License`: Section แยกด้านล่างสุด พร้อม MIT badge (root เท่านั้น)

### 2. Table Column Specs

- `Features`: 5 columns (Icon, Feature, Description, Benefit, Usage)
- `Project > Goal`: 4 columns (Icon, Goal, Status, Description)
- `Project > Scope`: 4 columns (Icon, Scope, Status, Description)
- `Project > When To Use`: 3 columns (Icon, Use Case, Description)
- `Project > Key Concepts`/`Core Principles`/`Best Practices`: 3 columns (Icon, Name, Description)
- `Development > Tech Stack`: 4 columns (Layer, Technology, Version, Description)
- `Development > How It Work`: ภาพ diagram แบบ text codeblock (ไม่ใช่ ANSI)
- `Development > Architecture`/`Workflows`/`Skills`: codeblock
- `Development > Scripts`: JSON codeblock พร้อม comment

### 3. Content Standards

- ทำ `/use-lang-en` — README.md ทั้งหมดเป็นภาษาอังกฤษ
- ใช้ข้อมูลจริงจาก `/analyze-project`, code รันได้จริง
- ไม่ใช้ placeholder ยกเว้น banner image
- ไม่มี `## Information`, `## Key Concepts`, `## Tech Stack` เป็น section แยก

### 4. Features Writing Standards

- Coverage: ครอบคลุมทุก features จาก source code ไม่มีการข้าม
- Concise Rows: แต่ละ row กระชับ มี row ให้ครบ ไม่เขียน Description ยาว
- Business-Focused: เขียน business value ไม่ใช่แค่ technical details

### 5. Icons

- ใช้ iconify CDN: `![icon](https://api.iconify.design/<set>:<name>.svg?color=<hex>)`
- ห้ามใช้ icon ขาวดำ (ไม่มี color parameter) ทุก icon ต้องมี `?color=<hex>`
- ห้ามใช้ emoji ในตารางทั้งหมด
- เลือก icon set ที่เหมาะสม: `mdi`, `lucide`, `material-symbols`, `tabler`, `ph`, `iconoir`
- แต่ละ icon ต้องมี color ที่แตกต่างกันตามเหมาะสม - ไม่ใช้สีเดียวทั้งหมด
- กำหนด color ด้วย `?color=<hex>` (ไม่มี `#`) เช่น `?color=1976d2`
- คอลัมน์ Icon ในตารางต้องจัดให้อยู่ตรงกลางของ cell เสมอ ใช้ `:---:` ใน header row
- แนวทางสี (เลือกตาม context ของแต่ละ icon):
  - `1976d2` (ฟ้า) — core, utility, primary | `388e3c` (เขียว) — success, in scope | `d32f2f` (แดง) — negative, out of scope, security
  - `f57c00` (ส้ม) — warning, highlight | `7b1fa2` (ม่วง) — design, UI | `c2185b` (ชมพู) — features, testing
  - `303f9f` (คราม) — concepts, web | `0097a7` (ฟ้าขี้ม้า) — development, CLI | `00796b` (เขียวเข้ม) — build, tools | `ffa000` (เหลือวอำพัน) — file, content
- ตัวอย่าง: `![rocket](https://api.iconify.design/mdi:rocket.svg?color=303f9f)`
- ห้ามใช้ ANSI codeblock ใน README ทั้งหมด ใช้ codeblock ธรรมดาแทน

## Example Template

```markdown
# @wrikka/package-name
> 🚀 Short description
Longer description.
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

## Quick Start

1. **Install Package** — `terminal`
   Install the package to your project
   ```bash
   bun add @wrikka/package-name
   ```
2. **Import Utilities** — `src/index.ts`
   Import functions from the package
   ```typescript
   import { func } from '@wrikka/package-name';
   ```
3. **Use In Your App** — `src/app.ts`
   Call the function in your code
   ```typescript
   func();
   ```

## Features
| :---: | Feature | Description | Benefit | Usage |
|------|---------|-------------|---------|-------|
| ![icon](https://api.iconify.design/mdi:rocket.svg?color=303f9f) | Name | What it does | Why it matters | `func()` |

## Usage

### example.ts

```typescript
import { func } from '@wrikka/package-name';
func('hello');
```

## Project
<details><summary>Goal</summary>
| :---: | Goal | Status | Description |
|------|------|--------|-------------|
| ![icon](https://api.iconify.design/mdi:target.svg?color=388e3c) | Goal item | ✓ Goal | Desc |
| ![icon](https://api.iconify.design/mdi:close.svg?color=d32f2f) | Non-goal | ✗ Not Goal | Desc |
</details>
<details><summary>Scope</summary>
| :---: | Scope | Status | Description |
|------|-------|--------|-------------|
| ![icon](https://api.iconify.design/mdi:check.svg?color=388e3c) | In scope | ✓ In Scope | Desc |
| ![icon](https://api.iconify.design/mdi:close.svg?color=d32f2f) | Out of scope | ✗ Out of Scope | Desc |
</details>
<details><summary>Key Concepts</summary>
| :---: | Concept | Description |
|------|---------|-------------|
| ![icon](https://api.iconify.design/mdi:lightbulb.svg?color=303f9f) | Concept | Desc |
</details>
<!-- Core Principles, When To Use, Best Practices: same 3-column pattern as Key Concepts -->

## API References
<details><summary>Functions</summary>
| Function | Description |
|----------|-------------|
| `func(arg)` | Does something |
</details>

## Development
<details><summary>Tech Stack</summary>
| Layer | Technology | Version | Description |
|-------|-------------|---------|-------------|
| Runtime | Bun | >= 1.3.10 | JavaScript runtime |
| Language | TypeScript | 6.0.3 | Type-safe development |
</details>
<details><summary>How It Work</summary>
```text
      ┌─────────┐         ┌─────────┐         ┌─────────┐
      │ Input   │  ─────▶ │ Process │  ─────▶ │ Output  │
      └─────────┘         └─────────┘         └─────────┘
```
</details>
<details><summary>Architecture</summary>
```
src/
├── modules/
│   └── ...
└── index.ts
```
</details>
<details><summary>Scripts</summary>
```json
{
  "dev": "bun run src/index.ts",              // Run in development mode
  "build": "bunup",                            // Build with bunup
  "test": "vitest run",                         // Run tests with Vitest
  "lint": "biome check",                        // Lint with Biome
  "typecheck": "tsgo --noEmit",                 // Type check with tsgo
  "verify": "bun run lint && bun run test",    // Check + test
  "ci": "bun run verify && bun run build"      // Verify + build
}
```
</details>
```

## Expected Outcome

- README.md ครบถ้วน ใช้ข้อมูลจริงจาก `/analyze-project` ไม่มี placeholder ยกเว้น banner image
- Section order: Quick Start > Features > Usage > Project > API References > Development > License
- Features: row กระชับ ครอบคลุมทุก feature จาก source code เขียน business value
- ตารางทั้งหมดใช้ colored icon จาก iconify CDN (มี `?color=<hex>`) คอลัมน์ Icon จัดกึ่งกลางด้วย `:---:`
- ไม่มี ANSI codeblock ใน README ทั้งหมด
- ภาษาอังกฤษทั้งหมดตาม `/use-lang-en`
