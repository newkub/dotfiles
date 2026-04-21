---
title: Follow Lefthook
description: ตั้งค่าและใช้งาน Lefthook สำหรับ Git hooks automation
auto_execution_mode: 3
---

## Goal

ตั้งค่า Lefthook เป็นเครื่องมือจัดการ Git hooks ที่เร็วและทรงพลัง รองรับ parallel execution และ monorepo

## Execute

### 1. Install Lefthook

ติดตั้ง Lefthook ตาม platform ที่ใช้

1. Node.js: รัน `bun add -D lefthook`
2. Homebrew: รัน `brew install lefthook`
3. Winget: รัน `winget install lefthook`
4. Linux: ดูวิธีติดตั้งจาก official docs

### 2. Create Configuration

สร้าง lefthook.yml config file

1. รัน `lefthook install` เพื่อสร้าง config file
2. สร้าง `lefthook.yml` ที่ root directory
3. ตั้งค่า hooks พื้นฐาน เช่น pre-commit, pre-push, pre-merge
4. ใช้ `parallel: true` สำหรับ performance

```yaml
pre-commit:
  parallel: true
  commands:
    lint:
      glob: "*.{ts,tsx,js,jsx}"
      run: bunx eslint {staged_files} --fix
      stage_fixed: true
    format:
      glob: "*.{ts,tsx,js,jsx,json,md}"
      run: bunx prettier --write {staged_files}
      stage_fixed: true
```

### 3. Configure Hooks

ตั้งค่า Git hooks ตามความต้องการ

1. pre-commit: รัน lint, format, typecheck ก่อน commit
2. pre-push: รัน tests ก่อน push
3. pre-merge: รัน tests ก่อน merge
4. ใช้ `glob` เพื่อ filter files
5. ใช้ `stage_fixed: true` เพื่อ auto-stage ไฟล์ที่แก้ไข

```yaml
pre-commit:
  parallel: true
  commands:
    typecheck:
      run: bunx tsc --noEmit

pre-push:
  commands:
    test:
      run: bun run test

pre-merge:
  parallel: true
  commands:
    test:
      run: bun run test
    typecheck:
      run: bunx tsc --noEmit
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

1. รัน `lefthook run pre-commit` เพื่อทดสอบ pre-commit hook
2. รัน `lefthook run pre-push` เพื่อทดสอบ pre-push hook
3. รัน `lefthook run pre-merge` เพื่อทดสอบ pre-merge hook
4. รัน `lefthook run` เพื่อรัน hooks group
5. ใช้ `LEFTHOOK=0 git commit` เพื่อ skip hooks
6. ตั้งค่า `output` option เพื่อ control output

## Rules

- ใช้ run ตามที่กำหนดใน package manifest หรือ task file
- ใช้ `parallel: true` เสมอเพื่อ performance
- ใช้ `stage_fixed: true` สำหรับ linter/formatter
- ใช้ `glob` filters เพื่อ skip commands ที่ไม่เกี่ยวข้อง
- ใช้ `skip: - merge` และ `skip: - rebase` เพื่อข้าม hooks
- ใช้ `tags` เพื่อ group commands ที่เกี่ยวข้องกัน
- ใช้ `lefthook-local.yml` สำหรับ local overrides
- ใช้ Bun scripts สำหรับ cross-platform compatibility

## Expected Outcome

- Lefthook ติดตั้งและ config สำเร็จ
- Git hooks ทำงานอัตโนมัติ
- Code quality checks ทำงานก่อน commit
- Validation ทำงานก่อน push
- Performance ดีขึ้นด้วย parallel execution