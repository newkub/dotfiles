---
title: รัน Lint
description: รัน linting เพื่อตรวจสอบคุณภาพโค้ดในโปรเจกต์
---

## Precondition

- มี bun ติดตั้งในระบบ
- มีไฟล์ package.json ในโปรเจกต์
- มี linter ที่กำหนดค่าไว้ (biome, eslint, หรือ oxlint)

## Input

| ตัวแปร | ประเภท | คำอธิบาย |
|--------|--------|----------|
| projectPath | string | absolute path ของโปรเจกต์ |
| fix | boolean | แก้ไขปัญหาอัตโนมัติ (default: false) |
| linter | string | เลือก linter: biome, eslint, oxlint (default: biome) |

## 1. Prepare

- ตรวจสอบว่า package.json มีอยู่ใน projectPath
- ยืนยันว่า linter ที่เลือกมีอยู่ใน dependencies

## 2. Execute

1. เปลี่ยน directory ไปยัง project
   ```bash
   cd [projectPath]
   ```

2. รัน linter ตามที่กำหนด

   **กรณีใช้ Biome:**
   ```bash
   bun run lint
   ```
   หรือแก้ไขอัตโนมัติ:
   ```bash
   bun run lint:fix
   ```

   **กรณีใช้ ESLint:**
   ```bash
   bunx eslint .
   ```
   หรือแก้ไขอัตโนมัติ:
   ```bash
   bunx eslint . --fix
   ```

   **กรณีใช้ Oxlint:**
   ```bash
   bunx oxlint .
   ```

3. ตรวจสอบผลลัพธ์
   ```bash
   echo $?
   ```

## 3. Validate

- [ ] Linter รันสำเร็จโดยไม่มี error
- [ ] ไม่มีไฟล์ที่มีปัญหาหลังจาก fix (ถ้า fix = true)
- [ ] สามารถรัน `bun run build` ได้สำเร็จต่อไป
