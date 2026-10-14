# Global Rules

## 1. Refactor-To-SRP Always

- เวลา user สั่งให้ทำอะไรใหม่ (create/implement feature, file, module, config, docs, skill) หรือสั่งอัปเดต/แก้ไขอะไรก็ตาม → ทำตาม `/refactor-to-srp` เสมอ
- ทุก unit/file ที่สร้างหรือแตะต้องมี single responsibility: 1 unit = 1 reason to change, ไฟล์ ≤250 บรรทัด (ยกเว้น barrel/index)
- ก่อนเขียน → อ่าน `refactor/SKILL.md` `## Rules` + `/refactor-to-srp`; หลังเขียน/แก้เสร็จ → ทำ `/refactor` SRP scope กับไฟล์ที่แตะก่อนจบงานเสมอ ไม่ข้าม

## 2. Plan Before Bulk Work

- เวลา user สั่งให้ทำอะไรใหม่จำนวนเยอะในคราวเดียว (หลาย features/files/tasks พร้อมกัน) → ทำ `/create-plan-in-dot-devin` ก่อนเสมอ แล้วค่อย implement ตาม plan

## 3. Test Usage Always

- เวลา user สั่งให้ทำอะไร (create/implement feature, file, module, config, docs, skill หรือแก้ไขอะไรก็ตาม) → ทำ `/deep-test usage` ก่อนจบงานเสมอ เพื่อยืนยันว่า usage/examples/commands ทำงานได้จริง ไม่ข้าม
- `/deep-test usage` ยังเลือก domain test เพิ่มเติมได้ตรง domain เอง — website → `/deep-test website`, CLI → `/deep-test cli`, API → `/deep-test api`, e2e → `/deep-test e2e`, หลาย domain → `/deep-test all` (`/run-test` เป็น thin dispatcher ส่งต่อมาที่นี่)
- ถ้า `/deep-test usage` ไม่ applicable จริงๆ (เช่น research-only, report-only ที่ไม่มี runnable usage) → ระบุเหตุผลใน report แทนการข้ามเงียบๆ
