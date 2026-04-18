---
title: Setup Oxlint
description: ตั้งค่า eslint-plugin-oxlint สำหรับ fast linting ผ่าน ESLint 9+ flat config
auto_execution_mode: 3
---

## Goal

ติดตั้งและตั้งค่า eslint-plugin-oxlint สำหรับใช้งานร่วมกับ ESLint 9+ (flat config) เพื่อ linting ที่เร็วขึ้นด้วย Rust-based linter

## Execute

### 1. Precondition

1. ตรวจสอบว่ามี Bun ติดตั้งแล้ว
2. ตรวจสอบว่ามี package.json อยู่แล้ว
3. ตรวจสอบว่าใช้ ESLint 9+ (flat config)

### 2. Install Dependencies

1. ติดตั้ง oxlint และ eslint-plugin-oxlint

```bash
bun add -D oxlint eslint-plugin-oxlint
```

2. (Optional) ติดตั้ง dependency-cruiser สำหรับ architecture validation

```bash
bun add -D dependency-cruiser eslint-plugin-dependency-cruiser
```

### 3. Configure Oxlint CLI (Alternative)

1. ติดตั้ง oxlint CLI:

```bash
bun add -D oxlint
```

2. สร้าง `.oxlintrc.json`:

```json
{
  "categories": {
    "correctness": "error",
    "style": "warn",
    "suspicious": "warn",
    "perf": "warn"
  }
}
```

3. หรือใช้ TypeScript config `oxlint.config.ts`:

```ts
import { defineConfig } from 'oxlint';

export default defineConfig({
  categories: {
    correctness: 'error',
    style: 'warn',
    suspicious: 'warn',
    perf: 'warn',
  },
});
```

4. เปิดใช้งาน type-aware linting:

```bash
bunx oxlint --type-aware
```

### 4. Configure ESLint

1. สร้างหรือแก้ไข eslint.config.js ที่ root

```javascript
import oxlint from 'lint-plugin-oxlint';

export def[ype-aware-- ypeaware
  oxlint.configs['flat/recommended'],
];
```

2. หรือใช้ config จาก .oxlintrc.json ที่มีอยู่

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.buildFromOxlintConfigFile('./.oxlintrc.json'),
];
```

3. หรือ build config จาก object โดยตรง

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.buildFromOxlintConfig({
    categories: {
      correctness: 'warn',
    },
    rules: {
      eqeqeq: 'warn',
    },
  }),
];
```

### 4. Add Scripts

1. เพิ่ม scripts ใน package.json

```json
{
  "scripts": {
    "lint": "oxlint --type-aware",
    "lint:fix": "oxlint --type-aware --fix"
  }
}
```

### 5. Setup CI Integration

1. สร้าง GitHub Actions workflow สำหรับ oxlint

```yaml
# .github/workflows/lint.yml
name: Lint
on:
  pull_request:
  push:
    branches: [main]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: oven-sh/setup-bun@v1
      - run: bun install
      - name: Oxlint (Fast)
        run: bun run oxlint .
      - name: ESLint (Remaining rules)
        run: bun run eslint .
```

2. หรือใช้ GitHub format สำหรับ annotations

```json
{
  "scripts": {
    "lint:github": "eslint --format github ."
  }
}
```

### 6. Configure Nested Config (Monorepo)

1. สร้าง root config ที่ root directory

```javascript
// eslint.config.js (root)
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.configs['flat/recommended'],
  {
    rules: {
      'no-debugger': 'error',
    },
  },
];
```

2. สร้าง workspace config ที่ extends จาก root

```javascript
// apps/web/eslint.config.js
import rootConfig from '../../eslint.config.js';

export default [
  ...rootConfig,
  {
    rules: {
      'no-console': 'off',
    9,
  },
];
```CLI 

4. รัน bun run lint:type-aware เพื่อทดสอบ type-aware linting
### 7. Enable Plugins

1. ใช้ built-in plugins ผ่าน oxlint configs

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  // React plugin rules
  oxlint.configs['flat/react'],
  // TypeScript plugin rules
  oxlint.configs['flat/typescript'],
  // Import plugin rules
  oxlint.configs['flat/import'],
  // Jest plugin rules
  oxlint.configs['flat/jest'],
  // Vue plugin rules
  oxlint.configs['flat/vue'],
];
```

2. หรือใช้ buildFromOxlintConfig กับ plugins

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.buildFromOxlintConfig({
    plugins: ['react', 'typescript', 'import'],
    categories: {
      correctness: 'warn',
    },
  }),
];
```

### 8. Verify

1. รัน bun run lint เพื่อทดสอบการทำงาน
2. ตรวจสอบว่า oxlint rules ทำงานถูกต้อง
3. ตรวจสอบว่า ESLint integration ทำงานได้

## Rules

1. Installation
   - ใช้ bun add -D เท่านั้น
   - ติดตั้ง oxlint และ eslint-plugin-oxlint

2. Configuration
   - ใช้ flat config (ESLint 9+) เท่านั้น
   - ไม่รองรับ legacy config (ESLint < 9)
   - oxlint config ต้องอยู่สุดท้ายใน array เพื่อปิด rules ที่ซ้ำกับ ESLint

3. Available Configs

| Config | Description |
|--------|-------------|
| flat/recommended | correctness category |
| flat/all | ทุก rules |
| flat/eslint | ปิด ESLint rules |
| flat/import | ปิด import plugin rules |
| flat/react | ปิด React plugin rules |
| flat/typescript | ปิด TypeScript plugin rules |

4. Scripts
   - ต้องมี script lint ที่รัน oxlint ก่อน eslint
   - ต้องมี script lint:fix สำหรับ auto fix

5. Performance
   - รัน oxlint ก่อน ESLint เสมอ เพราะเร็วกว่ามาก
   - ใช้ --cache flag เมื่อรันบ่อย
   - รันเฉพาะไฟล์ที่เปลี่ยนแปลงใน pre-commit hook

6. CI Integration
   - ใช้ GitHub Actions หรือ GitLab CI
   - รัน oxlint ก่อน eslint ใน CI
   - ใช้ format github สำหรับ annotations

7. Nested Config
   - ใช้ eslint.config.js แทน .oxlintrc.json
   - แต่ละ workspace extends จาก root config
   - ไม่ต้องใช้ nested .oxlintrc.json

8. Plugins
   - ใช้ oxlint built-in plugins ผ่าน eslint-plugin-oxlint configs
   - รองรับ plugins: react, typescript, import, jest, vue, unicorn, nextjs, jsdoc, jsx-a11y, node, promise, vitest
   - ใช้ buildFromOxlintConfig กับ plugins array

## Expected Outcome

- eslint-plugin-oxlint ติดตั้งและทำงานได้
- Oxlint rules ทำงานผ่าน ESLint flat config
- Scripts lint และ lint:fix พร้อมใช้งาน
- สามารถใช้ร่วมกับ ESLint rules อื่นๆ ได้
