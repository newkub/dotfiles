---
trigger: manual
description: กฏในการจัดกลุ่มรายการให้เหมาะสม
instruction:
  - ต้องมี frontmatter
  - content เขียนตาม example
  - กฏต้องสามารถ VALIDATE และ VERIFY ได้
---

## 1. หลักการ GROUPING (ใช้เสมอ)

1.1. วัตถุประสงค์
    - จัดกลุ่มรายการให้เป็น partition ของ set ที่ไม่ซ้ำกันและครอบคลุมทุกรายการ
    - ทำให้โครงสร้างชัดเจนและอ่านง่ายขึ้น
    - ลดความสับสนในการค้นหาและบำรุงรักษา

1.2. หลักการจาก Set Theory
    - **Universe Set**: รายการทั้งหมดที่ต้องจัดกลุ่ม
    - **Equivalence Relation**: ความสัมพันธ์ที่ทุกรายการสามารถจัดเป็นกลุ่มได้ โดยมี properties:
        - Reflexive: รายการ equivalent กับตัวเองเสมอ
        - Symmetric: ถ้า A equivalent B แล้ว B ต้อง equivalent A
        - Transitive: ถ้า A equivalent B และ B equivalent C แล้ว A ต้อง equivalent C
    - **Equivalence Class**: กลุ่มของรายการทั้งหมดที่ equivalent กัน
    - **Partition**: การแบ่งรายการทั้งหมดเป็นกลุ่มที่ไม่ซ้ำกันและครอบคลุมทุกรายการ

1.3. ขั้นตอน GROUPING
    - DEFINE รายการทั้งหมดที่ต้องจัดกลุ่ม
    - DEFINE ความสัมพันธ์สำหรับการจัดกลุ่ม
    - VERIFY ว่าความสัมพันธ์เป็น equivalence relation
    - COMPUTE กลุ่มของรายการที่ equivalent กัน
    - VALIDATE ว่ากลุ่มทั้งหมดสร้าง partition ที่ถูกต้อง
    - VERIFY ว่าโครงสร้างชัดเจน

---

## 2. การวิเคราะห์ (ใช้เสมอ)

2.1. ตรวจสอบรายการทั้งหมด
    - IDENTIFY รายการทั้งหมดที่ต้องจัดกลุ่ม
    - CHECK ว่ามีรายการอย่างน้อย 1 รายการ
    - IDENTIFY คุณสมบัติของแต่ละรายการ

2.2. ตรวจสอบความสัมพันธ์
    - DEFINE criteria สำหรับการจัดกลุ่ม
    - VERIFY Reflexive: ทุกรายการต้อง equivalent กับตัวเอง
    - VERIFY Symmetric: ถ้ารายการ A อยู่กลุ่มเดียวกับ B แล้ว B ต้องอยู่กลุ่มเดียวกับ A
    - VERIFY Transitive: ถ้า A อยู่กลุ่มเดียวกับ B และ B อยู่กลุ่มเดียวกับ C แล้ว A ต้องอยู่กลุ่มเดียวกับ C

2.3. Example
    - ไฟล์ในโปรเจกต์: ไฟล์ A และ B อยู่กลุ่มเดียวกันถ้ามี type เหมือนกัน
    - tasks ใน project: task A และ B อยู่กลุ่มเดียวกันถ้ามี priority เหมือนกัน
    - items ใน list: item A และ B อยู่กลุ่มเดียวกันถ้ามี category เหมือนกัน

---

## 3. การจัดกลุ่ม (ใช้เสมอ)

3.1. กำหนดความสัมพันธ์
    - DEFINE relation ที่ชัดเจนและเป็น objective
    - ใช้ relation เดียวหรือหลาย relations ตามความเหมาะสม
    - relation ควรสอดคล้องกับวัตถุประสงค์

3.2. คำนวณกลุ่ม
    - FOR EACH รายการ:
        - COMPUTE กลุ่มของรายการทั้งหมดที่ equivalent กับรายการนั้น
        - GROUP รายการที่ equivalent กันเข้าด้วยกัน
    - ใช้ชื่อกลุ่มที่สื่อความหมายชัดเจน
    - แต่ละรายการควรอยู่ในกลุ่มเดียวเท่านั้น

3.3. สร้าง Partition
    - VERIFY ว่ากลุ่มทั้งหมดไม่ซ้ำกัน
    - VERIFY ว่า union ของทุกกลุ่มครอบคลุมรายการทั้งหมด
    - ใช้ hierarchy ที่เหมาะสมกับความซับซ้อน

3.4. Example
    ```
    // Universe Set: ไฟล์ในโปรเจกต์
    // Relation: ไฟล์ A และ B อยู่กลุ่มเดียวกันถ้ามี type เหมือนกัน

    รายการทั้งหมด = {config.ts, types.ts, Button.vue, Layout.vue, utils.ts}

    กลุ่มที่คำนวณได้:
    กลุ่ม config = {config.ts}
    กลุ่ม types = {types.ts}
    กลุ่ม components = {Button.vue, Layout.vue}
    กลุ่ม utils = {utils.ts}

    Partition:
    src/
      config/          # {config.ts}
      types/           # {types.ts}
      ui/
        components/    # {Button.vue, Layout.vue}
      functions/       # {utils.ts}
    ```

---

## 4. การ VALIDATE (ใช้เสมอ)

4.1. ตรวจสอบ Partition
    - ปฏิบัติตามขั้นตอนใน /validate-goal
    - CHECK ว่าทุกกลุ่มไม่ซ้ำกัน
    - CHECK ว่า union ของทุกกลุ่มครอบคลุมรายการทั้งหมด

4.2. ตรวจสอบความสัมพันธ์
    - CHECK ว่า relation เป็น equivalence relation
    - CHECK ว่า relation ใช้งานได้จริง
    - CHECK ว่า relation สอดคล้องกับวัตถุประสงค์

---

## 5. การ VERIFY (ใช้เสมอ)

5.1. ตรวจสอบความชัดเจน
    - ปฏิบัติตามขั้นตอนใน /verify-rules
    - CHECK ว่า partition อ่านง่าย
    - CHECK ว่าสามารถค้นหารายการได้ง่าย

5.2. ตรวจสอบความเหมาะสม
    - ASK ผู้ใช้ว่า partition เข้าใจง่ายไหม
    - CHECK ว่าจำนวนกลุ่มไม่มากเกินไปหรือน้อยเกินไป
    - CHECK ว่าชื่อกลุ่มสื่อความหมายชัดเจน

---

## 6. หมายเหตุ (ใช้เมื่อมีข้อยกเว้น)

| เงื่อนไข | การกระทำ |
|---|---|
| รายการมีคุณสมบัติหลายแบบ | ใช้ composite relations |
| รายการไม่เข้ากับกลุ่มใด | สร้างกลุ่ม "Other" หรือ "Miscellaneous" |
| รายการทั้งหมดมีจำนวนน้อยมาก | อาจไม่ต้องจัดกลุ่ม |
| relation ซับซ้อน | ใช้ multiple relations หรือ clustering algorithms |
