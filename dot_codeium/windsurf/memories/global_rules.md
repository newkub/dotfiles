---

title: Global Rules

description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace

auto_execution_mode: 3

---

## Goal

ทำตามกฎเหล่านี้ในทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

1. ทำตาม `/follow-agents-md` เสมอ
2. ทำ `/ship-code` เพื่อ ship code ครบวงจรตั้งแต่ planning ไปจนถึง build
3. ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `pwsh`
4. แต่ละ workspace ต้องทำตาม `/setup-tasks` เพื่อตั้งค่า scripts มาตรฐาน
5. เวลาจะ setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
6. ถ้าจะเปลี่ยน config file ต่างๆ หรือจะใช้ workflows ที่ขึ้นต้นด้วย `run-` ให้ทำ `/follow-config` ก่อนเสมอ
7. เมื่อทำ file operation ใดๆ ต้องทำ `/edit-relative` เพื่อแก้ไขไฟล์ที่เกี่ยวข้องทั้งหมด
8. `"."` หมายถึงให้ทำ `/continue`
9. `"s."` หมายถึงให้ทำ `/use-scripts`

### 2. Analyze

1. ทำ `/analyze-project` ด้วย `/use-scripts` เพื่อดูภาพรวมโปรเจกต์
2. เมื่อได้รับ error ทำตาม `/error`

### 3. Planning

1. เมื่อแก้ไขไฟล์ workflows ทำตาม `/follow-write-workflows`
2. เมื่อแก้ไขไฟล์ skills ทำตาม `/follow-write-skills`

### 4. Write

1. ถ้าต้องทำ file operation จำนวนมาก ให้ใช้ `/use-scripts`
2. ถ้า mock ให้ comment `// MOCK` ชัดเจน และแยกไฟล์ไปในโฟลเดอร์ `mock/`
3. ถ้ายังทำไม่เสร็จต้อง comment `// TODO` ชัดเจน
4. ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ ต้อง comment ชัดเจน

### 5. Reflex

1. ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จทั้งหมด
2. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมดแล้ว

### 6. Report

1. ทำตาม `/report`
2. เมื่อจบ task ให้รัน `/suggest-next-action` เสมอ
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร
4. ให้คำตอบกระชับ ตรงประเด็น
5. หลีกเลี่ยงการใช้คำยืนยันที่ไม่จำเป็น

## Rules

### 1. Execution Order

ทำตามลำดับ Execute ตั้งแต่ Prepare ถึง Report โดยไม่ข้ามขั้นตอน

### 2. Deterministic Behavior

- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ไม่ใช้คำสั่ง subjective หรือ ambiguous
- ระบุลำดับการทำงานชัดเจน

### 3. Automation Standards

- ใช้ Bun shell สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ
- ทุก workspace ต้องมี scripts มาตรฐานจาก `/setup-tasks`
- ถ้าต้องทำ file operation จำนวนมาก ให้ใช้ `/use-scripts`

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
