---
title: Use Packages
description: วิเคราะห์และแนะนำ packages/crates ที่มีอยู่ใน monorepo
auto_execution_mode: 3
follow.workflows:
  - /analyze-project
  - /use-lib-better
  - /use-deps-better
---

## Goal

วิเคราะห์ packages/ และ crates/ ที่มีอยู่ใน monorepo เพื่อระบุสิ่งที่ควรนำมาใช้ จัดลำดับความสำคัญ และให้คำแนะนำ

## Execute

### 1. Scan Directories

1. ใช้ `list_dir` ที่ `packages/` เพื่อดู packages ทั้งหมด
2. ใช้ `list_dir` ที่ `crates/` ถ้ามีเพื่อดู crates ทั้งหมด
3. อ่าน `package.json` หรือ `Cargo.toml` ของแต่ละ package/crate
4. รวบรวม metadata: name, version, description, keywords, dependencies
5. อ่าน `README.md` ของแต่ละ package/crate ถ้ามี

### 2. Analyze Each Package

1. ตรวจสอบ source structure: src/, lib/, bin/
2. ระบุ main exports และ public APIs
3. ดู dependencies และ peer dependencies
4. ตรวจสอบ test coverage และ documentation quality
5. ประเมิน maintenance status: last update, issues, PRs
6. ตรวจสอบ version stability และ semver compliance

### 3. Evaluate Relevance

1. ให้คะแนนแต่ละ package/crate ตามเกณฑ์ (1-5 points):
   - Relevance (1-5): ตรงกับ requirements ปัจจุบันหรือไม่
   - Maturity (1-5): Stable, tested, well-documented
   - Maintenance (1-5): Active development, responsive maintainers
   - Dependencies (1-5): Minimal, no conflicts
   - Performance (1-5): Efficient, no known bottlenecks
2. คำนวณ Total Score (สูงสุด 25 points)
3. ประเมิน Integration Effort (Low/Medium/High)
4. ตรวจสอบ compatibility กับ current stack

### 4. Recommend and Prioritize

1. สร้างรายการแนะนำพร้อมเหตุผลสำหรับแต่ละ package/crate
2. จัดลำดับตาม Priority Matrix:
   - High Priority: Total Score >= 20, Integration Effort: Low
   - Medium Priority: Total Score 15-19, Integration Effort: Medium
   - Low Priority: Total Score < 15, Integration Effort: High
3. ระบุ use cases ที่เหมาะสมสำหรับแต่ละ package/crate
4. แนะนำ integration approach

## Rules

### 1. Scanning

สแกนทุก packages และ crates

- ไม่ข้าม package/crate ใดๆ
- อ่าน metadata ให้ครบถ้วน
- บันทึก findings พร้อมหลักฐาน

### 2. Evaluation

ประเมินตามเกณฑ์ที่กำหนด

- ใช้ scoring system 1-5 points ตามเกณฑ์ที่กำหนด
- ประเมิน objectively ด้วยข้อมูลจริง
- ตรวจสอบ compatibility กับ current stack

### 3. Prioritization

จัดลำดับตาม Priority Matrix

- ใช้ Priority Matrix สำหรับการจัดลำดับ (High/Medium/Low)
- พิจารณา Relevance, Maturity, Maintenance, Dependencies, Performance
- จัดลำดับตาม impact และ effort ที่ต้องใช้

### 4. Documentation

บันทึก findings อย่างเป็นระบบ

- สร้างรายการ packages/crates พร้อม scores, use cases, integration effort
- ระบุ reasons สำหรับแต่ละ recommendation
- ให้ actionable next steps

## Expected Outcome

- รายการ packages/crates ทั้งหมดพร้อม metadata
- Scoring system ชัดเจน (Total Score 1-25 points)
- Priority Matrix สำหรับการจัดลำดับ (High/Medium/Low)
- คำแนะนำ use cases ที่เหมาะสมสำหรับแต่ละ package/crate
- Integration approach ที่ realistic และ prioritized
