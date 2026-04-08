---
title: Follow Turborepo
description: แนวทางการพัฒนา monorepo ด้วย Turborepo อย่างมืออาชีพ
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องตั้งค่าหรือปรับปรุง monorepo ด้วย Turborepo ให้เป็นไปตาม best practices และมีประสิทธิภาพสูงสุด

เหมาะสำหรับ:
- **New projects** — เริ่มต้น monorepo ใหม่
- **Migration** — ย้ายจาก Lerna/Nx มา Turborepo
- **Optimization** — ปรับปรุงประสิทธิภาพ monorepo ที่มีอยู่
- **Enterprise setup** — ตั้งค่าระดับองค์กรพร้อม governance

## Execute

1. วิเคราะห์สภาพแวดล้อมและความต้องการ

- ตรวจสอบว่ามี `node`, `bun`, `rustc` ที่จำเป็น
- ยืนยันว่า project เป็น monorepo (มีหลาย packages)
- ตรวจสอบว่า `turbo` ยังไม่ได้ติดตั้งใน root package.json
- ตรวจสอบว่ามี workspace structure ที่เหมาะสม
- ระบุ packages ทั้งหมดใน monorepo และ dependencies ระหว่างกัน
- วิเคราะห์ scripts ที่จำเป็นสำหรับแต่ละ package (dev, build, test, typecheck, format, verify, clean)
- กำหนด caching strategy สำหรับ build และ test
- วางแผน pipeline dependencies และ execution order
- วางแผน `--filter` patterns สำหรับ partial development
  - `turbo dev --filter=web` — development เฉพาะ web app
  - `turbo build --filter=...^ui` — build ui และ dependencies ที่เกี่ยวข้อง
  - `turbo test --filter=...[origin/main]` — test เฉพาะที่เปลี่ยนแปลง

2. ดำเนินการติดตั้งและตั้งค่า

**2.1 ติดตั้ง Turbo**

```bash
bun add --dev turbo
```

**2.2 ตั้งค่า Workspace**

Update `package.json` workspaces:

```json
{
  "workspaces": [
    "packages/*",
    "apps/*"
  ]
}
```

**2.3 กำหนด Engine Versions**

Add to `package.json` (CRITICAL: lock version ไม่ใช่ latest):

```json
{
  "engines": {
    "node": ">=20 <22",
    "bun": ">=1.3.10 <2.0.0",
    "rust": ">=1.70 <2.0.0"
  }
}
```

**2.4 ตั้งค่า Core Scripts**

Add to `package.json`:

```json
{
  "scripts": {
    "prepare": "bunx lefthook install && bunx taze -r -w -i",
    "dev": "turbo dev",
    "devtools": "turbo devtools",
    "format": "turbo format",
    "typecheck": "turbo typecheck",
    "build": "turbo build",
    "test": "turbo test",
    "lint": "turbo lint",
    "verify": "turbo run build test lint typecheck format",
    "release": "turbo release",
    "clean": "turbo clean"
  }
}
```

**Note:** Granular tasks (test:unit, test:e2e, build:app, etc.) ให้ package.json ในแต่ละ package จัดการเอง

**2.5 สร้าง Turbo Configuration**

Create `turbo.json`:

```json
{
  "$schema": "https://turbo.build/schema.json",
  "remoteCache": {
    "enabled": true
  },
  "globalEnv": ["NODE_ENV"],
  "globalDependencies": [
    "**/.env.*local"
  ],
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**", "!.next/cache/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "test": {
      "dependsOn": ["build"],
      "outputs": ["coverage/**"]
    },
    "lint": {
      "dependsOn": ["^lint"],
      "outputs": []
    },
    "typecheck": {
      "outputs": []
    },
    "format": {
      "dependsOn": ["^format"],
      "outputs": []
    },
    "clean": {
      "cache": false,
      "outputs": []
    },
    "prepare": {
      "cache": false,
      "outputs": []
    },
    "postinstall": {
      "cache": false,
      "outputs": []
    }
  }
}
```

**2.6 Optional: Setup Remote Cache**

```bash
npx turbo login
bunx turbo link --yes
```

**2.7 Optional: CI/CD Integration**

สร้าง GitHub Actions workflow (`.github/workflows/ci.yml`):

```yaml
name: CI
on: [push, pull_request]
jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: oven-sh/setup-bun@v1
      - run: bun install
      - run: bun turbo run build --filter=...[origin/main]
      - run: bun turbo run verify --filter=...[origin/main]
```

**2.8 Package Boundary Enforcement**

ESLint Flat Config + import rules:

ติดตั้ง: `bun add --dev eslint @eslint/js eslint-plugin-import eslint-plugin-boundaries`

Config (`eslint.config.js`):

```javascript
import js from '@eslint/js';
import importPlugin from 'eslint-plugin-import';
import boundaries from 'eslint-plugin-boundaries';

export default [
  js.configs.recommended,
  importPlugin.configs.recommended,
  {
    plugins: {
      boundaries
    },
    rules: {
      'boundaries/element-types': [
        'error',
        {
          default: 'disallow',
          rules: [
            { from: 'app', allow: ['application'] },
            { from: 'application', allow: ['domain'] },
            { from: 'domain', allow: [] }
          ]
        }
      ]
    }
  }
];
```

**2.9 Package API Enforcement**

ในแต่ละ package `package.json` ให้กำหนด `exports` อย่างชัดเจน:

```json
{
  "name": "@wrikka/domain",
  "exports": {
    ".": "./src/index.ts",
    "./types": "./src/types/index.ts"
  }
}
```

**2.10 dependency-cruiser**

ติดตั้ง: `bun add --dev dependency-cruiser`

Config (`dependency-cruiser.config.js`):

```javascript
export default {
  forbidden: [
    {
      name: 'no-domain-to-app',
      from: { path: '^packages/domain' },
      to: { path: '^apps' }
    },
    {
      name: 'no-app-to-infra',
      from: { path: '^apps' },
      to: { path: '^packages/infra' }
    },
    {
      name: 'no-cross-domain',
      from: { path: '^packages/domain' },
      to: { path: '^packages/domain' },
      except: { path: '^packages/domain/.*/test/.*' }
    },
    {
      name: 'no-circular-dependencies',
      from: { path: '.*' },
      to: { circular: true }
    }
  ]
};
```

Scripts เพิ่มใน package.json:

```json
{
  "scripts": {
    "check:deps": "depcruise --config dependency-cruiser.config.js src",
    "check:deps:graph": "depcruise --config dependency-cruiser.config.js --output-type dot src | dot -T svg > dependency-graph.svg"
  }
}
```

**2.11 TypeScript Project References**

สร้าง `tsconfig.base.json`:

```json
{
  "compilerOptions": {
    "composite": true,
    "declarationMap": true,
    "paths": {
      "@wrikka/domain/*": ["packages/domain/src/*"],
      "@wrikka/infra/*": ["packages/infra/src/*"]
    }
  },
  "references": [
    { "path": "./packages/domain" },
    { "path": "./packages/infra" }
  ]
}
```

ในแต่ละ package `tsconfig.json`:

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@wrikka/domain/*": ["../../packages/domain/src/*"]
    }
  }
}
```

3. ตรวจสอบความถูกต้องและยืนยันผล

- ตรวจสอบว่า turbo ติดตั้งสำเร็จและพร้อมใช้งาน (`bunx turbo --version`)
- ยืนยันว่า workspace configuration ถูกต้อง (`bun workspaces list`)
- ตรวจสอบว่า engine versions เป็นปัจจุบันและเข้ากันได้
- ตรวจสอบว่า turbo.json syntax ถูกต้อง (`bunx turbo lint`)
- ยืนยันว่า scripts ใน root package.json ถูกต้องและสมบูรณ์
- ทดสอบ run verify command: `bun verify`
- ตรวจสอบ pipeline: format → typecheck → build → test
- ตรวจสอบ performance: caching และ parallel execution ทำงานได้
- ตรวจสอบ dependencies: ระหว่าง packages ถูกต้อง
- ทดสอบ partial run:
  ```bash
  turbo dev --filter=web
  turbo build --filter=...^ui
  ```
- ทดสอบ affected strategy:
  ```bash
  turbo run build --filter=...[origin/main]
  turbo run test --filter=...[origin/main]
  turbo run verify --filter=...[origin/main]
  ```
- ใน CI/CD ใช้ BASE_REF:
  ```bash
  turbo run build --filter=...[${BASE_REF}]
  turbo run test --filter=...[${BASE_REF}]
  turbo run verify --filter=...[${BASE_REF}]
  ```
- ตรวจสอบว่า scripts ในทุก workspace สอดคล้องกัน
- ยืนยันว่า performance ดีขึ้น (เวลา build ลดลง)
- ตรวจสอบว่า developer experience ดีขึ้น
- สร้าง documentation สำหรับ team members

## Rules

1. Core Requirements

- ติดตั้ง `turbo` ใน root package.json เป็น devDependency
- กำหนด `workspaces` ใน package.json อย่างถูกต้อง
- ใช้ exact version ไม่ใช้ `latest` สำหรับความเสถียร
- ระบุ version ranges ที่ชัดเจนใน `engines`

2. Engine Versions (Locked)

- **Bun:** `">=1.3.10 <2.0.0"` (current: 1.3.10)
- **Node.js:** `">=20 <22"` (LTS)
- **Rust:** `">=1.70 <2.0.0"` (stable)

3. Core Scripts (Required)

```json
{
  "scripts": {
    "prepare": "bunx lefthook install && bunx taze -r -w -i",
    "dev": "turbo dev",
    "watch": "turbo watch",
    "build": "turbo build",
    "typecheck": "turbo typecheck",
    "format": "turbo format",
    "lint": "turbo lint",
    "test": "turbo test",
    "verify": "turbo run build test lint typecheck format",
    "release": "turbo release",
    "clean": "turbo clean"
  }
}
```

**หมายเหตุ:** สำหรับ project ที่ใช้ changesets ให้ใช้ `"release": "changeset publish"`

5. Package Flexibility

- **Core packages:** ต้องมี scripts หลัก (dev, build, test, typecheck, format, clean)
- **Utility packages:** อาจมี scripts เฉพาะที่จำเป็น (build, test, typecheck)
- **Apps:** ต้องมี scripts ครบ (dev, build, test, typecheck, format, clean)

6. Turbo Orchestration Rules

- ใช้ `turbo <command>` สำหรับ scripts ที่ต้องการ parallelization
- ใช้ `--filter` สำหรับ development แบบ selective
  - `turbo dev --filter=web` — dev เฉพาะ web app
  - `turbo build --filter=...^ui` — build ui และ dependencies
  - `turbo test --filter=...[origin/main]` — test เฉพาะที่เปลี่ยนแปลง
- เฉพาะ tasks ที่ต้องการ orchestration ควรอยู่ใน turbo.json
- กำหนด `outputs` และ `dependsOn` อย่างชัดเจน

7. Advanced Tips

- ใช้ `turbo graph` เพื่อ visualize dependencies ระหว่าง packages
- Monitor cache hit rates ด้วย `TURBO_LOG_LEVEL=debug` เพื่อ optimization
- Custom environment variables สำหรับ different deployment stages (build-time เท่านั้น)
- Incremental builds ด้วย affected strategy ใน CI/CD (ใช้ origin/main หรือ BASE_REF)
- Performance monitoring ติดตาม build times และ cache effectiveness
- Package API design ใช้ `exports` field เพื่อ enforce public boundaries
- Environment strategy ใช้เฉพาะ `NODE_ENV` ใน turbo.json ป้องกัน cache invalidation

## Expected Outcome

- **Turborepo setup สมบูรณ์** — ติดตั้งและกำหนดค่าอย่างถูกต้องตาม best practices
- **Workspace management** — dependencies และ scripts ที่สอดคล้องกันและมีประสิทธิภาพ
- **Performance improvement** — caching และ parallel execution ทำงานได้อย่างเต็มประสิทธิภาพ
- **Development workflow** — scripts ที่ใช้งานง่าย สม่ำเสมอ และ developer experience ที่ดีเยี่ยม
- **Package boundary enforcement** — ป้องกันการ import ข้าม layer ด้วย ESLint + dependency-cruiser
- **Documentation** — team members สามารถใช้งานได้ทันทีพร้อม best practices
