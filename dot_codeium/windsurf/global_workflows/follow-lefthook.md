---
title: Follow Lefthook
description: ตั้งค่า Lefthook สำหรับ Git hooks ใน Bun/Node ecosystem
auto_execution_mode: 3
file-patterns:
  - "lefthook.yml"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า Lefthook เป็น Git hooks manager สำหรับรัน scripts อัตโนมัติก่อน commit, rebase, checkout และอื่นๆ

## Scope

- ติดตั้ง Lefthook ใน Bun/Node ecosystem
- กำหนดค่า `lefthook.yml` ที่ root เท่านั้น
- รองรับ pre-commit, pre-rebase, post-receive, post-checkout hooks

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Location | Root ของโปรเจกต์ (ไม่ใช่ workspace) |

## Rules

| Category | Requirements |
|------|---------|
| **Single File** | มี `lefthook.yml` เดียวที่ root เท่านั้น |
| **Prepare Script** | ต้องมี `"prepare": "lefthook install"` ใน package.json |
| **No Workspace** | ไม่ใช้ lefthook.yml ใน workspaces |
| **Bun Only** | ใช้ `bun install` และ `bun run` ใน hooks |

## Structure

### Directory Structure

```text
project/
├── lefthook.yml          # ที่ root เท่านั้น
├── package.json          # มี prepare script
└── apps/
    └── (no lefthook.yml here)
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add lefthook, prepare script |
| Configure | กำหนด hooks | lefthook.yml |
| Install | ติดตั้ง hooks | Run prepare script |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี `package.json` อยู่แล้ว
  - อยู่ที่ root ของโปรเจกต์ (ไม่ใช่ workspace)

### Phase 1: Setup

- 1.1 **ติดตั้ง Lefthook**
  - รัน `bun add -D lefthook`
  - ตรวจสอบ installation สำเร็จ

- 1.2 **เพิ่ม Prepare Script**
  - เพิ่มใน `package.json`:

```json [package.json]
{
  "scripts": {
    "prepare": "lefthook install"
  }
}
```

### Phase 2: Configure

- 2.1 **สร้าง lefthook.yml**
  - สร้างไฟล์ `lefthook.yml` ที่ root:

```yml [lefthook.yml]
pre-commit:
  jobs:
    - name: install-deps
      run: bun install
    - name: format
      run: bun run format {staged_files}

pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin
    - name: rebase-check
      run: |
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})
        [ "$LOCAL" = "$REMOTE" ] && exit 0
        [ "$LOCAL" = "$BASE" ] && { echo "Branch behind, pull/rebase first!"; exit 1; }

post-receive:
  jobs:
    - name: open repo
      run: gh repo view --web

post-checkout:
  jobs:
    - name: install-deps
      run: bun install
```

### Phase 3: Install

- 3.1 **ติดตั้ง Hooks**
  - รัน `bun run prepare`
  - หรือ `lefthook install`
  - ตรวจสอบ hooks ถูกติดตั้งใน `.git/hooks/`

## Outputs

| Output | Details |
|--------|-----------|
| lefthook.yml | Git hooks configuration |
| Updated package.json | Prepare script |
| Installed hooks | ใน .git/hooks/ |

## Expected Outcome

- Lefthook ติดตั้งใน devDependencies
- `lefthook.yml` สร้างที่ root พร้อม hooks ที่กำหนด
- Prepare script ทำงานอัตโนมัติเมื่อ install
- Hooks ทำงานได้ถูกต้อง (pre-commit รัน install และ format)

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows ที่เกี่ยวข้อง
