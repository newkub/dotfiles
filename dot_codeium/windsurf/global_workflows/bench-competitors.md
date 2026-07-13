---
title: Benchmark Competitors
description: ศึกษาคู่แข่งและปรับปรุงจนดีกว่าในทุกมิติ
auto_execution_mode: 3
related:
  - /deep-research
  - /plan
  - /ship
  - /update-docs
  - /review-performance
  - /review-frontend
  - /pondering
---

## Goal

ศึกษาคู่แข่งและปรับปรุง project จนดีกว่าในทุกมิติ

## Scope

ครอบคลุมทุกมิติของ product: features, performance, UX/UI, architecture, DX, security, scalability, business

## Execute

### 1. Research Competitors

วิจัยคู่แข่งที่ relevant กับ project

1. ทำ `/deep-research` เพื่อรวบรวมข้อมูลคู่แข่ง
2. ระบุ competitors ที่เป็น direct และ indirect
3. วิเคราะห์ strengths, weaknesses, และ unique selling points
4. ระบุ tech stack, UX patterns, และ best practices

### 2. Create Comparison Report

สร้างรายงานเปรียบเทียบทุกมิติ

1. ทำ `/update-docs` เพื่อสร้าง docs structure ก่อน
2. สร้างไฟล์ `comparison.md` ใน `docs/project/`
3. สร้างตารางเปรียบเทียบทุกมิติ (Features, Performance, UX/UI, Architecture, DX, Security, Business)
4. สร้าง improvement roadmap พร้อม priority (Critical, High, Medium, Nice-to-have)
5. วิเคราะห์คู่แข่งแต่ละเจ้าแบบกระชับ

### 3. Implement Improvements

ปรับปรุง project จนดีกว่าคู่แข่ง

1. ทำ `/pondering` เพื่อทบทวนว่าควรปรับปรุงอะไรก่อนและผลกระทบของแต่ละการเปลี่ยนแปลง
2. ทำ `/plan` เพื่อวางแผนการปรับปรุง
3. ทำ `/ship` เพื่อ implement จนดีกว่าคู่แข่ง
4. ทำ `/review-performance` สำหรับ performance improvements
5. ทำ `/review-frontend` สำหรับ UX/UI improvements
6. หยุดเมื่อ project ดีกว่าคู่แข่งทั้งหมมในทุกมิติ

### 4. Update Progress

อัพเดทความคืบหน้าอย่างสม่ำเสมอ

1. Update ไฟล์ `comparison.md` เมื่อ implement เสร็จ
2. Update status ในตารางเปรียบเทียบ
3. Re-benchmark หลังการปรับปรุงแต่ละครั้ง

## Rules

### 1. Focus on Actionable Insights

เน้น metrics ที่ measurable และ actionable

- ไม่ต้อง research ลึกเกินความจำเป็น
- เน้น metrics ที่ measurable และ actionable
- รายงานกระชับไม่เกิน 1 หน้า A4

### 2. Document Structure

รักษาโครงสร้างให้สม่ำเสมอ

- แค่ 1 ไฟล์ `comparison.md` ใน `docs/project/`
- 2-3 sections หลักพอ
- ไม่ต้องมี timeline ละเอียด

### 3. Multi-Dimension Focus

ครอบคลุมทุกมิติของ product

- ไม่ใช่แค่ features แต่ครอบคลุมทุกมิติ
- วัดด้วย metrics ที่ objective
- เปรียบเทียบกับ competitors ที่ relevant

### 4. Implementation Discipline

ทำตาม plan จนกว่าจะดีกว่าคู่แข่ง

- ทำตาม plan จนกว่าจะดีกว่าคู่แข่ง
- หยุดเมื่อสำเร็จเป้าหมายในทุกมิติ
- ติดตามความคืบหน้าอย่างสม่ำเสมอ
- Re-benchmark หลังการปรับปรุงแต่ละครั้ง

### 5. Stop When Better

หยุดการทำงานเมื่อดีกว่าคู่แข่งแล้ว

- หยุดทันทีเมื่อ project ดีกว่าคู่แข่งในทุกมิติ
- ไม่ต้องทำ over-engineering หรือเพิ่ม features ที่ไม่จำเป็น
- ย้ายไปทำงานอื่นเมื่อสำเร็จเป้าหมายแล้ว

## Expected Outcome

- ไฟล์ `comparison.md` ใน `docs/project/` ที่มีตารางเปรียบเทียบทุกมิติ
- Project ดีกว่าคู่แข่งในทุกมิติ
- ใช้เวลาไม่เกิน 30 นาทีในการ benchmark
