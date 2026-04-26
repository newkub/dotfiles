---
title: Setup Oxlint
description: ตั้งค่า eslint-plugin-oxlint สำหรับ fast linting ผ่าน ESLint 9+ flat config
auto_execution_mode: 3
---

## Goal

ติดตั้งและตั้งค่า eslint-plugin-oxlint สำหรับใช้งานร่วมกับ ESLint 9+ (flat config) เพื่อ linting ที่เร็วขึ้นด้วย Rust-based linter

## Execute

### 1. Install Dependencies

1. ติดตั้ง oxlint และ eslint-plugin-oxlint

```bash
bun add -D oxlint@latest eslint-plugin-oxlint
```

### 2. Configure Oxlint

1. สร้าง `oxlint.config.ts`:

```ts
import { defineConfig } from 'oxlint';

export default defineConfig({
  plugins: ['eslint', 'typescript', 'unicorn'],
  options: {
    typeAware: true,
    typeCheck: true,
  },
});
```

### 3. Configure ESLint

1. สร้างหรือแก้ไข eslint.config.js ที่ root

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.configs['flat/recommended'],
];
```

2. หรือใช้ buildFromOxlintConfig กับ plugins

```javascript
import oxlint from 'eslint-plugin-oxlint';

export default [
  oxlint.buildFromOxlintConfig({
    plugins: ['react', 'typescript', 'import'],
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

### 5. Verify

1. รัน bun run lint เพื่อทดสอบการทำงาน
2. ตรวจสอบว่า oxlint rules ทำงานถูกต้อง
3. ตรวจสอบว่า ESLint integration ทำงานได้

## Rules

### 1. Installation

- ใช้ bun add -D เท่านั้น
- ติดตั้ง oxlint@latest และ eslint-plugin-oxlint

### 2. Configuration

- ใช้ flat config (ESLint 9+) เท่านั้น
- ไม่รองรับ legacy config (ESLint < 9)
- oxlint config ต้องอยู่สุดท้ายใน array เพื่อปิด rules ที่ซ้ำกับ ESLint

### 3. Available Configs

| Config | Description |
|--------|-------------|
| flat/recommended | correctness category |
| flat/all | ทุก rules |
| flat/eslint | ปิด ESLint rules |
| flat/import | ปิด import plugin rules |
| flat/react | ปิด React plugin rules |
| flat/typescript | ปิด TypeScript plugin rules |

### 4. Scripts

- ต้องมี script lint ที่รัน oxlint ก่อน eslint
- ต้องมี script lint:fix สำหรับ auto fix

### 5. Performance

- รัน oxlint ก่อน ESLint เสมอ เพราะเร็วกว่ามาก
- ใช้ --cache flag เมื่อรันบ่อย
- รันเฉพาะไฟล์ที่เปลี่ยนแปลงใน pre-commit hook

### 6. Plugins

- ใช้ oxlint built-in plugins ผ่าน eslint-plugin-oxlint configs
- ใช้ buildFromOxlintConfig กับ plugins array

| Plugin | Built-in | Description |
|--------|----------|-------------|
| eslint | Yes | ESLint core rules |
| typescript | Yes | TypeScript rules from typescript-eslint. Type-aware rules available using type-aware mode |
| unicorn | Yes | eslint-plugin-unicorn |
| react | No | eslint-plugin-react, eslint-plugin-react-hooks, eslint-plugin-react-refresh |
| nextjs | No | @next/eslint-plugin-next |
| oxc | Yes | Oxc-specific rules and selected rules ported from deepscan |
| import | No | eslint-plugin-import (equivalent to eslint-plugin-import-x) |
| jsdoc | No | eslint-plugin-jsdoc |
| jsx-a11y | No | eslint-plugin-jsx-a11y |
| node | No | eslint-plugin-n |
| promise | No | eslint-plugin-promise |
| jest | No | eslint-plugin-jest |
| vitest | No | @vitest/eslint-plugin aka eslint-plugin-vitest |
| vue | No | eslint-plugin-vue rules that work with script tags |

## Expected Outcome

- eslint-plugin-oxlint ติดตั้งและทำงานได้
- Oxlint rules ทำงานผ่าน ESLint flat config
- Scripts lint และ lint:fix พร้อมใช้งาน
- สามารถใช้ร่วมกับ ESLint rules อื่นๆ ได้
