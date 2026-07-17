---
title: Use Scripts
description: สร้าง scripts สำหรับ automate งานด้วย Bun native APIs, pwsh, หรือ ast-grep
auto_execution_mode: 3
related:
  - /use-bun-shell
  - /use-ast-grep
  - /follow-gitignore
  - /follow-bun
---

## Goal

สร้าง scripts เพื่อ automate งานและประมวลผลไฟล์ ด้วย Bun native APIs, pwsh, หรือ ast-grep ตามความเหมาะสม

## Scope

ใช้สำหรับสร้าง scripts ใน workspace ด้วย Bun native APIs, pwsh, หรือ ast-grep

## Execute

### 1. Choose Type and Location

> Goal: เลือก script type และ location ที่เหมาะสม

1. เลือก type: Bun native APIs (performance/cross-platform), pwsh (Windows), หรือ ast-grep (AST)
2. เลือก location: `temp/` (throwaway), `.devin/scripts/` (permanent), หรือ `.devin/scripts/temp/` (default)
3. ทำตาม `/follow-gitignore` เพื่อให้ temp directories ถูก ignore

### 2. Create Script

> Goal: เขียน script ตาม standards

1. เขียนแบบ composable: `createScript()` return state + actions
2. ใช้ Bun native APIs สำหรับ `.ts` scripts (ดู `/use-bun-shell`, `/follow-bun`)
3. ใช้ CDN imports สำหรับ external dependencies: `https://esm.sh/<name>`
4. เพิ่ม `dryRun` option สำหรับ testing

### 3. Test and Execute

> Goal: ทดสอบและรัน script อย่างปลอดภัย

1. รัน script ใน dry run mode เพื่อดูผลลัพธ์
2. แก้ไข errors ก่อนรันจริง
3. รัน: `bun run <script>.ts`, `pwsh <script>.ps1`, หรือ `ast-grep scan`
4. ลบ scripts จาก `temp/` และ `.devin/scripts/temp/` หลังใช้งานเสร็จ

## Rules

### Script Types

- **Bun native APIs**: file operations, networking, database, compression, crypto
- **pwsh**: Windows system administration, file system operations, automation
- **ast-grep**: AST-based code search, linting, transformation

### File Locations

- `temp/` — scripts ชั่วคราวที่ workspace root (throwaway, gitignored)
- `.devin/scripts/` — scripts ถาวร (committed, เก็บไว้ใช้ซ้ำ)
- `.devin/scripts/temp/` — scripts ชั่วคราวใน .devin (default, gitignored)
- ใช้ `.ts` สำหรับ Bun scripts, `.ps1` สำหรับ PowerShell

### Bun Native API Preference

- ใช้ Bun native APIs สำหรับ `.ts` scripts เสมอเมื่อเป็นไปได้
- `Bun.Glob` แทน `fast-glob`, `Bun.$` แทน `execa`, `Bun.file()` + `Bun.write()` แทน `fs-extra`

### CDN Libraries

```typescript
import { z } from "https://esm.sh/zod"
import { glob } from "https://esm.sh/glob"
```

- CLI: `zod`, `cac`, `consola`, `@clack/prompts`, `picocolors`
- Parsing: `yaml`, `gray-matter`, `jsonc-parser`
- File System: `pretty-bytes`, `env-paths`, `semver`
- Async: `p-limit`, `p-queue`, `p-map`

## Expected Outcome

- Scripts ทำงานได้ด้วย Bun native APIs, pwsh, หรือ ast-grep
- Dependencies ผ่าน CDN (ไม่ต้อง install)
- Scripts อยู่ใน location ถูกต้องตาม Rules
- Temp scripts ถูกลบหลังใช้งาน, permanent scripts เก็บไว้ใช้ซ้ำ
- Dry run mode สำหรับทดสอบก่อน execute จริง

