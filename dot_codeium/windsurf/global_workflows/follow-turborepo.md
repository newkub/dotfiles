---
description: ตั้งค่า Turborepo สำหรับ monorepo
title: follow-turborepo
auto_execution_mode: 3
---

## 1. Pre-Execution

1. ตรวจสอบโครงสร้าง monorepo ที่มีหลาย apps และ packages
   - ยืนยันว่ามีการติดตั้ง package manager (bun) แล้ว
   - เตรียม dependencies ที่จำเป็นสำหรับ Turborepo

2. ศึกษาสถานะปัจจุบันของโปรเจกต์ว่าเป็น monorepo หรือไม่
   - ระบุจำนวน apps และ packages ที่มีอยู่
   - เข้าใจ dependencies ที่มีผลต่อการตั้งค่า Turborepo

3. วางแผนการสร้างโครงสร้างโฟลเดอร์ตามมาตรฐาน
   - แบ่งขั้นตอนการตั้งค่า configuration เป็นส่วนๆ
   - ประเมินเวลาที่ต้องใช้สำหรับการตั้งค่าทั้งหมด

## 2. Main Operations

1. สร้างโครงสร้างโฟลเดอร์มาตรฐานสำหรับ Turborepo monorepo
   - สร้างโฟลเดอร์หลัก apps/ และ packages/
   - สร้างโฟลเดอร์ .github/workflows/ สำหรับ CI/CD

2. สร้าง package.json ที่ root ด้วยค่าที่กำหนด
   - ตั้งค่า packageManager เป็น bun version ล่าสุด
   - กำหนด scripts ที่จำเป็นสำหรับ Turborepo

3. สร้างไฟล์ turbo.json พร้อม schema
   - กำหนด task dependencies และ caching rules
   - ตั้งค่า globalDependencies ที่เหมาะสม

4. ติดตั้ง dependencies ที่จำเป็นสำหรับ Turborepo monorepo
   - ติดตั้ง turbo สำหรับ build system
   - ติดตั้ง lefthook สำหรับ Git hooks
   - ติดตั้ง taze สำหรับ dependency version checking
   - ติดตั้ง node-modules-inspector สำหรับตรวจสอบ modules
   - ติดตั้ง @ast-grep/cli สำหรับ code search
   - ติดตั้ง vitest สำหรับ testing

5. ตั้งค่า package.json สำหรับแต่ละ workspace
   - กำหนด scripts ที่ตรงกับ turbo tasks
   - สร้าง README.md และ .gitignore สำหรับทุก workspace

6. ตั้งค่า Git configuration สำหรับ monorepo
   - เพิ่ม .turbo ใน .gitignore
   - ตั้งค่า Git hooks ผ่าน lefthook
   - สร้าง workflow สำหรับ GitHub Actions

7. รัน /follow-vitest workflow เพื่อตั้งค่า testing
   - ตั้งค่า testing configuration สำหรับ monorepo
   - กำหนด test scripts ให้ทำงานร่วมกับ Turborepo

## 3. Validation

1. ตรวจสอบโครงสร้างโฟลเดอร์ว่ามี apps/ และ packages/ ถูกต้อง
   - ตรวจสอบว่ามี .github/workflows/ สำหรับ CI/CD
   - ตรวจสอบว่ามีไฟล์ configuration ครบถ้วน

2. ตรวจสอบ Root Configuration ว่า package.json มี scripts ที่จำเป็นครบถ้วน
   - ตรวจสอบว่า turbo.json มี task dependencies ถูกต้อง
   - ตรวจสอบว่า packageManager ตั้งค่าเป็น bun

3. ตรวจสอบ Dependencies ว่าติดตั้ง dependencies ที่จำเป็นครบถ้วน
   - ตรวจสอบว่า dependencies versions เป็นรุ่นล่าสุด
   - ตรวจสอบว่าไม่มี conflicts ระหว่าง dependencies

4. ตรวจสอบ Workspace Configuration ว่าทุก workspace มี scripts ที่ตรงกับ turbo tasks
   - ตรวจสอบว่า workspace names ตรงกับ folder names
   - ตรวจสอบว่ามี README.md และ .gitignore ในทุก workspace

5. ตรวจสอบ Git Configuration ว่า .turbo อยู่ใน .gitignore
   - ตรวจสอบว่า Git hooks ตั้งค่าถูกต้อง
   - ตรวจสอบว่า GitHub Actions workflow สมบูรณ์

## 4. Verification

1. ทดสอบ Turbo Commands โดยรัน `turbo dev` เพื่อทดสอบ development mode
   - รัน `turbo build` เพื่อทดสอบ build process
   - รัน `turbo lint` เพื่อทดสอบ linting
   - รัน `turbo test` เพื่อทดสอบ testing

2. ทดสอบ Workspace Integration โดยรัน `bun install` เพื่อติดตั้ง dependencies ทั้งหมด
   - ทดสอบการทำงานของแต่ละ workspace
   - ตรวจสอบว่า dependencies ระหว่าง workspaces ทำงานถูกต้อง

3. ทดสอบ Caching โดยรัน `turbo build` ซ้ำเพื่อทดสอบ caching
   - ตรวจสอบว่า cache ทำงานถูกต้อง
   - ยืนยันว่า build times ลดลงหลังจาก caching

4. ทดสอบ Git Hooks โดยทำการ commit เพื่อทดสอบ Git hooks
   - ตรวจสอบว่า lefthook ทำงานถูกต้อง
   - ยืนยันว่า pre-commit hooks ทำงาน

5. ทดสอบ CI/CD Pipeline โดยตรวจสอบว่า GitHub Actions workflow ทำงานถูกต้อง
   - ทดสอบการ build และ test ใน CI environment
   - ยืนยันว่า pipeline สมบูรณ์

6. ทดสอบ Performance โดยวัดผล build times ก่อนและหลังใช้ Turborepo
   - ตรวจสอบว่า caching เพิ่มประสิทธิภาพ
   - ยืนยันว่า parallel execution ทำงาน

---

# Turborepo Best Practices

## Folder Structure

โครงสร้างโฟลเดอร์มาตรฐานสำหรับ Turborepo monorepo

### ตัวอย่าง

```
my-turborepo/
├── .github/
│   └── workflows/
│       └── ci.yml
├── apps/
│   ├── app1/
│   └── app2/
├── packages/
│   ├── pkg1/
│   └── pkg2/
├── .gitignore
├── vitest.config.ts
├── lefthook.yml
├── package.json
├── turbo.json
└── bun.lock
```



## Root Configuration

### package.json

ตั้งค่า root package.json สำหรับ monorepo

#### ตัวอย่าง

```json
{
  "name": "",
  "packageManager": "bun@",
  "scripts": {
    "watch": "turbo watch verify",
    "prepare": "bunx lefthook install && bunx taze -r -w -i",
    "dev": "turbo dev --ui=tui",
    "format": "turbo format",
    "scan": "bunx sg scan -r",
    "check:modules": "bunx node-modules-inspector",
    "lint": "turbo lint",
    "test": "turbo test",
    "build": "turbo build",
    "verify": "turbo lint && turbo test && turbo build",
    "devtools": "turbo devtools"
  }
}
```

### turbo.json

กำหนด task dependencies และ caching สำหรับ Turborepo

#### ตัวอย่าง

```json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": [],
  "tasks": {
    "watch": {
      "cache": false,
      "persistent": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "prepare": {
      "cache": false
    },
    "format": {
      "dependsOn": ["^prepare"]
    },
    "lint": {
      "dependsOn": ["^format"],
      "cache" : false
    },
    "test": {
      "dependsOn": ["^lint"],
      "cache" : true
    },
    "build": {
      "dependsOn": ["^lint"],
      "outputs": [],
      "cache" : false
    }
  }
}
```

## Required Dependencies

ติดตั้ง dependencies ที่จำเป็นสำหรับ Turborepo monorepo

### ตัวอย่าง

```bash
bun add -d turbo lefthook taze node-modules-inspector @ast-grep/cli vitest
```

| Package | Purpose | Workflow |
|---------|---------|----------|
| `turbo` | Build system สำหรับ monorepo | - |
| `lefthook` | Git hooks manager | `/follow-lefthook` |
| `taze` | Dependency version checker | - |
| `node-modules-inspector` | ตรวจสอบ node modules | - |
| `@ast-grep/cli` | Code search and linting | `/follow-ast-grep` |
| `vitest` | Testing framework | `/follow-vitest` |

## Workspace Configuration

กฎและข้อกำหนดสำหรับแต่ละ workspace

### Requirements

| Rule | Description |
|------|-------------|
| **Follow** | `/follow-package-json`, `/follow-config-file` |
| **Naming** | `name` = folder name |
| **Tasks** | ตรงกับ root scripts ที่มี `turbo` |
| **Files** | `package.json`, `README.md`, `.gitignore` (ทุก workspace) |
| **Examples** | `examples/` สำหรับ `packages/` |

### Script Requirements

ทุก workspace ต้องมี scripts ที่ตรงกับ turbo tasks ใน root package.json

#### Required Scripts

จาก root package.json ที่มี turbo scripts:
- `watch` → ทุก workspace ต้องมี `watch` script
- `dev` → ทุก workspace ต้องมี `dev` script  
- `format` → ทุก workspace ต้องมี `format` script
- `lint` → ทุก workspace ต้องมี `lint` script
- `test` → ทุก workspace ต้องมี `test` script
- `build` → ทุก workspace ต้องมี `build` script

#### ตัวอย่างการตั้งค่า scripts ใน workspace

```json
{
  "name": "workspace-name",
  "scripts": {
    "watch": "bun watch",                    // สำหรับ development watch mode
    "dev": "bun dev",                        // สำหรับ development server
    "format": "dprint fmt",                  // สำหรับ formatting
    "lint": "oxlint --fix",                  // สำหรับ linting
    "test": "vitest --run",                  // สำหรับ testing
    "build": "tsdown"                        // สำหรับ building
  }
}
```

#### การตรวจสอบ

1. ตรวจสอบว่ามี `watch`, `dev`, `format`, `lint`, `test`, `build` ครบ
2. ถ้าขาด → ADD script ที่เหมาะสมกับ workspace
3. ถ้ามีแต่ไม่ตรง → UPDATE ให้สอดคล้องกับ turbo tasks

---

## 4. Git Configuration

ตั้งค่า Git hooks และ ignore files

### .gitignore

ไฟล์ที่ต้อง ignore ใน Turborepo monorepo

#### ตัวอย่าง

```
.turbo
```

---

## Vitest Configuration

ตั้งค่า Vitest สำหรับการทดสอบ

### การตั้งค่า

รัน workflow `/follow-vitest` เพื่อตั้งค่า Vitest สำหรับ monorepo

