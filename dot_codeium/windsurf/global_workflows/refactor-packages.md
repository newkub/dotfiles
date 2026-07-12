---
title: Refactor Packages
description: Refactor packages ให้มี single responsibility และแนะนำ packages ที่เหมาะสม
auto_execution_mode: 3
related:
  - /refactor-modules
  - /edit-relative
  - /follow-code-quality
---

## Goal

Refactor packages ให้มี single responsibility ตาม SRP และแนะนำ packages ที่เหมาะสมกับโปรเจกต์

## Scope

ครอบคลุมการตัดสินใจว่าควร refactor packages หรือไม่, ประเมิน cohesion, change frequency, deployment boundaries, และแนะนำ packages จาก workspace ที่ควรนำมาใช้

## Execute

### 1. Analyze Current Project

วิเคราะห์โปรเจกต์ปัจจุบัน

1. อ่าน `package.json`, `Cargo.toml`, หรือไฟล์จัดการ dependencies ที่เกี่ยวข้อง
2. วิเคราะห์ dependencies ที่มีอยู่ในโปรเจกต์ปัจจุบัน
3. ระบุประเภทโปรเจกต์ (web, backend, desktop, mobile, library, etc.)
4. ระบุภาษาและ framework ที่ใช้

### 2. Evaluate Package Complexity

ประเมินว่า package ซับซ้อนเกินไปหรือไม่

1. ทำ `/analyze-project` เพื่อดูภาพรวมโปรเจกต์
2. ตรวจสอบ cognitive complexity และ navigability ของ package
3. ระบุ reasons to change ที่หลากหลาย
4. ตรวจสอบ coupling ระหว่าง concerns ภายใน package
5. ประเมิน test setup complexity
6. ตรวจสอบ dependencies ที่ไม่จำเป็น

### 3. Analyze Change Patterns

วิเคราะห์ patterns การเปลี่ยนแปลงของ package

- ส่วนต่างๆ ของ package เปลี่ยนพร้อมกันหรือไม่
- ถูก maintain โดยทีมเดียวกันหรือไม่
- มี release lifecycle เดียวกันหรือไม่
- concerns เหล่านี้ evolve แยกกันหรือไม่
- ถูกใช้โดย packages อื่นด้วย patterns เดียวกันหรือไม่

### 4. Assess Refactor Necessity

ตัดสินใจว่าควร refactor หรือไม่

- Package มีหลาย reasons to change
- Package ยากต่อการ test เพราะ concerns ปนกัน
- Package มี coupling สูงระหว่าง concerns
- Package ไม่ appropriately coupled
- Package ยากต่อการ understand และ maintain
- Package มี dependencies ที่ไม่จำเป็น
- Package ไม่ reusable ตามที่ควรจะเป็น

### 5. Consider Deployment Boundaries

พิจารณา deployment และ versioning boundaries

- พิจารณา deployment boundary และ versioning strategy
- อย่าแยก concerns ที่ deploy ร่วมกันเสมอโดยไม่จำเป็น
- พิจารณาว่า concerns มี deployment cohesion หรือไม่
- พิจารณา semantic versioning impact

### 6. Plan Refactor Strategy

วางแผนการ refactor ถ้าจำเป็น

1. ทำ `/refactor-modules` เพื่อแยก modules ภายใน package
2. จัดลำดับ dependencies ระหว่าง packages ให้ชัดเจน
3. สร้าง abstractions เมื่อจำเป็นและ beneficial
4. วางแผน versioning strategy สำหรับ packages ใหม่

### 7. Scan Workspace Packages

สำรวจ packages ใน workspace

1. สำรวจโครงสร้าง workspace
2. อ่าน `package.json` หรือ `Cargo.toml` ของแต่ละ package
3. จัดกลุ่ม packages ตามประเภท:
   - UI Components
   - Utilities
   - Frameworks
   - Libraries
   - Tools
   - Integrations

### 8. Analyze Package Relevance

สำหรับแต่ละ package ใน workspace:

1. ตรวจสอบความเข้ากันได้กับโปรเจกต์:
   - ภาษาที่ใช้
   - Platform ที่รองรับ
   - Dependencies ที่ต้องการ
2. ประเมินประโยชน์:
   - ลด code duplication
   - เพิ่มประสิทธิภาพ
   - ปรับปรุง DX
3. ตรวจสอบสถานะ:
   - Version stability
   - Maintenance status
   - Documentation quality

### 9. Generate Recommendations

สร้างรายงานแนะนำ packages:

1. High Priority - Packages ที่ควรใช้ทันที:
   - แก้ปัญหาที่มีอยู่
   - ลด code duplication อย่างชัดเจน
   - เพิ่มประสิทธิภาพอย่างมีนัยสำคัญ

2. Medium Priority - Packages ที่ควรพิจารณา:
   - ปรับปรุง DX
   - เพิ่ม features ที่มีประโยชน์
   - มี trade-offs ที่ต้องพิจารณา

3. Low Priority - Packages ที่อาจไม่จำเป็น:
   - Over-engineering
   - ไม่เข้ากับ requirements
   - มี dependencies มากเกินไป

### 10. Verify Refactor Impact

ตรวจสอบผลกระทบของ refactor

1. ทำ `/run-test` เพื่อยืนยัน functionality
2. ทำ `/run-lint` เพื่อตรวจสอบ code quality
3. ประเมินว่า package ดีขึ้นหรือไม่
4. ตรวจสอบว่าไม่เกิด circular dependencies ระหว่าง packages
5. ประเมินว่าไม่เกิด fragmentation
6. ตรวจสอบว่า consumers ยังใช้งานได้

### 11. Update References

อัปเดท references ทั้งหมดที่เกี่ยวข้อง

1. ทำตาม `/edit-relative`
2. อัปเดท `package.json` dependencies
3. อัปเดท import paths ในทุก packages

## Rules

### 1. Cohesion First

Prefer high cohesion over artificial separation

- ไม่แยก packages เพื่อ conceptual purity เท่านั้น
- รวม code ที่ changes together, deploys together, tests together
- รวม code ที่ understood better together
- หลีกเลี่ยง fragmentation ที่เพิ่ม cognitive load
- พิจารณา dependency graph complexity

### 2. When To Refactor

Refactor เมื่อ:

- Package มีหลาย reasons to change
- Package ยากต่อการ test เพราะ concerns ปนกัน
- Package มี coupling สูงระหว่าง concerns
- Package ไม่ appropriately coupled
- Package ยากต่อการ understand
- Package มี dependencies ที่ไม่จำเป็น
- Package ไม่ reusable ตามที่ควรจะเป็น

### 3. When Not To Refactor

ไม่ refactor เมื่อ:

- Package มี single responsibility ชัดเจน
- Package ยาวแต่ cohesive สูง
- Package ไม่มีปัญหาในการ test
- Package changes together, deploys together
- Refactor จะทำลาย stability หรือเพิ่ม fragmentation
- Refactor จะเพิ่ม dependency graph complexity มากเกินไป

### 4. Appropriate Coupling

Package appropriately coupled เมื่อ:

- ใช้ abstractions เมื่อจำเป็นและ beneficial
- ไม่ lock implementation โดยไม่จำเป็น
- ใช้ language idioms อย่างเหมาะสม
- สามารถ isolate ได้เมื่อจำเป็น
- มี clear interfaces เมื่อจำเป็น
- Dependencies ระหว่าง packages ชัดเจนและจำเป็น

### 5. Over-Refactoring Signs

หลีกเลี่ยง over-refactoring เมื่อ:

- แยก packages เล็กเกินไป (micro-packages)
- สร้าง abstractions ที่ไม่จำเป็น
- เพิ่ม complexity โดยไม่ได้ผล
- แยกโดยไม่พิจารณา usage patterns
- สร้าง dependencies ที่ซับซ้อน
- แยกแล้วต้องส่ง dependencies เยอะ
- เพิ่ม dependency graph depth มากเกินไป

### 6. Monorepo Principles

หลักการสำหรับ monorepos

- Single Responsibility Principle (SRP) - one reason to change
- High Cohesion, Low Coupling
- Separation of Concerns
- Change Frequency Analysis
- Deployment Boundary Awareness
- Versioning Strategy Consistency
- Dependency Graph Manageability

### 7. Refactor Signals

ใช้ signals เหล่านี้เพื่อตัดสินใจ:

| Signal | Meaning | Refactor? |
|--------|---------|-----------|
| เปลี่ยนหลายเหตุผล | ต่ำ cohesion | ✅ |
| Test setup ยุ่ง | concern ปน | ✅ |
| แก้ bug แล้วกระทบหลายส่วน | coupling สูง | ✅ |
| แยกแล้ว import วน | boundary ผิด | ❌ |
| แยกแล้วต้องส่ง dependency เยอะ | over-splitting | ❌ |
| คนอ่านต้องเปิด 8 files | fragmentation | ❌ |
| ทุกอย่างเปลี่ยนพร้อมกันเสมอ | same lifecycle | ❌ |
| Dependencies วนกัน | circular deps | ❌ |
| Versioning ซับซ้อน | boundary ผิด | ❌ |

### 8. Analysis Criteria

ประเมิน packages ตามเกณฑ์:

- Relevance: เข้ากับโปรเจกต์และ requirements
- Compatibility: ใช้ภาษาและ platform เดียวกัน
- Stability: Version stable และมีการ maintain
- Documentation: มี docs ครบถ้วน
- Adoption: มีการใช้งานจริงใน workspace
- Maintenance: มีการอัพเดตสม่ำเสมอ

### 9. Prioritization

จัดลำดับความสำคัญ:

1. Critical - แก้ปัญหาร้ายแรงหรือ security issues
2. High - ลด duplication หรือเพิ่มประสิทธิภาพอย่างชัดเจน
3. Medium - ปรับปรุง DX หรือเพิ่ม features
4. Low - Nice-to-have หรือ future consideration

### 10. Documentation

รายงานต้องประกอบด้วย:

- ชื่อ package และ version
- คำอธิบายสั้นๆ
- เหตุผลที่แนะนำ
- วิธีการติดตั้ง
- วิธีการใช้งาน
- Trade-offs และ considerations
- Breaking changes (ถ้ามี)

### 11. Context Awareness

พิจารณา context ของโปรเจกต์:

- ขนาดโปรเจกต์ (small, medium, large)
- ทีมขนาด (individual, small team, large team)
- Timeline (MVP, production, maintenance)
- Constraints (performance, security, compliance)

### 12. Avoid Over-Engineering

ไม่แนะนำ packages ที่:

- ซับซ้อนเกินความจำเป็น
- มี dependencies มากเกินไป
- ไม่มี clear benefit
- ไม่มีการ maintain

## Expected Outcome

- Packages ที่มี single responsibility เมื่อจำเป็น
- Packages ที่ appropriately coupled
- High cohesion และ low coupling
- ไม่ over-refactor
- Code ที่ maintainable และ reusable
- Dependencies ที่ชัดเจน
- Dependency graph ที่จัดการได้
- Versioning strategy ที่สม่ำเสมอ
- รายงาน packages ที่ควรใช้แบ่งตาม priority
- คำแนะนำ integration ที่ชัดเจน
- การวิเคราะห์ trade-offs
- ตัวอย่างการใช้งาน
- คำแนะนำเกี่ยวกับ migration path

## Common Mistakes

- Refactor เมื่อไม่จำเป็น
- Over-refactor จนเกินไป
- ไม่พิจารณา change frequency
- แยกโดยไม่ดู usage patterns
- สร้าง abstractions ที่ไม่จำเป็น
- ไม่ verify ผลกระทบ
- แยกโดยไม่พิจารณา deployment boundaries
- ไม่พิจารณา versioning impact
- สร้าง circular dependencies

## Anti-Patterns

- ❌ Refactor ทุก package โดยไม่ประเมิน
- ❌ แยก packages เล็กเกินไป
- ❌ สร้าง abstractions ที่ไม่ใช้
- ❌ Refactor โดยไม่ดู impact
- ❌ แยก concerns ที่ operate ร่วมกัน
- ❌ ไม่ verify ด้วย tests
- ❌ ใช้ language idioms ผิด
- ❌ สร้าง dependency graph ที่ซับซ้อน
- ❌ ไม่พิจารณา versioning strategy
