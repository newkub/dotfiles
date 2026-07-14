---
title: Deep Analyze
description: วิเคราะห์โปรเจกต์อย่างลึกซึ้งด้วยหลายมิติและ external research
auto_execution_mode: 3
related:
  - /analyze-project
  - /deep-review
  - /deep-review
  - /deep-review
  - /deep-research
  - /deep-thinking
  - /scan-codebase
  - /follow-code-quality
  - /check-duplication
---

## Goal

วิเคราะห์โปรเจกต์อย่างลึกซึ้งครบทุกมิติ เพื่อเข้าใจ architecture, patterns, quality, และ opportunities สำหรับ improvements

## Scope

ครอบคลุมการวิเคราะห์หลายมิติ:
- Architecture และ design patterns
- Code quality และ technical debt
- Features และ business logic
- Dependencies และ tech stack
- Performance และ security
- External research สำหรับ best practices
- Recommendations สำหรับ improvements

## Execute

### 1. Deep Thinking Phase

ทำ `/deep-thinking` เพื่อวิเคราะห์ปัญหาและวางแผนก่อนเริ่ม

1. กำหนด objectives ของการวิเคราะห์
2. แบ่งปัญหาออกเป็น sub-problems
3. สร้างทางเลือกสำหรับ analysis approach
4. ตรวจสอบ assumptions
5. สร้าง action plan ที่ชัดเจน

### 2. Quick Scan Phase

ทำ `/analyze-project` เพื่อวิเคราะห์โปรเจกต์พื้นฐาน

1. ทำ `/analyze-project` เพื่อวิเคราะห์โปรเจกต์อย่างครบถ้วน
2. Scan file structure และ project type
3. Search code patterns ทั่วไป
4. Structural analysis ด้วย ast-grep
5. Quality check พื้นฐาน
6. สร้าง structured data สำหรับ analysis

### 3. Structure Analysis

ทำ `/deep-review` เพื่อวิเคราะห์โครงสร้าง

1. รัน tree command ดู directory structure
2. รัน ast-grep outline ดู structure ภายในไฟล์
3. วิเคราะห์ findings (SRP violations, tight coupling)
4. ตรวจสอบ file patterns และ naming conventions

### 4. Architecture Analysis

วิเคราะห์ architecture และ design patterns

1. ทำ `/deep-review` ระบุ architectural pattern
2. วิเคราะหา data flow ด้วย `Grep`
3. ระบุ design patterns ที่ใช้
4. ตรวจสอบ adherence ต่อ architecture principles
5. วิเคราะหา coupling และ cohesion

### 5. Features Analysis

ทำ `/deep-review` เพื่อวิเคราะห์ features

1. Discovery และ inventory features ทั้งหมด
2. Categorize และ group features
3. Document features ในรูปแบบ systematic
4. Validate และ review features

### 6. Code Quality Analysis

วิเคราะห์ code quality อย่างละเอียด

1. ทำ `/use-ast-grep` หา patterns, anti-patterns, design patterns
2. หา code smells ด้วย `Grep` multiline mode
3. ทำ `/use-scripts` คำนวณ metrics (complexity, coupling, cohesion)
4. ตรวจสอบ naming conventions
5. ทำ `/check-duplication`, `/check-unused-files`, `/check-unused-deps` แบบ parallel
6. ตรวจหา hardcoded secrets ด้วย `Grep`

### 7. Dependencies And Tech Stack

วิเคราะห์ dependencies และ tech stack

1. อ่าน manifest files แบบ parallel
2. ระบุ tech stack และ versions
3. วิเคราะหา dependency graph
4. ตรวจสอบ outdated dependencies
5. วิเคราะหา security vulnerabilities ด้วย `/check-vulnerability`

### 8. Performance And Security

วิเคราะห์ performance และ security

1. วิเคราะหา performance bottlenecks
2. ตรวจสอบ security vulnerabilities
3. วิเคราะหา error handling และ resilience
4. ตรวจสอบ caching strategies
5. วิเคราะหา database queries ถ้ามี

### 9. External Research

ทำ `/deep-research` เพื่อค้นหา best practices

1. ค้นหา best practices สำหรับ tech stack ที่ใช้
2. ค้นหา alternatives ที่ดีกว่าสำหรับ dependencies
3. ค้นหา official documentation สำหรับ tools/libraries
4. เปรียบเทียบ findings กับ project ปัจจุบัน
5. ระบุ gaps ระหว่าง current implementation และ best practices

### 10. Comprehensive Report

สร้างรายงานครบถ้วน

1. ทำ `/report` สร้างตารางจัดกลุ่มตามหมวดหมู่
2. ให้ recommendations ตาม priority และ impact
3. ระบุ action items ที่ชัดเจน
4. สร้าง roadmap สำหรับ improvements

## Rules

### 1. Analysis Depth

วิเคราะห์อย่างละเอียดและครบถ้วน

- ใช้ `/deep-thinking` ก่อนเริ่มเสมอ
- ใช้ `/scan-codebase` สำหรับ quick overview
- ใช้ workflows เฉพาะทางสำหรับแต่ละมิติ
- ใช้ `/deep-research` สำหรับ external validation
- ไม่ข้ามขั้นตอน analysis ใดๆ

### 2. Tool Selection

เลือก tools ที่เหมาะสมกับแต่ละมิติ

- **Structure**: `/deep-review`, tree command, ast-grep outline
- **Architecture**: `/deep-review`, `Grep`, `/use-ast-grep`
- **Features**: `/deep-review`
- **Code Quality**: `/use-ast-grep`, `Grep`, `/use-scripts`, check workflows
- **Dependencies**: manifest files, `/check-vulnerability`
- **Research**: `/deep-research`, DeepWiki, Context7, WebSearch

### 3. Parallel Processing

ประมวลผลแบบ parallel เพื่อความเร็ว

- อ่าน manifest files พร้อมกัน
- รัน checks หลายอย่างพร้อมกัน
- รัน `Grep` patterns พร้อมกัน
- รัน ast-grep patterns พร้อมกัน

### 4. Metric Thresholds

กำหนด thresholds สำหรับ code quality

- Long functions: > 50 lines
- Deep nesting: > 3 levels
- High complexity: cyclomatic complexity > 10
- Large files: > 300 lines
- High coupling: > 7 dependencies
- Low cohesion: < 0.3

### 5. Research Validation

ตรวจสอบความถูกต้องของ external research

- ใช้ multiple sources สำหรับ validation
- ตรวจสอบ credibility ของ sources
- เปรียบเทียบกับ project context
- ระบุ assumptions ที่ใช้ใน research

### 6. Report Quality

สร้างรายงานที่มีคุณภาพและนำไปปฏิบัติได้

- จัดกลุ่ม findings ตามหมวดหมู่
- ให้ recommendations ตาม priority และ impact
- ระบุ action items ที่ชัดเจน
- สร้าง roadmap สำหรับ improvements
- ใช้ `/report-format-table` สำหรับ structured output

## Expected Outcome

- เข้าใจ architecture และ design patterns ที่ใช้
- ระบุ code quality issues พร้อม severity
- ระบุ features ทั้งหมดและ dependencies
- ระบุ tech stack และ outdated dependencies
- ระบุ performance และ security issues
- ระบุ gaps ระหว่าง current implementation และ best practices
- Recommendations สำหรับ improvements ตาม priority และ impact
- Roadmap สำหรับ improvements ที่ชัดเจน
