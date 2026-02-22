---
trigger: manual
description: แทนที่เนื้อหาในไฟล์หรือโค้ด
condition: ใช้เมื่อต้องแก้ไขเนื้อหาในไฟล์หรือโค้ด
---

# Replace Content

## 1. Identify Content to Replace (ใช้เสมอ)

ระบุเนื้อหาที่ต้องการแทนที่

`IDENTIFY target` : ต้องแทนที่ -> SEARCH และ MARK เนื้อหาที่ต้องการแทนที่

1. SEARCH เนื้อหา x ที่ต้องการแทนที่
2. MARK ตำแหน่งที่ต้องการแทนที่
3. PREPARE เนื้อหา y ที่จะนำมาแทนที่

---

## 2. Execute Replacement (ใช้เสมอ)

ทำการแทนที่เนื้อหา

`REPLACE content` : มีเนื้อหา x และ y -> EXECUTE การแทนที่

1. REPLACE x ด้วย y ในไฟล์หรือโค้ดที่ระบุ
2. VERIFY ว่าการแทนที่ถูกต้อง
3. CHECK ว่าไม่มีผลข้างเคียงจากการแทนที่ 