---
title: Learn from Web
description: เรียนรู้จากเว็บไซต์หลักและเอกสารด้วย DeepWiki, Context7 และ Official Documentation
auto_execution_mode: 3
related_workflows:
  - /deep-research
  - /follow-best-practice
---

## Goal

เรียนรู้จากเว็บไซต์หลักและเอกสารอย่างเป็นระบบ เพื่อให้ได้ข้อมูลที่ครบถ้วนและถูกต้องที่สุด

## Scope

ค้นหาและเรียนรู้จาก DeepWiki, Context7, Web Search และ Official Documentation

## Execute

### 1. Research Strategy

1. กำหนดลำดับความสำคัญของแหล่งข้อมูล
2. ใช้ DeepWiki สำหรับ GitHub repositories
3. ใช้ Context7 สำหรับ libraries และ frameworks
4. ใช้ Web Search เป็น fallback
5. เข้าถึง Official Documentation เสมอ

### 2. DeepWiki Research

1. ใช้ `read_wiki_structure` เพื่อดู topics ทั้งหมด
2. ใช้ `read_wiki_contents` เพื่ออ่านเนื้อหาของ topic ที่เลือก
3. ใช้ `ask_question` สำหรับคำถามเฉพาะเจาะจง
4. เริ่มด้วย structure เพื่อดู topics ทั้งหมดก่อน
5. เลือก topics ที่เกี่ยวข้องกับงานปัจจุบัน
6. อ่าน getting started ก่อน advanced topics
7. บันทึก code examples และ configuration examples

### 3. Context7 Research

1. ใช้ `resolve-library-id` เพื่อหา library ID ที่ถูกต้อง
2. ใช้ `query-docs` สำหรับ documentation ที่ต้องการ
3. Query ให้เฉพาะเจาะจง เช่น "How to setup authentication with JWT in Express.js"
4. ตรวจสอบ source reputation และ benchmark scores
5. เลือก library ที่มี source reputation High หรือ Medium
6. อ่าน examples และ code snippets ที่ Context7 ให้มา
7. ตรวจสอบ version ที่เข้ากันได้กับ project
8. ไม่เรียก Context7 เกิน 3 ครั้งต่อคำถาม

### 4. Web Search Research

1. ใช้ `search_web` เมื่อไม่มีข้อมูลจาก DeepWiki หรือ Context7
2. กำหนด query ที่ชัดเจนและเฉพาะเจาะจง
3. ใช้ domain filter ถ้าจำเป็น เช่น domain: "bun.sh"
4. เปรียบเทียบข้อมูลจากหลายแหล่ง
5. ตรวจสอบว่าข้อมูลเป็นปัจจุบัน (check publish date)

### 5. Knowledge Extraction

1. จดบันทึกหลักการที่สำคัญและ core concepts
2. ระบุ features และ capabilities หลักทั้งหมด
3. บันทึก best practices และ recommendations
4. บันทึก code examples ที่สำคัญพร้อมคำอธิบาย
5. บันทึก configuration examples ที่สำคัญ
6. บันทึก edge cases และ common pitfalls
7. สร้าง summary สำหรับแต่ละ source

### 6. Validation

1. ทดลองใช้งานตามที่เรียนรู้
2. สร้างโปรเจกต์ตัวอย่างเพื่อทดสอบ
3. เปรียบเทียบข้อมูลจากหลายแหล่ง
4. ยืนยันว่าข้อมูลเป็นปัจจุบัน
5. ตรวจสอบว่า code examples ทำงานได้จริง
6. ทดสอบ edge cases และ error handling

### 7. Application

1. นำความรู้ไปใช้ในโปรเจกต์จริง
2. สร้าง examples หรือ tutorials สำหรับทีม
3. ติดตาม updates จากเว็บไซต์หลักอย่างสม่ำเสมอ
4. สร้าง learning loop สำหรับพัฒนาตนเอง
5. บันทึก lessons learned สำหรับ future reference
6. แชร์ความรู้กับทีมผ่าน documentation

## Rules

### 1. Information Source Priority

กำหนดลำดับความสำคัญของแหล่งข้อมูล:

- ลำดับแหล่งข้อมูล: `DeepWiki` → `Context7` → `Web Search` → `Official Docs`
- ใช้ `DeepWiki` ก่อนถ้าเป็น GitHub repository
- ใช้ `Context7` สำหรับ libraries และ frameworks
- ใช้ `Web Search` เป็น fallback
- เข้าถึง `Official Documentation` เสมอ

### 2. Deep Research Integration

สำหรับการค้นหาข้อมูลลึกจาก multiple sources:

- ทำ `/deep-research` เมื่อต้องการค้นหาจาก NPM, GitHub, DeepWiki, Context7 และ Windsurf WebSearch
- ใช้ CRW สำหรับ crawl official documentation เมื่อจำเป็น
- ตรวจสอบ credibility และ freshness ของข้อมูล

### 3. Best Practices Application

สำหรับการนำความรู้ไปใช้งาน:

- ทำ `/follow-best-practice` เพื่อใช้ความรู้ตามมาตรฐานของ language, runtime, และ library
- ตรวจสอบความถูกต้องด้วย linter และ typecheck
- รัน tests เพื่อยืนยันว่าไม่มี regression

## Expected Outcome

- ข้อมูลที่ครบถ้วนจาก multiple sources
- ความรู้ที่ถูกต้องและเป็นปัจจุบัน
- Code examples และ best practices ที่บันทึกไว้
- การนำความรู้ไปใช้งานจริง
- การทดสอบและ validation ที่ครบถ้วน
