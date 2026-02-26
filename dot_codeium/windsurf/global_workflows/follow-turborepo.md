---
description: ตั้งค่า Turborepo สำหรับ monorepo
title: follow-turborepo
auto_execution_mode: 3
---

## 1. Main Operations

- สร้างโฟลเดอร์ apps/ และ packages/
- สร้าง package.json ที่ root ด้วย scripts สำหรับ Turborepo
- สร้าง turbo.json ด้วย task dependencies
- ติดตั้ง dependencies: turbo, lefthook, taze, node-modules-inspector, @ast-grep/cli, vitest
- ตั้งค่า package.json สำหรับ workspaces ด้วย scripts ตรงกับ turbo tasks
- ตั้งค่า Git hooks และ .gitignore
- รัน /follow-vitest

## 2. Best Practices

### โครงสร้างโฟลเดอร์

```
my-turborepo/
├── .github/workflows/
├── apps/
├── packages/
├── .gitignore
├── package.json
├── turbo.json
└── bun.lock
```



### Root package.json

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

#### ตัวอย่าง

```json
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

### Dependencies

### ตัวอย่าง

```bash
bun add -d turbo lefthook taze node-modules-inspector @ast-grep/cli vitest
```

| แพ็คเกจ | วัตถุประสงค์ | Workflow |
|---------|---------|----------|
| `turbo` | Build system สำหรับ monorepo | - |
| `lefthook` | Git hooks manager | `/follow-lefthook` |
| `taze` | Dependency version checker | - |
| `node-modules-inspector` | ตรวจสอบ node modules | - |
| `@ast-grep/cli` | Code search and linting | `/follow-ast-grep` |
| `vitest` | Testing framework | `/follow-vitest` |


### Git Configuration

- เพิ่ม `.turbo` ใน .gitignore
- ตั้งค่า Git hooks ผ่าน lefthook

### Vitest Configuration

รัน `/follow-vitest`

