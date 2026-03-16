---
title: improve-naming
description: ปรับปรุงชื่อไฟล์ โฟลเดอร์ และตัวแปรให้ตรงตาม conventions และสื่อความหมายชัดเจน
auto_execution_mode: 3
file-patterns:
  - "**/*"
---

## Purpose

ปรับปรุง naming conventions ทั้งหมดในโปรเจกต์ให้:

- ตรงตามมาตรฐาน conventional ที่เหมาะสม
- สื่อความหมายชัดเจน ไม่กำกวม
- มีความสอดคล้องกันในทุกส่วนของโปรเจกต์
- 1 file = 1 single responsibility

## Scope

ใช้สำหรับ:

- ตรวจสอบและปรับปรุงชื่อไฟล์
- ตรวจสอบและปรับปรุงชื่อโฟลเดอร์
- ตรวจสอบและปรับปรุงชื่อตัวแปร/ฟังก์ชัน
- ตรวจสอบ single responsibility ของแต่ละไฟล์

## Inputs

| Input | Details |
|-------|-----------|
| Target Directory | Directory to be reviewed |
| Naming Convention | Standard to use (kebab-case, camelCase, PascalCase) |
| File Patterns | File patterns to be reviewed |

## Rules

### Naming Convention Standards

| Type | Convention | Example |
|--------|-----------|---------|
| **General Files** | kebab-case | `my-file.ts`, `user-service.ts` |
| **React Components** | PascalCase | `MyComponent.tsx`, `UserCard.tsx` |
| **Folders** | kebab-case | `utils/`, `user-management/` |
| **Variables** | camelCase | `userName`, `totalCount` |
| **Constants** | UPPER_SNAKE_CASE | `MAX_RETRY`, `API_BASE_URL` |
| **Functions** | camelCase | `getUserData()`, `handleSubmit()` |
| **Classes/Interfaces** | PascalCase | `UserService`, `ApiResponse` |
| **Test Files** | .test.ts or .spec.ts | `utils.test.ts`, `helpers.spec.ts` |
| **Type Files** | .types.ts | `user.types.ts` |
| **Config Files** | Literal name | `tsconfig.json`, `.eslintrc.js` |

### Single Responsibility Rules

| Criteria | Description |
|-------|---------|
| **1 File = 1 Purpose** | Each file has a single clear purpose |
| **Max 300 Lines** | Split if exceeds |
| **Max 10 Exports** | Refactor into module if exceeds |
| **Cohesive** | Everything in file is related |

### Language Standards

| Aspect | Requirement |
|--------|-------------|
| **Headings** | All headings must be in English |
| **Content** | All content in Thai with English loanwords for clarity (e.g., naming, convention, refactor), except code which must be in English |
| **Table Headers** | Use English for table column headers |
| **Technical Terms** | Use English loanwords for technical terms (e.g., directory, export, import, build, test) |

## Structure

### Directory Structure (Example)

```text
project/
├── src/
│   ├── components/           # React/Vue components (PascalCase files)
│   ├── utils/                # Utility functions (kebab-case files)
│   ├── services/             # Business logic services
│   ├── types/                # Type definitions
│   └── constants/            # Constants
├── tests/                    # Test files (.test.ts)
├── docs/                     # Documentation
└── config/                   # Configuration files
```

### File Categories by Naming

| Category | Pattern | Example |
|---------|---------|---------|
| Components | `PascalCase.tsx` | `UserCard.tsx` |
| Utilities | `kebab-case.ts` | `date-utils.ts` |
| Types | `*.types.ts` | `user.types.ts` |
| Tests | `*.test.ts` | `utils.test.ts` |
| Config | Literal name | `vite.config.ts` |

## Steps

### Phase 1: Setup

- 1.1 **เตรียม Context**
  - อ่าน global rules ของโปรเจกต์
  - ตรวจสอบว่ามี naming conventions ที่กำหนดไว้หรือไม่
  - ยืนยันสิทธิ์ในการ rename files

- 1.2 **กำหนด Scope**
  - ระบุ directory ที่ต้องการตรวจสอบ
  - กำหนด file patterns ที่สนใจ
  - วางแผนลำดับการตรวจสอบ

### Phase 2: Research

- 2.1 **ศึกษา Conventions**
  - อ่านไฟล์ที่มีอยู่เพื่อเข้าใจ patterns ปัจจุบัน
  - หา conventions ที่ใช้แล้วสม่ำเสมอ
  - จดบันทึก inconsistencies ที่พบ

- 2.2 **วิเคราะห์ File Purposes**
  - อ่านแต่ละไฟล์เพื่อเข้าใจหน้าที่
  - ระบุไฟล์ที่มีหลาย responsibility
  - ทำรายการไฟล์ที่ต้อง refactor

### Phase 3: Analyze

- 3.1 **ตรวจสอบชื่อไฟล์**
  - ตรวจสอบว่าชื่อสื่อความหมายหรือไม่
  - ตรวจสอบ convention ที่ใช้
  - หาไฟล์ที่ชื่อคล้ายกันแต่ทำงานต่างกัน

- 3.2 **ตรวจสอบชื่อโฟลเดอร์**
  - ตรวจสอบโครงสร้างโฟลเดอร์
  - หาโฟลเดอร์ที่ชื่อไม่สื่อความหมาย
  - ตรวจสอบความสอดคล้องของโครงสร้าง

- 3.3 **ตรวจสอบ Single Responsibility**
  - นับจำนวน exports ในแต่ละไฟล์
  - นับจำนวนบรรทัด
  - ประเมินความเกี่ยวข้องของ code ในไฟล์

### Phase 4: Plan

- 4.1 **วางแผนการ Rename**
  - สร้างรายการไฟล์/โฟลเดอร์ที่ต้อง rename
  - กำหนดชื่อใหม่ที่เหมาะสม
  - ตรวจสอบว่าชื่อใหม่ไม่ซ้ำ

- 4.2 **วางแผนการ Refactor**
  - หาไฟล์ที่ต้องแยกเป็น 2+ ไฟล์
  - วางแผนการย้าย functions/classes
  - กำหนดลำดับการ refactor

- 4.3 **วางแผนการอัพเดท References**
  - หาไฟล์ที่ import/ reference ไฟล์ที่จะ rename
  - วางแผนการอัพเดท paths
  - ตรวจสอบ circular dependencies

### Phase 5: Execute

- 5.1 **Rename Files/Folders**
  - 5.1.1 Rename ตามรายการที่วางแผน
  - 5.1.2 อัพเดท imports ในไฟล์ที่ affected
  - 5.1.3 อัพเดท config files (tsconfig, vite, etc.)

- 5.2 **Refactor Multi-Responsibility Files**
  - 5.2.1 ใช้ `/refactor-files` ถ้าไฟล์มีหลาย responsibility
  - 5.2.2 แยกไฟล์ตามหน้าที่
  - 5.2.3 สร้าง barrel exports ถ้าจำเป็น

- 5.3 **อัพเดท Documentation**
  - 5.3.1 อัพเดท README ถ้ามีการเปลี่ยนโครงสร้าง
  - 5.3.2 อัพเดท comments ที่ reference ชื่อเก่า
  - 5.3.3 อัพเดท docs อื่นๆ ที่เกี่ยวข้อง

### Phase 6: Verify

- 6.1 **ตรวจสอบการทำงาน**
  - 6.1.1 รัน build/compile เพื่อตรวจสอบ errors
  - 6.1.2 รัน tests เพื่อตรวจสอบว่าไม่พัง
  - 6.1.3 ตรวจสอบ imports ทั้งหมดถูกต้อง

- 6.2 **ตรวจสอบ Naming**
  - 6.2.1 ตรวจสอบว่าทุกชื่อตรงตาม conventions
  - 6.2.2 ตรวจสอบว่าไม่มีชื่อซ้ำ
  - 6.2.3 ตรวจสอบว่าชื่อสื่อความหมาย

- 6.3 **ตรวจสอบ References**
  - 6.3.1 ตรวจสอบว่า paths ทั้งหมดถูกต้อง
  - 6.3.2 ตรวจสอบว่าไม่มี broken links
  - 6.3.3 ตรวจสอบว่า imports ทำงานได้

### Phase 7: Review

- 7.1 **Review คุณภาพ**
  - 7.1.1 ตรวจสอบว่าชื่อใหม่ดีกว่าเดิม
  - 7.1.2 ตรวจสอบว่าโครงสร้างชัดเจนขึ้น
  - 7.1.3 ตรวจสอบว่า maintain ง่ายขึ้น

- 7.2 **Consistency Check**
  - 7.2.1 ตรวจสอบว่า conventions สม่ำเสมอทั้งโปรเจกต์
  - 7.2.2 ตรวจสอบว่าไม่มีการใช้ conventions ผสม
  - 7.2.3 ตรวจสอบว่า patterns ใช้ consistently

### Phase 8: Finalize

- 8.1 **สรุปผล**
  - 8.1.1 สร้างรายการสิ่งที่เปลี่ยนแปลง
  - 8.1.2 บันทึก conventions ที่ใช้
  - 8.1.3 อัพเดท documentation ถ้าจำเป็น

- 8.2 **Commit Changes**
  - 8.2.1 ใช้ conventional commit message
  - 8.2.2 แยก commits ตามประเภทการเปลี่ยนแปลง
  - 8.2.3 รัน `/commit` เพื่อ commit ที่ถูกต้อง

## Outputs

| Output | Details |
|--------|-----------|
| Renamed Files | List of renamed files |
| Refactored Files | List of split/merged files |
| Updated References | List of files with updated imports |
| Conventions Doc | Document of conventions used |

## Expected Outcome

หลังจากทำตาม workflow นี้:

- ✅ ทุกชื่อไฟล์สื่อความหมายและตรงตาม conventions
- ✅ ทุกชื่อโฟลเดอร์สื่อความหมายและตรงตาม conventions
- ✅ แต่ละไฟล์มี single responsibility ชัดเจน
- ✅ โครงสร้างโปรเจกต์สม่ำเสมอและ maintain ง่าย
- ✅ ไม่มี broken imports หรือ references
- ✅ Build และ tests ผ่านทั้งหมด

## Reference

- `/write-workflows` - มาตรฐานการเขียน workflow
- `/review-structure` - การตรวจสอบโครงสร้าง
- `/refactor-files` - การ refactor ไฟล์
- `/commit` - การ commit ตาม conventions
