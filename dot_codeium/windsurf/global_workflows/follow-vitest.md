---
description: ติดตั้งและตั้งค่า Vitest สำหรับ unit testing ด้วย Vite
title: Vitest Configuration
auto_execution_mode: 3
---

## Goal

ตั้งค่า Vitest เป็น testing framework หลักสำหรับโปรเจกต์ TypeScript/JavaScript

## Execute

### 1. Installation

1. ติดตั้ง Vitest ด้วย `bun add -D vitest`
2. ตรวจสอบว่ามี Vite >= v6.0.0 และ Node >= v20.0.0
3. เพิ่ม test script ใน `package.json`
4. ใช้ `bun run test` แทน `bun test` เพื่อหลีกเลี่ยง Bun test runner

### 2. Configuration

1. สร้าง `vitest.config.ts` หรือใช้ `vite.config.ts` ที่มีอยู่
2. เปิดใช้งาน globals เพื่อลดการ import
3. ตั้งค่า test patterns เป็น `**/*.test.ts` หรือ `**/*.spec.ts`
4. กำหนด environment เป็น `node` หรือ `jsdom` ตามความต้องการ
5. ตั้งค่า coverage ด้วย `@vitest/coverage-v8` หรือ `@vitest/coverage-istanbul`

### 3. Monorepo Setup

1. ใช้ Vitest Projects สำหรับหลาย packages ใน monorepo
2. กำหนด glob patterns สำหรับแต่ละ project
3. ตั้งค่า extends จาก root config เพื่อ reuse configuration
4. ใช้ workspace protocol สำหรับ internal dependencies
5. ตั้งค่า `--filter` เพื่อรัน tests บน packages เฉพาะ

### 4. Writing Tests

1. ใช้ `test` หรือ `it` จาก globals แทนการ import
2. ใช้ `expect` สำหรับ assertions
3. จัดระเบียบ test files ตามโครงสร้าง source code
4. ใช้ `describe` สำหรับ grouping related tests
5. ใช้ `beforeEach`, `afterEach`, `beforeAll`, `afterAll` สำหรับ setup/teardown

### 5. Best Practices

1. ใช้ mocking และ stubbing อย่างเหมาะสมด้วย `vi.mock` และ `vi.fn`
2. ใช้ snapshots สำหรับ testing UI components
3. ตั้งค่า watch mode สำหรับ development
4. ใช้ `vitest run` สำหรับ CI/CD
5. ติดตั้ง VS Code extension สำหรับ IDE integration

## Rules

- ต้องมี `vitest.config.ts` หรือ `vite.config.ts` ที่ root
- ใช้ `bun add -D vitest` สำหรับ installation
- เปิดใช้งาน globals เพื่อลด boilerplate
- ใช้ test patterns `.test.ts` หรือ `.spec.ts`
- ใช้ Vitest Projects สำหรับ monorepo
- ตรวจสอบ compatibility ของ Node.js และ Bun version
- ใช้ `bun run test` แทน `bun test`

## Expected Outcome

- Vitest ติดตั้งและทำงานได้
- Config รองรับ globals และ monorepo
- Tests รันได้ทั้งหมด
- เป็นไปตาม best practices จาก official documentation
