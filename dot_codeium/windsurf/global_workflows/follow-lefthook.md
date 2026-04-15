---
title: Follow Lefthook
description: ตั้งค่า Lefthook เป็น Git hooks manager พร้อม TypeScript scripts
auto_execution_mode: 3
---

## Goal

ตั้งค่า Lefthook เป็น Git hooks manager สำหรับรัน lint, typecheck, test อัตโนมัติก่อน commit, push, rebase ด้วย TypeScript scripts และ cross-platform compatibility

## Execute

### 1. Check Environment Prerequisites

1. ตรวจสอบว่ามี Bun ติดตั้งแล้ว
2. ตรวจสอบว่ามี package.json อยู่แล้ว
3. ตรวจสอบว่าอยู่ที่ root ของโปรเจกต์

### 2. Install Lefthook Package

1. รัน bun add -D lefthook
2. ตรวจสอบว่า lefthook ถูกเพิ่มใน devDependencies

### 3. Add Prepare Script to Package.json

1. เพิ่ม script "prepare": "bunx lefthook install" ใน package.json **ที่ root เท่านั้น**
2. ตรวจสอบว่าไม่มี prepare script เดิมทับซ้อน
3. **สำคัญ: อย่าเพิ่ม lefthook install ใน prepare script ของ workspace packages** - ให้มีเฉพาะที่ root

### 4. Create Lefthook.yml at Root

1. สร้างไฟล์ lefthook.yml ที่ root ของโปรเจกต์
2. กำหนดค่า pre-commit hook ด้วย lint, format, typecheck (parallel: true)
3. กำหนดค่า pre-push hook ด้วย typecheck + lint + test (turbo affected)
4. กำหนดค่า commit-msg hook สำหรับ conventional commits validation
5. กำหนดค่า pre-rebase hook เป็น optional (warning mode)
6. **ใช้ glob patterns สำหรับ file filtering ใน lefthook.yml (เช่น `**/*.{ts,tsx,vue}`)**
7. **ใช้ `{staged_files}` เพื่อส่ง files ที่ Lefthook filter แล้วไปยัง script**
8. ใช้ stage_fixed: true สำหรับ auto git add หลังจาก fix
9. เพิ่ม skip: [merge, rebase] สำหรับ pre-commit hooks
10. เพิ่ม skip: [merge] สำหรับ commit-msg hook
11. ตรวจสอบว่าไม่มี bun install ใน hooks
12. ตรวจสอบว่า hooks ใช้ TypeScript scripts (bun run scripts/*.ts) เท่านั้น

**ตัวอย่าง lefthook.yml แบบสมบูรณ์:**

```yaml
pre-commit:
  parallel: true
  commands:
    lint:
      glob: "**/*.{ts,tsx,vue}"
      run: bun run scripts/githooks/lint-staged.ts {staged_files}
      stage_fixed: true
      skip: [merge, rebase]
    typos:
      glob: "**/*.{ts,tsx,vue,md,json,yml,yaml}"
      run: bun run scripts/githooks/check-typos.ts {staged_files}
      stage_fixed: true
      skip: [merge, rebase]
    format:
      glob: "**/*.{ts,tsx,vue,json,md,yml,yaml,css,scss}"
      run: bun run scripts/githooks/format-staged.ts {staged_files}
      stage_fixed: true
      skip: [merge, rebase]

commit-msg:
  commands:
    conventional-commits:
      run: bun run scripts/githooks/commit-msg-validator.ts {1}
      skip: [merge]

pre-push:
  parallel: false
  commands:
    verify-affected:
      run: bun run scripts/githooks/verify-affected.ts

pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin
    - name: rebase-check
      run: bun run scripts/githooks/rebase-check.ts
```

**หมายเหตุสำคัญ:**
- `{staged_files}` คือตัวแปรพิเศษของ Lefthook ที่จะส่ง list of files ที่ match กับ glob pattern และถูก staged แล้ว
- Script จะได้รับ files เป็น command-line arguments แทนการใช้ manual git diff
- วิธีนี้สะอาดกว่า, เร็วกว่า, และลดความเสี่ยงจาก error

### 5. Create TypeScript Script Runners

1. สร้าง scripts/githooks/ directory ที่ root ของโปรเจกต์
2. สร้าง scripts/githooks/lint-staged.ts สำหรับ pre-commit lint
3. สร้าง scripts/githooks/check-typos.ts สำหรับ pre-commit typo check
4. สร้าง scripts/githooks/format-staged.ts สำหรับ pre-commit format
5. สร้าง scripts/githooks/run-tests.ts สำหรับ pre-commit test
6. สร้าง scripts/githooks/verify-affected.ts สำหรับ pre-push verification
7. สร้าง scripts/githooks/rebase-check.ts สำหรับ pre-rebase check
8. สร้าง scripts/githooks/commit-msg-validator.ts สำหรับ conventional commits validation

**lint-staged.ts (รับ files จาก Lefthook):**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

// รับ files จาก command-line arguments ที่ Lefthook ส่งมา
const files = process.argv.slice(2);

if (files.length === 0) {
	console.log("No files to lint");
	process.exit(0);
}

console.log(`Linting ${files.length} staged files...`);

try {
	await $`bun run lint:fix ${files.join(" ")}`;
	console.log("✓ Lint completed successfully");
	process.exit(0);
} catch (error) {
	console.error("✗ Lint failed", error);
	process.exit(1);
}
```

**check-typos.ts (cross-platform compatible):**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

// รับ files จาก command-line arguments
const files = process.argv.slice(2);

// Check if typos is installed (cross-platform)
const isTyposInstalled = await $`typos --version`.nothrow().quiet();

if (isTyposInstalled.exitCode !== 0) {
	console.log("⚠ typos not installed, skipping typo check");
	process.exit(0);
}

if (files.length === 0) {
	console.log("No files to check for typos");
	process.exit(0);
}

console.log(`Checking ${files.length} files for typos...`);

try {
	await $`typos --write-changes ${files.join(" ")}`;
	console.log("✓ Typo check completed");
	process.exit(0);
} catch (error) {
	console.error("✗ Typo check failed", error);
	process.exit(1);
}
```

**format-staged.ts:**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

const files = process.argv.slice(2);

if (files.length === 0) {
	console.log("No files to format");
	process.exit(0);
}

console.log(`Formatting ${files.length} staged files...`);

try {
	await $`bun run format ${files.join(" ")}`;
	console.log("✓ Format completed successfully");
	process.exit(0);
} catch (error) {
	console.error("✗ Format failed", error);
	process.exit(1);
}
```

**run-tests.ts (สำหรับ test files เท่านั้น):**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

const files = process.argv.slice(2);

if (files.length === 0) {
	console.log("No test files to run");
	process.exit(0);
}

console.log(`Running tests for ${files.length} files...`);

try {
	await $`bun test ${files.join(" ")}`;
	console.log("✓ Tests passed");
	process.exit(0);
} catch (error) {
	console.error("✗ Tests failed", error);
	process.exit(1);
}
```

**verify-affected.ts (สำหรับ pre-push):**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

console.log("Verifying affected packages...");

try {
	// ใช้ turbo affected สำหรับ monorepo หรือ run lint/test ทั้งหมด
	await $`bun run lint`;
	await $`bun run typecheck`;
	await $`bun run test`;
	console.log("✓ All verifications passed");
	process.exit(0);
} catch (error) {
	console.error("✗ Verification failed", error);
	process.exit(1);
}
```

**rebase-check.ts (warning mode):**

```typescript
#!/usr/bin/env bun
import { $ } from "bun";

console.log("Checking branch state before rebase...");

try {
	// เช็คว่ามี uncommitted changes หรือไม่
	const status = (await $`git status --porcelain`.text()).trim();

	if (status) {
		console.warn("⚠ You have uncommitted changes. Consider committing or stashing before rebase.");
		// Warning mode: ไม่ block rebase
		process.exit(0);
	}

	console.log("✓ Branch state clean");
	process.exit(0);
} catch (error) {
	console.error("✗ Rebase check failed", error);
	// Warning mode: ไม่ block rebase
	process.exit(0);
}
```

**commit-msg-validator.ts:**

```typescript
#!/usr/bin/env bun
export {};

const commitMsgFile = process.argv[2];

if (!commitMsgFile) {
	console.error("✗ No commit message file provided");
	process.exit(1);
}

const commitMsg = await Bun.file(commitMsgFile).text();

// Conventional commits pattern: type(scope): description
const pattern = /^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .+/;

if (!pattern.test(commitMsg.trim())) {
	console.error("✗ Invalid commit message format");
	console.error("Expected format: type(scope): description");
	console.error("Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert");
	process.exit(1);
}

console.log("✓ Commit message format valid");
process.exit(0);
```

9. ตรวจสอบว่า scripts ใช้ Bun APIs อย่างถูกต้อง: `(await $`command`.text()).trim()` แทน `await $`command`.text().trim()`
10. ตรวจสอบว่า scripts ใช้ Bun APIs หรือ execa/zx เพื่อ cross-platform compatibility
11. **ตรวจสอบว่า scripts รับ files จาก process.argv.slice(2) แทน manual git diff**

### 6. Install Git Hooks

1. รัน bun run prepare หรือ lefthook install
2. ตรวจสอบว่า hooks ถูกติดตั้งใน .git/hooks/
3. ตรวจสอบว่า hooks ทำงานได้ถูกต้อง
4. **หลังจากแก้ lefthook.yml ทุกครั้ง ต้องรัน lefthook install อีกครั้ง**

### 7. Troubleshooting

**Hook ไม่ทำงาน:**
- ตรวจสอบว่า lefthook install ถูกรันแล้ว
- ตรวจสอบ .git/hooks/ directory ว่ามี hook files อยู่
- รัน lefthook install อีกครั้ง
- ตรวจสอบว่า lefthook.yml อยู่ที่ root ของโปรเจกต์

**Windows compatibility issues:**
- ใช้ Bun APIs หรือ execa/zx แทน shell commands โดยตรง
- หลีกเลี่ยง `which`, `ls`, `cat` ที่ไม่มีใน Windows
- ใช้ `await $`command`.nothrow().quiet()` สำหรับ check command existence

**Skip hooks ชั่วคราว:**
```bash
git commit --no-verify -m "message"
git push --no-verify
```

**Debug hooks:**
- เพิ่ม console.log ใน scripts
- รัน script ด้วย bun run scripts/githooks/script.ts <files>
- ตรวจสอบ output จาก Lefthook: LEFTHOOK_DEBUG=1 git commit

**Monorepo considerations:**
- ใช้ `root: true` ใน lefthook.yml ถ้าต้องการ hooks ที่ root level
- ใช้ turbo affected สำหรับ pre-push: `turbo run lint --filter=[HEAD]`

## Expected Outcome

- Lefthook ติดตั้งและตั้งค่าเรียบร้อย
- Git hooks ทำงานอัตโนมัติก่อน commit, push, rebase
- pre-commit hook รัน lint, format, typecheck บน staged files ด้วย `{staged_files}`
- pre-push hook รัน typecheck, lint, test สำหรับ affected packages
- commit-msg hook ตรวจสอบ conventional commits
- pre-rebase hook ตรวจสอบ branch state ใน warning mode
- TypeScript scripts รับ files จาก command-line arguments
- Scripts ทำงานได้ทั้ง Windows และ Unix (cross-platform)
- Glob patterns สำหรับ file filtering ใน lefthook.yml
- stage_fixed: true สำหรับ auto git add หลังจาก fix
- ไม่ใช้ manual git diff ใน scripts (ใช้ {staged_files} แทน)

## Rules

1. Lefthook prepare script ต้องอยู่เฉพาะใน root package.json เท่านั้น
2. อย่าเพิ่ม lefthook install ใน prepare script ของ workspace packages หรือ apps
3. ใช้ bun run ใน hooks เท่านั้น
4. ไม่ใช้ bun install ใน hooks
5. ไม่ใช้ npm หรือ yarn ใน hooks
6. Hooks ต้อง fast และ deterministic
7. pre-commit ต้อง run เฉพาะ staged files ด้วย `{staged_files}` จาก Lefthook
8. pre-push ต้อง run เฉพาะ affected files (ใช้ turbo affected)
9. Hooks ต้องใช้ TypeScript scripts (bun run scripts/*.ts) เท่านั้น
10. Scripts ต้องใช้ Bun APIs อย่างถูกต้อง: `(await $`command`.text()).trim()` แทน `await $`command`.text().trim()`
11. Scripts ต้องรับ files จาก process.argv.slice(2) แทน manual git diff
12. Scripts ต้องใช้ Bun APIs หรือ execa/zx เพื่อ cross-platform compatibility
13. Scripts ต้องใช้ .nothrow().quiet() สำหรับ check command existence (แทน which/where)
14. ตรวจสอบว่าทำงานได้ทั้ง Windows และ Unix
