---
title: Global Rules
description: Execution guidelines สำหรับการทำงานทุก task ตามมาตรฐาน
auto_execution_mode: 3
related_workflows:
  - /follow-workflows
  - /follow-skills
  - /read-related-workflows
  - /follow-architecture
  - /follow-content-quality
  - /report
  - /use-scripts
  - /code-search
  - /resolve-errors
  - /refactor
  - /edit-relative
  - /plan
  - /report-plan
  - /realize-implementation
  - /update-dot-devin
  - /loop-until-complete
  - /run-check
  - /commit
  - /follow-git-workflows
  - /suggest-next-action
  - /use-in-another-workflows
  - /write-global-workflows
  - /follow-config
  - /check-reference
  - /follow-best-practice
  - /learn-from-web
  - /deep-research
  - /follow-your-suggestion
  - /continue
  - /try-again
  - /deep-analyze-with-use-scripts
  - /ask-me
  - /scan-codebase
  - /report-format-table
  - /idea
  - /use-workflows
---

## Goal
ทำตาม execution guidelines ทุกครั้งเพื่อให้การทำงานสม่ำเสมอและมีคุณภาพ

## Scope
ใช้สำหรับทุก workspace ในการทำงานทุก task

## Execute

### 1. Prepare Workspace
ตั้งค่าและเตรียม workspace ก่อนเริ่ม task
- การทำงานกับไฟล์ทุกอย่างต้องทำ `/edit-relative`
- ใช้ `"."` สำหรับ `/continue` หรือ `/try-again`

### 2. Read References
อ่าน references ก่อนเริ่มทำงาน
- ทำ `/read-related-workflows` เพื่ออ่าน workflows ที่เกี่ยวข้องทั้งหมดก่อนเริ่มทำงาน
- ทำ `/follow-workflows` เพื่ออ่านและทำตาม workflows ทั้ง global และ project
- ทำ `/follow-skills` เพื่ออ่านและใช้ skills ที่เหมาะสมกับ task
- ทำ `/check-reference` เพื่อตรวจสอบ references ที่จะใช้มีอยู่จริง

### 3. Research And Learn
เรียนรู้ best practices และ official docs ก่อนเริ่มงานที่ต้องความรู้ใหม่
- ทำ `/follow-best-practice` สำหรับ topic ที่เกี่ยวข้อง
- ทำ `/learn-from-web` เพื่อเรียนรู้จาก official documentation
- ทำ `/deep-research` เมื่อต้องการข้อมูลลึกจาก multiple sources

### 4. Analyze And Plan
วิเคราะห์และวางแผนงาน
- ใช้ `/use-scripts` สำหรับการวิเคราะห์
- ทำ `/plan` ก่อนแก้ไขไฟล์จำนวนมาก
- ก่อนลงมือทำ ให้ทำ `/report-plan` มาก่อน ตอบในแชท แล้วทำต่อได้เลย
- ถ้าไฟล์ชื่อขึ้นต้นด้วย `analyze-` ให้ทำ `/deep-analyze-with-use-scripts`
- ถ้ามี error ให้ทำ `/resolve-errors`
- ทำ `/follow-your-suggestion` เพื่อ apply suggestions จากการวิเคราะห์ก่อนหน้า

### 5. Search Code
ค้นหา code patterns, symbols, หรือ references
- ทำ `/code-search`

### 6. Write Code
เขียนและแก้ไข code ตามมาตรฐาน
- ทำ `/refactor` ก่อนเขียน code
- ทำ `/follow-architecture` เมื่อแก้ไข
- ถ้าแก้ไขไฟล์มากกว่า 10 ไฟล์ ให้ทำ `/use-scripts`
- ถ้าเจอไฟล์ที่ยาวกว่า 250 บรรทัด ให้จดไว้ก่อน แล้วทำ `/refactor` หลังจบ task
- Mock ให้ comment `// MOCK` และแยกไฟล์ไป `mock/`
- ยังทำไม่เสร็จให้ comment `// TODO`
- ห้าม mock หรือ TODO โดยไม่จำเป็น
- ถ้าแก้ไข workflows ให้ทำ `/write-global-workflows`
- ถ้าแก้ไข `global_rules.md` ให้ทำ `/write-global-workflows`
- ถ้าแก้ไข skills ให้ทำ `/write-skills`
- ถ้าแก้ไข config file ให้ทำ `/follow-config`

### 7. Iterate And Complete
ทำซ้ำจน implement เสร็จ
- กลับไปตรวจสอบ planning เรื่อยๆ
- ทำ `/loop-until-complete` เมื่องานต้อง verify จนกว่าจะผ่านเงื่อนไข
- ทำ `/realize-implementation` หลังเสร็จงานเสมอ
- ถ้ามีการเปลี่ยนแปลง package manifest ให้ทำ `/update-dot-devin` เสมอ
- ทำ `/run-check` หลังจาก task เสมอ
- ทำ `/commit` เป็นระยะๆ ตามเหมาะสม — ไม่ถี่เกินไปและไม่นานเกินไป พิจารณาเมื่อ: งานมีความเสี่ยงสูง, ทำการเปลี่ยนแปลงเยอะ, จบ sub-task สำคัญ, หรือต้องการบันทึก progress ก่อนขั้นตอนใหญ่ถัดไป

### 8. Report And Communicate
รายงานผลลัพธ์และสื่อสาร
- ทำตาม `/report`
- คุยกับผู้ใช้เป็นภาษาไทย กระชับ ตรงประเด็น
- รายงานผลเป็น bullet points สั้นๆ
- ไม่เริ่มตอบด้วย acknowledgment phrases
- ไม่ถามผู้ใช้ยกเว้นกรณีเสี่ยงสูง ถ้าต้องถามให้ใช้ `/ask-me`
- ถ้าผู้ใช้บอกว่า "ขอ idea" ให้ทำ `/idea`

### 9. Suggest Next Action And Cross-References
พิจารณาการใช้ต่อหลังเสร็จงาน
- ทำ `/suggest-next-action` เพื่อแนะนำ action ถัดไปที่ควรทำ
- ทำ `/use-in-another-workflows` เพื่อพิจารณาว่า workflow หรือ skill ควรถูกอ้างอิงในไฟล์ใดบ้าง

## Rules

### 1. Structure And Consistency
- `title`: Title Case ชัดเจน (ตรงกับ filename)
- `description`: กระชับไม่เกิน 100 ตัวอักษร
- `auto_execution_mode`: 3 เท่านั้น
- ## Goal, ## Scope, ## Execute, ## Rules, ## Expected Outcome (required)
- Goal สอดคล้องกับ Filename, Execute สอดคล้องกับ Goal และ Rules
- Expected Outcome สอดคล้องกับ Goal
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง ระบุลำดับการทำงานชัดเจน
- ทุกไฟล์ต้องยาวไม่เกิน 250 บรรทัด

### 2. Multi-Tool Compatibility
- รองรับหลาย AI tools โดยใช้ relative references ไม่ผูกกับ tool เดียว
- ตรวจจับ tool จาก directory structure ก่อนเขียน
- ใช้ relative paths ใน workflow content ไม่ใช้ absolute paths ของ tool เฉพาะ

### 3. Content And Style
- หัวข้อภาษาอังกฤษ Title Case, รายการภาษาไทย
- ทุก heading ใน Execute ต้องเป็นภาษาอังกฤษ Title Case
- ใช้ bullet points (-) ชิดซ้ายใน Rules
- ใช้ backticks สำหรับ `tools`, `commands`, `file paths`, `/workflow-name`
- เขียนเป็นหลักการ how-to ไม่ใช่ step-by-step เฉพาะกรณี

### 4. References And Non-Redundancy
- ใช้ references แทนการ duplicate เนื้อหา
- ทำ `/check-reference` เพื่อตรวจสอบ references มีอยู่จริง
- ไม่ซ้ำซ้อนระหว่าง Execute และ Rules
- Orchestrator workflow อ้างถึง sub-workflow โดยไม่ระบุรายละเอียดภายใน

### 5. Execution Ordering
- เรียงลำดับ: Foundation ก่อน, High impact ก่อน, Dependencies ก่อน, Critical path ก่อน, Hard to change ก่อน, High risk เพื่อ fail fast
- เขียน conditional execution สำหรับ steps ที่ไม่จำเป็นต้องทำทุก project ใช้ "ถ้ามี..." หรือ "ถ้า project มี..."

### 6. Script Automation
- ใช้ `/use-scripts` เมื่อ file operations มากกว่า 10 ไฟล์, data processing ซับซ้อน, หรือ batch transformations ต้อง consistency
- ใช้ `/use-scripts` เมื่อ pattern matching ต้อง parser หรือ metrics calculation ต้อง aggregation

### 7. Workflow Selection
- ใช้ workflows ที่ขึ้นต้นด้วย "use-" สำหรับ tools/libraries ที่เฉพาะเจาะจง
- ใช้ `/scan-codebase` สำหรับ scan codebase อย่างรวดเร็ว
- ใช้ `/deep-analyze-with-use-scripts` สำหรับ workflows ที่มี step วิเคราะห์โปรเจกต์

### 8. Report Formatting
- `analyze-*` workflows ต้องมี report step (เช่น `/report-format-table`)
- `review-*` workflows ต้องมี severity classification (Critical, High, Medium, Low) และ actionable recommendations

### 9. Best Practices Alignment
- อ้างอิง official documentation เมื่อเขียนเกี่ยวกับ tools หรือ libraries เฉพาะเจาะจง
- ตรวจสอบว่า structure สอดคล้องกับ best practices ของ markdown และ documentation

### 10. Ecosystem Detection
- ตรวจสอบ `package.json`, `Cargo.toml`, `go.mod` เพื่อระบุ ecosystem
- แปลง tool equivalents อัตโนมัติ (เช่น `bunx` → `npx`, `bun test` → `vitest`)

### 11. Code Quality
- แก้ที่ root cause ไม่ใช่ symptoms ใช้ minimal upstream fixes
- ห้ามแก้เกินความจำเป็น ถ้าไม่แน่ใจให้ debug ก่อน
- ทำตาม existing style ของ codebase
- ห้ามเปลี่ยน code ที่ไม่เกี่ยวข้อง
- ห้ามลบหรือเพิ่ม comments โดยไม่จำเป็น
- สร้างไฟล์ใหม่เฉพาะที่จำเป็น

## Expected Outcome
- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
- ใช้ tools และ libs ของ ecosystem นั้นๆ ได้อย่างเหมาะสม
- รองรับหลาย AI tools โดยใช้ relative references
- มีการ research และ learn ก่อนเริ่มงานที่ต้องความรู้ใหม่
- มีการ apply suggestions อย่างเป็นระบบตาม priority

