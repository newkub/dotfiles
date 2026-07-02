---
title: Use Scripts
description: สร้าง scripts สำหรับ automate งานด้วย Bun native APIs, pwsh, หรือ ast-grep
auto_execution_mode: 3
related_workflows:
  - /use-bun-shell
  - /analyze-with-ast-grep
---

## Goal

สร้าง scripts เพื่อ automate งานและประมวลผลไฟล์ ด้วย Bun native APIs, pwsh, หรือ ast-grep ตามความเหมาะสม

## Scope

ใช้สำหรับสร้าง scripts ใน `.devin/scripts` ที่ root workspace เท่านั้น

## Execute

### 1. Prepare

1. ทำตาม `/write-windsurf-global-workflows` เมื่อสร้างหรือแก้ไข workflow

### 2. Choose Script Type

1. ใช้ Bun native APIs ถ้าต้องการ performance และ cross-platform: ดูจาก `/use-bun-shell`
2. ใช้ pwsh ถ้าต้องการ Windows-specific commands หรือ system administration
3. ใช้ ast-grep ถ้าต้องการ AST-based code search และ transformation: ดูจาก `/analyze-with-ast-grep`

### 3. Create Script

1. สร้างไฟล์ script ตาม Rules ในหมวด File Location
2. เขียนแบบ composable: `createScript()` return state + actions
3. ดูรายละเอียด Bun APIs จาก `/use-bun-shell`
4. ดูรายละเอียด ast-grep จาก `/analyze-with-ast-grep`

### 4. Dry Run

1. รัน script ใน dry run mode เพื่อดูผลลัพธ์ก่อน execute จริง
2. ตรวจสอบว่า script ทำงานถูกต้อง
3. แก้ไข errors ก่อนรันจริง

### 5. Execute and Cleanup

1. รัน script ด้วย `bun run <script>.ts` สำหรับ Bun scripts
2. รัน script ด้วย `pwsh <script>.ps1` สำหรับ PowerShell scripts
3. รัน script ด้วย `ast-grep scan` สำหรับ ast-grep rules
4. ลบ scripts จาก `.devin/scripts` หลังใช้งานเสร็จ (สำคัญ: ต้องลบทุกครั้งหลังใช้งาน)
5. ลบ scripts ที่สร้างด้วย `/write-windsurf-global-workflows` หลังใช้งานเสร็จ (สำคัญ: ต้องลบทุกครั้งหลังใช้งาน)

## Rules

### File Location

ตำแหน่งไฟล์สำหรับเก็บ scripts

```
.devin/scripts/    # Global scripts ที่ root workspace เท่านั้น (ลบหลังใช้)
```

- สร้าง scripts เฉพาะใน `.devin/scripts` ที่ root workspace
- ไม่สร้าง scripts ใน sub-workspaces หรือแต่ละ workspace
- ใช้ `.ts` สำหรับ Bun scripts
- ใช้ `.ps1` สำหรับ PowerShell scripts
- ตั้งชื่อสื่อถึงการทำงาน

### Script Type Selection

เลือก script type ตามความเหมาะสม

- **Bun native APIs**: ใช้สำหรับ file operations, networking, database, compression, crypto
- **pwsh**: ใช้สำหรับ Windows system administration, file system operations, automation
- **ast-grep**: ใช้สำหรับ AST-based code search, linting, transformation

### Bun Native APIs

ดูรายละเอียดจาก `/use-bun-shell`:

```typescript
const content = await Bun.file(path).text()
await Bun.write(outputPath, content)
await $`git status`.text()
for await (const file of new Bun.Glob("**/*.ts").scan()) { /* process */ }
```

### PowerShell Commands

ใช้ PowerShell สำหรับ Windows-specific tasks:

```powershell
Get-ChildItem -Path "." -Filter "*.ts" | ForEach-Object { /* process */ }
Get-Process | Where-Object { $_.Name -eq "node" }
```

### Ast-grep Commands

ดูรายละเอียดเพิ่มเติมจาก `/analyze-with-ast-grep`

```bash
# Outline: สำรวจ structure ก่อน analysis
ast-grep outline src --json=compact
ast-grep outline src/parser.ts --items imports

# Search pattern โดยไม่สร้าง file
bun -e "await $`ast-grep run -p 'console.log($ARG)' -l ts`"

# Inline rule โดยไม่สร้าง YAML file
bun -e "await $`ast-grep run --inline-rules 'id: test-rule language: ts rule: pattern: test($X)'`"

# Rewrite โดยไม่สร้าง fix template
bun -e "await $`ast-grep run -p 'console.log($X)' -r 'console.warn($X)' -l ts`"

# Scan with production rules
ast-grep scan --config sgconfig.yml
```

Pattern matching และ rule configuration ดูจาก `/analyze-with-ast-grep`

### CDN Imports

ใช้ imports จาก CDN สำหรับ dependencies (สำหรับ Bun scripts):

```typescript
import { z } from "https://esm.sh/zod"
import { glob } from "https://esm.sh/glob"
```

- ใช้ `https://esm.sh/` สำหรับ TypeScript packages
- ใช้ `https://deno.land/` สำหรับ Deno-compatible packages
- ไม่ต้อง install dependencies ด้วย package manager

### Script Template

ตัวอย่าง Bun script template ดูจาก `/use-bun-shell`

ตัวอย่าง script ที่ใช้ ast-grep ร่วมกับ Bun shell:

```typescript
#!/usr/bin/env bun

import { $ } from "bun"

interface AstGrepOptions {
  pattern: string
  rewrite?: string
  lang?: string
  dryRun?: boolean
}

function createAstGrepScript(options: AstGrepOptions) {
  const matches: string[] = []
  let rewritten = 0

  async function run() {
    const cmd = options.rewrite
      ? $`ast-grep run -p ${options.pattern} -r ${options.rewrite} -l ${options.lang ?? "ts"}`
      : $`ast-grep run -p ${options.pattern} -l ${options.lang ?? "ts"}`
    if (options.dryRun) {
      const output = await cmd.text()
      matches.push(...output.split("\n").filter(Boolean))
      console.log(`[DRY RUN] Found ${matches.length} matches`)
    } else {
      await cmd
      rewritten++
    }
  }

  async function outline(path: string) {
    const output = await $`ast-grep outline ${path} --json=compact`.text()
    return JSON.parse(output)
  }

  return { run, outline, matches, rewritten }
}

const script = createAstGrepScript({
  pattern: "console.log($ARG)",
  rewrite: "console.warn($ARG)",
  lang: "ts",
  dryRun: true,
})
await script.run()
```

### Dry Run Mode

ทุก script ต้องรองรับ dry run mode:

- เพิ่ม `dryRun` option ใน script
- แสดงผลลัพธ์ที่จะเกิดขึ้นโดยไม่ execute จริง
- ใช้ console.log หรือ log output เพื่อแสดงผล
- ตรวจสอบผลลัพธ์ก่อน execute จริง

### Standards

มาตรฐานการเขียน scripts

- ใช้ Bun native APIs, pwsh, หรือ ast-grep ตามความเหมาะสม
- ใช้ ESM format สำหรับ Bun scripts
- เขียนแบบ composable: `createScript()` return state + actions
- ใช้ CDN imports สำหรับ external dependencies (Bun scripts)
- รองรับ dry run mode เสมอ
- ลบ scripts หลังใช้งาน

## Expected Outcome

- Scripts ที่ใช้งานได้จริง ด้วย Bun native APIs, pwsh, หรือ ast-grep
- ไม่ต้อง install dependencies สำหรับ Bun scripts
- Scripts ใน `.devin/scripts` ที่ root workspace เท่านั้น
- Scripts ที่ใช้แล้วลบออก
- Dry run mode สำหรับทดสอบก่อน execute จริง

