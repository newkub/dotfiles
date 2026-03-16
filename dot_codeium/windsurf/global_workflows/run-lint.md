---
title: Run Lint
description: รัน linter และแก้ไข error/warning สำหรับไฟล์ต่างๆ ตามประเภท
auto_execution_mode: 3
file-patterns:
  - "**/*.md"
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
  - "**/*.rs"
  - "**/*.py"
  - "**/*.lua"
  - "**/*.go"
  - "**/*.vue"
  - "**/*.json"
  - "**/*.yaml"
  - "**/*.yml"
follow:
  skills:
    - "@biome"
    - "@oxlint"
  workflows:
    - "/validate"
    - "/optimize-content-readability"
    - "/write-workflows"
  files:
    - "guidelines/linting.md"
---

## Purpose

รัน linter บนไฟล์ต่างๆ ใน project ตามประเภทไฟล์ แล้วแก้ไขทั้ง error และ warning ให้หมดไม่เหลือ เพื่อรักษาคุณภาพโค้ดและความสอดคล้องของ coding standards

## Scope

- ใช้กับไฟล์หลายประเภท (markdown, typescript, javascript, rust, python, lua, go, vue, json, yaml)
- รวมถึงการรัน linter และการแก้ไข error/warning
- รองรับการใช้หลาย tools (biome, oxlint, ruff, cargo, etc.)
- ไม่รวมการ setup linter ใหม่ (ใช้ /setup แทน)

## Inputs

| Input | รายละเอียด |
|-------|-----------|
| Target Files | ไฟล์หรือ pattern ที่ต้องการ lint |
| Linter Config | ไฟล์ config ของ linter (ถ้ามี) |
| Available Tools | Tools ที่ติดตั้งในระบบ |

## Rules

### Linter Standards

| หมวด | ข้อกำหนด |
|------|---------|
| **No Errors** | ต้องแก้ไขทุก error ให้หมด |
| **No Warnings** | ต้องแก้ไขทุก warning ให้หมด |
| **Type Aware** | ใช้ type-aware linting เมื่อเป็นไปได้ |
| **Auto Fix** | ใช้ auto-fix ก่อน manual fix |

### Quality Standards

| หมวด | ข้อกำหนด |
|------|---------|
| **Incremental** | แก้ไขทีละไฟล์หรือทีละประเภท |
| **Verification** | รัน linter ซ้ำหลังแก้ไข |
| **Safety** | ต้องรักษา functionality เดิม |

## Structure

### โครงสร้าง Directory

```text
project/
├── biome.json              # Biome config
├── oxlintrc.json           # Oxlint config
├── ruff.toml               # Ruff config
├── .yamllint               # Yamllint config
├── stylua.toml             # Stylua config
├── src/                    # Source files
├── tests/                  # Test files
└── docs/                   # Documentation files
```

### Phase Definitions

| Phase | คำอธิบาย | กิจกรรมหลัก |
|-------|---------|------------|
| **Setup** | เตรียม context | ตรวจสอบ linter config |
| **Research** | ศึกษา rules | อ่าน config และ documentation |
| **Analyze** | วิเคราะห์ไฟล์ | ระบุไฟล์เป้าหมาย |
| **Plan** | วางแผน | เลือกคำสั่ง linter |
| **Execute** | ลงมือทำ | รัน linter และแก้ไข |
| **Verify** | ตรวจสอบ | ยืนยันไม่มี error/warning |
| **Review** | ประเมิน | ตรวจสอบคุณภาพ |
| **Finalize** | ปิดงาน | ยืนยันพร้อมใช้งาน |

### Linter Commands by File Type

| File Pattern | Command | Tools |
|-------------|---------|-------|
| **.md** | `rumdl fmt --disable MD013 .` | rumdl |
| **.ts, .tsx** | `tsc --noEmit && oxlint --type-aware --fix && biome lint --write` | tsc, oxlint, biome |
| **.js, .jsx, .mjs** | `oxlint --fix && biome lint --write` | oxlint, biome |
| **.rs** | `cargo clippy && cargo fmt --check` | cargo |
| **.py** | `ruff check . && ruff format --check .` | ruff |
| **.lua** | `stylua --check .` | stylua |
| **.go** | `go vet ./... && gofmt -l .` | go |
| **.vue** | `vue-tsc --noEmit && oxlint --fix && biome lint --write` | vue-tsc, oxlint, biome |
| **.json** | `biome lint` | biome |
| **.yaml, .yml** | `yamllint .` | yamllint |
| **package.json** | `bun run lint` หรือ `npm run lint` | bun/npm |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Linter Tools**
  - ยืนยันว่ามี linter tools ที่จำเป็น (biome, oxlint, ruff, etc.)
  - ตรวจสอบว่า tools ทำงานได้
  - ถ้าขาด tool ให้ติดตั้งก่อน

- 0.2 **ตรวจสอบ Config Files**
  - ตรวจสอบว่ามี linter config (biome.json, .oxlintrc.json, etc.)
  - ยืนยันว่า config ถูกต้องและไม่มี syntax error

### Phase 1: Setup

- 1.1 **เตรียม Context**
  - ตรวจสอบ linter config ที่มีอยู่ใน project
  - ระบุประเภทไฟล์ที่ต้องการ lint
  - ใช้ `/validate` ตรวจสอบว่า linter config มีอยู่และถูกต้อง

### Phase 2: Research

- 2.1 **ศึกษา Linter Rules**
  - ใช้ `/optimize-content-readability` อ่าน config files
  - เข้าใจกฎ rules และการตั้งค่า
  - จดบันทึก rules ที่สำคัญ

### Phase 3: Analyze

- 3.1 **วิเคราะห์ไฟล์เป้าหมาย**
  - ระบุไฟล์ที่ต้อง lint จาก file-patterns
  - จัดกลุ่มไฟล์ตามประเภทเพื่อเลือกคำสั่งที่เหมาะสม
  - ลำดับความสำคัญ (config → source → test)

### Phase 4: Plan

- 4.1 **วางแผนการ Lint**
  - เลือกคำสั่ง linter ตามประเภทไฟล์จากตาราง Linter Commands
  - กำหนดลำดับการรัน (เริ่มจากไฟล์ config → source → test)
  - วางแผนการแก้ไข (auto-fix ก่อน manual fix)

### Phase 5: Execute

- 5.1 **รัน Linter ตามประเภทไฟล์**
  - รัน linter สำหรับแต่ละประเภทไฟล์ตามแผนที่วางไว้
  - บันทึกผลลัพธ์ (errors และ warnings)
  - ใช้ auto-fix เมื่อเป็นไปได้

- 5.2 **แก้ไข Errors**
  - แก้ไขทุก error ที่พบให้หมด
  - รัน linter ซ้ำเพื่อยืนยันว่า error หมดไป

- 5.3 **แก้ไข Warnings**
  - แก้ไขทุก warning ที่พบให้หมด
  - รัน linter ซ้ำเพื่อยืนยันว่า warning หมดไป

### Phase 6: Verify

- 6.1 **ตรวจสอบผลลัพธ์**
  - รัน linter อีกครั้งเพื่อยืนยันว่าไม่มี error/warning เหลือ
  - ใช้ `/validate` ตรวจสอบความถูกต้อง
  - ยืนยันว่าไฟล์ทั้งหมดผ่าน linter

### Phase 7: Review

- 7.1 **ตรวจสอบคุณภาพ**
  - อ่านทวนโค้ดที่แก้ไขเพื่อความถูกต้อง
  - ตรวจสอบว่าการแก้ไขไม่ทำให้เกิด bug ใหม่
  - ยืนยันว่า functionality ยังทำงานได้เหมือนเดิม

### Phase 8: Finalize

- 8.1 **ปิดงาน**
  - รัน `rumdl check --disable MD013 .` เพื่อตรวจสอบ markdown format
  - ยืนยันไฟล์พร้อมใช้งาน
  - สรุปสิ่งที่แก้ไข

## Outputs

| Output | รายละเอียด |
|--------|-----------|
| Linted Files | ไฟล์ที่ผ่านการ lint |
| Fixed Errors | จำนวน errors ที่แก้ไข |
| Fixed Warnings | จำนวน warnings ที่แก้ไข |
| Clean Codebase | โค้ดที่ไม่มี linter issues |

## Expected Outcome

- ไม่มี linter errors เหลืออยู่
- ไม่มี linter warnings เหลืออยู่
- โค้ดผ่าน coding standards ทั้งหมด
- ไม่มี regression จากการแก้ไข
- ไฟล์พร้อมใช้งาน

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/optimize-content-readability` - ปรับปรุงความชัดเจนของเนื้อหา
- `/write-workflows` - แนวทางการสร้าง workflow
- `@biome` - Biome linter skill
- `@oxlint` - Oxlint skill
