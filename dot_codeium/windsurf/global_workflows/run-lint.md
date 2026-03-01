---
description: รัน lint และแก้ไข errors ตาม best practices
---

## 1. กำหนด Lint

1. เลือกคำสั่ง lint ตาม framework

   - Nuxt: `nuxt typecheck && oxlint --fix --type-aware && biome lint --write`
   - TypeScript: `tsc --noEmit && oxlint --fix --type-aware && biome lint --write`
   - Vue: `biome lint --write && vue-tsc --noEmit`
   - React: `biome lint --write && tsc --noEmit`
   - Next: `biome lint --write && next lint`

## 2. รัน Lint

1. รัน lint ใน package manifest

2. ถ้าเจอ error ให้เช็คไฟล์ที่ error ว่ายาวไหม ถ้ายาวให้ @[/refactor-long-files] ก่อน

3. แก้ไข errors และ warnings จนหมด

   - แก้ไขได้ทันทีเมื่อเห็น error หรือ warning
   - ถ้าเจอ error ที่ซับซ้อนหรือต้องการ refactor ให้ทำตาม @[/refactor]
   - ถ้ายังแก้ไม่ได้หรือต้องการการปรับปรุงโครงสร้าง ให้รัน @[/refactor] ก่อน
