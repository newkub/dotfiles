---
title: Use Scripts
description: สร้าง scripts สำหรับ automate งานด้วย Bun native APIs, pwsh, หรือ ast-grep
auto_execution_mode: 3
related_workflows:
  - /bun-native
  - /use-ast-grep
---

## Goal

สร้าง scripts เพื่อ automate งานและประมวลผลไฟล์ ด้วย Bun native APIs, pwsh, หรือ ast-grep ตามความเหมาะสม

## Execute

### 1. Prepare

1. ทำตาม `/write-windsurf-global-workflows` เมื่อสร้างหรือแก้ไข workflow

### 2. Choose Script Type

1. ใช้ Bun native APIs ถ้าต้องการ performance และ cross-platform: ดูจาก `/bun-native`
2. ใช้ pwsh ถ้าต้องการ Windows-specific commands หรือ system administration
3. ใช้ ast-grep ถ้าต้องการ AST-based code search และ transformation: ดูจาก `/use-ast-grep`

### 3. Create Script

1. สร้างไฟล์ `.ts` ใน `scripts/temp/` ที่ root workspace เท่านั้น
2. ไม่ต้องสร้าง scripts ในแต่ละ workspace
3. เขียนแบบ composable: `createScript()` return state + actions
4. สำหรับ Bun: ใช้ Bun native APIs และ CDN imports
5. สำหรับ pwsh: ใช้ PowerShell commands
6. สำหรับ ast-grep: ใช้ ast-grep CLI commands

### 4. Dry Run

1. รัน script ใน dry run mode เพื่อดูผลลัพธ์ก่อน execute จริง
2. ตรวจสอบว่า script ทำงานถูกต้อง
3. แก้ไข errors ก่อนรันจริง

### 5. Execute and Cleanup

1. รัน script ด้วย `bun run <script>.ts` สำหรับ Bun scripts
2. รัน script ด้วย `pwsh <script>.ps1` สำหรับ PowerShell scripts
3. รัน script ด้วย `ast-grep scan` สำหรับ ast-grep rules
4. ลบ scripts จาก `scripts/temp/` หลังใช้งาน
5. ลบ scripts ที่สร้างด้วย `/write-windsurf-global-workflows` หลังใช้งาน

## Rules

### File Location

ตำแหน่งไฟล์สำหรับเก็บ scripts

```
scripts/temp/    # Global scripts ที่ root workspace เท่านั้น (ลบหลังใช้)
```

- สร้าง scripts เฉพาะใน `scripts/temp/` ที่ root workspace
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

ดูรายละเอียดจาก `/bun-native`:

```typescript
// File operations
const content = await Bun.file(path).text()
await Bun.write(outputPath, content)

// Shell commands
await $`git status`.text()

// File patterns
for await (const file of new Bun.Glob("**/*.ts").scan()) {
  // process file
}
```

### PowerShell Commands

ใช้ PowerShell สำหรับ Windows-specific tasks:

```powershell
# File operations
Get-ChildItem -Path "." -Filter "*.ts" | ForEach-Object {
  # process file
}

# System commands
Get-Process | Where-Object { $_.Name -eq "node" }
```

### Ast-grep Commands

ดูรายละเอียดจาก `/use-ast-grep`:

```bash
# Search pattern
ast-grep run -p 'console.log($ARG)'

# Scan with rules
ast-grep scan --config sgconfig.yml
```

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

ตัวอย่าง script แบบ composable (Bun)

```typescript
#!/usr/bin/env bun

import { z } from "https://esm.sh/zod"

interface ScriptOptions {
  pattern: string
  dryRun?: boolean
}

function createScript(options: ScriptOptions) {
  const errors: Error[] = []
  let processed = 0

  async function run() {
    const files = new Bun.Glob(options.pattern).scan()
    for await (const file of files) {
      if (options.dryRun) {
        console.log(`[DRY RUN] Would process: ${file}`)
      } else {
        // Process logic
        processed++
      }
    }
  }

  return { run, errors, processed }
}

const script = createScript({ pattern: "**/*.ts", dryRun: true })
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
- Scripts ใน `scripts/temp/` ที่ root workspace เท่านั้น
- Scripts ที่ใช้แล้วลบออก
- Dry run mode สำหรับทดสอบก่อน execute จริง

