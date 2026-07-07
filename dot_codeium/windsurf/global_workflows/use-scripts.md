---
title: Use Scripts
description: สร้าง scripts สำหรับ automate งานด้วย Bun native APIs, pwsh, หรือ ast-grep
auto_execution_mode: 3
related_workflows:
  - /use-bun-shell
  - /use-ast-grep
  - /follow-gitignore
  - /learn-from-code-pattern
---

## Goal

สร้าง scripts เพื่อ automate งานและประมวลผลไฟล์ ด้วย Bun native APIs, pwsh, หรือ ast-grep ตามความเหมาะสม

## Scope

ใช้สำหรับสร้าง scripts ใน `.devin/scripts/temp/` ใน workspace เท่านั้น

## Execute

### 1. Prepare

1. ทำตาม `/write-global-workflows` เมื่อสร้างหรือแก้ไข workflow
2. ทำตาม `/follow-gitignore` เพื่อให้ temp directory ถูก ignore ใน .gitignore

### 2. Choose Script Type

1. ใช้ Bun native APIs ถ้าต้องการ performance และ cross-platform: ดูจาก `/use-bun-shell`
2. ใช้ pwsh ถ้าต้องการ Windows-specific commands หรือ system administration
3. ใช้ ast-grep ถ้าต้องการ AST-based code search และ transformation: ดูจาก `/use-ast-grep`

### 3. Create Script

1. สร้างไฟล์ script ตาม Rules ในหมวด File Location
2. เขียนแบบ composable: `createScript()` return state + actions
3. ดูรายละเอียด Bun APIs จาก `/use-bun-shell`
4. ดูรายละเอียด ast-grep จาก `/use-ast-grep`
5. ไฟล์ script ยาวได้ตามต้องการ ไม่ต้อง split

### 4. Dry Run

1. รัน script ใน dry run mode เพื่อดูผลลัพธ์ก่อน execute จริง
2. ตรวจสอบว่า script ทำงานถูกต้อง
3. แก้ไข errors ก่อนรันจริง

### 5. Execute and Cleanup

1. รัน script ด้วย `bun run .devin/scripts/temp/<script>.ts` สำหรับ Bun scripts
2. รัน script ด้วย `pwsh .devin/scripts/temp/<script>.ps1` สำหรับ PowerShell scripts
3. รัน script ด้วย `ast-grep scan` สำหรับ ast-grep rules
4. ลบ scripts จาก `.devin/scripts/temp/` หลังใช้งานเสร็จ (สำคัญ: ต้องลบทุกครั้งหลังใช้งาน)

## Rules

### File Location

ตำแหน่งไฟล์สำหรับเก็บ scripts ใน workspace

```
.devin/scripts/temp/            # สร้าง scripts ที่นี่ (ถูก ignore โดย .gitignore)
```

- สร้าง scripts เฉพาะใน `.devin/scripts/temp/` ใน workspace เท่านั้น
- ต้องเพิ่ม `.devin/scripts/temp/` ใน `.gitignore` ของทุก project
- ใช้ `.ts` สำหรับ Bun scripts
- ใช้ `.ps1` สำหรับ PowerShell scripts
- ตั้งชื่อสื่อถึงการทำงาน พร้อม prefix `wrikka-` เพื่อหลีกเลี่ยงการชนกับไฟล์อื่น

### Script Type Selection

เลือก script type ตามความเหมาะสม

- `Bun native APIs`: ใช้สำหรับ file operations, networking, database, compression, crypto
- `pwsh`: ใช้สำหรับ Windows system administration, file system operations, automation
- `ast-grep`: ใช้สำหรับ AST-based code search, linting, transformation

### CDN Imports

ใช้ imports จาก CDN สำหรับ dependencies (สำหรับ Bun scripts):

```typescript
import { z } from "https://esm.sh/zod"
import { glob } from "https://esm.sh/glob"
```

- ใช้ `https://esm.sh/` สำหรับ TypeScript packages
- ใช้ `https://deno.land/` สำหรับ Deno-compatible packages
- ไม่ต้อง install dependencies ด้วย package manager

### Dry Run Mode

ทุก script ต้องรองรับ dry run mode:

- เพิ่ม `dryRun` option ใน script
- แสดงผลลัพธ์ที่จะเกิดขึ้นโดยไม่ execute จริง
- ตรวจสอบผลลัพธ์ก่อน execute จริง

### Recommended Libraries

Libraries สำหรับ CLI scripts (ใช้ CDN imports `https://esm.sh/<name>`):

#### CLI And Output

| Library | Purpose |
|---------|---------|
| `zod` | Schema validation, input parsing |
| `cac` | CLI argument parsing, subcommands |
| `citty` | CLI framework, type-safe args (UnJS) |
| `consola` | Structured logging, log levels |
| `@clack/prompts` | Interactive prompts, confirm, select |
| `chalk` / `picocolors` | Terminal colors (`picocolors` เล็กกว่า) |
| `cli-table3` | Table output for reports |
| `boxen` | Terminal boxes for highlight output |
| `listr2` | Multi-step task list for CLI |
| `ora` | Spinners, progress indicators |
| `cli-progress` | Progress bars (single/multi) |
| `log-symbols` | Success/warning/error/info symbols |

#### String And Parsing

| Library | Purpose |
|---------|---------|
| `change-case` | Case conversion (camel, snake, kebab, pascal) |
| `diff-match-patch` | Text diffing for file changes |
| `string-width` | Visual width of strings (CJK, emoji) |
| `cli-truncate` | Truncate text to fit terminal width |
| `yaml` | YAML parsing and stringifying |
| `gray-matter` | Markdown frontmatter parsing |
| `jsonc-parser` | JSONC parsing (JSON with comments) |
| `csv-parse` | CSV parsing (streaming, sync) |
| `markdown-it` | Markdown parsing to HTML |

#### File System And System

| Library | Purpose |
|---------|---------|
| `pretty-bytes` | Human-readable file sizes |
| `env-paths` | OS-specific app paths (config, cache, data) |
| `fs-extra` | Extra fs methods (copy, ensure, readJson) |
| `semver` | Semantic version comparison and parsing |
| `envinfo` | Collect environment info (OS, packages) |

#### Code Analysis And Async

| Library | Purpose |
|---------|---------|
| `ts-morph` | TypeScript AST analysis |
| `oxc-parser` | Rust-based JS/TS parser (เร็วกว่า `ts-morph` 50-100x) |
| `p-limit` | Limit promise concurrency |
| `p-queue` | Promise queue with concurrency control |
| `p-map` | Map over async with concurrency |

#### Time And Benchmarking

| Library | Purpose |
|---------|---------|
| `pretty-ms` | Human-readable milliseconds |
| `date-fns` | Modern date utilities |
| `mitata` | Fast benchmarking (Rust-based) |

### Bun Native Alternatives

- ใช้ `Bun.Glob` แทน `fast-glob`
- ใช้ `Bun.$` แทน `execa` สำหรับ child process execution
- ใช้ `Bun.file()` + `Bun.write()` แทน `fs-extra` สำหรับ file I/O เมื่อเป็นไปได้

### Standards

- ใช้ ESM format สำหรับ Bun scripts
- เขียนแบบ composable: `createScript()` return state + actions
- ใช้ CDN imports สำหรับ external dependencies
- รองรับ dry run mode เสมอ
- ลบ scripts หลังใช้งาน

## Expected Outcome

- Scripts ที่ใช้งานได้จริง ด้วย Bun native APIs, pwsh, หรือ ast-grep
- ไม่ต้อง install dependencies สำหรับ Bun scripts
- Scripts ใน `.devin/scripts/temp/` ใน workspace เท่านั้น (ถูก ignore โดย .gitignore)
- Scripts ที่ใช้แล้วลบออก
- Dry run mode สำหรับทดสอบก่อน execute จริง

