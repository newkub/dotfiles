---
description: แนวทางการพัฒนา monorepo ด้วย Turborepo v2.x
title: Turborepo Best Practices
auto_execution_mode: 3
url: https://turborepo.dev/docs
related_workflows:
  - /follow-monorepo
  - /follow-bun
  - /follow-package-manifest
  - /follow-tasks
---

## Goal

กำหนดแนวทางการพัฒนา monorepo ด้วย Turborepo v2.x ให้มีประสิทธิภาพสูงสุด

## Scope

ใช้สำหรับ monorepo ที่ใช้ Turborepo สำหรับ task orchestration และ build orchestration

## Execute

### 1. Repository Structure

1. ใช้ workspace configuration ด้วย `bun` (แนะนำ) หรือ pnpm/npm/yarn
2. ตั้งค่า root `package.json` ให้มี `private`, `packageManager`, `workspaces`
3. ใช้ package tasks แทน root tasks
4. สร้าง `turbo.json` ที่ root พร้อม `$schema`
5. จัดโครงสร้าง directory ด้วย `apps/*`, `packages/*` (ห้าม nested packages เช่น `apps/**`)
6. แต่ละ package ต้องมี `package.json` พร้อม `exports` สำหรับ entrypoints
7. หลีกเลี่ยงการเข้าถึง files ข้าม package boundaries (ห้ามใช้ `../`)

### 2. Task Configuration

1. กำหนด `inputs` สำหรับ cache invalidation - ใช้ `$TURBO_DEFAULT$` เพื่อ include default inputs พร้อม custom
2. กำหนด `outputs` สำหรับ caching artifacts (เช่น `dist/**`, `.next/**`)
3. ตั้งค่า `dependsOn` สำหรับ task dependencies:
   - `^task` - task ใน upstream dependencies ต้องทำก่อน
   - `task` - task ใน same package ต้องทำก่อน
4. ตั้งค่า `cache: true` สำหรับ tasks ที่มี deterministic output
5. ตั้งค่า `cache: false` สำหรับ dev servers และ tasks ที่มี side effects
6. ตั้งค่า `persistent: true` สำหรับ long-running tasks (dev servers, watchers)
7. ตั้งค่า `interactive: true` สำหรับ tasks ที่รับ stdin (เช่น test watchers)
8. ตั้งค่า `interruptible: true` สำหรับ persistent tasks ที่ต้อง restart ใน `turbo watch`
9. ตั้งค่า `env` สำหรับ environment variables ที่ affect cache hash (ไม่ใช้ `$` prefix)
10. ตั้งค่า `passThroughEnv` สำหรับ env vars ที่ runtime ใช้แต่ไม่ affect hash (เช่น secrets)
11. ตั้งค่า `outputLogs` เป็น `full`, `new-only`, `errors-only`, หรือ `none`

### 3. Global Configuration

1. เปิดใช้ `futureFlags.globalConfiguration: true` เพื่อใช้ `global` key
2. `global.inputs` (แทน `globalDependencies`) - files ที่ prepend เข้าทุก task's inputs
3. `global.env` (แทน `globalEnv`) - env vars ที่ affect hash ของทุก tasks
4. `global.passThroughEnv` (แทน `globalPassThroughEnv`) - env vars ที่ runtime ใช้แต่ไม่ affect hash
5. `global.envMode: "strict"` - filter env vars ที่ไม่ได้ declare
6. `global.cacheDir`, `global.cacheMaxAge`, `global.cacheMaxSize` - cache settings
7. `global.daemon` - ควบคุม daemon process
8. แต่ละ task สามารถ exclude global files ด้วย negation globs เมื่อใช้ `globalConfiguration`

### 4. Package Configurations

1. ใช้ package-level `turbo.json` เพื่อ override หรือ extend root config
2. ใช้ `"extends": ["//"]` เพื่อ inherit จาก root `turbo.json`
3. ใช้ `$TURBO_EXTENDS$` เป็น element แรกใน array เพื่อ append แทน replace
4. ใช้ `"extends": false` เพื่อ disable task เฉพาะ package
5. รองรับ fields: `dependsOn`, `env`, `inputs`, `outputs`, `passThroughEnv`, `with`

### 5. Boundaries And Tags (Experimental)

1. ใช้ `turbo boundaries` เพื่อตรวจสอบ package isolation
2. กำหนด `tags` ใน package-level `turbo.json` สำหรับ labeling packages
3. กำหนด `boundaries` ใน root `turbo.json` สำหรับ dependency rules:
   - `allow` - tags ที่อนุญาตให้ depend ได้
   - `deny` - tags ที่ห้าม depend
4. รองรับทั้ง `dependencies` และ `dependents` rules
5. ตรวจสอบ rules ลึกถึง transitive dependencies

### 6. Watch Mode

1. ใช้ `turbo watch <task>` สำหรับ re-run tasks เมื่อ source changes
2. Watch mode ตาม Task Graph ใน `turbo.json`
3. ตั้งค่า `interruptible: true` สำหรับ persistent tasks ที่ต้อง restart
4. เปิด `futureFlags.watchUsingTaskInputs` เพื่อใช้ task-level `inputs` ใน watch mode
5. ใช้ `--experimental-write-cache` สำหรับ write cache ใน watch mode

### 7. Usage And Filtering

1. รัน `turbo run <task>` สำหรับ task เฉพาะ
2. ใช้ `--affected` เพื่อรันเฉพาะ changed packages (auto-compares กับ default branch)
3. ใช้ `--filter` สำหรับ packages เฉพาะ:
   - `--filter=web` - รันเฉพาะ package `web`
   - `--filter=./apps/*` - รันทุก packages ใน `apps/`
   - `--filter=web...` - package และ dependencies
   - `--filter=...web` - package และ dependents
4. เปิด `futureFlags.filterUsingTasks` เพื่อ filter ที่ task level แทน package level
5. ใช้ `turbo prune --docker` สำหรับ Docker builds
6. ใช้ `--dry=json` สำหรับ inspect task dependencies

### 8. Remote Caching

1. ตั้งค่า `remoteCache` ใน `turbo.json` หรือ `global.remoteCache`
2. รัน `bunx turbo link --yes` เพื่อเชื่อมต่อ Vercel Remote Cache
3. ใช้ `TURBO_TOKEN` และ `TURBO_TEAM` สำหรับ authentication
4. กำหนด `remoteCache.enabled`, `remoteCache.signature`, `remoteCache.timeout`
5. ตั้งค่า `remoteCache.apiUrl`, `remoteCache.loginUrl` สำหรับ self-hosted
6. Turborepo แชร์ local cache ระหว่าง Git worktrees อัตโนมัติ

## Rules

### 1. Configuration

ตั้งค่า `turbo.json` ให้ถูกต้องตาม Turborepo v2.x

- ต้องมี `turbo.json` ที่ root พร้อม `$schema`
- ใช้ `futureFlags.globalConfiguration: true` เพื่อย้าย global keys ไปใต้ `global`
- `global.inputs` เปลี่ยน semantics เป็น per-task hashing แทน global hash
- กำหนด `inputs` ด้วย pattern ที่ครอบคลุม source files
- กำหนด `outputs` ด้วย pattern ที่ระบุ build artifacts
- ใช้ `dependsOn: ["^task"]` สำหรับ upstream dependencies
- ใช้ workspace protocol สำหรับ internal dependencies
- ตั้งค่า `persistent: true` สำหรับ dev servers
- ตั้งค่า `interactive: true` สำหรับ tasks ที่รับ stdin
- ตั้งค่า `interruptible: true` สำหรับ persistent tasks ใน watch mode
- ใช้ `env` ไม่มี `$` prefix, แยก `passThroughEnv` สำหรับ secrets

### 2. Scripts Configuration

- ทุก workspace ต้องมี scripts ที่ตรงกับ turbo tasks
- ใช้ `turbo run <task>` ใน root scripts
- ถ้า workspace มี scripts เพิ่มเติมซ้ำกับ root scripts มากกว่า 2 อัน ให้กำหนดใน root `package.json`
- ทำ `/follow-tasks` และ `/follow-package-manifest`

### 3. Boundaries

- ใช้ `turbo boundaries` เพื่อ enforce package isolation
- กำหนด `tags` ใน package-level `turbo.json`
- กำหนด `boundaries` rules ใน root `turbo.json`
- ใช้ `allow` และ `deny` สำหรับ `dependencies` และ `dependents`

### 4. Performance

- ใช้ `--affected` หรือ `--filter` เพื่อ skip unaffected packages
- ตั้งค่า Remote Cache สำหรับ production builds
- ใช้ `turbo watch` สำหรับ development workflow
- ตรวจสอบ task dependencies ด้วย `--dry=json`
- ใช้ `cacheMaxSize` และ `cacheMaxAge` สำหรับ cache management

## Expected Outcome

- Monorepo ที่มีประสิทธิภาพสูงด้วย Turborepo v2.x
- Caching ที่ทำงานได้อย่างมีประสิทธิภาพด้วย global configuration
- Package isolation ด้วย Boundaries และ Tags
- Development workflow ที่รวดเร็วด้วย Watch Mode
- Build times ที่ลดลงอย่างมีนัยสำคัญ
