---
title: Follow Oxlint
description: ตั้งค่าและใช้งาน Oxlint สำหรับ fast linting ด้วย Rust-based linter
auto_execution_mode: 3
file-patterns:
  - ".oxlintrc.json"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า Oxlint เป็น linter ที่เร็วที่สุดสำหรับ JavaScript/TypeScript ด้วยประสิทธิภาพจาก Rust

## Scope

- ติดตั้ง Oxlint และ TypeScript plugin
- กำหนดค่า `.oxlintrc.json` สำหรับ root และ workspaces
- เพิ่ม scripts ใน `package.json`
- รองรับหลาย plugins (React, Vue, Next.js, ฯลฯ)

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Project Type | Single repo หรือ monorepo |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | `bun add -D oxlint oxlint-tsgolint` |
| **Script** | มี script `lint` ใน package.json |
| **Type Aware** | ใช้ `--type-aware` flag |
| **Plugins** | ระบุ plugins ที่ใช้ในคอนฟิก |
| **Monorepo** | Workspaces extends จาก root config |

## Structure

### Directory Structure

```text
project/
├── .oxlintrc.json        # Root config
├── package.json          # Lint script
└── apps/
    └── app1/
        └── .oxlintrc.json # Extends root
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add oxlint packages |
| Configure | สร้าง config | .oxlintrc.json |
| Script | เพิ่ม scripts | package.json |
| Verify | ทดสอบ | Run lint |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Oxlint**
  - รัน `bun add -D oxlint oxlint-tsgolint`
  - ตรวจสอบ installation สำเร็จ

### Phase 2: Configure

- 2.1 **สร้าง Root Config**
  - สร้าง `.oxlintrc.json` ที่ root:

```json [.oxlintrc.json]
{
	"$schema": "./node_modules/oxlint/configuration_schema.json",
	"plugins": [
		"import",
		"oxc",
		"react",
		"unicorn",
		"react-perf",
		"vitest",
		"jsx-a11y",
        "nextjs",
        "import",
		"promise",
		"vitest",
		"typescript",
		"vue",
		"node"
	],
	"env": {
		"browser": true,
		"node": true
	}
}
```

- 2.2 **เพิ่ม Lint Script**
  - เพิ่มใน `package.json`:

```json [package.json]
{
  "scripts": {
    "lint": "oxlint --fix --type-aware"
  }
}
```

### Phase 3: Monorepo Setup (ถ้ามี)

- 3.1 **Workspace Config**
  - ในแต่ละ workspace สร้าง `.oxlintrc.json`:

```json [.oxlintrc.json]
{
  "extends": ["../.oxlintrc.json"]
}
```

### Phase 4: Verify

- 4.1 **ทดสอบการทำงาน**
  - รัน `bun run lint`
  - ตรวจสอบว่า lint ทำงานได้ถูกต้อง

## Outputs

| Output | Details |
|--------|-----------|
| .oxlintrc.json | Root configuration |
| Updated package.json | Lint script |
| Workspace configs | ถ้าเป็น monorepo |

## Expected Outcome

- Oxlint ติดตั้งและทำงานได้
- Plugins ที่กำหนดทำงานได้
- Type-aware checking enabled
- Monorepo extends ทำงานถูกต้อง

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows ที่เกี่ยวข้อง
