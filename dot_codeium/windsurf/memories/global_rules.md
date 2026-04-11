---
title: Global Rules
description: กฎและแนวทางการพัฒนาโปรเจกต์ทั่วไปสำหรับทุก workspace
auto_execution_mode: 3
---

ใช้เป็นแนวทางหลักสำหรับทุกการพัฒนาทุก project เมื่อไม่แน่ใจว่าควรทำอย่างไรให้กลับมาอ่านกฎเหล่านี้

## Execute

1. Prepare

เตรียมความพร้อมก่อนเริ่มงาน

- คุยกับผู้ใช้เป็นภาษาไทยเสมอ
- "." หมายถึงให้ทำ `/continue`
- ไม่ใช้ npm
- ใช้ git file ops ก่อน ถ้าใช้ไม่ได้ให้ใช้ pwsh
- ถ้าส่ง URL ให้ ให้รัน `/watch-browser` ทันที
- ทุกครั้งก่อนทำอะไรให้ @[/analyze-project] ก่อนเสมอ

2. Analyze

วิเคราะห์โปรเจกต์และความต้องการก่อนเริ่มทำงาน

- ตรวจสอบ manifest file ที่เกี่ยวข้อง
- ตรวจสอบ patterns ที่มีอยู่แล้วใน codebase (naming, structure, conventions)
- ดูตัวอย่าง implementations ที่คล้ายกันก่อนเริ่มทำ
- ถ้าต้อง analyze อะไรยากๆ สามารถใช้ `/use-bun-shell`

3. Planning

- พยายามทำให้ `/make-real` ให้ใช้งานได้จริงๆ

4. Execute

ดำเนินการตามกฎที่กำหนดอย่างเคร่งครัด

- no hard code
- แยก separate concerns (types, config, utils ออกจาก logic หลัก เสมอ
- ทุก folder ต้องมี barrel export
- ใช้ import alias เสมอ
- ทำ bulk file ops ใช้ pwsh
- ถ้าส่ง error ให้อ่านและทำตาม /fix-error

5. Report

สรุปและรายงานผล

- ทุกครั้งที่จบ task ให้สรุปงานที่ทำเสร็จแล้วเป็นตารางเสมอ
- เสนอขั้นตอนต่อไปที่ควรทำ เป็นข้อๆ ให้ผู้ใช้พิจารณาเสมอ

## Rules

1. Language Rule

- คุยกับผู้ใช้เป็นภาษาไทยเสมอในทุกการสื่อสาร

2. Package Manager Rule

- ไม่ใช้ npm ใช้ bun แทนเสมอ

3. File Operations Rule

- ใช้ git file ops ก่อน ถ้าใช้ไม่ได้ให้ใช้ pwsh

4. URL Handling Rule

- ถ้าผู้ใช้ส่ง URL ให้รัน `/watch-browser` ทันที

5. Analysis Rule

- ทุกครั้งก่อนทำอะไรให้ @[/analyze-project] ก่อนเสมอ

6. Code Quality Rules

- no hard code
- แยก separate concerns (types, config, utils ออกจาก logic หลัก เสมอ
- ทุก folder ต้องมี barrel export
- ใช้ import alias เสมอ

7. Error Handling Rule

- ถ้าส่ง error ให้อ่านและทำตาม /fix-error

8. Reporting Rule

- ทุกครั้งที่จบ task ให้สรุปงานที่ทำเสร็จแล้วเป็นตารางเสมอ
- เสนอขั้นตอนต่อไปที่ควรทำ เป็นข้อๆ ให้ผู้ใช้พิจารณาเสมอ

