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

### 2. Setup Tsdown

ดำเนินการตั้งค่า tsdown

1. ติดตั้ง tsdown ด้วยคำสั่ง `bun add -D tsdown`
2. สร้างไฟล์ tsdown.config.ts พร้อมกำหนด entry, format, dts generation
3. เพิ่ม build scripts ใน package.json (build, build:watch)
4. รัน build เพื่อตรวจสอบว่าทำงานได้ถูกต้อง

### 3. Validate Setup

ตรวจสอบความถูกต้องและยืนยันว่าพร้อมใช้งาน

1. ตรวจสอบ output ใน dist/ ว่าสร้างถูกต้อง
2. ยืนยันว่า type declarations (.d.ts) สร้างครบถ้วน
3. ทดสอบ build scripts ว่าทำงานได้

## Rules

### Installation

- ใช้คำสั่ง `bun add -D tsdown` เท่านั้น
- ติดตั้ง unplugin-vue/rolldown หากต้องการ build Vue components
- ตรวจสอบ installation สำเร็จก่อนดำเนินการต่อ

### Configuration

- สร้างไฟล์ `tsdown.config.ts` ใช้ TypeScript format
- ระบุ `entry` เป็น array เช่น `['./src/index.ts']`
- กำหนด output formats เป็น array เช่น `['esm', 'cjs']`
- Enable dts generation ด้วย `dts: true` หรือ `dts: { vue: true }`

### Build Scripts

- เพิ่ม script `"build": "tsdown"` ใน package.json
- เพิ่ม script `"build:watch": "tsdown --watch"` สำหรับ development
- เพิ่ม script `"watch": "tsdown --watch"` สำหรับ shortcut

### Output Configuration

- เปิดใช้ `clean: true` เพื่อล้าง dist ก่อน build
- เปิดใช้ `treeshake: true` สำหรับ tree shaking
- เปิดใช้ `minify: true` สำหรับ production build

## Expected Outcome

- tsdown.config.ts สร้างถูกต้อง
- package.json มี build scripts ครบถ้วน
- dist/ มี bundled files (ESM + CJS)
- dist/*.d.ts มี type declarations ครบถ้วน
