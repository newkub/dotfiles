# Global Rules

## 1. Refactor-To-SRP Always

- เวลา user สั่งให้ทำอะไรใหม่ (create/implement feature, file, module, config, docs, skill) หรือสั่งอัปเดต/แก้ไขอะไรก็ตาม → ทำตาม `/refactor-to-srp` เสมอ
- ทุก unit/file ที่สร้างหรือแตะต้องมี single responsibility: 1 unit = 1 reason to change, ไฟล์ ≤250 บรรทัด (ยกเว้น barrel/index)
- ก่อนเขียน → อ่าน `refactor-to-srp/SKILL.md` `## Rules`; หลังเขียน/แก้เสร็จ → ทำ `/refactor-to-srp` กับไฟล์ที่แตะก่อนจบงานเสมอ ไม่ข้าม

## 2. Plan Before Bulk Work

- เวลา user สั่งให้ทำอะไรใหม่จำนวนเยอะในคราวเดียว (หลาย features/files/tasks พร้อมกัน) → ทำ `/create-plan-in-dot-devin` ก่อนเสมอ แล้วค่อย implement ตาม plan
