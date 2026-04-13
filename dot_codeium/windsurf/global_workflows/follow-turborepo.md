---
title: Follow Turborepo
description: ตั้งค่า monorepo ด้วย Turborepo พร้อม caching และ parallel execution
auto_execution_mode: 3
---

## Goal

สร้าง monorepo ด้วย Turborepo ที่มี caching, parallel execution, และ package boundary enforcement

## Execute

### 1. Analyze Environment

1. ตรวจสอบ `node`, `bun`, `rustc` ติดตั้งแล้ว
2. ยืนยัน project เป็น monorepo (มีหลาย packages)
3. ตรวจสอบ workspace structure
4. ระบุ packages ทั้งหมดและ dependencies ระหว่างกัน
5. วิเคราะห์ scripts ที่จำเป็น: dev, build, test, typecheck, format, verify, clean
6. กำหนด caching strategy และ pipeline dependencies
7. วางแผน `--filter` patterns:
   - `turbo dev --filter=web` — development เฉพาะ web app
   - `turbo build --filter=...^ui` — build ui และ dependencies
   - `turbo test --filter=...[origin/main]` — test เฉพาะที่เปลี่ยนแปลง

### 2. Install And Configure

#### 2.1 Install Turbo

```bash
bun add --dev turbo
```

#### 2.2 Configure Workspaces

Update `package.json`:

```json
{
  "workspaces": ["packages/*", "apps/*"],
  "engines": {
    "node": ">=20 <22",
    "bun": ">=1.3.10 <2.0.0",
    "rust": ">=1.70 <2.0.0"
  },
  "scripts": {
    "prepare": "bunx lefthook install && bunx taze -r -w -i",
    "dev": "turbo dev",
    "devtools": "turbo devtools",
    "build": "turbo build",
    "test": "turbo test",
    "typecheck": "turbo typecheck",
    "format": "turbo format",
    "lint": "turbo lint",
    "verify": "turbo run build test lint typecheck format",
    "release": "turbo release",
    "clean": "turbo clean"
  }
}
```

#### 2.3 Create Turbo Configuration

Create `turbo.json`:

```json
{
  "$schema": "https://turbo.build/schema.json",
  "remoteCache": {
    "enabled": true
  },
  "globalEnv": ["NODE_ENV"],
  "globalDependencies": ["**/.env.*local"],
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

#### 2.4 Optional Remote Cache

```bash
bunx turbo login
bunx turbo link --yes
```

#### 2.5 CI/CD Integration

Create `.github/workflows/ci.yml`:

```yaml
name: CI
on: [push, pull_request]
jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - uses: oven-sh/setup-bun@v1
      - run: bun install
      - run: bun turbo run verify --filter=...[origin/main]
```

#### 2.6 Package Boundary Enforcement

Install: `bun add --dev eslint @eslint/js eslint-plugin-import eslint-plugin-boundaries`

Config `eslint.config.js`:

```javascript
import js from '@eslint/js';
import importPlugin from 'eslint-plugin-import';
import boundaries from 'eslint-plugin-boundaries';

export default [
  js.configs.recommended,
  importPlugin.configs.recommended,
  {
    plugins: { boundaries },
    rules: {
      'boundaries/element-types': ['error', {
        default: 'disallow',
        rules: [
          { from: 'app', allow: ['application'] },
          { from: 'application', allow: ['domain'] },
          { from: 'domain', allow: [] }
        ]
      }]
    }
  }
];
```

#### 2.7 Dependency Cruiser

Install: `bun add --dev eslint-plugin-dependency-cruiser dependency-cruiser`

Config `eslint.config.js`:

```javascript
import dependencyCruiser from 'eslint-plugin-dependency-cruiser';
export default [
  dependencyCruiser.configs.recommended
];
```

Config `dependency-cruiser.config.js`:

```javascript
export default {
  forbidden: [
    { name: 'no-domain-to-app', from: { path: '^packages/domain' }, to: { path: '^apps' } },
    { name: 'no-app-to-infra', from: { path: '^apps' }, to: { path: '^packages/infra' } },
    { name: 'no-circular', from: { path: '.*' }, to: { circular: true } }
  ]
};
```

### 3. Verify Setup

1. ตรวจสอบ `bunx turbo --version`
2. ตรวจสอบ `bun workspaces list`
3. ตรวจสอบ `turbo.json` syntax
4. ทดสอบ `bun run verify`
5. ตรวจสอบ pipeline: format → typecheck → build → test
6. ทดสอบ partial run: `turbo dev --filter=web`
7. ทดสอบ affected: `turbo run build --filter=...[origin/main]`

## Rules

### 1. Frontmatter Standards

- title: Title Case
- description: ไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3

### 2. Engine Versions

| Tool | Version |
|------|---------|
| Bun | `>=1.3.10 <2.0.0` |
| Node.js | `>=20 <22` |
| Rust | `>=1.70 <2.0.0` |

### 3. Core Scripts

- prepare: setup hooks และ update dependencies
- dev/devtools: development mode (cache: false)
- build: build ทั้งหมด (dependsOn: ["^build"])
- test: test (dependsOn: ["build"])
- lint: linting (dependsOn: ["^lint"])
- typecheck: type checking
- format: formatting (dependsOn: ["^format"])
- verify: full pipeline
- release: release build
- clean: clean artifacts

### 4. Turbo Configuration

- ใช้ `^` prefix สำหรับ dependencies (upstream build)
- กำหนด `outputs` ชัดเจนเพื่อ caching
- `cache: false` สำหรับ dev, prepare, postinstall
- `persistent: true` สำหรับ dev server

### 5. Package Flexibility

- Core packages: ต้องมี dev, build, test, typecheck, format, clean
- Utility packages: build, test, typecheck
- Apps: ต้องมีครบทุก scripts

### 6. Filter Patterns

- `turbo dev --filter=<package>` — dev เฉพาะ package
- `turbo build --filter=...^<package>` — build package + dependencies
- `turbo test --filter=...[origin/main]` — test เฉพาะที่เปลี่ยนแปลง

### 7. Package Boundaries

- ใช้ `eslint-plugin-boundaries` ป้องกัน import ข้าม layer
- ใช้ `eslint-plugin-dependency-cruiser` ตรวจสอบ circular dependencies
- กำหนด `exports` field ในแต่ละ package

### 8. Environment Variables

- `NODE_ENV` อยู่ใน `globalEnv`
- ใช้เฉพาะ build-time variables
- หลีกเลี่ยง runtime variables ที่เปลี่ยนบ่อย

### 9. Performance Tips

- ใช้ `turbo graph` visualize dependencies
- Monitor cache hit rates ด้วย `TURBO_LOG_LEVEL=debug`
- ใช้ affected strategy ใน CI/CD
- ติดตาม build times และ cache effectiveness

### 10. CI/CD

- ใช้ `--filter=...[origin/main]` หรือ `${BASE_REF}`
- Setup remote cache เพื่อแชร์ cache ระหว่าง builds
- ใช้ `fetch-depth: 0` สำหรับ affected detection

### 11. Package Manifest Setup

- ตั้งค่า `package.json` ตาม `/follow-package-manifest`
- เลือก template level ตามขนาดโปรเจกต์: Minimal, Standard หรือ Complete
- กำหนด scripts ให้สอดคล้องกับ tech stack (Bun/TS, Rust, Go, PHP)
- ตรวจสอบ verify pipeline: format → lint → typecheck → test
- ใช้ `prepare` script สำหรับ setup hooks และ dependencies

## Expected Outcome

1. Turborepo ติดตั้งและทำงานพร้อม caching และ parallel execution
2. Workspace configuration สมบูรณ์ด้วย engine versions และ scripts
3. Build pipeline มีประสิทธิภาพสูงด้วย proper task dependencies
4. Package boundaries ถูก enforce ด้วย ESLint
5. CI/CD integration ทำงานร่วมกับ affected strategy
6. Developer experience ดีขึ้นด้วย commands ที่สม่ำเสมอ
