---
title: Global Rules
description: ลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ
auto_execution_mode: 3
related:
  - edit-relative
  - suggest-next-action
  - continue
  - follow-your-suggestion
  - follow-skills
  - check-reference
  - follow-best-practice
  - learn-from-web
  - deep-research
  - use-scripts
  - plan
  - report-plan
  - deep-analyze-by-use-scripts
  - scan-codebase
  - resolve-errors
  - ask-me
  - refactor
  - follow-architecture
  - follow-write-devin-skills
  - follow-config
  - follow-deep
  - follow-barrel-export
  - restructure
  - loop-until-complete
  - realize-implementation
  - update-dot-devin
  - validate
  - run-check
  - git-commit
  - ship
  - report
  - idea
  - report-only

---

## Goal

กำหนดลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ

## Scope

ใช้กับทุก task และทุก workspace โดยปรับ tools ตาม ecosystem ที่ตรวจพบ

## Execute

### 1. Prepare Workspace

เตรียม workspace, prompt, และขอบเขตงาน

> Goal: ระบุ workspace, prompt, ขอบเขต และ references ชัดเจน

1. ทำ `edit-relative` สำหรับงานที่เกี่ยวข้องกับไฟล์
2. ใช้ "." เป็น trigger สำหรับ `/continue` หรือ `/suggest-next-action` — ถ้างานยังไม่เสร็จให้ทำ `/continue`, ถ้าต้องการแนะนำทิศทางให้ทำ `/suggest-next-action`
3. ถ้าเข้าถึง workspace ไม่ได้ → stop และ report โดยไม่แก้ไขไฟล์

### 2. Read References

อ่าน skills และ references ก่อนวิเคราะห์หรือเขียน

> Goal: ใช้ข้อกำหนดที่มีอยู่จริง ไม่ซ้ำซ้อน

1. ทำ `follow-skills` เพื่อเลือก skills ที่ตรงกับ task
2. ทำ `follow-write-devin-skills` เพื่ออ่านและทำความเข้าใจ skills และ global rules
3. ทำ `check-reference` เพื่อยื่นยันว่า references มีอยู่จริง
4. ถ้า reference จำเป็นไม่มี → stop และ report

### 3. Research And Learn

ค้นคว้าเฉพาะเมื่อ task ต้องใช้ความรู้ใหม่หรือข้อมูลภายนอก

> Goal: ข้อมูลถูกต้อง ทันสมัย มีแหล่งอ้างอิง

1. ทำ `follow-best-practice` สำหรับ topic, tool หรือ library ที่เกี่ยวข้อง
2. ทำ `learn-from-web` โดยให้ official docs เป็นแหล่งหลัก
3. ทำ `deep-research` เมื่อต้อง cross-check หลายแหล่งหรือมีความเสี่ยงสูง
4. ถ้าตรวจสอบข้อมูลสำคัญไม่ได้ → ระบุความไม่แน่นอนและ stop ก่อนเปลี่ยนแปลงที่เสี่ยง

### 4. Analyze Plan And Search

วิเคราะห์ context วางแผน และค้นหา code ก่อนแก้ไข

> Goal: ระบุ root cause, impact, consumers และแผนแก้ไขที่เล็กที่สุด

1. ทำ `report-only` เพื่อรายงานสถานะปัจจุบันก่อนเริ่มงาน จากนั้นดำเนินการตาม scope
2. ทำ `follow-deep` เพื่อพิจารณาและเรียก `deep-*` skills ที่เกี่ยวข้องกับ context ของ task
3. ใช้ `use-scripts` เมื่อต้องประมวลผลข้อมูลซับซ้อน
4. ทำ `plan` ก่อนแก้ไขหลายไฟล์ และ `report-plan` ก่อนลงมือ
5. ถ้า filename ขึ้นต้นด้วย `analyze-` → ทำ `deep-analyze-by-use-scripts`
6. ทำ `scan-codebase` เพื่อค้นหา symbols, call sites, consumers
7. ทำ `follow-your-suggestion` เมื่อ task ให้ apply ข้อเสนอจากการวิเคราะห์ก่อนหน้า
8. ถ้าพบ error → ทำ `resolve-errors`; ถ้าข้อกำหนดเสี่ยงสูงไม่ชัด → ใช้ `ask-me`

### 5. Write Code

เขียนหรือ refactor โดยรักษา architecture, references และ public API

> Goal: การเปลี่ยนแปลง minimal, runnable, สอดคล้องมาตรฐาน project

1. อ่าน `refactor` ก่อนเขียน code
2. ทำ `follow-architecture` และรักษา existing style
3. ถ้าแก้ >10 ไฟล์ → ทำ `use-scripts`; ถ้าไฟล์ยาว >250 บรรทัด → ทำ `refactor` หลังจบ task
4. ใช้ mock/TODO เฉพาะจำเป็น โดยระบุ `// MOCK` ใน `mock/` หรือ `// TODO` สำหรับงานที่ยังไม่เสร็จ
5. ถ้าแก้ skills หรือ `global_rules.md` → ทำ `follow-write-devin-skills`
6. ถ้าแก้ config → ทำ `follow-config`; ถ้าแก้ barrel export → ทำ `follow-barrel-export`
7. หลังเขียนหรือ refactor → ทำ `restructure`
8. ถ้า check ไม่ผ่าน → ทำ `resolve-errors` และ recheck สูงสุด 3 รอบ; ถ้ายังไม่ผ่าน → stop และ report

### 6. Validate And Complete

ตรวจสอบ implementation จนผ่านเกณฑ์และพร้อมส่งมอบ

> Goal: ไม่มี implementation gap, regression หรือ validation failure

1. ทบทวนแผนและทำ `loop-until-complete` เมื่อต้องตรวจซ้ำจนผ่าน
2. ทำ `realize-implementation` หลัง implementation เสร็จ
3. ถ้า package manifest เปลี่ยน → ทำ `update-dot-devin`
4. ทำ `validate` ก่อนจบ task
5. ทำ `run-check` เสมอหลังจบ task เพื่อตรวจสอบ lint, typecheck และ scan ก่อนส่งมอบ
6. ทำ `git-commit` เมื่อจบ sub-task สำคัญ งานเสี่ยงสูง หรือเปลี่ยนแปลงจำนวนมาก
7. ทำ `ship` หลังเสร็จงาน; ถ้า validation ไม่ผ่าน → report สถานะและห้ามอ้างว่างานเสร็จ
8. ทำ `ask-me` เพื่อถาม user ว่าต้องการทำ action ถัดไปหรือไม่

### 7. Report And Communicate

รายงานผลตาม evidence โดยกระชับและตรงสถานะจริง

> Goal: ผู้ใช้ทราบสิ่งที่เปลี่ยน ผลตรวจสอบ ข้อจำกัด และสถานะส่งมอบ

1. ทำตาม `report` และสื่อสารเป็นภาษาไทยด้วย bullet points สั้นๆ
2. ไม่เริ่มด้วย acknowledgment phrase และไม่กล่าวอ้างผลที่ยังไม่ตรวจสอบ
3. ถ้าตัดสินใจเรื่องเสี่ยงสูง → ใช้ `ask-me`; ถ้าผู้ใช้ขอ idea → ทำ `idea`
4. ถ้างานไม่สมบูรณ์ → ระบุสิ่งที่ค้าง สาเหตุ และขั้นตอนที่จำเป็น

## Rules

### 1. Structure And Consistency

- เรียง `## Goal` → `## Scope` → `## Execute` → `## Rules` → `## Expected Outcome` ไม่เกิน 250 บรรทัด
- Frontmatter: `title` Title Case, `description` ≤100 ตัวอักษร, `auto_execution_mode: 3`
- `related` ต้องมีเฉพาะ skills ที่เรียกโดยตรง ไม่มี missing/unused
- Heading ภาษาอังกฤษ Title Case, รายการภาษาไทย, backticks สำหรับ `tools`, `commands`, paths และ skill references
- ทุก section ต้องสอดคล้องกันและให้ผลเหมือนเดิมเมื่อ input เหมือนเดิม

### 2. Multi-Tool Compatibility

- ตรวจ ecosystem จาก `package.json`, `Cargo.toml`, `go.mod` ก่อนเลือก tools
- ใช้ relative references และแปลง command equivalents ตาม ecosystem ไม่ผูกกับ AI tool เดียว
- ถ้า workspace เป็น monorepo ให้ใช้ run command ของ monorepo (`moon run`, `turbo run`, `pnpm --recursive`, `bun run --filter` ตามที่ตรวจพบ) กับ skills `run-*` ต่างๆ แทนการรันผ่าน workspace เดี่ยว
- ใช้ `use-*` skills สำหรับ tools/libraries เฉพาะเจาะจง และใช้ official docs เป็นแหล่งหลัก
- ถ้าต้องติดตั้ง program แบบ global ให้พยายามใช้ `mise use -g <program>` ก่อน แล้วจึงพิจารณา package manager ของระบบ เช่น `scoop`, `brew`, `apt`, `winget`

### 3. Safety And Deterministic Execution

- การลบ ย้าย overwrite หรือ action เสี่ยงสูงต้องมี dry run และ user confirmation ก่อนดำเนินการ
- เรียง Foundation → Dependencies → High impact → Critical path → High risk เพื่อ fail fast ลด rework
- ใช้เงื่อนไข "ถ้ามี..." เฉพาะ steps ที่ไม่จำเป็นทุก task และระบุเกณฑ์ผ่าน/ไม่ผ่านที่วัดผลได้
- รันซ้ำด้วย input/state เดิมต้องได้ output เดิม ไม่สร้าง side effects ซ้ำ

### 4. High Impact Content

- เก็บเฉพาะข้อกำหนดที่ทำให้ผลลัพธ์เปลี่ยนอย่างมีนัยสำคัญ ครอบคลุม impact สำคัญทั้งหมด
- ทุก instruction ต้องระบุ action, condition หรือ expected result ที่ตีความได้ทางเดียว
- ห้ามใช้ placeholder, generic filler, mock หรือ TODO ที่ไม่จำเป็น

## Expected Outcome

- ลำดับ prepare → read → research → analyze → write → validate → report อย่างชัดเจน
- ทุก task ใช้ references ที่มีอยู่จริง แก้ไขปลอดภัย ตรวจสอบผลได้ รายงานตาม evidence
- รองรับหลาย workspace, ecosystems และ AI tools โดยไม่ทำลาย backward compatibility
