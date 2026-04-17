---
description: แนวทางการพัฒนา monorepo ด้วย Turborepo
title: Turborepo Best Practices
auto_execution_mode: 3
---

## Goal

กำหนดแนวทางการพัฒนา monorepo ด้วย Turborepo ให้มีประสิทธิภาพสูงสุด

## Execute

### 1. Repository Structure

1. ใช้ workspace configuration ด้วย pnpm หรือ npm/yarn/bun
2. ตั้งค่า root `package.json` ให้มี private, packageManager, workspaces
3. ใช้ package tasks แทน root tasks
4. สร้าง `turbo.json` ที่ root
5. จัดโครงสร้าง directory ด้วย apps/*, packages/*, modules/*

### 2. Configuration

1. ติดตั้ง Turborepo ด้วย `bun add -D turbo`
2. สร้าง `turbo.json` ด้วย $schema และ tasks configuration
3. กำหนด `inputs` สำหรับ cache invalidation
4. กำหนด `outputs` สำหรับ caching artifacts
5. ตั้งค่า `dependsOn` สำหรับ task dependencies
6. ตั้งค่า `cache` เป็น true สำหรับ tasks ที่สามารถ cache
7. ตั้งค่า `persistent: true` สำหรับ long-running tasks
8. ตั้งค่า `env` สำหรับ environment variables
9. ทำ `/follow-verify`

### 3. Usage

1. รัน `turbo run <task>` สำหรับ task เฉพาะ
2. ใช้ `--filter` สำหรับ packages เฉพาะ:
   - `turbo run build --filter=docs` - รัน build เฉพาะ docs workspace
   - `turbo run build --filter=...[origin/main]` - รัน build เฉพาะที่เปลี่ยนแปลง
3. ใช้ `turbo prune` สำหรับ Docker builds:
   - `turbo prune --docker` - สร้าง Docker context เฉพาะที่จำเป็น
4. ใช้ `--dry=json` สำหรับ inspect dependencies:
   - `turbo run build --dry=json` - ดู task dependencies โดยไม่รันจริง

### 4. Remote Caching

1. ตั้งค่า Remote Cache ด้วย Vercel
2. รัน `bunx turbo link --yes` เพื่อเชื่อมต่อกับ Vercel Remote Cache
3. ใช้ `TURBO_TOKEN` และ `TURBO_TEAM` สำหรับ authentication
4. ตรวจสอบ cache hit/miss ด้วย `turbo run build --dry=json`

## Rules

### 1. Configuration

ตั้งค่า turbo.json ให้ถูกต้องตาม Turborepo v2

- ต้องมี `turbo.json` ที่ root
- ใช้ `$schema` สำหรับ type safety
- `turbo.json` ต้องกำหนด tasks ตาม scripts
- กำหนด `inputs` ด้วย pattern ที่ครอบคลุม source files
- กำหนด `outputs` ด้วย pattern ที่ระบุ build artifacts
- ใช้ `dependsOn: ["^task"]` สำหรับ dependencies จาก upstream packages
- ใช้ workspace protocol สำหรับ internal dependencies
- ตั้งค่า `persistent: true` สำหรับ dev servers

```json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "inputs": ["src/**", "package.json"],
      "outputs": ["dist/**", ".next/**"],
      "cache": true
    },
    "test": {
      "dependsOn": ["build"],
      "inputs": ["src/**", "test/**", "package.json"],
      "cache": true
    },
    "lint": {
      "inputs": ["src/**", "package.json"],
      "cache": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

### 2. Scripts Configuration

ตั้งค่า scripts ให้สอดคล้องกับ Turborepo

- ทุก workspace ต้องมี scripts ที่ตรงกับ turbo tasks ใน root `package.json`
- ถ้า workspace มี scripts เพิ่มเติมซ้ำกับ root scripts มากกว่า 2 อัน ให้กำหนดใน root `package.json` ว่าใช้ turbo
- ใช้ `turbo run <task>` สำหรับรัน scripts ผ่าน Turborepo
- ตัวอย่าง root scripts:
  ```json
  {
    "scripts": {
      "build": "turbo run build",
      "test": "turbo run test",
      "lint": "turbo run lint"
    }
  }
  ```

### 3. Performance

- ใช้ `--filter` เพื่อ skip tasks บน unaffected packages
- ตั้งค่า Remote Cache สำหรับ production builds
- ตรวจสอบ task dependencies ด้วย `turbo run build --dry=json`

## Expected Outcome

- Monorepo ที่มีประสิทธิภาพสูงด้วย Turborepo
- Caching ที่ทำงานได้อย่างมีประสิทธิภาพ
- Build times ที่ลดลงอย่างมีนัยสำคัญ

