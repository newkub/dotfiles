---
title: Benchmark Competitors
description: ศึกษาคู่แข่งและปรับปรุง project ให้ดีกว่าในทุกมิติ
auto_execution_mode: 3
related:
  - /bench-features
  - /deep-research
  - /pondering
  - /plan
  - /ship-code
  - /update-docs
  - /review-performance
  - /review-frontend
  - /ask-me
---

## Goal

ศึกษาคู่แข่งและปรับปรุง project ให้ดีกว่าในทุกมิติ

## Scope

ครอบคลุมทุกมิติของ product: features, performance, UX/UI, architecture, DX, security, scalability, business ไม่ใช่แค่มิติใดมิติหนึ่ง

## Execute

### 1. Research Competitors

วิจัยคู่แข่งที่ relevant

> Goal: รู้ competitor landscape และ best practices

1. ทำ `/deep-research` เพื่อรวบรวมข้อมูลคู่แข่ง
2. ระบุ competitors ที่เป็น direct และ indirect
3. วิเคราะห์ strengths, weaknesses, unique selling points, tech stack, UX patterns
4. ถ้าหาข้อมูลไม่ได้ → stop และ report

### 2. Benchmark Features

เปรียบเทียบและปรับปรุงมิติ features

> Goal: ให้ features ดีกว่าคู่แข่ง

1. ทำ `/bench-features` เพื่อ benchmark มิติ features
2. รับผลเป็น section หรือไฟล์ `comparison-features.md`
3. ถ้า `/bench-features` fail → stop และ report

### 3. Benchmark Other Dimensions

เปรียบเทียบมิติที่เหลือนอกเหนือ features

> Goal: ครอบคลุม performance, UX/UI, architecture, DX, security, business

1. ทำ `/review-performance` สำหรับ performance
2. ทำ `/review-frontend` สำหรับ UX/UI
3. ถ้ามีมิติอื่น (architecture, DX, security, scalability, business) ให้ใช้เครื่องมือที่เหมาะสม
4. บันทึกผลใน `docs/project/comparison.md`

### 4. Plan Improvements

วางแผนปรับปรุงให้ดีกว่าคู่แข่ง

> Goal: ได้ roadmap ครอบทุกมิติ

1. ทำ `/pondering` เพื่อทบทวน priority และผลกระทบ
2. ทำ `/plan` เพื่อสร้าง roadmap ครอบทุกมิติ
3. ระบุ priority: Critical, High, Medium, Nice-to-have
4. ถ้า scope ไม่ชัด → ใช้ `/ask-me` ก่อน plan

### 5. Implement Improvements

ปรับปรุง project ตาม roadmap

> Goal: ดีกว่าคู่แข่งในทุกมิติ

1. ทำ `/ship-code` เพื่อ implement improvements
2. ทำ `/review-performance` สำหรับ performance improvements
3. ทำ `/review-frontend` สำหรับ UX/UI improvements
4. หยุดเมื่อดีกว่าคู่แข่งทั้งหมดในทุกมิติ

### 6. Update Report

อัปเดตรายงานเปรียบเทียบ

> Goal: รายงาน reflect สถานะล่าสุด

1. ทำ `/update-docs` เพื่ออัปเดต `docs/project/comparison.md`
2. อัปเดต status ในตารางเปรียบเทียบ
3. Re-benchmark หลังการปรับปรุง

## Rules

### 1. Focus On Actionable Insights

- เน้น metrics ที่ measurable และ actionable
- ไม่ research ลึกเกินความจำเป็น
- รายงานกระชับไม่เกิน 1 หน้า A4

### 2. Document Structure

- ไฟล์หลัก `comparison.md` ใน `docs/project/`
- อนุญาตไฟล์ย่อย `comparison-*.md` จาก sub-workflows เช่น `comparison-features.md`
- 2-3 sections หลักพอ
- ไม่ต้องมี timeline ละเอียด

### 3. Multi-Dimension Focus

- ไม่ใช่แค่ features แต่ครอบคลุมทุกมิติ
- วัดด้วย metrics ที่ objective
- เปรียบเทียบกับ competitors ที่ relevant

### 4. Implementation Discipline

- ทำตาม plan จนกว่าจะดีกว่าคู่แข่ง
- หยุดเมื่อสำเร็จเป้าหมายในทุกมิติ
- ติดตามความคืบหน้าอย่างสม่ำเสมอ
- Re-benchmark หลังการปรับปรุงแต่ละครั้ง

### 5. Stop When Better

- หยุดทันทีเมื่อ project ดีกว่าคู่แข่งในทุกมิติ
- ไม่ทำ over-engineering หรือเพิ่ม features ที่ไม่จำเป็น
- ย้ายไปทำงานอื่นเมื่อสำเร็จเป้าหมายแล้ว

## Expected Outcome

- ไฟล์ `docs/project/comparison.md` ที่มีตารางเปรียบเทียบทุกมิติ
- Project ดีกว่าคู่แข่งในทุกมิติ
- ใช้เวลาไม่เกิน 30 นาทีในการ benchmark
