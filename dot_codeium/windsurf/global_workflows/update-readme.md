---
title: Update README
description: อัพเดท README.md ทุก workspace ให้มีรูปแบบที่สอดคล้องกัน
type: workflow
version: 1.0.0
auto_execution_mode: 3
file-patterns:
  - "**/README.md"
  - "**/readme.md"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/write-workflows"
    - "/follow-readme-monorepo"
    - "/follow-readme-apps"
    - "/follow-readme-packages"
---

## Purpose

อัพเดท README.md ทุก workspace ให้มีรูปแบบและข้อมูลที่สอดคล้องกัน

## Scope

ใช้สำหรับ:

- ตรวจสอบ README.md ในทุก workspace
- อัพเดท README.md ที่ว่างหรือไม่สมบูรณ์
- ใช้รูปแบบมาตรฐานสำหรับทุก README.md
- ตรวจสอบความถูกต้องของข้อมูลและ commands

## Inputs

| Input | Details |
|-------|---------|
| Workspaces | รายการ workspaces ที่ต้องอัพเดท |
| Structure | โครงสร้าง monorepo (apps/, packages/) |
| Standards | รูปแบบมาตรฐานที่ต้องการ |

## Rules

### Check Rules

| Category | Requirements |
|----------|--------------|
| **Main README** | ตรวจสอบ README.md หลักของ workspace |
| **Apps** | ตรวจสอบ README.md ใน apps/ ทุกตัว |
| **Packages** | ตรวจสอบ README.md ใน packages/ ทุกตัว |
| **List** | สร้างรายการ README.md ที่ต้องอัพเดท |

### Update Rules

| Category | Requirements |
|----------|--------------|
| **Main** | ใช้ `/follow-readme-monorepo` สำหรับ README.md หลัก |
| **Apps** | ใช้ `/follow-readme-apps` สำหรับแต่ละ app |
| **Packages** | ใช้ `/follow-readme-packages` สำหรับแต่ละ package |
| **Completeness** | ตรวจสอบข้อมูลครบถ้วนในแต่ละส่วน |

## Structure

### Directory Structure

```text
workspace/
├── README.md              # Main workspace README
├── apps/
│   ├── app1/
│   │   └── README.md      # App-specific README
│   └── app2/
│       └── README.md
└── packages/
    ├── pkg1/
    │   └── README.md      # Package-specific README
    └── pkg2/
        └── README.md
```

## Steps

### Phase 1: Setup

- 1.1 **เตรียม Context**
  - อ่าน `/write-workflows` เพื่อเข้าใจมาตรฐาน
  - ตรวจสอบโครงสร้าง workspaces
  - ยืนยัน target directories

- 1.2 **กำหนด Scope**
  - ระบุ workspaces ที่ต้องอัพเดท
  - กำหนดรูปแบบมาตรฐาน
  - วางแผนลำดับการอัพเดท

### Phase 2: Research

- 2.1 **ศึกษา Reference**
  - อ่าน `/follow-readme-monorepo` workflow
  - อ่าน `/follow-readme-apps` workflow
  - อ่าน `/follow-readme-packages` workflow

- 2.2 **รวบรวมข้อมูล**
  - รวบรวมข้อมูล apps ทั้งหมด
  - รวบรวมข้อมูล packages ทั้งหมด
  - บันทึก dependencies และ relationships

### Phase 3: Analyze

- 3.1 **วิเคราะห์โครงสร้าง**
  - ตรวจสอบ README.md หลัก
  - ตรวจสอบ README.md ใน apps/
  - ตรวจสอบ README.md ใน packages/
  - สร้างรายการที่ต้องอัพเดท

- 3.2 **ระบุ Gaps**
  - หา README.md ที่ขาดหาย
  - หา README.md ที่ไม่สมบูรณ์
  - หา README.md ที่ไม่ตรงมาตรฐาน

### Phase 4: Plan

- 4.1 **วางแผนอัพเดท**
  - กำหนดลำดับการอัพเดท (Main → Apps → Packages)
  - วางแผน content สำหรับแต่ละ README.md
  - เตรียม templates ที่จำเป็น

### Phase 5: Execute

- 5.1 **อัพเดท Main README**
  - ใช้ `/follow-readme-monorepo` สำหรับ README.md หลัก
  - ตรวจสอบว่าสร้างเสร็จแล้ว
  - ตรวจสอบข้อมูล packages และ apps ครบถ้วน

- 5.2 **อัพเดท Apps**
  - ใช้ `/follow-readme-apps` สำหรับแต่ละ app
  - ตรวจสอบว่า README.md ของแต่ละ app สร้างเสร็จแล้ว
  - ตรวจสอบข้อมูลเฉพาะของแต่ละ app ครบถ้วน

- 5.3 **อัพเดท Packages**
  - ใช้ `/follow-readme-packages` สำหรับแต่ละ package
  - ตรวจสอบว่า README.md ของแต่ละ package สร้างเสร็จแล้ว
  - ตรวจสอบข้อมูลเฉพาะของแต่ละ package ครบถ้วน

### Phase 6: Verify

- 6.1 **ตรวจสอบรูปแบบ**
  - ตรวจสอบว่าทุก README.md มีรูปแบบที่สอดคล้องกัน
  - ตรวจสอบว่าทุก README.md มีข้อมูลครบถ้วน
  - ตรวจสอบ formatting เป็นมาตรฐาน

- 6.2 **ตรวจสอบ Content**
  - ตรวจสอบว่า commands ทั้งหมดถูกต้อง
  - ตรวจสอบว่า examples ทั้งหมดใช้งานได้จริง
  - ตรวจสอบ links และ references

### Phase 7: Review

- 7.1 **ตรวจสอบคุณภาพ**
  - อ่านทวนเนื้อหาทั้งหมด
  - ตรวจสอบความชัดเจนของภาษา
  - ตรวจสอบ formatting

### Phase 8: Finalize

- 8.1 **สรุปผลงาน**
  - สรุปรายการ README.md ที่อัพเดท
  - ยืนยันความสมบูรณ์

## Outputs

| Output | Details |
|--------|---------|
| Updated READMEs | รายการ README.md ที่อัพเดท |
| Consistency | รูปแบบสอดคล้องกัน |
| Completeness | ข้อมูลครบถ้วน |

## Expected Outcome

- ทุก README.md มีรูปแบบที่กำหนด
- ข้อมูลใน README.md ครบถ้วนและถูกต้อง
- Commands และ examples ทำงานได้จริง
- รูปแบบสอดคล้องกันในทุก workspace

## Reference

- `/follow-readme-monorepo` - สำหรับ README.md หลัก
- `/follow-readme-apps` - สำหรับ apps
- `/follow-readme-packages` - สำหรับ packages
- `/write-workflows` - มาตรฐานการเขียน workflow
- `@write-markdown` - แนวทางการเขียน Markdown
