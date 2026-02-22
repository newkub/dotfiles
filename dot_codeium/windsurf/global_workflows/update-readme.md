---
trigger: manual
description: อัพเดท README.md ทุก workspace ให้มีรูปแบบที่สอดคล้องกัน
instruction:
  - CHECK README.md ในทุก workspace
  - UPDATE README.md ที่ยังไม่มีหรือไม่สมบูรณ์
  - USE รูปแบบที่กำหนดสำหรับทุก README.md
condition:
  - ใช้เมื่อต้องการอัพเดท README.md ให้ครบถ้วน
  - ใช้เมื่อมีการสร้าง workspace ใหม่
  - ใช้เมื่อต้องการให้ README.md มีรูปแบบที่สอดค้องกัน
---

# 1. Check README.md in all workspaces (ใช้เสมอ)

1.1. CHECK README.md หลักของ workspace
1.2. CHECK README.md ใน apps/ ทุกตัว
1.3. CHECK README.md ใน packages/ ทุกตัว
1.4. CREATE รายการ README.md ที่ต้องอัพเดท

---

# 2. Update main README.md (ใช้เมื่อ README.md หลักว่างหรือไม่สมบูรณ์)

2.1. CALL [follow-readme-monorepo](follow-readme-monorepo.md)
2.2. VERIFY ว่า README.md หลักสร้างเสร็จแล้ว
2.3. CHECK ว่ามีข้อมูล packages และ apps ครบถ้วน

---

# 3. Update README.md in apps/ (ใช้เมื่อมี apps/)

3.1. CALL [follow-readme-apps](follow-readme-apps.md)
3.2. VERIFY ว่า README.md ของแต่ละ app สร้างเสร็จแล้ว
3.3. CHECK ว่ามีข้อมูลเฉพาะของแต่ละ app ครบถ้วน

---

# 4. Update README.md in packages/ (ใช้เมื่อมี packages/)

4.1. CALL [follow-readme-packages](follow-readme-packages.md)
4.2. VERIFY ว่า README.md ของแต่ละ package สร้างเสร็จแล้ว
4.3. CHECK ว่ามีข้อมูลเฉพาะของแต่ละ package ครบถ้วน

---

# 5. Verify all README.md files (ใช้เสมอ)

5.1. VERIFY ว่าทุก README.md มีรูปแบบที่สอดคล้องกัน
5.2. CHECK ว่าทุก README.md มีข้อมูลครบถ้วน
5.3. VERIFY ว่า commands ทั้งหมดถูกต้อง
5.4. CHECK ว่า examples ทั้งหมดใช้งานได้จริง
5.5. VERIFY ว่า tables และ emoji ใช้เหมาะสม

---

# 6. Guidelines (ใช้เสมอ)

6.1. USE English for headings
6.2. USE English for code blocks
6.3. USE emoji appropriately
6.4. ADD real usage examples
6.5. MAINTAIN consistency across all README.md files
6.6. VERIFY commands are correct
6.7. WRITE according to best practices to achieve 10/10 score

