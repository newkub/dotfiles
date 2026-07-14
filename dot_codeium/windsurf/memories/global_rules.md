---
title: Global Rules
description: ลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ
auto_execution_mode: 3
related_workflows:
  - /edit-relative
  - /continue
  - /follow-your-suggestion
  - /read-related-workflows
  - /follow-workflows
  - /follow-skills
  - /check-reference
  - /follow-best-practice
  - /learn-from-web
  - /deep-research
  - /use-scripts
  - /plan
  - /report-plan
  - /deep-analyze-codebase
  - /resolve-errors
  - /scan-codebase
  - /refactor
  - /follow-architecture
  - /write-global-workflows
  - /write-skills
  - /follow-config
  - /follow-barrel-export
  - /restructure
  - /run-check
  - /loop-until-complete
  - /realize-implementation
  - /update-dot-devin
  - /validate
  - /commit
  - /ship
  - /report
  - /ask-me
  - /idea
  - /suggest-next-action
  - /dont-over-engineer
  - /follow-software-engineering
  - /report-format-table
  - /update-health-cli
  - /report-before
---

## Goal

กำหนดลำดับการทำงานทุก task ให้ปลอดภัย ตรวจสอบได้ และส่งมอบครบ

## Scope

ใช้กับทุก task และทุก workspace โดยปรับ tools ตาม ecosystem ที่ตรวจพบ

## Execute

### 1. Prepare Workspace

เตรียม workspace และขอบเขตงาน

> Goal: ระบุ workspace ขอบเขต และ references ชัดเจน

1. ทำ `/edit-relative` สำหรับงานที่เกี่ยวข้องกับไฟล์
2. ใช้ `"."` เป็น target สำหรับ `/continue` หรือ `/follow-your-suggestion`
3. ถ้าเข้าถึง workspace ไม่ได้ → stop และ report โดยไม่แก้ไขไฟล์

### 2. Read References

อ่าน workflows, skills และ references ก่อนวิเคราะห์หรือเขียน

> Goal: ใช้ข้อกำหนดที่มีอยู่จริง ไม่ซ้ำซ้อน

1. ทำ `/read-related-workflows` และ `/follow-workflows` สำหรับ global และ project workflows
2. ทำ `/follow-skills` เพื่อเลือก skills ที่ตรงกับ task
3. ทำ `/check-reference` เพื่อยืนยันว่า references มีอยู่จริง
4. ถ้า reference จำเป็นไม่มี → stop และ report

### 3. Research And Learn

ค้นคว้าเฉพาะเมื่อ task ต้องใช้ความรู้ใหม่หรือข้อมูลภายนอก

> Goal: ข้อมูลถูกต้อง ทันสมัย มีแหล่งอ้างอิง

1. ทำ `/follow-best-practice` สำหรับ topic, tool หรือ library ที่เกี่ยวข้อง
2. ทำ `/learn-from-web` โดยให้ official docs เป็นแหล่งหลัก
3. ทำ `/deep-research` เมื่อต้อง cross-check หลายแหล่งหรือมีความเสี่ยงสูง
4. ถ้าตรวจสอบข้อมูลสำคัญไม่ได้ → ระบุความไม่แน่นอนและ stop ก่อนเปลี่ยนแปลงที่เสี่ยง

### 4. Analyze Plan And Search

วิเคราะห์ context วางแผน และค้นหา code ก่อนแก้ไข

> Goal: ระบุ root cause, impact, consumers และแผนแก้ไขที่เล็กที่สุด

1. ทำ `/report-before` เพื่อรายงานสถานะปัจจุบันก่อนเริ่มงาน แล้วดำเนินการต่อทันที
2. ใช้ `/use-scripts` เมื่อต้องประมวลผลข้อมูลซับซ้อน
3. ทำ `/plan` ก่อนแก้ไขหลายไฟล์ และ `/report-plan` ก่อนลงมือ
4. ถ้า filename ขึ้นต้นด้วย `analyze-` → ทำ `/deep-analyze-codebase`
5. ทำ `/scan-codebase` เพื่อค้นหา symbols, call sites, consumers
6. ทำ `/follow-your-suggestion` เมื่อ task ให้ apply ข้อเสนอจากการวิเคราะห์ก่อนหน้า
7. ถ้าพบ error → ทำ `/resolve-errors`; ถ้าข้อกำหนดเสี่ยงสูงไม่ชัด → ใช้ `/ask-me`

### 5. Write Code

เขียนหรือ refactor โดยรักษา architecture, references และ public API

> Goal: การเปลี่ยนแปลง minimal, runnable, สอดคล้องมาตรฐาน project

1. อ่าน `/refactor` ก่อนเขียน code
2. ทำ `/follow-architecture` และรักษา existing style
3. ถ้าแก้ >10 ไฟล์ → ทำ `/use-scripts`; ถ้าไฟล์ยาว >250 บรรทัด → ทำ `/refactor` หลังจบ task
4. ใช้ mock/TODO เฉพาะจำเป็น โดยระบุ `// MOCK` ใน `mock/` หรือ `// TODO` สำหรับงานที่ยังไม่เสร็จ
5. ถ้าแก้ workflows หรือ `global_rules.md` → ทำ `/write-global-workflows`; ถ้าแก้ skills → ทำ `/write-skills`
6. ถ้าแก้ config → ทำ `/follow-config`; ถ้าแก้ barrel export → ทำ `/follow-barrel-export`
7. หลังเขียนหรือ refactor → ทำ `/restructure` และ `/run-check`
8. ถ้า check ไม่ผ่าน → ทำ `/resolve-errors` และ recheck สูงสุด 3 รอบ; ถ้ายังไม่ผ่าน → stop และ report

### 6. Validate And Complete

ตรวจสอบ implementation จนผ่านเกณฑ์และพร้อมส่งมอบ

> Goal: ไม่มี implementation gap, regression หรือ validation failure

1. ทบทวนแผนและทำ `/loop-until-complete` เมื่อต้องตรวจซ้ำจนผ่าน
2. ทำ `/realize-implementation` หลัง implementation เสร็จ
3. ถ้า package manifest เปลี่ยน → ทำ `/update-dot-devin`
4. ทำ `/validate` และ `/run-check` ก่อนจบ task
5. ทำ `/commit` เมื่อจบ sub-task สำคัญ งานเสี่ยงสูง หรือเปลี่ยนแปลงจำนวนมาก
6. ทำ `/ship` หลังเสร็จงาน; ถ้า validation ไม่ผ่าน → report สถานะและห้ามอ้างว่างานเสร็จ

### 7. Report And Communicate

รายงานผลตาม evidence โดยกระชับและตรงสถานะจริง

> Goal: ผู้ใช้ทราบสิ่งที่เปลี่ยน ผลตรวจสอบ ข้อจำกัด และสถานะส่งมอบ

1. ทำตาม `/report` และสื่อสารเป็นภาษาไทยด้วย bullet points สั้นๆ
2. ไม่เริ่มด้วย acknowledgment phrase และไม่กล่าวอ้างผลที่ยังไม่ตรวจสอบ
3. ถ้าตัดสินใจเรื่องเสี่ยงสูง → ใช้ `/ask-me`; ถ้าผู้ใช้ขอ idea → ทำ `/idea`
4. ถ้างานไม่สมบูรณ์ → ระบุสิ่งที่ค้าง สาเหตุ และขั้นตอนที่จำเป็น

### 8. Update Cross-References

ตรวจผลกระทบต่อ references และกำหนด action ถัดไป

> Goal: ไม่มี broken references และมี next action ที่สอดคล้องผลลัพธ์

1. ทำ `/deep-analyze-codebase` step 4-5 เพื่อระบุและเพิ่ม cross-references ที่ต้องอัปเดต
2. ทำ `/suggest-next-action` เพื่อเสนอ action ถัดไปที่มี impact จริง
3. ถ้าไม่พบ reference หรือ action ที่ต้องเปลี่ยน → report ว่าไม่ต้องดำเนินการเพิ่ม

## Rules

### 1. Structure And Consistency

- เรียง `## Goal` → `## Scope` → `## Execute` → `## Rules` → `## Expected Outcome` ไม่เกิน 250 บรรทัด
- Frontmatter: `title` Title Case, `description` ≤100 ตัวอักษร, `auto_execution_mode: 3`
- Execute: heading → description → `> Goal:` → numbered list; Rules: bullet list แต่ละหัวข้อมี single concern
- ทุก section ต้องสอดคล้องกันและให้ผลเหมือนเดิมเมื่อ input เหมือนเดิม

### 2. Multi-Tool Compatibility

- ตรวจ ecosystem จาก `package.json`, `Cargo.toml`, `go.mod` ก่อนเลือก tools
- ใช้ relative references และแปลง command equivalents ตาม ecosystem ไม่ผูกกับ AI tool เดียว
- ใช้ `use-*` workflows สำหรับ tools/libraries เฉพาะเจาะจง และใช้ official docs เป็นแหล่งหลัก

### 3. References And Automation

- ใช้ references แทน duplicate และทำ `/check-reference` ก่อนใช้งาน
- `related_workflows` ต้องมีเฉพาะ workflows ที่เรียกโดยตรง ไม่มี missing/unused
- ใช้ `/use-scripts` เมื่อ >10 ไฟล์, pattern matching ต้องใช้ parser, metrics ต้อง aggregation หรือ batch transformation ต้อง consistency
- ใช้ `/scan-codebase` สำหรับ quick scan และ `/deep-analyze-codebase` สำหรับ deep analysis
- `review-*` ต้องตรวจ `/update-health-cli` ก่อน: ถ้ามี→รันเลย ถ้าไม่มี→ทำ `/update-health-cli` ก่อนแล้วรัน

### 4. Content And Reporting

- Heading ภาษาอังกฤษ Title Case, รายการภาษาไทย, backticks สำหรับ `tools`, `commands`, paths และ workflow references
- เขียนเป็น how-to ที่ explicit และ actionable ไม่เพิ่ม noise หรือ duplicate ระหว่าง Execute กับ Rules
- `analyze-*` ต้องรายงานด้วย `/report-format-table`; `review-*` ต้องมี severity และ actionable recommendations
- รายงานเฉพาะผลที่มี evidence แยก completed, failed, skipped, unverified ชัดเจน

### 5. Safety And Code Quality

- แก้ root cause ด้วย minimal upstream fix; ทำ `/dont-over-engineer` และ `/follow-software-engineering`
- ห้ามเปลี่ยน code ไม่เกี่ยวข้อง เพิ่ม/ลบ comments โดยไม่จำเป็น สร้างไฟล์เกินจำเป็น หรือ hardcode secrets
- การลบ ย้าย overwrite หรือ action เสี่ยงสูงต้องมี dry run และ user confirmation ก่อนดำเนินการ
- ทำตาม existing style; ถ้าไม่แน่ใจ → debug และตรวจ evidence ก่อนแก้

### 6. Deterministic Execution

- เรียง Foundation → Dependencies → High impact → Critical path → High risk เพื่อ fail fast ลด rework
- ใช้เงื่อนไข "ถ้ามี..." เฉพาะ steps ที่ไม่จำเป็นทุก task และระบุเกณฑ์ผ่าน/ไม่ผ่านที่วัดผลได้
- Validation retry สูงสุด 3 รอบ; ถ้ายังไม่ผ่าน → stop และ report ไม่ซ่อน failure
- รันซ้ำด้วย input/state เดิมต้องได้ output เดิม ไม่สร้าง side effects ซ้ำ

### 7. High Impact Content

- เก็บเฉพาะข้อกำหนดที่ทำให้ผลลัพธ์เปลี่ยนอย่างมีนัยสำคัญ ครอบคลุม impact สำคัญทั้งหมด
- ทุก instruction ต้องระบุ action, condition หรือ expected result ที่ตีความได้ทางเดียว
- ห้ามใช้ placeholder, generic filler, mock หรือ TODO ที่ไม่จำเป็น

## Expected Outcome

- ลำดับ prepare → read → research → analyze → write → validate → report → update references อย่างชัดเจน
- ทุก task ใช้ references ที่มีอยู่จริง แก้ไขปลอดภัย ตรวจสอบผลได้ รายงานตาม evidence
- รองรับหลาย workspace, ecosystems และ AI tools โดยไม่ทำลาย backward compatibility
