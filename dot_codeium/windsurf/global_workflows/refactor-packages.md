---
title: Refactor Packages
description: Refactor packages ตาม SRP และแนะนำ packages จาก workspace
auto_execution_mode: 3
related:
  - /analyze-project
  - /dont-over-engineer
  - /plan
  - /use-or-refactor-to-modules
  - /restructure
  - /relocation
  - /rename
  - /all-workspaces
  - /run-check
  - /run-test
  - /check-circular-dependencies
  - /check-duplication
  - /update-reference
  - /edit-relative
---

## Goal

Refactor packages ให้มี single responsibility ตาม SRP และแนะนำ packages จาก workspace ที่เหมาะสมกับโปรเจกต์

## Scope

ใช้กับ monorepo หรือ project ที่มี packages หลายตัว โดยประเมินว่าควร split/merge/relocate packages หรือไม่ วิเคราะห์ cohesion, change frequency, deployment boundaries และแนะนำ packages ที่ควรนำมาใช้

## Execute

### 1. Analyze Current Project

วิเคราะห์โปรเจกต์ก่อนตัดสินใจ

> Goal: รู้ว่า project เป็นอะไร ใช้อะไร และมี packages อะไร

1. อ่าน `package.json`, `Cargo.toml`, `bun.lock`, หรือ manifest ที่เกี่ยวข้อง
2. ระบุภาษา, framework, project type, และ workspace layout
3. วิเคราะห์ dependencies ทั้งหมด (ภายใน/ภายนอก) และจุดประสงค์ของแต่ละ package
4. ทำ `/analyze-project` เพื่อดูภาพรวม

### 2. Evaluate Package Cohesion

ประเมินว่า package ต่างๆ มี SRP หรือไม่

> Goal: หา packages ที่ violate SRP หรือ over-coupled

1. สร้างตาราง package: ชื่อ, ไฟล์, top-level symbols, imports/exports, จำนวน consumer
2. ตรวจสอบ cognitive complexity, navigability, และ test setup ความยาก
3. ระบุ reasons to change ของแต่ละ package (ควรมีหนึ่งเหตุผล)
4. ตรวจ coupling ระหว่าง concerns ภายใน package และ dependencies ที่ไม่จำเป็น
5. วิเคราะห์ change patterns: แต่ละส่วนเปลี่ยนพร้อมกันหรือไม่, maintain โดยทีมเดียวกัน, release lifecycle เดียวกัน

### 3. Assess Refactor Necessity

ตัดสินใจว่าควร refactor หรือไม่

> Goal: ไม่ refactor โดยใช้เหตุผลชัดเจน

1. ทำ `/dont-over-engineer` เพื่อกำหนดขอบเขต
2. เครื่องหมาย refactor: หลาย reasons to change, test ยาก, coupling สูง, ไม่ reusable, dependencies เกิน
3. เครื่องหมายไม่ refactor: single responsibility ชัด, ยาวแต่ cohesive, เปลี่ยนด้วยกันเสมอ, refactor ทำลาย stability
4. พิจารณา deployment/versioning boundary: concerns ที่ deploy ร่วมกันควรอยู่ด้วยกันถ้าแยกไม่มีประโยชน์

### 4. Plan Refactor

วางแผนการ split/merge/relocate packages

> Goal: แผน minimal ที่กระทบน้อยที่สุด

1. ทำ `/plan` เพื่อสร้างแผน split, extract, merge, หรือ relocate
2. ใช้ `/use-or-refactor-to-modules` สำหรับ packages ที่ยังแยกย่อยได้ในระดับ module
3. ระบุ consumers ทั้งหมดและ public API ที่จะกระทบ
4. กำหนดลำดับงาน: เริ่มจาก leaf packages ที่ไม่มี dependents

### 5. Refactor Packages

ดำเนินการ restructure packages ตามแผน

> Goal: ทุก package มี single responsibility ชัดเจน

1. split/merge packages ตาม domain concern
2. ใช้ `/restructure` หรือ `/relocation` เมื่อต้องย้ายไฟล์ระหว่าง packages
3. ใช้ `/rename` เมื่อต้องเปลี่ยนชื่อ package หรือ identifier
4. ลบ dependencies ที่ไม่จำเป็น
5. สร้าง abstractions เมื่อจำเป็นและลด coupling

### 6. Scan and Recommend Workspace Packages

สำรวจ packages ใน workspace และแนะนำที่เหมาะสม

> Goal: แนะนำ packages ที่แก้ปัญหา, ลด duplication, หรือปรับปรุง DX

1. parallel: ทำ `/all-workspaces` สำรวจ workspace ทั้งหมด ∥ อ่าน `package.json` หรือ `Cargo.toml` ของแต่ละ package
2. จัดกลุ่ม packages: UI Components, Utilities, Frameworks, Libraries, Tools, Integrations
3. สำหรับแต่ละ package ประเมิน: ภาษา/เข้ากันได้, stability, maintenance, documentation, adoption
4. จัดลำดับความสำคัญ: Critical (แก้ปัญหา/ความปลอดภัย), High (ลด duplication/ประสิทธิภาพ), Medium (DX), Low (nice-to-have)
5. ระบุ installation, usage, trade-offs, breaking changes

### 7. Verify Refactor Impact

ตรวจสอบว่า packages ยังทำงานได้และดีขึ้น

> Goal: ไม่มี regression, circular dependency, หรือ fragmentation

1. parallel: ทำ `/run-check` สำหรับ lint/typecheck ∥ ทำ `/run-test` สำหรับ regression
2. ทำ `/check-circular-dependencies` และ `/check-duplication`
3. ประเมินว่า package ดีขึ้นหรือไม่: cohesion, coupling, consumer ใช้งานได้
4. ถ้าไม่ผ่าน → กลับไปแก้ที่ Step 4-5 (สูงสุด 3 ครั้ง → stop/report)

### 8. Update References and Report

อัปเดท references และสรุปผล

> Goal: ไม่มี broken references และมีรายงานชัดเจน

1. ทำ `/update-reference` เพื่ออัปเดท `package.json`, imports, path aliases, tsconfig, AGENTS.md, .devin/rules
2. ทำ `/edit-relative` สำหรับ relative paths ที่เปลี่ยน
3. สร้างรายงาน: ตาราง Before/After (package, reason to change, dependencies, consumer count, SRP status), actions ที่ทำ, recommendations, TODO ถ้ามี

## Rules

### 1. Cohesion Over Separation

- ไม่ split packages เพื่อ conceptual purity อย่างเดียว
- รวม code ที่ change, deploy, test, และเข้าใจด้วยกัน
- หลีกเลี่ยง fragmentation ที่เพิ่ม cognitive load

### 2. Refactor Signals

Refactor เมื่อ:

- หลาย reasons to change
- test ยากเพราะ concerns ปน
- coupling สูง
- ไม่ reusable
- dependencies ไม่จำเป็น

### 3. No-Refactor Signals

ไม่ refactor เมื่อ:

- single responsibility ชัด
- ยาวแต่ cohesive
- เปลี่ยนด้วยกันเสมอ
- ทำลาย stability หรือเพิ่ม fragmentation

### 4. Appropriate Coupling

- ใช้ abstractions เมื่อจำเป็นจริง
- ไม่ lock implementation โดยไม่จำเป็น
- interfaces ชัดเจน
- dependencies ชัดเจนและจำเป็น

### 5. Avoid Over-Refactoring

- ไม่สร้าง micro-packages
- ไม่สร้าง abstractions ที่ไม่ใช้
- ไม่เพิ่ม dependency graph depth โดยไม่ได้ผล
- ไม่ส่ง dependencies จำนวนมากข้าม packages

### 6. Verification Required

- ต้องทำ `/analyze-project` ก่อนและหลัง
- ต้องผ่าน `/run-check` และ `/run-test`
- ต้องอัปเดท `/update-reference` หลังทุกครั้งที่ restructure

## Expected Outcome

- Packages มี single responsibility ชัดเจน
- Dependencies ชัดเจน ไม่มี circular
- ผ่าน lint, typecheck, test
- รายงาน recommendations จัดลำดับตาม priority
- รายงาน Before/After ของ SRP metrics และ actions ที่ทำ
