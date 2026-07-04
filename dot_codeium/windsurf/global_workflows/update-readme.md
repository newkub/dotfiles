---
title: Update Readme
description: สร้าง README.md ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์
auto_execution_mode: 3
related_workflows:
  - /analyze-project
  - /all-workspaces
  - /follow-content-quality
  - /write-windsurf-global-workflows
---

## Goal

สร้าง `README.md` ที่มีเนื้อหาครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากการวิเคราะห์โปรเจกต์ สำหรับ root และ workspaces ใน monorepo

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
2. ไม่ต้องมี `License` และ `History` sections (ใช้ของ root)

### 4. Validate

1. ทำ `/follow-content-quality` เพื่อตรวจสอบคุณภาพ
2. ใช้ `/update-references` หากมี file changes

## Rules

### 1. Section Order

จัดเรียง sections ตามลำดับต่อไปนี้:

- `Status Callout`: ด้านบนสุด - ใช้ `> 🚀` หรือ emoji ที่เหมาะสม
- `Hero Section`: Title, Description, Badges (ชิดซ้าย, รวม License MIT badge)
- `## Project`: `<details>`/`<summary>` accordion ลำดับ Goal, Scope, When To Use, Key Concepts, Core Principles, Best Practices (อยู่เหนือ Features)
- `## Features`: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม icon จาก iconify - เขียนให้ครอบคลุมที่สุด, maximize coverage
- `## Quick Start`: Installation ด้วย numbered steps ไม่มี indent, มี filename ใน codeblock, มี file structure
- `## Usage`: HTML 2-column layout (ซ้าย: code block + filename, ขวา: 2 ส่วน - description ตรงกลาง + ANSI preview, ยืดสูงเท่า col ซ้าย)
- `## API References`: `<details>`/`<summary>` accordion สำหรับ subsections พร้อมตาราง (ไม่มี file structure)
- `## Development`: `<details>`/`<summary>` accordion ลำดับ Tech Stack, How It Work, Architecture, Scripts, Workflows, Skills
- `## License`: Section แยกด้านล่างสุด พร้อม MIT badge (root เท่านั้น)

### 2. Usage Format

- ซ้าย: `### filename.ts` heading + `typescript` codeblock
- ขวา: `<p align="center">` description ตรงกลาง + `ansi` codeblock preview
- ใช้ `<table><tr><td width="50%" valign="top">` ทั้ง 2 คอลัมน์ กว้างเท่ากัน

### 3. API References Format

- แต่ละ subsection เป็น `<details>`/`<summary>` accordion พร้อม Markdown table
- ไม่มี file structure (file structure อยู่ใน Development > Architecture)

### 4. Project Format

- `Goal`: 4 columns (Icon, Goal, Status, Description) - รวม ✓ Goal / ✗ Not Goal
- `Scope`: 4 columns (Icon, Scope, Status, Description) - รวม ✓ In Scope / ✗ Out of Scope
- `When To Use`: 3 columns (Icon, Use Case, Description) - แสดงว่าปกติใช้ยังไงและถ้าใช้จะเป็นยังไง
- `Key Concepts`, `Core Principles`, `Best Practices`: 3 columns (Icon, Name, Description)

### 5. Development Format

- `Tech Stack`: 4 columns (Layer, Technology, Version, Description) จาก `package.json`
- `How It Work`: ANSI visual workflow diagram พร้อม icons (📦 🔧 ✅ ❌ etc.) จัด layout ให้อยู่ตรงกลาง
- `Architecture`, `Workflows`, `Skills`: codeblock แสดง structure
- `Scripts`: แสดงเป็น JSON codeblock จาก `package.json` scripts object จริงๆ พร้อม comment ในแต่ละบรรทัด

### 6. Quick Start Format

- HTML 2-column layout: ซ้ายแสดง title + description + file structure, ขวาแสดง steps
- คอลัมน์กว้างเท่ากัน 50%/50%
- ซ้าย: มี title และ description อธิบายโครงสร้างโปรเจกต์
- ขวา: แต่ละ step มี heading + description อธิบายสั้นๆ ก่อน codeblock
- Step headings เขียนให้เข้าใจง่าย (เช่น Install Package, Import Utilities, Use In Your App)
- แต่ละ codeblock มี filename ใน heading
- ใช้ `<table><tr><td width="50%" valign="top">` ทั้ง 2 คอลัมน์

### 7. Content Standards

- ใช้ข้อมูลจริงจาก `/analyze-project`, code รันได้จริง
- ไม่ใช้ placeholder ยกเว้น banner image
- README.md: Headers/List ภาษาอังกฤษ, Workflow: ภาษาไทย
- ไม่มี `## Information`, `## Key Concepts`, `## Tech Stack` เป็น section แยก

### 8. Features Writing Standards

- Coverage: ครอบคลุมทุก features จาก source code ไม่มีการข้าม
- Concise Rows: แต่ละ row กระชับ ไม่ใช่เขียน Description ให้ยาว แต่มี row ให้ครบ
- Business-Focused: เขียน business value ไม่ใช่แค่ technical details
- Icons: ใช้ icon จาก iconify ที่เหมาะสม

## Example Template

```markdown
# @wrikka/package-name
> 🚀 Short description
Longer description.
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

## Project
<details><summary>Goal</summary>
| Icon | Goal | Status | Description |
|------|------|--------|-------------|
| ![icon](url) | Goal item | ✓ Goal | Desc |
| ![icon](url) | Non-goal | ✗ Not Goal | Desc |
</details>
<details><summary>Scope</summary>
| Icon | Scope | Status | Description |
|------|-------|--------|-------------|
| ![icon](url) | In scope | ✓ In Scope | Desc |
| ![icon](url) | Out of scope | ✗ Out of Scope | Desc |
</details>
<details><summary>Key Concepts</summary>
| Icon | Concept | Description |
|------|---------|-------------|
| ![icon](url) | Concept | Desc |
</details>
<details><summary>Core Principles</summary>
| Icon | Principle | Description |
|------|-----------|-------------|
| ![icon](url) | Principle | Desc |
</details>
<details><summary>When To Use</summary>
| Icon | Use Case | Description |
|------|----------|-------------|
| ![icon](url) | Use case | When to use and what happens |
</details>
<details><summary>Best Practices</summary>
| Icon | Practice | Description |
|------|----------|-------------|
| ![icon](url) | Practice | Desc |
</details>

## Features
| Icon | Feature | Description | Benefit | Usage |
|------|---------|-------------|---------|-------|
| ![icon](url) | Name | What it does | Why it matters | `func()` |

## Quick Start
<table>
<tr>
<td width="50%" valign="top">

**Project Structure**

โครงสร้างไฟล์หลักของ package แสดง entry point และ modules

```
src/
├── index.ts    # Import and export
└── app.ts      # Usage example
```

</td>
<td width="50%" valign="top">

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

</td>
</tr>
</table>

## Usage
### example.ts
<table>
<tr>
<td width="50%" valign="top">

```typescript
import { func } from '@wrikka/package-name';
func('hello');
```

</td>
<td width="50%" valign="top">

<p align="center">Preview shows terminal output.</p>

```ansi
┌─────────────────────────┐
│  Result output here     │
│  ✓ Done                 │
└─────────────────────────┘
```

</td>
</tr>
</table>

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
| Build | bunup | latest | Bundling with Bun |
</details>
<details><summary>How It Work</summary>
```ansi
      ┌─────────┐         ┌─────────┐         ┌─────────┐
      │ 📦 Input │  ─────▶ │ 🔧 Process │  ─────▶ │ ✅ Output │
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
  "scripts": {
    "dev": "bun run src/index.ts",              // Run in development mode
    "build": "bunup",                            // Build with bunup
    "build:watch": "bunup --watch",               // Build in watch mode
    "test": "vitest run",                         // Run tests with Vitest
    "test:watch": "vitest",                       // Watch mode tests
    "test:coverage": "vitest run --coverage",     // Tests with coverage report
    "lint": "biome check",                        // Lint with Biome
    "lint:fix": "biome check --write",            // Auto-fix lint issues
    "typecheck": "tsgo --noEmit",                 // Type check with tsgo
    "typecheck:watch": "tsgo --noEmit --watch",   // Type check in watch mode
    "scan": "sg scan",                            // AST scan with ast-grep
    "check": "bun run lint && bun run typecheck && bun run scan",  // Lint + typecheck + scan
    "verify": "bun run check && bun run test",    // Check + test
    "ci": "bun run verify && bun run build",      // Verify + build
    "clean": "rm -rf node_modules",               // Remove node_modules
    "security": "bun audit"                       // Security audit
  }
}
```
</details>
<details><summary>Workflows</summary>
```
.devin/
├── rules/
├── scripts/
├── workflows/
└── hooks/
```
</details>
<details><summary>Skills</summary>
```
(No skills needed for this package)
```
</details>
```

## Expected Outcome

- README.md ครบถ้วน ไม่มี placeholder
- Project อยู่เหนือ Features, ไม่มี Information/Tech Stack section แยก
- Features: row กระชับ ครอบคลุมทุก feature ไม่ใช่ Description ยาว
- Quick Start: ไม่มี indent, มี filename, มี file structure
- Usage: col ขวา 2 ส่วน (description ตรงกลาง + ANSI), กว้างเท่ากัน
- API References: ไม่มี file structure
- Development: Tech Stack, How It Work (visual ANSI), Architecture, Scripts, Workflows, Skills
