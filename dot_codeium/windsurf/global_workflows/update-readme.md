---
title: Update Readme
description: สร้าง README.md ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์
auto_execution_mode: 3
related:
  - /check-should-update
  - /gen-changelog
  - /gen-release
  - /analyze-project
  - /all-workspaces
  - /follow-content-quality
  - /use-lang-en
  - /edit-relative
  - /report-uxui-sketch
  - /follow-parallel
---

## Goal

สร้าง `README.md` ครบถ้วนด้วย template มาตรฐานและข้อมูลจริงจากโปรเจกต์ สำหรับ root และ workspaces ใน monorepo

## Scope

ครอบคลุมการสร้าง `README.md` สำหรับ root และทุก workspace ใน monorepo — idempotent: รันซ้ำได้โดยไม่เกิด side effects

## Execute

### 1. Prepare

เตรียมข้อมูลก่อนเขียน README

> Goal: รู้ project type และมี changelog พร้อม

1. ทำ `/check-should-update` เพื่อตรวจ git changes ก่อน — ถ้าไม่มี changes → skip และ report
2. parallel: `/gen-changelog` ∥ `/gen-release` ถ้ามี tag release — ใช้ `/follow-parallel`
3. อ่าน `package.json` ตรวจสอบ project type: `cli-sdk` หรือ `app`
4. ถ้าอ่าน `package.json` ไม่ได้ → stop และ report

### 2. Write Root README

เขียน README หลักของ monorepo

> Goal: Root README ครบถ้วนตาม template ใช้ข้อมูลจริง

1. ทำ `/analyze-project` เพื่อเก็บข้อมูล root
2. อ่าน `manifest files`, `source code`, `config files`
3. เขียน README ตาม template ด้านล่าง
4. ถ้าข้อมูลไม่ครบ → stop และ report ไม่ใช้ placeholder — ถ้า write fail → retry (max 3 → stop/report)

### 3. Generate UI Sketch

สร้าง UX/UI sketch สำหรับ README

> Goal: มี sketch แสดง layout หลักของ workspace

1. ทำ `/report-uxui-sketch` เพื่อวาด layout หลักของ workspace
2. วาดเฉพาะหน้าหลักหรือหน้าที่สำคัญที่สุดของ workspace
3. แปลง sketch เป็น text codeblock (ไม่ใช่ ANSI) สำหรับใส่ใน README
4. วาง sketch ด้านบน Get Started โดยไม่ต้องมี heading — ถ้า sketch fail → retry (max 3 → stop/report)

### 4. Update Workspaces READMEs

อัปเดต README ทุก workspace ใน monorepo

> Goal: ทุก workspace มี README ครบถ้วนตาม template

1. ทำ `/all-workspaces` เพื่อ update README ทุก workspaces
2. ไม่ต้องมี `License` section (ใช้ของ root)
3. ถ้า workspace ไม่มี `package.json` → skip และ report — ถ้า update fail → retry (max 3 → stop/report)

### 5. Validate

ตรวจสอบคุณภาพและอัปเดต references

> Goal: README ผ่าน quality check และ references ถูกต้อง

1. parallel: `/follow-content-quality` ∥ `/edit-relative` เพื่อตรวจสอบคุณภาพและอัปเดต references ไปพร้อมกัน — ใช้ `/follow-parallel`
2. ถ้า validation ไม่ผ่าน → revise และ recheck (max 3 ครั้ง → stop/report)

## Rules

### 1. Section Order And Format

จัดเรียง sections ตามลำดับต่อไปนี้:

- `Status Callout`: ด้านบนสุด - ใช้ `> 🚀` หรือ emoji ที่เหมาะสม
- `Hero Section`: Title, Description, Badges (ชิดซ้าย, ไม่รวม License badge)
- `UI Sketch`: text codeblock แสดง UX/UI layout sketch จาก `/report-uxui-sketch` (ไม่ใช่ ANSI, ใช้ text codeblock ธรรมดา) - วางด้านบน Get Started โดยไม่ต้องมี heading
- `## Get Started`: numbered steps ด้านบน, แต่ละ step มี heading + description ก่อน codeblock
- `## Features`: Markdown table 5 columns (Icon, Feature, Description, Benefit, Usage) พร้อม colored icon จาก iconify CDN
- `## Usage`: `### Usage via ...` heading สำหรับแต่ละ access method (Web, API, CLI, SDK, TUI, etc.) — ครอบคลุมทุก ways ที่ user ใช้งานได้ — ดู Rule `Usage Content Types`
- `## Project`: `<details>`/`<summary>` accordion ลำดับ Goal, Scope, When To Use, Key Concepts, Core Principles, Best Practices
- `## API References`: `<details>`/`<summary>` accordion สำหรับ subsections พร้อม Markdown table (ไม่มี file structure)
- `## Development`: `<details>`/`<summary>` accordion ลำดับ Tech Stack, How It Work, Architecture, Scripts, Workflows, Skills
- `## License`: Section แยกด้านล่างสุด ไม่มี badge (root เท่านั้น)

### 2. Table Column Specs

- `Features`: 5 columns (Icon, Feature, Description, Benefit, Usage)
- `Project > Goal`: 4 columns (Icon, Goal, Status, Description)
- `Project > Scope`: 4 columns (Icon, Scope, Status, Description)
- `Project > When To Use`: 3 columns (Icon, Use Case, Description)
- `Project > Key Concepts`/`Core Principles`/`Best Practices`: 3 columns (Icon, Name, Description)
- `Development > Tech Stack`: 4 columns (Layer, Technology, Version, Description)
- `Development > How It Work`: ภาพ diagram แบบ text codeblock (ไม่ใช่ ANSI)
- `Development > Architecture`/`Workflows`/`Skills`: file structure codeblock (tree format with `#` comments)
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

### 5. Usage Content Types

- **Web**: เขียนเป็น text instructions บอกว่ากดอะไรตรงไหน เช่น "Open the app, navigate to sidebar, click on module" — ห้ามใช้ code block
- **API**: เขียนเป็น code block พร้อม import และ function call
- **CLI**: เขียนเป็น bash code block พร้อม command
- **SDK**: เขียนเป็น code block พร้อม install + import + usage
- **TUI**: เขียนเป็น text instructions บอกว่ากด key อะไร เช่น "Press `q` to quit, `/` to search"
- **Desktop**: เขียนเป็น text instructions บอกว่าเปิด app อย่างไร ใช้ menu อะไร
- **Browser Extension**: เขียนเป็น text instructions บอกว่า install จาก store ไหน ใช้ปุ่มอะไร

### 6. Icons

- ใช้ iconify CDN: `![icon](https://api.iconify.design/<set>:<name>.svg?color=%23<hex>&width=20)` — ต้องมี `?color=%23<hex>` เสมอ (ไม่มี = ขาวดำ)
- ห้ามใช้ emoji ในตาราง — ใช้ icon set: `mdi`, `lucide`, `material-symbols`, `tabler`, `ph`, `iconoir`
- คอลัมน์ Icon จัดกึ่งกลางด้วย `:---:` — แต่ละ icon ต้องมี color ที่แตกต่างกัน
- แนวทางสี: `1976d2` (ฟ้า/core), `388e3c` (เขียว/in scope), `d32f2f` (แดง/out scope), `f57c00` (ส้ม/warning), `7b1fa2` (ม่วง/UI), `c2185b` (ชมพู/features), `303f9f` (คราม/concepts), `0097a7` (ฟ้าขี้ม้า/CLI), `00796b` (เขียวเข้ม/build), `ffa000` (ทอง/content)
- ห้ามใช้ ANSI codeblock ใน README ทั้งหมด

## Example Template

```markdown
# @wrikka/package-name
> 🚀 Short description — Longer description.

```text
┌───────────────────────────────────┐
│  [×]  Package Name                │
├──────────┬────────────────────────┤
│  Sidebar │  Main Content          │
│  [Item]  │  ┌──────────────┐      │
│  └───────┘  │  Component   │      │
└───────────────────────────────────┘
```

## Get Started

1. **Install Package** — `terminal`
   ```bash
   bun add @wrikka/package-name
   ```
2. **Import And Use** — `src/app.ts`
   ```typescript
   import { func } from '@wrikka/package-name';
   func();
   ```

## Features
| Icon | Feature | Description | Benefit | Usage |
|:---:|---------|-------------|---------|-------|
| ![icon](https://api.iconify.design/mdi:rocket.svg?color=%23303f9f&width=20) | Name | What it does | Why it matters | `func()` |

## Usage

### Usage via Web

Open the app at `http://localhost:3000`. Navigate to the sidebar and click on the desired module.

### Usage via API

```typescript
import { createClient } from '@wrikka/package-name/client';
const client = createClient({ url: 'https://api.wrikka.app' });
await client.func('hello');
```

### Usage via CLI

```bash
bunx @wrikka/package-name hello
```

## Project
<details><summary>Goal</summary>
| Icon | Goal | Status | Description |
|:---:|------|--------|-------------|
| ![icon](https://api.iconify.design/mdi:target.svg?color=%23388e3c&width=20) | Goal item | ✓ Goal | Desc |
| ![icon](https://api.iconify.design/mdi:close.svg?color=%23d32f2f&width=20) | Non-goal | ✗ Not Goal | Desc |
</details>
<!-- Scope, When To Use, Key Concepts, Core Principles, Best Practices: same pattern -->

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
┌─────────┐    ┌─────────┐    ┌─────────┐
│ Input   │ ─▶ │ Process │ ─▶ │ Output  │
└─────────┘    └─────────┘    └─────────┘
```
</details>
<details><summary>Architecture</summary>
```
src/
├── modules/
└── index.ts
```
</details>
<details><summary>Scripts</summary>
```json
{
  "dev": "bun run src/index.ts",       // Development mode
  "build": "bunup",                     // Build
  "test": "vitest run",                 // Tests
  "check": "biome lint && tsgo --noEmit && ast-grep scan",  // Lint + type + scan
  "verify": "bun run check && bun run test",                // Check + test
  "ci": "bun run verify && bun run build"                   // Verify + build
}
```
</details>
<!-- Workflows, Skills: file structure codeblock with # comments -->

## Expected Outcome

- README.md ครบถ้วน ใช้ข้อมูลจริงจาก `/analyze-project` ไม่มี placeholder ยกเว้น banner image
- Section order: UI Sketch > Get Started > Features > Usage > Project > API References > Development > License
- `## Usage` ครอบคลุมทุก access methods — ใช้ `### Usage via ...` heading สำหรับแต่ละ method
- Features: row กระชับ ครอบคลุมทุก feature เขียน business value
- ตารางทั้งหมดใช้ colored icon จาก iconify CDN คอลัมน์ Icon จัดกึ่งกลาง — ไม่มี ANSI codeblock — ภาษาอังกฤษตาม `/use-lang-en`
