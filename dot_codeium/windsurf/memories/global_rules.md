---

title: Global Rules

description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace

auto_execution_mode: 3

---

## Goal

ทำตามกฎเหล่านี้ในทุก workspace เพื่อให้การทำงานสม่ำเสมอ

## Execute

### 1. Prepare

1. ทำ `/follow-agents-md` เสมอ
2. ทำ `/ship-code` เพื่อ ship code ครบวงจร
3. ใช้ `git` สำหรับ file operations ถ้าใช้ไม่ได้ให้ใช้ `pwsh`
4. แต่ละ workspace ต้องทำ `/setup-tasks` เพื่อตั้งค่า scripts มาตรฐาน
5. Setup อะไรให้ดู `/follow-windsurf-global-workflows` ก่อน
6. เปลี่ยน config หรือใช้ workflows `run-` ให้ทำ `/follow-config` ก่อน
7. File operation ใดๆ ต้องทำ `/edit-relative` เพื่อแก้ไขไฟล์ที่เกี่ยวข้องทั้งหมด
8. `"."` = `/continue`, `"s."` = `/use-scripts`

### 2. Analyze

1. ทำ `/analyze-project` ด้วย `/use-scripts` เพื่อดูภาพรวมโปรเจกต์
2. เมื่อได้รับ error ทำตาม `/error`
3. ถ้า error มาจากคำสั่งที่ผู้ใช้รันเอง:
   - แก้ไข error นั้นเท่านั้น
   - ไม่ต้อง run task หรือ command อื่น

### 3. Read Reference

1. เมื่อได้รับ user prompt ให้อ่าน reference ก่อนเสมอ:
   - Workflows ที่เกี่ยวข้อง
   - Skills ที่เกี่ยวข้อง
   - Global rules ที่เกี่ยวข้อง
2. วิเคราะห์และ planning ตาม reference
3. ลดเวลาโดยไม่ต้องค้นหาข้อมูลซ้ำ

### 4. Planning

1. แก้ไข workflows ทำตาม `/follow-write-workflows`
2. แก้ไข skills ทำตาม `/follow-write-skills`

### 5. Write

1. ก่อนเขียน code ทำ `/follow-principles-engineering`
2. แก้ไขอะไร ทำ `/follow-architecture` เพื่อเลือก pattern ที่เหมาะสม
3. ถ้าต้องแก้ไขไฟล์จำนวนมาก ให้ทำ `/plan` ก่อน
4. File operation จำนวนมาก ใช้ `/use-scripts`
5. Mock ให้ comment `// MOCK` ชัดเจน และแยกไฟล์ไป `mock/`
6. ยังทำไม่เสร็จ comment `// TODO` ชัดเจน
7. ไม่ mock หรือ TODO โดย default ยกเว้นจำเป็นจริงๆ

### 6. Reflex

1. ทำ `/loop-until-complete` ทำซ้ำจน implement เสร็จทั้งหมด
2. กลับไป check planning เรื่อยๆ จนมั่นใจว่า implement เสร็จทั้งหมด

### 7. Report

1. ทำตาม `/report`
2. เมื่อจบ task รัน `/suggest-next-action` เสมอ
3. คุยกับผู้ใช้เป็นภาษาไทยเสมอ
4. คำตอบกระชับ ตรงประเด็น
5. หลีกเลี่ยงคำยืนยันที่ไม่จำเป็น

## Rules

- ใช้ Bun shell สำหรับ automation เสมอ
- ใช้ `bunx` แทน `npx` เสมอ
- ทุก workspace ต้องมี scripts มาตรฐานจาก `/follow-tasks`
- File operation จำนวนมาก ใช้ `/use-scripts`
- Execute ต้องให้ผลลัพธ์เหมือนกันทุกครั้ง
- ไม่ใช้คำสั่ง subjective หรือ ambiguous
- ระบุลำดับการทำงานชัดเจน

## Expected Outcome

- การทำงานสม่ำเสมอทุก workspace
- Code quality สูงและเป็นไปตามมาตรฐาน
- ไม่มี mock หรือ TODO ที่ไม่จำเป็น
- Workflows ทำงานได้อย่างมีประสิทธิภาพ
- การสื่อสารชัดเจนและกระชับ
