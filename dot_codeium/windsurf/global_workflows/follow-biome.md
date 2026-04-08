---
title: Follow Biome
description: ตั้งค่าและใช้งาน Biome สำหรับ linting และ formatting แทน ESLint/Prettier
auto_execution_mode: 3
file-patterns:
  - "biome.jsonc"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า Biome เป็นเครื่องมือหลักสำหรับ linting และ formatting แทน ESLint/Prettier ด้วยความเร็วและประสิทธิภาพสูง

## Scope

- ติดตั้ง Biome CLI ผ่าน Bun
- กำหนดค่า `biome.jsonc` สำหรับ root และ workspaces
- เพิ่ม scripts ใน `package.json`
- รองรับ monorepo configuration

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun (เท่านั้น) |
| Project Type | Single repo หรือ monorepo |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | ใช้ `bun add -D @biomejs/biome` เท่านั้น |
| **Scripts** | ต้องมี `lint` และ `format` ใน `package.json` |
| **Config** | ใช้ `biome.jsonc` (with comments) ไม่ใช่ `.json` |
| **VCS** | Enable git integration ใน config |
| **Monorepo** | Root = true, workspaces ใช้ `root: false` + `extends` |

## Structure

### Directory Structure

```text
project/
├── biome.jsonc           # Root config (root: true)
├── package.json          # Scripts
└── apps/
    └── app1/
        └── biome.jsonc   # Workspace config (root: false, extends)
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง dependencies | Add Biome CLI |
| Configure | สร้าง config files | biome.jsonc, scripts |
| Verify | ตรวจสอบการทำงาน | Run lint/format |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Biome**
  - รัน `bun add -D @biomejs/biome`
  - ตรวจสอบ installation สำเร็จ

### Phase 2: Configure

- 2.1 **สร้าง Root Config**
  - สร้าง `biome.jsonc` ที่ root:

```json [biome.jsonc]
{
	"$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
	"vcs": {
		"enabled": true,
		"clientKind": "git",
		"useIgnoreFile": true
	}
}
```

- 2.2 **เพิ่ม Scripts**
  - เพิ่มใน `package.json`:

```json [package.json]
{
    "scripts": {
       "lint" : "biome lint --write",
       "format" : "biome format --write"
    }
}
```

### Phase 3: Monorepo Setup (ถ้ามี)

- 3.1 **Workspace Config**
  - ในแต่ละ workspace สร้าง `biome.jsonc`:

```json [biome.jsonc]
{
   "root": false,
   "extends": "//"
}
```

### Phase 4: Verify

- 4.1 **ทดสอบการทำงาน**
  - รัน `bun run lint`
  - รัน `bun run format`
  - ตรวจสอบว่าทำงานได้ถูกต้อง

## Outputs

| Output | Details |
|--------|-----------|
| biome.jsonc | Root configuration file |
| Updated package.json | Scripts for lint/format |
| Workspace configs | ถ้าเป็น monorepo |

## Expected Outcome

- Biome ติดตั้งและทำงานได้
- มี scripts `lint` และ `format` พร้อมใช้
- Config รองรับ git ignore
- Monorepo workspaces extends จาก root config ถูกต้อง

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows ที่เกี่ยวข้อง
