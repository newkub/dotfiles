---
trigger: manual
description: กำหนดกฏในการใช้ scripts สำหรับทำงานที่ซ้ำๆ หรือจำนวนมาก
instruction:
  - ใช้ TypeScript หรือ Bun shell แทน PowerShell
  - เขียน script ในโฟลเดอร์ scripts/
  - ทดสอบด้วย tsc --noEmit หรือ bun run ก่อนรัน
  - ลบ script หลังใช้งาน
condition:
  - ใช้เมื่อต้องทำงานเยอะหรือซ้ำๆ
  - ใช้เมื่อต้องเขียน script อัตโนมัติ
goal: ลดความซ้ำซ้อนและเพิ่มประสิทธิภาพในการทำงาน
input: งานที่ต้องทำซ้ำๆ หรือจำนวนมาก
output: Script ที่ทำงานอัตโนมัติ
outcome: ลดเวลาทำงานและความผิดพลาดจากการทำงานซ้ำ
---

## 1. การสร้าง Script (ใช้เมื่อต้องทำงานซ้ำๆ หรือจำนวนมาก)

- ต้องทำงานเยอะหรือซ้ำๆ -> เขียนไฟล์ในโฟลเดอร์ scripts/
- ต้องเขียน script -> เลือกใช้ TypeScript (.ts) หรือ Bun shell (.bun.sh)
  - **TypeScript (.ts)**: ใช้เมื่อต้องการ type safety และ logic ที่ซับซ้อน
  - **Bun shell (.bun.sh)**: ใช้เมื่อต้องการ shell command แบบ cross-platform

## 2. การทดสอบ Script (ใช้ก่อนรันจริง)

- เขียน script เสร็จแล้ว -> รัน `tsc --noEmit <file>` เพื่อทดสอบ
- พบ Error หรือ Warning -> แก้ไขให้ครบก่อนรันจริง

## 3. การรัน Script (ใช้เมื่อผ่านการทดสอบแล้ว)

- Script ผ่านการทดสอบ -> รัน script ด้วย `bun run scripts/<file>`

## 4. การลบ Script (ใช้หลังจากใช้งานเสร็จ)

- ใช้งาน script เสร็จแล้ว -> ลบไฟล์ที่เพิ่งเขียน