---
description: แนวทางการจัดกลุ่ม items ตามความสัมพันธ์และ priority
auto_execution_mode: 3
---

## 1. Analyze Items

1. เก็บรวบรวม items ทั้งหมดที่ต้องจัดการ
   - อ่านเนื้อหาของแต่ละ item
   - บันทึก metadata (type, source, target)
2. ระบุ attributes ของแต่ละ item
   - type (feature, bugfix, refactor, docs)
   - component (frontend, backend, shared, infra)
   - priority (critical, high, medium, low)
   - dependencies (items ที่ต้องทำก่อน)
3. หา patterns และ relationships
   - common themes หรือ topics
   - dependencies ระหว่าง items
   - items ที่แก้ไข同一 files

## 2. Define Grouping Criteria

1. เลือก criteria หลักสำหรับจัดกลุ่ม
   - by type: จัดตามประเภทงาน
   - by component: จัดตามส่วนของระบบ
   - by priority: จัดตามความสำคัญ
   - by dependency: จัดตามลำดับการทำงาน
2. กำหนดกฎสำหรับแต่ละ group
   - เงื่อนไขที่ item จะเข้า group
   - จำนวน items สูงสุดต่อ group
   - priority ภายใน group

## 3. Create Groups

1. สร้าง groups ตาม criteria
   - ตั้งชื่อ group ที่สื่อความหมาย
   - ใส่ items ลงในแต่ละ group
   - ตรวจสอบว่าไม่มี item ตกหล่น
2. เรียงลำดับ groups
   - group ที่มี priority สูงทำก่อน
   - group ที่ไม่มี dependencies ทำก่อน
   - group ที่พร้อมดำเนินการทำก่อน
3. จัดลำดับ items ภายในแต่ละ group
   - เรียงตาม dependencies
   - เรียงตามความซับซ้อน
   - เรียงตาม priority

## 4. Validation

1. ตรวจสอบความครบถ้วน
   - ทุก item อยู่ใน group ใด group หนึ่ง
   - ไม่มี item ซ้ำใน multiple groups
   - ไม่มี item ตกหล่น
2. ตรวจสอบ criteria
   - items ในแต่ละ group สอดคล้องกับ criteria
   - สามารถอธิบายเหตุผลของการจัดกลุ่มได้
   - grouping consistent ทั่วทั้ง set
3. ตรวจสอบ priority และ dependencies
   - ลำดับ groups ถูกต้องตาม dependencies
   - ไม่มี circular dependencies
   - priority สอดคล้องกับ business value

## 5. Verification

1. ยืนยัน group structure
   - จำนวน groups เหมาะสม
   - ขนาดแต่ละ group balance
   - สามารถทำงาน parallel ระหว่าง groups ได้
2. ยืนยัน execution order
   - ลำดับการทำงานชัดเจน
   - dependencies ถูกจัดการแล้ว
   - มี documentation ของ grouping rationale
