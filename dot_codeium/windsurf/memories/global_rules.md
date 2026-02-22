---
description: กฎการทำงานแบบง่าย
title: global-rules
auto_execution_mode: 3
---

## 1. การทำงาน

- ใช้ภาษาไทยในการสื่อสาร
- ใช้ bun เป็น package manager
- วิเคราะห์โครงสร้างก่อนแก้ไข
- สร้าง todo_list สำหรับงานซับซ้อน
- แบ่งโค้ดเป็นไฟล์ย่อยตาม single responsibility
- ไม่ hardcode sensitive data
- ไม่ hardcode ค่าต่างๆ ในโค้ด
- ไม่สร้าง mockup data สำหรับ production
- เขียนโค้ดให้พร้อมใช้งานจริง (production ready)
- file ops ใช้ pwsh
- ตรวจสอบ file structure ใช้ eza --tree --git-ignore
