---
title: Follow Biome
description: ตั้งค่าและใช้งาน Biome สำหรับ linting และ formatting แทน ESLint/Prettier
auto_execution_mode: 3
---

ตั้งค่า Biome เป็นเครื่องมือหลักสำหรับ linting และ formatting แทน ESLint/Prettier

## Goal

ติดตั้งและกำหนดค่า Biome สำหรับ linting และ formatting ด้วย Bun

## Execute

### 1. Setup

1. ติดตั้ง Biome CLI ด้วย `bun add -D @biomejs/biome`
2. ตรวจสอบว่ามี `package.json` อยู่แล้ว

### 2. Configure

1. สร้าง `biome.jsonc` ที่ root พร้อม VCS integration และ recommended rules

```json [biome.jsonc]
{
	"$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
	"vcs": {
		"enabled": true,
		"clientKind": "git",
		"useIgnoreFile": true
	},
	"linter": {
		"enabled": true
	},
	"formatter": {
		"enabled": true
	}
}
```

2. เพิ่ม scripts `lint`, `lint:fix` และ `format` ใน `package.json`

```json [package.json]
{
    "scripts": {
       "lint" : "biome lint",
       "lint:fix" : "biome lint --write",
       "format" : "biome format --write"
    }
}
```

### 3. Monorepo

1. ในแต่ละ workspace สร้าง `biome.jsonc` ด้วย `root: false` และ `extends: "//"`

```json [biome.jsonc]
{
   "root": false,
   "extends": "//"
}
```

### 4. Optional Domains

1. เลือก domains ที่เกี่ยวข้องกับโปรเจกต์
2. เพิ่ม domains ใน `biome.jsonc` ผ่าน `linter.domains`

```json [biome.jsonc]
{
	"linter": {
		"domains": {
			"drizzle": "recommended",
			"project": "recommended",
			"types": "recommended",
			"turborepo": "recommended",
			"vue": "recommended",
			"vitest": "recommended"
		}
	}
}
```

### 5. Verify

1. รัน `bun run lint`
2. รัน `bun run format`

### 6. GitHub Actions CI

1. สร้าง `.github/workflows/biome.yml` สำหรับ CI/CD

```yaml [.github/workflows/biome.yml]
name: Code quality

on:
  push:
  pull_request:

jobs:
  quality:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          persist-credentials: false
      - name: Setup Biome
        uses: biomejs/setup-biome@v2
        with:
          version: latest
      - name: Run Biome
        run: biome ci .
```

## Rules

### 1. Installation

- ใช้ `bun add -D @biomejs/biome` เท่านั้น
- ต้องมี `package.json` อยู่แล้ว

### 2. Configuration

- ใช้ `biome.jsonc` (with comments) ไม่ใช่ `.json`
- Enable VCS integration ด้วย git
- Root config ใช้ `root: true`
- Workspace configs ใช้ `root: false` + `extends: "//"`

### 3. Scripts

- ต้องมี `lint` script: `biome lint` (check only)
- ต้องมี `lint:fix` script: `biome lint --write` (fix issues)
- ต้องมี `format` script: `biome format --write`

### 4. Optional Domains

- Domain ใช้ `recommended` เท่านั้น ไม่ใช้ `all`
- Drizzle: สำหรับโปรเจกต์ที่ใช้ Drizzle ORM
- Next: สำหรับ Next.js projects
- Playwright: สำหรับ Playwright test projects
- Project: สำหรับ project-level analysis (มีผลต่อ performance)
- Qwik: สำหรับ Qwik projects
- React: สำหรับ React projects (conflict กับ Solid)
- ReactNative: สำหรับ React Native projects
- Solid: สำหรับ Solid projects (conflict กับ React)
- Test: สำหรับ test files
- Turborepo: สำหรับ Turborepo projects
- Types: สำหรับ type analysis (มีผลต่อ performance)
- Vue: สำหรับ Vue projects

## Expected Outcome

- Biome ติดตั้งและทำงานได้
- มี scripts `lint`, `lint:fix` และ `format` พร้อมใช้
- Config รองรับ git ignore
- Monorepo workspaces extends จาก root config ถูกต้อง
