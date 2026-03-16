---
title: Global Rules
description: กฎหลักที่ต้องปฏิบัติตามในทุกการทำงาน สำหรับ AI assistant
auto_execution_mode: 3
file-patterns:
  - "**/*.md"

follow:
  skills:
    - "@write-skills"
    - "@write-markdown"
    - "@write-workflows"

  workflows:
    - "/optimize-workflows"
    - "/optimize-content-readability"

  files: []
  mcp: []
---

## Purpose

กำหนดกฎหลักที่ AI assistant ต้องปฏิบัติตามในทุกการทำงาน เพื่อให้ได้ผลลัพธ์ที่สม่ำเสมอ มีคุณภาพ และสอดคล้องกับความต้องการของผู้ใช้

## Scope

ใช้กับ:

- ทุกการตอบกลับผู้ใช้
- ทุกการแก้ไขไฟล์
- ทุกการรันคำสั่ง

## Inputs

| Input | Details |
|-------|---------|
| User Request | คำขอหรือคำสั่งจากผู้ใช้ |
| Context | ไฟล์ที่เปิดอยู่, workspace structure |
| Rules | Global rules, AGENTs.md, Skills |

## Rules

### Communication

| Category | Requirements |
|----------|--------------|
| **Language** | ตอบกลับเป็นภาษาไทยทุกครั้ง |
| **Style** | กระชับ ตรงประเด็น ไม่ verbose |
| **Shortcuts** | `.` = continue, `/` = workflow command |

### Development

| Category | Requirements |
|----------|--------------|
| **Runtime** | ใช้ `bun` เท่านั้น ห้ามใช้ npm/npx/yarn/pnpm |
| **Vue** | ใช้ `script setup lang="ts"`, script อยู่บน template |
| **Tools** | ใช้ Biome, oxlint แทน ESLint/Prettier |

### File Operations

| Category | Requirements |
|----------|--------------|
| **Paths** | ใช้ absolute paths เสมอ |
| **Shell** | ใช้ `pwsh` สำหรับ file operations |
| **Reference** | อัพเดท relative paths เมื่อ rename file |
| **Patterns** | ดูไฟล์ใกล้เคียงก่อนสร้างใหม่ |
| **GitKeep** | ห้ามสร้าง `.gitkeep` โดยไม่จำเป็น |

### Error Handling

| Category | Requirements |
|----------|--------------|
| **Collect First** | เจอ error/warning ให้จดบันทึกไว้ก่อน แก้ทีหลัง |
| **Incremental Lint** | `/run-lint` เฉพาะไฟล์ที่แก้ไขใหม่ ยกเว้นมีคำสั่งให้ run ทั้ง project |
| **Fix All** | ต้องแก้ error/warning ให้หมดไม่เหลือ |

### Workflow

| Category | Requirements |
|----------|--------------|
| **Follow** | `global_workflows/` หรือ `*/workflows/*` → `@write-workflows` |
| **Skills** | `skills/` → `@write-skills` และ `@write-markdown` |
| **New Skills** | ก่อนเขียนใน `skills/` ให้ทำตาม `/write-skills` ก่อน |
| **Quality** | ไฟล์ .md → `@write-markdown` |

## Structure

### Directory Structure

```text
C:/Users/Veerapong/.codeium/windsurf/
├── global_workflows/     # Workflows ทั่วไป
├── memories/
│   └── global_rules.md   # ไฟล์นี้
└── skills/               # Skill definitions
```

### Phase Definitions

| Phase | Description | Activities |
|-------|-------------|------------|
| **Setup** | เตรียม context | โหลด rules, อ่าน AGENTs.md |
| **Research** | ศึกษา reference | โหลด skills, ศึกษา docs |
| **Analyze** | วิเคราะห์ task | แยก request, ระบุ dependencies |
| **Plan** | วางแผน | กำหนดลำดับ steps |
| **Execute** | ลงมือทำ | พัฒนา, แก้ไขไฟล์ |
| **Verify** | ตรวจสอบ | รัน lint, ตรวจสอบคุณภาพ |
| **Review** | ทบทวน | ตรวจสอบ don'ts |
| **Finalize** | ปิดงาน | สรุปผลงาน |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบสิทธิ์** - มีสิทธิ์เขียนไฟล์ใน directory เป้าหมาย
- 0.2 **ตรวจสอบ Dependencies** - มี tools ที่จำเป็น (bun, git, pwsh)
- 0.3 **อ่าน Global Rules** - โหลด memory นี้ก่อนเริ่มงาน
- 0.4 **อ่าน AGENTs.md** - ถ้ามีไฟล์ AGENTs.md ให้อ่านก่อนเริ่ม

### Phase 1: Setup

- 1.1 **โหลด Global Rules** - โหลด memory นี้ก่อนเริ่มงาน
- 1.2 **อ่าน AGENTs.md** - อ่าน `@AGENTs.md` ก่อนแก้ไขไฟล์ใน `skills/`
- 1.3 **ตรวจสอบ Skills** - ตรวจสอบ skills ที่ตรงกับ file pattern
- 1.4 **เตรียม Context** - ยืนยันใช้ภาษาไทย, โหลด skills ที่เกี่ยวข้อง

### Phase 2: Research

- 2.1 **สื่อสารกับผู้ใช้** - ภาษาไทย กระชับ, `.` = continue
- 2.2 **ศึกษา Reference** - โหลด `@skill-name` ที่เกี่ยวข้อง

### Phase 3: Analyze

- 3.1 **วิเคราะห์ Task** - แยก request, ระบุ skills และ file patterns
- 3.2 **วิเคราะห์ Dependencies** - ตรวจสอบ tools และ MCP servers

### Phase 4: Plan

- 4.1 **วางแผนการทำงาน** - กำหนดลำดับ steps, ระบุ workflows
- 4.2 **ตรวจสอบ Conventions** - ดูไฟล์ใกล้เคียง, ยืนยัน absolute paths

### Phase 5: Execute

- 5.1 **Development** - Bun เท่านั้น, Vue: `script setup lang="ts"`, Tools: Biome, oxlint
- 5.2 **File Operations** - `pwsh`, absolute paths, `/update-reference` เมื่อ rename
- 5.3 **Follow Patterns** - `*/workflows/*` → `@write-workflows`, `skills/` → `@write-skills`
- 5.4 **Error Collection** - จด error/warning ไว้ก่อน, แก้ทีหลัง, `/run-lint` เฉพาะไฟล์ที่แก้

### Phase 6: Verify

- 6.1 **ตรวจสอบคุณภาพ** - `.md` → `@write-markdown`, workflows → `@write-workflows`
- 6.2 **Fix Error** - `/watch-terminal` ก่อนแก้ไข, ใช้ `@[/learn-from-web]` ถ้าแก้ไม่ผ่าน

### Phase 7: Review

- 7.1 **Don'ts** - ห้ามใช้ npm/npx/yarn/pnpm, ห้ามใช้ relative paths, ห้ามข้าม skill, ห้ามสร้างไฟล์โดยไม่ดู patterns, ห้ามลืมอัพเดท paths

### Phase 8: Finalize

- 8.1 **สรุปผลงาน** - ตรวจสอบความสมบูรณ์, สรุปสิ่งที่เปลี่ยนแปลง

## Outputs

| Output | Details |
|--------|---------|
| Consistency | ผลลัพธ์สม่ำเสมอทุกครั้ง |
| Quality | คุณภาพตามมาตรฐานที่กำหนด |
| Compliance | ปฏิบัติตามกฎทุกข้อ |

## Expected Outcome

- ตอบกลับภาษาไทยทุกครั้ง
- ใช้ `bun` เท่านั้น ไม่ใช้ npm/npx/yarn/pnpm
- ใช้ absolute paths
- ปฏิบัติตาม workflow standards
- จด error/warning ก่อน แก้ทีหลัง
- `/run-lint` เฉพาะไฟล์ที่แก้ไข

## Reference

- `/write-workflows` - มาตรฐานการสร้าง workflow files
- `/optimize-workflows` - ปรับปรุงคุณภาพ workflows
- `/run-lint` - รัน linter เฉพาะไฟล์ที่แก้ไข
- `@write-skills` - แนวทางการสร้าง skills
- `@write-markdown` - แนวทางการเขียน Markdown

---

## Workflow Prefix Reference

| Prefix | ตัวอย่าง |
|--------|---------|
| `add-` | `/add-windsurf-skills` |
| `analyze-` | `/analyze-project` |
| `check-` | `/check-correctness` |
| `commit-` | `/commit-and-push` |
| `create-` | `/create-git-branch` |
| `fix-` | `/fix-error` |
| `follow-` | `/follow-nuxt`, `/follow-rust` |
| `git-` | `/git-create-feature-branch` |
| `run-` | `/run-build`, `/run-lint` |
| `update-` | `/update-dependencies` |
| `write-` | `/write-workflows`, `/write-skills` |

**หมายเหตุ:** พิมพ์ `/` ตามด้วยส่วนหนึ่งของชื่อ workflow ระบบจะแสดงตัวเลือกที่ตรงกัน
