---
title: Follow Tsdown
description: ตั้งค่าและใช้งาน tsdown สำหรับ bundle TypeScript libraries ด้วย Rolldown - รองรับทุก config options และ plugin ecosystems
auto_execution_mode: 3
---


## Goal

ตั้งค่า tsdown เป็น library bundler สำหรับ TypeScript ด้วย Rolldown รองรับ type declarations generation และ multiple output formats

## Execute

### 1. Analyze Project

วิเคราะห์โปรเจกต์และความต้องการ

1. ตรวจสอบว่าเป็น TypeScript library project
2. ยืนยันว่ามี Bun ติดตั้งแล้ว
3. ตรวจสอบว่ามี package.json อยู่แล้ว
4. ระบุ output formats ที่ต้องการ (ESM, CJS, IIFE)
5. ตรวจสอบ Node.js version requirement (^22.18.0 || >=24.0.0)

### 2. Setup Tsdown

ดำเนินการตั้งค่า tsdown

1. ติดตั้ง tsdown ด้วยคำสั่ง `bun add -D tsdown`
2. ตรวจสอบ version ด้วย `bunx tsdown --version`
3. ตรวจสอบ CLI options ด้วย `bunx tsdown --help`
4. สร้างไฟล์ tsdown.config.ts พร้อมกำหนด entry, format, dts generation
5. เพิ่ม build scripts ใน package.json (build, build:watch)
6. รัน build เพื่อตรวจสอบว่าทำงานได้ถูกต้อง

### 3. Validate Setup

ตรวจสอบความถูกต้องและยืนยันว่าพร้อมใช้งาน

1. ตรวจสอบ output ใน dist/ ว่าสร้างถูกต้อง
2. ยืนยันว่า type declarations (.d.ts) สร้างครบถ้วน
3. ทดสอบ build scripts ว่าทำงานได้
4. ทดสอบ watch mode ด้วย `bunx tsdown --watch`

## Rules

### Installation

ติดตั้ง tsdown อย่างถูกต้อง

- ใช้คำสั่ง `bun add -D tsdown` เท่านั้น
- ตรวจสอบ Node.js version requirement (^22.18.0 || >=24.0.0)
- ติดตั้ง unplugin-vue/rolldown หากต้องการ build Vue components
- ตรวจสอบ installation สำเร็จก่อนดำเนินการต่อ
- ใช้ `create-tsdown` CLI สำหรับ scaffolding project ใหม่

### Configuration

ตั้งค่า tsdown.config.ts อย่างถูกต้อง

- สร้างไฟล์ `tsdown.config.ts` ใช้ TypeScript format
- ใช้ `defineConfig` helper สำหรับ type safety
- ระบุ `entry` เป็น array เช่น `['./src/index.ts']`
- กำหนด output formats เป็น array เช่น `['esm', 'cjs']`
- Enable dts generation ด้วย `dts: true` หรือ `dts: { vue: true }`
- รองรับ config file formats: .ts, .js, .mjs, .cjs, .mts, .cts

### Build Scripts

ตั้งค่า scripts ใน package.json

- เพิ่ม script `"build": "tsdown"` ใน package.json
- เพิ่ม script `"build:watch": "tsdown --watch"` สำหรับ development
- เพิ่ม script `"watch": "tsdown --watch"` สำหรับ shortcut
- เพิ่ม script `"dev": "tsdown --watch"` สำหรับ development mode

### Output Configuration

ตั้งค่า output options

- เปิดใช้ `clean: true` เพื่อล้าง dist ก่อน build
- เปิดใช้ `treeshake: true` สำหรับ tree shaking (default)
- เปิดใช้ `minify: true` สำหรับ production build
- รองรับ unbundle mode ด้วย `bundle: false`
- รองรับ SEA (Single Executable Archive) ด้วย `exe: true`

### Plugin System

ใช้ plugins อย่างถูกต้อง

- รองรับ Rolldown plugins, Rollup plugins, unplugin, และ Vite plugins
- เพิ่ม plugins ใน config: `plugins: [SomePlugin()]`
- ใช้ `rolldown-plugin-dts` สำหรับ DTS generation (built-in)
- ใช้ `rolldown-plugin-require-cjs` สำหรับ CJS requirement patterns
- ใช้ internal plugins: ShebangPlugin, DepsPlugin, WatchPlugin

### Framework Plugins

ใช้ plugins สำหรับ frameworks ต่างๆ

- Vue: ใช้ `unplugin-vue/rolldown` พร้อม `dts: { vue: true }` และติดตั้ง `vue-tsc` และ `unplugin-vue`
- React: ใช้ standard config หรือ `@rolldown/plugin-babel` + `@vitejs/plugin-react` สำหรับ React Compiler
- Solid: ใช้ `unplugin-solid/rolldown` สำหรับ SolidJS JSX transform และติดตั้ง `unplugin-solid`
- Svelte: ใช้ `rollup-plugin-svelte` + `svelte-preprocess` แต่แนะนำให้ใช้ source distribution (ไม่ต้อง bundle)
- ใช้ `create-tsdown -t <framework>` สำหรับ scaffolding project ใหม่ (vue, react, solid, svelte, react-compiler)
- ตั้งค่า `platform: 'neutral'` สำหรับ compatibility สูงสุดระหว่าง browser และ Node.js

### Validation

ตรวจสอบคุณภาพ package

- ใช้ `publint` สำหรับ lint package.json (built-in support)
- ใช้ `attw` (Are The Types Wrong) สำหรับ type validation (built-in support)
- ใช้ `tsnapi` สำหรับ API snapshot comparison
- เปิดใช้ validation ใน config: `publint: true`, `attw: true`

### Workspace Support

ใช้ใน monorepo

- รองรับ workspace bundling ด้วย workspace config
- ใช้ `devExports` สำหรับ development mode ใน monorepo
- รองรับ multiple packages ใน workspace
- ใช้ `tinyglobby` สำหรับ file discovery

### Migration

Migrate จาก bundlers อื่น

- ใช้ `tsdown-migrate` สำหรับ migrate จาก tsup
- Compatible กับ tsup options หลักๆ
- ใช้ `bunx tsdown-migrate` สำหรับ auto-migration

## Expected Outcome

- tsdown.config.ts สร้างถูกต้อง
- package.json มี build scripts ครบถ้วน
- dist/ มี bundled files (ESM + CJS)
- dist/*.d.ts มี type declarations ครบถ้วน
- Watch mode ทำงานได้
- Plugins ทำงานได้
- Validation (publint, attw) ผ่าน

