---
title: Follow Knip
description: Setup and configure Knip for detecting unused files, dependencies, and exports in monorepos
auto_execution_mode: 3
related:
  - /follow-code-quality
  - /follow-monorepo
  - /run-check
  - /resolve-errors
---

## Goal

ตั้งค่าและใช้งาน Knip สำหรับตรวจจับ unused files, dependencies และ exports อย่างถูกต้องตาม official best practices

## Scope

ใช้กับทุกโปรเจกต์ที่ต้องการวิเคราะห์ unused code — รองรับทั้ง single project และ monorepo ที่มี workspaces

## Execute

### 1. Install And Create Config

ติดตั้ง Knip และสร้าง config file ใน root directory

> Goal: Knip ติดตั้งและมี config file พร้อมใช้งาน

1. รัน `bun add -D knip`
2. สร้าง `knip.json` ใน root directory สำหรับ monorepo หรือ single project
3. ตั้งค่า `$schema` เป็น `https://unpkg.com/knip@latest/schema.json`
4. ถ้าเป็น monorepo → ใช้ `workspaces` object แทน root-level `entry`/`project`

### 2. Configure Workspaces

กำหนด entry points และ project patterns สำหรับแต่ละ workspace

> Goal: ทุก workspace มี entry และ project patterns ที่ถูกต้อง ไม่มี redundant patterns

1. Knip อ่าน workspaces จาก `package.json#workspaces`, `pnpm-workspace.yaml`, หรือ `knip.json#workspaces` อัตโนมัติ
2. แต่ละ workspace ต้องมี `package.json` — ถ้าไม่มี → เพิ่ม path ลงใน `workspaces` object ของ `knip.json`
3. ระบุ `entry` เฉพาะไฟล์ที่ Knip ไม่ detect อัตโนมัติ — Knip มี plugins ที่ auto-detect entry files จาก common patterns เช่น `src/index.ts`, `package.json#exports`
4. ระบุ `project` เป็น glob patterns ของ source files ใน workspace นั้น
5. ถ้า workspace ไม่มี custom entry/project → ใช้ empty object `{}`
6. รัน `bunx knip --debug` เพื่อตรวจสอบว่า patterns ถูกต้องและไม่มี redundant

### 3. Configure Advanced Options

เพิ่ม options ที่เพิ่มความแม่นยำในการตรวจจับ

> Goal: Config มี advanced options ที่ลด false positives และบังคับใช้ config ที่ถูกต้อง

1. เพิ่ม `ignoreExportsUsedInFile` เพื่อ ignore exports ที่ใช้เฉพาะภายในไฟล์ — แนะนำ `{ "interface": true, "type": true }`
2. เพิ่ม `includeEntryExports: true` ในแต่ละ workspace ที่เป็น private package เพื่อตรวจสอบ unused exports ใน entry files
3. เพิ่ม `treatConfigHintsAsErrors: true` เพื่อบังคับว่า config ต้องถูกต้อง — exit code 1 ถ้ามี config hints
4. ใช้ `ignoreDependencies` เฉพาะเมื่อจำเป็น — เช่น type packages ที่ไม่ปรากฏใน imports โดยตรง
5. ใช้ `ignoreBinaries` สำหรับ binaries ที่ใช้แต่ไม่ได้มาจาก dependency เช่น `["docker-compose", "bunx"]`

### 4. Configure Package.json Scripts

เพิ่ม scripts สำหรับรัน Knip ใน `package.json`

> Goal: Scripts ครบสำหรับ default, production, และ strict mode

1. เพิ่ม `"knip": "knip"` สำหรับ default analysis
2. เพิ่ม `"knip:prod": "knip --production"` สำหรับ production-only analysis (exclude tests, devDependencies)
3. เพิ่ม `"knip:strict": "knip --strict"` สำหรับ strict production mode (includes peerDependencies, type-only imports)
4. ห้ามเพิ่ม `"knip:fix"` จนกว่า config จะ settled และไม่มี config hints — `knip --fix` เป็นอันตรายถ้า config ไม่สมบูรณ์

### 5. Run And Fix Issues

รัน Knip และแก้ไข issues ตามลำดับความสำคัญ

> Goal: ไม่มี config hints และ unused code ถูกแก้ไขหรือ ignore อย่างถูกต้อง

1. รัน `bunx knip` ครั้งแรกเพื่อดู config hints — แก้ config hints ก่อนเสมอ
2. หลัง config hints หมด → รัน `bunx knip` อีกครั้งเพื่อดู actual issues
3. ตรวจสอบ issues ที่รายงาน — แยก false positives จากจริง
4. แก้ unused code โดยลบหรือใช้งาน — ห้าม ignore โดยไม่จำเป็น
5. ถ้าจำเป็นต้อง ignore → ใช้ targeted options (`ignoreFiles`, `ignoreBinaries`, `ignoreDependencies`, `ignoreMembers`, `ignoreUnresolved`) แทน `ignore` ที่กว้างเกินไป
6. รัน `bunx knip --production` เพื่อตรวจสอบ production code แยกต่างหาก

## Rules

### 1. Avoid Ignore Patterns

- ห้ามใช้ `ignore` แบบกว้างๆ เช่น `**/*.config.*`, `**/*.d.ts` — Knip ไม่ใช่ file-based linter แบบ ESLint
- `ignore` เป็นเพียงการ suppress reporting ไม่ใช่การ exclude จาก analysis — ทำให้เกิด blind spots
- ใช้ `entry` และ `project` patterns ที่ถูกต้องแทนการ ignore
- ถ้าจำเป็นจริงๆ ใช้ targeted options: `ignoreFiles`, `ignoreBinaries`, `ignoreDependencies`, `ignoreMembers`, `ignoreUnresolved`

### 2. Monorepo Workspaces

- ใน monorepo ใช้ `workspaces` object — root-level `entry`/`project` ถูก ignore
- root workspace ใช้ชื่อ `"."` ภายใต้ `workspaces`
- แต่ละ workspace รองรับ: `entry`, `project`, `ignore`, `ignoreBinaries`, `ignoreDependencies`, `ignoreIssues`, `ignoreMembers`, `ignoreUnresolved`, `includeEntryExports`, `paths`, plugins
- ห้าม nest workspaces ใน Knip config — แต่ folder structure สามารถ nest ได้
- ใช้ `--workspace` หรือ `-W` flag เพื่อ filter workspace เช่น `knip -W apps/website`

### 3. Production Mode

- ใช้ `--production` เพื่อวิเคราะห์เฉพาะ production code — exclude tests, stories, devDependencies อัตโนมัติ
- ใช้ `!` suffix ใน entry/project patterns เพื่อ mark production files เช่น `"src/index.ts!"`
- `--strict` implies `--production` และเพิ่ม: verify workspace isolation, include peerDependencies, report type-only imports
- รันทั้ง default และ production mode แยกกัน — ไม่ใช่ทดแทนกัน

### 4. Configuration Hints

- แก้ config hints ก่อนเสมอ — config hints บอกว่า Knip ไม่เข้าใจ project ทำให้เกิด false positives
- เปิด `treatConfigHintsAsErrors: true` เพื่อบังคับว่า config ต้องถูกต้อง
- ห้าม ignore หรือ disable config hints — แก้ที่ root cause
- ใช้ `--debug` เพื่อดู verbose output ของ workspaces, plugins, และ resolved files

### 5. Exports Configuration

- ใช้ `ignoreExportsUsedInFile` สำหรับ types/interfaces ที่ใช้เฉพาะในไฟล์ — ลด noise โดยไม่ hide issues
- ใช้ `includeEntryExports: true` สำหรับ private/self-contained packages เพื่อตรวจสอบ unused exports ใน entry files
- ใช้ JSDoc tags เช่น `@internal` หรือ `@lintignore` เพื่อ tag exports ที่ต้องการ exclude
- กำหนด `tags` ใน config เพื่อ filter tagged exports เช่น `{ "tags": ["-lintignore"] }`

### 6. Plugins

- Knip มี plugins สำหรับ Vite, Vitest, Playwright, Next.js, Remix, Astro, Svelte และอื่นๆ
- Plugins auto-detect entry files และ config — ห้าม duplicate ใน `entry` ของ workspace
- ปิด plugin ด้วย `false` เช่น `{ "webpack": false }`
- เปิด plugin ด้วย `true` เช่น `{ "playwright": true }`
- Override plugin config/entry เช่น `{ "mocha": { "config": "config/mocha.config.js", "entry": ["**/*.spec.js"] } }`

### 7. Safe Usage

- ห้ามรัน `knip --fix` จนกว่า config จะ settled และไม่มี config hints — อาจลบ code ที่ใช้งานจริง
- ตรวจสอบ issues ที่รายงานด้วยตาก่อนแก้ไขเสมอ
- ใช้ `--include` หรือ `--exclude` เพื่อ filter issue types เช่น `knip --include files,dependencies`
- ใช้ `rules` ใน config เพื่อกำหนด severity: `"error"`, `"warn"`, `"off"` เช่น `{ "rules": { "files": "warn", "duplicates": "off" } }`

## Expected Outcome

- `knip.json` ตั้งค่าครบถ้วนตาม official best practices
- ไม่มี config hints
- Scripts สำหรับ default, production, และ strict mode พร้อมใช้งาน
- ไม่มี unused files, dependencies, หรือ exports (หรือมี targeted ignore ที่จำเป็น)
- Monorepo ทุก workspace ถูกวิเคราะห์ครบถ้วน
