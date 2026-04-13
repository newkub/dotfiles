title: Follow Knip
description: ตั้งค่าและใช้งาน Knip สำหรับตรวจสอบ unused files, dependencies และ exports
auto_execution_mode: 3
## Purpose

ตั้งค่า Knip สำหรับตรวจสอบและลบ unused files, dependencies และ exports เพื่อลด technical debt และ bundle size

## Scope

- ติดตั้ง Knip CLI
- กำหนดค่า `.knip.json` สำหรับ single repo และ monorepo
- เพิ่ม scripts ใน `package.json`
- รองรับ Turborepo integration

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Project Type | Single repo หรือ monorepo |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | `bun add -D knip` |
| **Config** | สร้าง `.knip.json` ที่ root |
| **Entry** | ระบุ entry points สำหรับทุก project |
| **Ignore** | กำหนด patterns ที่ไม่ต้องตรวจสอบ |
| **Scripts** | มี `knip` และ `knip:fix` |

## Structure

### Directory Structure

```text
project/
├── .knip.json            # Knip configuration
├── package.json          # Scripts
└── turbo.json            # Turborepo integration (ถ้ามี)
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add knip |
| Configure | กำหนดค่า | .knip.json |
| Script | เพิ่ม scripts | package.json |
| Turborepo | Integration | turbo.json |
| Verify | ทดสอบ | Run knip |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Knip**
  - รัน `bun add -D knip`
  - ตรวจสอบ installation สำเร็จ

### Phase 2: Configure

- 2.1 **สร้าง .knip.json**
  - สร้างไฟล์ `.knip.json` ที่ root:

```json [.knip.json]
{
  "$schema": "https://unpkg.com/knip@latest/schema.json",
  "entry": ["apps/*/app.ts", "packages/*/src/index.ts"],
  "project": ["apps/*/package.json", "packages/*/package.json"],
  "ignore": [
    "**/*.config.*",
    "**/*.d.ts",
    "**/dist/**",
    "**/node_modules/**",
    "**/.next/**",
    "**/.nuxt/**",
    "**/.turbo/**"
  ],
  "ignoreDependencies": [
    "@types/*",
    "typescript",
    "bun-types"
  ]
}
```

### Phase 3: Script

- 3.1 **เพิ่ม Scripts**
  - เพิ่มใน `package.json`:

```json [package.json]
{
  "scripts": {
    "knip": "knip",
    "knip:fix": "knip --fix"
  }
}
```

### Phase 4: Turborepo (ถ้ามี)

- 4.1 **เพิ่ม Task ใน turbo.json**
  - เพิ่มใน `turbo.json`:

```json [turbo.json]
{
  "tasks": {
    "knip": {
      "dependsOn": ["^build"],
      "cache": false
    }
  }
}
```

### Phase 5: Verify

- 5.1 **ทดสอบการทำงาน**
  - รัน `bun run knip`
  - ตรวจสอบ unused files, dependencies, exports
  - รัน `bun run knip:fix` เพื่อ auto-fix ที่เป็นไปได้

## Outputs

| Output | Details |
|--------|-----------|
| .knip.json | Knip configuration |
| Updated package.json | Knip scripts |
| Updated turbo.json | Turborepo integration |

## Expected Outcome

- Knip ติดตั้งและทำงานได้
- Config กำหนด entry และ ignore ถูกต้อง
- Scripts พร้อมใช้งาน
- ตรวจพบ unused items ได้
- Auto-fix ทำงานได้

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows
