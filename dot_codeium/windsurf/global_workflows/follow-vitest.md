---
trigger: always_on
description: แนวทางการตั้งค่าและใช้งาน Vitest รวมถึง Vitest Projects สำหรับ monorepo
instruction:
  - ทำตาม workflows ย่อยตามลำดับที่กำหนด
  - ตรวจสอบความเข้ากันได้ของ dependencies
condition:
  - ใช้เมื่อต้องการตั้งค่า Vitest สำหรับโปรเจกต์
  - ใช้เมื่อต้องการเขียน tests สำหรับ source code
  - ใช้เมื่อมีหลาย packages หรือ monorepo
---

## 1. Installation and Configuration (ใช้เสมอ)

1.1. ทำ /follow-vitest-config
   - ติดตั้ง Vitest และ dependencies ที่จำเป็น
   - ตั้งค่า package.json scripts
   - สร้าง vitest.config.ts พื้นฐาน

---

## 2. Projects Configuration (ใช้เมื่อมีหลาย packages หรือ monorepo)

2.1. ทำ /follow-vitest-projects
   - ตรวจสอบความเหมาะสมของการใช้งาน Vitest Projects
   - กำหนด glob patterns สำหรับ projects
   - ตั้งค่า extends เพื่อสืบทอดค่าจาก root config

---

## 3. Write Tests (ใช้เมื่อต้องเขียน test สำหรับ source code)

3.1. ทำ /follow-vitest-write-tests
   - วิเคราะห์โครงสร้างและระบุไฟล์ที่ต้องเขียน test
   - เขียน test files สำหรับ source code
   - รัน tests เพื่อตรวจสอบ

---

## 4. Best Practices (ใช้เสมอเมื่อทำงานกับ Vitest)

4.1. ทำ /follow-vitest-best-practices
   - ใช้ globals เพื่อลดการ import
   - จัดระเบียบ test files
   - ใช้ mocking และ stubbing อย่างเหมาะสม

---

## 5. Compatibility Check (ใช้เสมอ)

5.1. ทำ /check-compatibility
   - ตรวจสอบความเข้ากันได้ของ dependencies
   - ตรวจสอบเวอร์ชันของ Node.js และ Bun

---

## หมายเหตุ

- ใช้ Bun เป็น package manager
- ตรวจสอบความเข้ากันได้ของ dependencies อย่างสม่ำเสมอ
- ใช้ Vitest Projects เมื่อมีหลาย packages ใน monorepo