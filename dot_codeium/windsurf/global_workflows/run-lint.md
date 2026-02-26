---
description: รัน lint และแก้ไขโค้ด
title: run-lint
auto_execution_mode: 3
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

2. แก้ไข errors และ warnings จนหมด

   - แก้ไขได้ทันทีเมื่อเห็น error หรือ warning
