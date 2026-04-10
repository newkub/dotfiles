---
title: Follow Lefthook
description: ตั้งค่า Lefthook เป็น Git hooks manager สำหรับรัน scripts อัตโนมัติก่อน commit, rebase, checkout, push และอื่นๆ ด้วย production-grade best practices พร้อม fail fast mode, caching, และ optional hooks สำหรับ Bun/Node ecosystem
auto_execution_mode: 3
---

Workflow นี้สำหรับตั้งค่า Lefthook เป็น Git hooks manager ที่ fast, deterministic และ cross-platform สำหรับรัน lint, typecheck, test และ automation อื่นๆ ก่อน commit, push, rebase, checkout และ receive ด้วย TypeScript scripts ที่ทำงานได้ทั้ง Windows และ Unix

## Execute

1. Check environment prerequisites

- ตรวจสอบว่ามี Bun ติดตั้งแล้ว
- ตรวจสอบว่ามี package.json อยู่แล้ว
- ตรวจสอบว่าอยู่ที่ root ของโปรเจกต์ (ไม่ใช่ workspace)

2. Install Lefthook package

- รัน bun add -D lefthook
- ตรวจสอบว่า installation สำเร็จ
- ตรวจสอบว่า lefthook ถูกเพิ่มใน devDependencies

3. Add prepare script to package.json

- เพิ่ม script "prepare": "lefthook install" ใน package.json
- ตรวจสอบว่า script ถูกเพิ่มอย่างถูกต้อง
- ตรวจสอบว่าไม่มี prepare script เดิมทับซ้อน

4. Create lefthook.yml at root

- สร้างไฟล์ lefthook.yml ที่ root ของโปรเจกต์
- กำหนดค่า pre-commit hook ด้วย lint-staged (fast, staged only, cross-platform)
- กำหนดค่า pre-push hook ด้วย typecheck + affected lint only (lightweight, no test unit เพื่อลด duplicate compute กับ CI)
- กำหนดค่า pre-rebase hook เป็น optional (ใช้ lefthook-local.yml สำหรับ local overrides)
- ตรวจสอบว่าไม่มี bun install ใน hooks
- ตรวจสอบว่า hooks ใช้ TypeScript scripts (bun run scripts/*.ts) เท่านั้น
- ตรวจสอบว่า scripts ที่ใช้มีอยู่ใน package.json (ดู /setup-verify สำหรับ scripts template)

5. Create TypeScript script runners

- สร้าง scripts/ directory ที่ root ของโปรเจกต์
- สร้าง scripts/verify-affected.ts สำหรับ pre-push (typecheck + affected lint only, lightweight, ใช้ turbo affected)
- สร้าง scripts/rebase-check.ts สำหรับ pre-rebase (optional warning mode)
- สร้าง scripts/verify-quick.ts สำหรับ fail fast mode (typecheck + lint only)
- ตรวจสอบว่า scripts ใช้ Bun APIs หรือ execa/zx เพื่อ cross-platform compatibility

6. Add mode-based environment variables

- เพิ่ม `LEFTHOOK_MODE=dev|ci|local` ใน .env.example
- dev mode: hooks soft, pre-rebase warning only
- local mode: hooks minimal, pre-rebase disabled
- ci mode: hooks strict, pre-rebase disabled (CI ไม่ควรใช้ pre-rebase hook)

7. Install git hooks

- รัน bun run prepare หรือ lefthook install
- ตรวจสอบว่า hooks ถูกติดตั้งใน .git/hooks/
- ตรวจสอบว่า hooks ทำงานได้ถูกต้อง

### Example

ตัวอย่าง lefthook.yml ที่ root ของโปรเจกต์ (พร้อม mode-based config):

```yml [lefthook.yml]
pre-commit:
  parallel: false
  jobs:
    - name: lint-staged
      run: bun run lint-staged

pre-push:
  parallel: false
  jobs:
    - name: verify-affected
      run: bun run scripts/verify-affected.ts

pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin
    - name: rebase-check
      run: bun run scripts/rebase-check.ts
```

ตัวอย่าง lefthook-local.yml สำหรับ local overrides (เพิ่มใน .gitignore):

```yml [lefthook-local.yml]
# Skip pre-rebase hook in local development
pre-rebase:
  skip: true
```

ตัวอย่าง package.json ที่ root ของโปรเจกต์ (พร้อม fail fast mode):

```json [package.json]
{
  "scripts": {
    "prepare": "lefthook install",
    "lint-staged": "lint-staged",
    "format": "biome format --write",
    "lint": "biome lint --write",
    "typecheck": "turbo typecheck",
    "test:unit": "vitest run --coverage",
    "verify": "bun run format && bun run lint && bun run typecheck && bun run test:unit",
    "verify:quick": "bun run scripts/verify-quick.ts",
    "git:check-rebase": "bun run scripts/rebase-check.ts"
  },
  "devDependencies": {
    "lefthook": "^2.1.5",
    "lint-staged": "^15.2.0"
  }
}
```

ตัวอย่าง .env.example (สำหรับ mode-based config):

```env [.env.example]
# Lefthook mode: dev (soft hooks), local (minimal), or ci (strict hooks)
LEFTHOOK_MODE=dev
```

หมายเหตุ: dependency updates ควรรัน manual (bunx taze -r -w -i) เมื่อจำเป็นเท่านั้น

หมายเหตุ: ดู /setup-verify สำหรับ scripts template ที่ครบถ้วน (7 layers)

### TypeScript Script Examples

scripts/verify-affected.ts (typecheck + affected lint only for pre-push, using turbo affected):

```ts [scripts/verify-affected.ts]
#!/usr/bin/env bun
import { $ } from 'bun';

// Get base commit for affected files
const base = await $`git merge-base origin/main HEAD`.text().then(t => t.trim());

// Run typecheck on affected packages only using turbo affected
await $`turbo run typecheck --filter=...[${base}]`;
```

scripts/rebase-check.ts (cross-platform rebase check with warning mode):

```ts [scripts/rebase-check.ts]
#!/usr/bin/env bun
import { $ } from 'bun';

const mode = process.env.LEFTHOOK_MODE || 'dev';

const local = await $`git rev-parse @`.then((o) => o.stdout.toString().trim());
const remote = await $`git rev-parse @{u}`.then((o) => o.stdout.toString().trim());
const base = await $`git merge-base @ @{u}`.then((o) => o.stdout.toString().trim());

if (local === remote) {
  process.exit(0);
}

if (local === base) {
  const msg = '⚠️  Branch behind remote. Run: git pull --rebase';
  if (mode === 'ci') {
    console.error(msg);
    process.exit(1);
  } else {
    console.warn(msg);
    process.exit(0); // Warning mode in dev
  }
}

if (remote === base) {
  const msg = '⚠️  Branch has diverged. Run: git pull --rebase';
  if (mode === 'ci') {
    console.error(msg);
    process.exit(1);
  } else {
    console.warn(msg);
    process.exit(0); // Warning mode in dev
  }
}
```

scripts/verify-quick.ts (fail fast mode - typecheck + lint only):

```ts [scripts/verify-quick.ts]
#!/usr/bin/env bun
import { $ } from 'bun';

console.log('🚀 Running quick verification (typecheck + lint only)...');

await $`bun run typecheck`;
await $`bun run lint`;

console.log('✅ Quick verification passed!');
```

lint-staged.config.js (lint-staged configuration):

```js [lint-staged.config.js]
export default {
  '*.{js,ts,jsx,tsx}': ['biome format --write', 'biome lint --write'],
  '*.{json,jsonc}': ['biome format --write'],
};
```

หมายเหตุ: Biome จะ format และ lint ในครั้งเดียว (Biome handles staged files correctly)

หมายเหตุ: ใช้ turbo cache ด้วย `--cache` flag เพื่อลดเวลาในการรัน affected commands

## Rules

1. Single file configuration

- มี lefthook.yml เดียวที่ root เท่านั้น
- ไม่สร้าง lefthook.yml ใน workspaces
- ไม่สร้าง lefthook.yml ใน subdirectories

2. Prepare script requirement

- ต้องมี "prepare": "lefthook install" ใน package.json
- prepare script ต้องทำงานอัตโนมัติเมื่อ install
- ต้องอยู่ที่ root package.json เท่านั้น

3. Bun execution only

- ใช้ bun run ใน hooks เท่านั้น
- ไม่ใช้ bun install ใน hooks
- ไม่ใช้ npm หรือ yarn ใน hooks
- หมายเหตุ: ถ้ามี contributor ภายนอกที่ใช้ Node-only ควรเตรียม fallback script

4. Performance first

- Hooks ต้อง fast และ deterministic
- pre-commit ต้อง run เฉพาะ staged files ด้วย lint-staged
- pre-push ต้อง run เฉพาะ affected files (ใช้ turbo affected)
- ใช้ turbo cache หรือ nx cache สำหรับ affected commands
- ไม่รัน heavy operations ใน pre-commit
- หลีกเลี่ยง duplicate work (lint 2 รอบ, test 2 รอบ)
- pre-push ไม่ควรรัน test unit เต็ม เพื่อลด duplicate compute กับ CI

5. Lean hooks philosophy

- hooks ต้อง minimal และ fast
- หลีกเลี่ยง hooks ที่ noisy (post-checkout, post-merge, post-receive)
- pre-rebase ควรเป็น optional warning หรือ CLI command แทน blocking
- pre-push ควรเป็น lightweight (typecheck + affected lint only) เพื่อลด duplicate compute กับ CI
- ให้ developer รัน manual commands สำหรับ dependency management
- hooks ควร focus บน code quality และ branch safety เท่านั้น

6. Non-blocking user experience

- post-receive ต้องไม่ auto-open browser
- post-receive ต้องแสดง URL แทน
- hooks ต้องไม่ break git flow

7. Branch protection

- pre-rebase ต้องเช็ค branch state
- pre-rebase ต้องแนะนำ command เมื่อ fail
- pre-rebase ต้อง detect diverged branches
- pre-rebase ควรเป็น warning mode ใน dev, disabled ใน CI (CI ไม่ควรใช้ pre-rebase hook)

8. Verify pipeline alignment

- pre-commit ต้องเป็น lint-staged เท่านั้น (fast, staged only, cross-platform)
- pre-push ต้องเป็น typecheck + affected lint only (lightweight, no test unit เพื่อลด duplicate compute กับ CI)
- CI ต้องรัน full verify (format + lint + typecheck + test) เป็น single source of truth
- scripts ที่ใช้ต้องสอดคล้องกับ /setup-verify template
- ดู /setup-verify สำหรับ scripts template และ verify pipeline

9. Cross-platform compatibility

- Hooks ต้องใช้ TypeScript scripts (bun run scripts/*.ts) แทน shell scripts
- Scripts ต้องใช้ Bun APIs หรือ execa/zx เพื่อ cross-platform compatibility
- หลีกเลี่ยง bash-specific syntax เช่น `[ ! -d "node_modules" ]`
- ตรวจสอบว่าทำงานได้ทั้ง Windows (pwsh) และ Unix (bash/zsh)

10. Mode-based configuration

- ใช้ `LEFTHOOK_MODE` environment variable สำหรับ dev/ci/local mode
- dev mode: hooks soft, pre-rebase warning only, fail fast enabled
- local mode: hooks minimal, pre-rebase disabled
- ci mode: hooks strict, pre-rebase disabled, full verify only
- ใช้ `lefthook-local.yml` สำหรับ local overrides (skip specific hooks ใน local)
- lefthook-local.yml ควรถูกเพิ่มใน .gitignore
