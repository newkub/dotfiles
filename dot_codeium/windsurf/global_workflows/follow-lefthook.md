---
title: Follow Lefthook
description: ตั้งค่าและใช้งาน Lefthook สำหรับ Git hooks automation
auto_execution_mode: 3
---


## Goal

ตั้งค่า Lefthook เป็นเครื่องมือจัดการ Git hooks ที่เร็วและทรงพลัง รองรับ parallel execution และ monorepo

## Scope

ตั้งค่า Lefthook สำหรับ projects และ monorepos

## Execute

### 1. Use Lefthook

ใช้ Lefthook ผ่าน bunx โดยไม่ต้องติดตั้ง

1. รัน `bunx lefthook install` เพื่อติดตั้ง git hooks
2. ใช้ `bunx lefthook` สำหรับคำสั่งทั้งหมด
3. ไม่ต้องติดตั้ง lefthook ใน package.json

### 2. Create Configuration

สร้าง lefthook.yml config file

1. รัน `bunx lefthook install` เพื่อสร้าง config file
2. สร้าง `lefthook.yml` ที่ root directory
3. ตั้งค่า hooks พื้นฐาน: pre-push, pre-merge-commit
4. เพิ่ม `assert_lefthook_installed: true` เพื่อ fail ถ้า lefthook ไม่ได้ติดตั้ง
5. เพิ่ม `min_version` เพื่อ pin 最低 version
6. ใช้ `parallel: true` สำหรับ performance

```yaml
assert_lefthook_installed: true
min_version: 2.0.0

pre-push:
  parallel: true
  commands:
    lint:
      run: bun run lint
      fail_text: "Lint failed. Fix linting errors before pushing."
    scan:
      run: bun run scan
      fail_text: "Scan failed. Fix code quality issues before pushing."
    format:
      run: bun run format
      fail_text: "Format failed. Fix formatting issues before pushing."
    typecheck:
      run: bun run typecheck
      fail_text: "Typecheck failed. Fix type errors before pushing."
    test:
      run: bun run test
      fail_text: "Tests failed. Fix failing tests before pushing."
```

### 3. Configure Hooks

ตั้งค่า Git hooks ตามความต้องการ

1. pre-push: รัน lint, scan, format, typecheck, test ก่อน push
2. pre-merge-commit: รัน typecheck ก่อน merge
3. ใช้ `glob` เพื่อ filter files
4. ใช้ `exclude` เป็น YAML list format เพื่อข้ามไฟล์ที่ไม่ต้องการ
5. ใช้ `stage_fixed: true` เพื่อ auto-stage ไฟล์ที่แก้ไข
6. ใช้ `fail_text` เพื่อแสดงข้อความ actionable เมื่อ fail

```yaml
pre-push:
  parallel: true
  commands:
    lint:
      run: bun run lint
      fail_text: "Lint failed. Fix linting errors before pushing."
    scan:
      run: bun run scan
      fail_text: "Scan failed. Fix code quality issues before pushing."
    format:
      run: bun run format
      fail_text: "Format failed. Fix formatting issues before pushing."
    typecheck:
      run: bun run typecheck
      fail_text: "Typecheck failed. Fix type errors before pushing."
    test:
      run: bun run test
      fail_text: "Tests failed. Fix failing tests before pushing."

pre-merge-commit:
  parallel: true
  commands:
    typecheck:
      run: bun run typecheck
      fail_text: "Typecheck failed. Fix type errors before merging."
```

### 4. Advanced Features

ใช้ features ขั้นสูงของ Lefthook

1. ใช้ `tags` เพื่อ group commands
2. สร้าง `lefthook-local.yml` สำหรับ local config (add to .gitignore)
3. ใช้ `glob` และ `regexp` filters
4. ตั้งค่า monorepo ด้วย `root` option
5. ใช้ custom scripts ใน `lefthook/hooks/`

```yaml
pre-commit:
  parallel: true
  commands:
    frontend-lint:
      root: "packages/frontend/"
      glob: "*.{ts,tsx}"
      run: yarn workspace frontend lint {staged_files}
      stage_fixed: true
      tags: [frontend]
    backend-lint:
      root: "packages/backend/"
      glob: "*.go"
      run: golangci-lint run --fix {staged_files}
      stage_fixed: true
      tags: [backend]

# lefthook-local.yml (add to .gitignore)
pre-commit:
  commands:
    some-heavy-check:
      skip: true
```

### 5. Run Hooks

รัน hooks ด้วยคำสั่ง Lefthook

1. รัน `bunx lefthook run pre-push` เพื่อทดสอบ pre-push hook
2. รัน `bunx lefthook run pre-merge-commit` เพื่อทดสอบ pre-merge-commit hook
3. รัน `bunx lefthook run` เพื่อรัน hooks group
4. ใช้ `LEFTHOOK=0 git commit` เพื่อ skip hooks
5. ตั้งค่า `output` option เพื่อ control output
6. ใช้ `--no-stage-fixed` flag เพื่อทดสอบโดยไม่ stage ไฟล์ที่แก้ไข

## Rules

- ใช้ run ตามที่กำหนดใน package manifest หรือ task file
- ใช้ `assert_lefthook_installed: true` เสมอเพื่อป้องกัน hooks ทำงานโดยไม่มี lefthook
- ใช้ `min_version` เพื่อ pin 最低 version ที่รองรับ features ที่ใช้
- ใช้ `parallel: true` เสมอเพื่อ performance
- ใช้ `stage_fixed: true` สำหรับ linter/formatter
- ใช้ `glob` filters เพื่อ skip commands ที่ไม่เกี่ยวข้อง
- ใช้ `exclude` เป็น YAML list format (ไม่ใช่ space-separated string)
- ใช้ `fail_text` ทุก command เพื่อแสดง actionable error messages
- ใช้ Biome สำหรับ lint และ format ไม่ใช้ ESLint หรือ Prettier
- ใช้ `--no-errors-on-unmatched` สำหรับ biome lint เพื่อไม่ error เมื่อไม่มีไฟล์ตรง glob
- ใช้ hook name ที่ถูกต้อง: `pre-commit`, `pre-push`, `pre-merge-commit` (ไม่ใช่ `pre-merge`)
- ใช้ `skip: - merge` และ `skip: - rebase` เพื่อข้าม hooks
- ใช้ `tags` เพื่อ group commands ที่เกี่ยวข้องกัน
- ใช้ `lefthook-local.yml` สำหรับ local overrides
- ใช้ Bun scripts สำหรับ cross-platform compatibility

## Expected Outcome

- Lefthook ใช้งานผ่าน bunx สำเร็จ
- Git hooks ทำงานอัตโนมัติ
- Validation ทำงานก่อน push
- Performance ดีขึ้นด้วย parallel execution
- Hooks fail ชัดเจนเมื่อ lefthook ไม่ได้ติดตั้ง
- Error messages มี actionable guidance
