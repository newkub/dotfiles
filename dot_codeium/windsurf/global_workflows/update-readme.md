---
title: Update README Workflow
description: อัพเดท README.md ให้มีโครงสร้างและเนื้อหาที่สมบูรณ์ตามมาตรฐาน
auto_execution_mode: 3
follow:
- "/follow-workflows-template"
---

## Prompt

ใช้ workflow นี้เมื่อต้องการอัพเดท README.md ให้มีโครงสร้างและเนื้อหาที่สมบูรณ์ตามมาตรฐานที่กำหนด

## Purpose

กำหนดมาตรฐานการเขียน README.md สำหรับ Wrikka Platform:
- **โครงสร้างสม่ำเสมอ** — ทุก README ใช้ sections เดียวกัน
- **เนื้อหาครบถ้วน** — ครอบคลุม Introduction ถึง License
- **Template ที่ใช้งานได้จริง** — มี code block สำหรับ Root และ Package
- **ภาษาอังกฤษเข้าใจง่าย** — สื่อสารชัดเจนกับ developer ทุกระดับ

## Rules

- Root README: ต้องมีหัวข้อ Introduction, Problems, Solutions, Features, Packages Overview, Contributing, License
- Package README: ต้องมีหัวข้อ Introduction, Problems, Solutions, Features, Installation, Usage, Use Cases, Configuration, API Reference, Changelog, License
- เนื้อหาต้องเป็นภาษาอังกฤษและเข้าใจง่าย
- ต้องอัพเดทข้อมูลให้เป็นปัจจุบันเสมอ
- ต้องมีตัวอย่างการใช้งานที่ชัดเจน
- โครงสร้างต้องสอดคล้องกับ project จริง

## Execute

1. check : ตรวจสอบสถานะ README.md ปัจจุบัน
   - อ่านไฟล์ README.md ปัจจุบัน
   - ตรวจสอบว่ามีโครงสร้างตามที่กำหนดหรือไม่
   - ตรวจสอบว่าเนื้อหาเป็นปัจจุบันหรือไม่

2. analyze : วิเคราะห์โครงสร้างโปรเจกต์และเนื้อหาที่ต้องการ
   - ตรวจสอบโครงสร้าง apps/ และ packages/
   - วิเคราะห์ dependencies ที่ใช้จริง
   - ตรวจสอบว่ามี application อะไรบ้างที่ต้องอธิบาย

3. action : อัพเดทเนื้อหา README.md พร้อมใช้ template ที่กำหนด
   - เขียน Introduction ที่อธิบายโปรเจกต์ชัดเจน
   - อธิบาย Problems ที่โปรเจกต์แก้ไข
   - อธิบาย Solutions และ Features ที่มี
   - เขียน Installation พร้อมตัวอย่างคำสั่งติดตั้ง
   - เขียน Usage พร้อมตัวอย่างการใช้งาน Basic และ Advanced
   - เขียน Use Cases อย่างน้อย 2 สถานการณ์
   - เขียน Configuration เป็น table format
   - เขียน API Reference แบบ grouping by function type
   - เพิ่ม License section (MIT)
   - Template สำหรับ Root README (Monorepo):

      ```markdown
      # {Project Name}

      ## Introduction

      {1-2 sentences describing what this project is}

      ## Problems

      - Problem 1
      - Problem 2
      - Problem 3

      ## Solutions

      {How this project solves the problems}

      ## Features

      - Feature 1
      - Feature 2
      - Feature 3

      ## Packages Overview

      | Package | Description | Version | Tags |
      |---------|-------------|---------|------|
      | [pkg1](./packages/pkg1) | Description | 1.0.0 | `tag1`, `tag2` |
      | [pkg2](./packages/pkg2) | Description | 1.0.0 | `tag3` |

      ## Contributing

      {How to contribute guidelines}

      ## License

      MIT
      ```
   - Template สำหรับ Package README (Workspace):

      ```markdown
      # {Package Name}

      ## Introduction

      {What this package does}

      ## Problems

      - Problem this package solves

      ## Solutions

      {How this package solves it}

      ## Features

      - Feature 1
      - Feature 2
      - Feature 3

      ## Installation

      ```bash
      bun install {package-name}
      ```

      ## Usage

      ### Basic

      ```typescript
      import { something } from '{package-name}';

      // Basic usage example
      const result = something();
      ```

      ### Advanced

      ```typescript
      import { advanced } from '{package-name}';

      // Advanced usage with options
      const result = advanced({
        option: 'value'
      });
      ```

      ## Use Cases

      ### Use Case 1: {Scenario name}

      {Description of when to use this}

      ```typescript
      import { feature } from '{package-name}';

      // Implementation for this use case
      const result = feature({
        specificOption: 'value'
      });
      ```

      ### Use Case 2: {Another scenario}

      {Description}

      ```typescript
      // Code example
      ```

      ## Configuration

      | Option | Type | Default | Description |
      |--------|------|---------|-------------|
      | option1 | string | 'default' | Description |
      | option2 | boolean | true | Description |

      ## API Reference

      ### Core Functions

      | Function | Params | Returns | Description |
      |----------|--------|---------|-------------|
      | `functionName` | - | `ReturnType` | Description |
      | | `param: Type` | | Parameter description |
      | | `options: Options` | | Options description |

      ### Utility Functions

      | Function | Params | Returns | Description |
      |----------|--------|---------|-------------|
      | `anotherFn` | - | `Result` | Description |
      | | `input: string` | | Input parameter |

      ## Changelog

      See [CHANGELOG.md](./CHANGELOG.md) for release history.

      ## License

      MIT
      ```

4. validate : ตรวจสอบความถูกต้องของเนื้อหา
   - ตรวจสอบว่าโครงสร้างตามที่กำหนด
   - ยืนยันว่าตัวอย่างการใช้งานถูกต้อง
   - ตรวจสอบว่าไม่มีข้อมูลที่ผิดพลาด

5. verify : ยืนยันผลลัพธ์สุดท้าย
   - ตรวจสอบว่า README.md อัพเดทสำเร็จ
   - ยืนยันว่าเนื้อหาสอดคล้องกับโปรเจกต์จริง
   - ตรวจสอบว่ารูปแบบ markdown ถูกต้อง

6. review : ทบทวนผลลัพธ์และกระบวนการเพื่อความมั่นใจ
   - ตรวจสอบอีกครั้งว่าทุกอย่างถูกต้อง
   - ยืนยันว่าไม่มีปัญหาที่ถูกมองข้าม
   - ตรวจสอบว่า workflow ทำงานได้ตามที่คาดหวัง

## Expected Outcome

README.md ที่อัพเดทแล้ว:
- ใช้โครงสร้างตามมาตรฐานที่กำหนด
- มีเนื้อหาครบถ้วนตั้งแต่ Introduction ถึง License
- มีตัวอย่างการใช้งานที่ชัดเจนและถูกต้อง
- สอดคล้องกับโครงสร้างโปรเจกต์จริง
- เขียนด้วยภาษาอังกฤษที่เข้าใจง่าย
