---
title: Vitest Configuration
description: ติดตั้งและตั้งค่า Vitest สำหรับ unit testing ด้วย Vite
auto_execution_mode: 3
related_workflows:
  - /follow-vite
  - /follow-typescript
  - /write-test
---

## Goal

ตั้งค่า Vitest เป็น testing framework หลักสำหรับโปรเจกต์ TypeScript/JavaScript

## Scope

ติดตั้งและตั้งค่า Vitest สำหรับ unit testing ในโปรเจกต์เดี่ยวและ monorepo

## Execute

### 1. Installation

1. ทำ `/follow-vite` เพื่อตรวจสอบ Vite setup
2. ติดตั้ง Vitest ด้วย `bun add -D vitest`
3. ติดตั้ง coverage tool ด้วย `bun add -D @vitest/coverage-v8`
4. ตรวจสอบว่ามี Vite >= v6.0.0 และ Node >= v20.0.0
5. เพิ่ม test script ใน `package.json`
6. ใช้ `bun run test` แทน `bun test` เพื่อหลีกเลี่ยง Bun test runner

### 2. Configuration

1. สร้าง `vitest.config.ts` หรือใช้ `vite.config.ts` ที่มีอยู่
2. เปิดใช้งาน globals เพื่อลดการ import
3. ตั้งค่า test patterns เป็น `**/*.test.ts` หรือ `**/*.spec.ts`
4. กำหนด environment เป็น `node` หรือ `jsdom` ตามความต้องการ
5. ตั้งค่า coverage ด้วย `@vitest/coverage-v8`
6. ตั้งค่า `test.include` และ `test.exclude` สำหรับ glob patterns

### 3. Monorepo Setup

1. ใช้ Vitest Projects สำหรับหลาย packages ใน monorepo
2. กำหนด glob patterns สำหรับแต่ละ project
3. ตั้งค่า extends จาก root config เพื่อ reuse configuration
4. ใช้ workspace protocol สำหรับ internal dependencies
5. ตั้งค่า `--filter` เพื่อรัน tests บน packages เฉพาะ
6. ตั้งค่า `--project` เพื่อรัน tests บน project เฉพาะ

### 4. Writing Tests

1. ทำ `/write-test` เพื่อเขียน test ที่มีคุณภาพ
2. ใช้ `test` หรือ `it` จาก globals แทนการ import
3. ใช้ `expect` สำหรับ assertions
4. จัดระเบียบ test files ตามโครงสร้าง source code
5. ใช้ `describe` สำหรับ grouping related tests
6. ใช้ `beforeEach`, `afterEach`, `beforeAll`, `afterAll` สำหรับ setup/teardown

### 5. Mocking And Stubbing

1. ใช้ `vi.mock` สำหรับ mocking modules
2. ใช้ `vi.fn` สำหรับ creating mock functions
3. ใช้ `vi.spyOn` สำหรับ spying on methods
4. ใช้ snapshots สำหรับ testing UI components
5. ใช้ `vi.clearAllMocks` สำหรับ cleanup ระหว่าง tests

### 6. Watch Mode And CI

1. ตั้งค่า watch mode สำหรับ development
2. ใช้ `vitest run` สำหรับ CI/CD
3. ติดตั้ง VS Code extension สำหรับ IDE integration
4. ตั้งค่า coverage thresholds สำหรับ quality gates
5. ตั้งค่า `--reporter` สำหรับ custom output formats

## Rules

### 1. Configuration Requirements

ต้องมี config file ที่ root:

- ต้องมี `vitest.config.ts` หรือ `vite.config.ts` ที่ root
- ใช้ `bun add -D vitest` สำหรับ installation
- เปิดใช้งาน globals เพื่อลด boilerplate
- ใช้ test patterns `.test.ts` หรือ `.spec.ts`
- ตรวจสอบ compatibility ของ Node.js และ Bun version
- ใช้ `bun run test` แทน `bun test`

### 2. Monorepo Configuration

ตั้งค่าสำหรับ monorepo:

- ใช้ Vitest Projects สำหรับหลาย packages
- กำหนด glob patterns สำหรับแต่ละ project
- ตั้งค่า extends จาก root config
- ใช้ workspace protocol สำหรับ internal dependencies
- ตั้งค่า `--filter` สำหรับ selective testing

### 3. Test Organization

จัดระเบียบ test files:

- จัด test files ตามโครงสร้าง source code
- ใช้ `describe` สำหรับ grouping related tests
- ใช้ test names ที่ชัดเจนและ descriptive
- ใช้ `beforeEach`, `afterEach` สำหรับ isolated tests
- ใช้ `beforeAll`, `afterAll` สำหรับ shared setup

### 4. Mocking Best Practices

ใช้ mocking อย่างเหมาะสม:

- ใช้ `vi.mock` สำหรับ mocking modules
- ใช้ `vi.fn` สำหรับ creating mock functions
- ใช้ `vi.spyOn` สำหรับ spying on methods
- ใช้ snapshots สำหรับ testing UI components
- ใช้ `vi.clearAllMocks` สำหรับ cleanup

## Expected Outcome

- Vitest ติดตั้งและทำงานได้
- Config รองรับ globals และ monorepo
- Tests รันได้ทั้งหมด
- เป็นไปตาม best practices จาก official documentation

