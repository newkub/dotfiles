---
title: Vitest Configuration
description: ติดตั้งและตั้งค่า Vitest 4 สำหรับ unit testing ด้วย Vite
auto_execution_mode: 3
related_workflows:
  - /follow-vite
  - /follow-typescript
  - /write-test
  - /follow-stryker-mutator
  - /follow-code-quality
---

## Goal

ตั้งค่า Vitest เป็น testing framework หลักสำหรับโปรเจกต์ TypeScript/JavaScript

## Scope

ติดตั้งและตั้งค่า Vitest 4 สำหรับ unit testing ในโปรเจกต์เดี่ยวและ monorepo

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
2. เปิดใช้งาน `globals` เพื่อลดการ import
3. ตั้งค่า test patterns เป็น `**/*.test.ts` หรือ `**/*.spec.ts`
4. กำหนด environment เป็น `node` หรือ `jsdom` ตามความต้องการ
5. ตั้งค่า coverage ด้วย `@vitest/coverage-v8` พร้อม `coverage.include` แบบ explicit
6. ตั้งค่า `test.include` และ `test.exclude` สำหรับ glob patterns
7. เปิดใช้งาน type-checking ด้วย `typecheck.enabled: true`
8. เพิ่ม `vitest/globals` ใน `tsconfig.json` types
9. ตั้งค่า `retry` สำหรับ flaky tests
10. ตั้งค่า `maxWorkers` สำหรับ pool performance
11. เพิ่ม `lcov` reporter สำหรับ CI/CD

### 3. Monorepo Setup

1. ใช้ `test.projects` array สำหรับหลาย packages (แทน `workspace` ที่ deprecated ตั้งแต่ Vitest 3.2)
2. กำหนด glob patterns หรือ inline config สำหรับแต่ละ project
3. ใช้ `defineProject` แทน `defineConfig` ใน project-level config files
4. ใช้ `extends: true` เพื่อ inherit options จาก root config
5. ตั้งค่า `--project` เพื่อรัน tests บน project เฉพาะ
6. ระบุ `name` ให้แต่ละ project ไม่ซ้ำกัน

### 4. Writing Tests

1. ทำ `/write-test` เพื่อเขียน test ที่มีคุณภาพ
2. ใช้ `test` หรือ `it` จาก globals แทนการ import
3. ใช้ `expect` สำหรับ assertions
4. จัดระเบียบ test files ตามโครงสร้าง source code
5. ใช้ `describe` สำหรับ grouping related tests
6. ใช้ `beforeEach`, `afterEach`, `beforeAll`, `afterAll` สำหรับ setup/teardown
7. ใช้ `test.for` สำหรับ parameterized tests
8. ใช้ test tags สำหรับ categorize tests และ apply shared options เช่น `timeout` หรือ `retry`

### 5. Test Tags

1. กำหนด tags ใน config ด้วย `test.tags` array แต่ละ tag มี `name` และ optional test options
2. ใช้ `test('name', { tags: ['db', 'flaky'] }, fn)` สำหรับ tag tests
3. กรองด้วย `--tags-filter` เช่น `vitest --tags-filter="unit"` หรือ `vitest --tags-filter="frontend && !flaky"`
4. ใช้ tag options เช่น `timeout`, `retry` ที่ apply อัตโนมัติกับทุก test ที่มี tag นั้น

### 6. Type-Checking

1. เปิดใช้งาน type-checking ด้วย `typecheck.enabled: true`
2. ใช้ไฟล์ `.test-d.ts` สำหรับ type tests
3. ตั้งค่า `typecheck.include` และ `typecheck.exclude`
4. ตั้งค่า `typecheck.tsconfig` สำหรับ custom tsconfig
5. ใช้ `typecheck.only` สำหรับ run เฉพาะ type tests
6. ตั้งค่า `typecheck.allowJs` สำหรับ JavaScript files
7. ตั้งค่า `typecheck.ignoreSourceErrors` สำหรับ ignore errors นอก test files

### 7. Fixtures And Test Context

1. ใช้ `test.extend()` สำหรับ create reusable fixtures
2. ใช้ scopes: `test`, `file`, `worker` สำหรับ lifecycle management
3. ใช้ builder pattern ใน Vitest 4.1: return value แทนการเรียก `use()` แล้ว TypeScript infer type อัตโนมัติ
4. ใช้ `onCleanup` callback สำหรับ teardown logic
5. ใช้ `test.override` สำหรับ override fixture values ใน specific suites (Vitest 4.1)
6. ใช้ `{ injected: true }` สำหรับ project-specific fixture values

### 8. Hooks

1. ใช้ `aroundEach` สำหรับ wrap tests ใน context เช่น `AsyncLocalStorage` หรือ database transactions
2. ใช้ `aroundAll` สำหรับ wrap ทุก suite
3. ใช้ `beforeAll`, `afterAll` รับ file และ worker contexts จาก fixtures (Vitest 4.1)

### 9. In-Source Testing

1. เปิดใช้งาน `includeSource` ใน config
2. เขียน tests ใน source code ด้วย `if (import.meta.vitest)` block
3. ใช้สำหรับ test utilities ที่อยู่ใกล้กับ implementation

### 10. Mocking And Stubbing

1. ใช้ `vi.mock` สำหรับ mocking modules
2. ใช้ `vi.fn` สำหรับ creating mock functions
3. ใช้ `vi.spyOn` สำหรับ spying on methods
4. ใช้ `vi.defineHelper` สำหรับ wrap utility functions เพื่อ stack traces ที่ชี้ไป call site
5. ใช้ chai-style assertions เช่น `expect(fn).to.have.been.called` สำหรับ migrate จาก Sinon
6. ใช้ `vi.clearAllMocks` สำหรับ cleanup ระหว่าง tests

### 11. Coverage

1. ใช้ `coverage.include` แบบ explicit เพราะ Vitest 4 รายงานเฉพาะ files ที่ loaded ระหว่าง test run
2. ใช้ `coverage.changed` เพื่อ limit coverage report เฉพาะ changed files
3. ใช้ `/* v8 ignore start */` และ `/* v8 ignore stop */` สำหรับ ignore specific lines
4. ตั้งค่า `coverage.htmlDir` สำหรับ custom HTML coverage output

### 12. Watch Mode And CI

1. ตั้งค่า watch mode สำหรับ development
2. ใช้ `vitest run` สำหรับ CI/CD
3. ติดตั้ง VS Code extension สำหรับ IDE integration
4. ตั้งค่า coverage thresholds สำหรับ quality gates
5. ใช้ `--detect-async-leaks` สำหรับ catch leaked timers และ async resources
6. ใช้ GitHub Actions Job Summary reporter สำหรับ CI

## Rules

### 1. Vitest 4 Breaking Changes

- `poolOptions` ถูก removed ใช้ top-level `maxWorkers`, `isolate`, `vmMemoryLimit` แทน
- `maxThreads` และ `maxForks` ถูกแทนด้วย `maxWorkers`
- `singleThread` และ `singleFork` ถูกแทนด้วย `maxWorkers: 1, isolate: false`
- `coverage.all` และ `coverage.extensions` ถูก removed ใช้ `coverage.include` แทน
- `workspace` config ถูก deprecated ใช้ `test.projects` แทน
- Browser Mode เป็น stable แล้ว ใช้ `@vitest/browser-playwright` แทน `@vitest/browser`

### 2. Monorepo Configuration

- ใช้ `test.projects` array สำหรับ multi-project setup
- ใช้ `defineProject` ใน project config files ไม่ใช่ `defineConfig`
- `coverage`, `reporters`, `attachmentsDir` config ได้ที่ root level เท่านั้น
- แต่ละ project ต้องมี `name` ไม่ซ้ำกัน

### 3. Fixture Best Practices

- ใช้ builder pattern (return value) แทน `use()` สำหรับ type inference อัตโนมัติ
- ใช้ `scope: 'worker'` เฉพาะเมื่อ `isolate: false` เพื่อ benefit เต็มที่
- ใช้ `onCleanup` สำหรับ teardown แทน manual cleanup ใน `afterEach`
- ใช้ `test.override` สำหรับ suite-specific fixture values

### 4. Test Organization

- จัด test files ตามโครงสร้าง source code
- ใช้ `describe` สำหรับ grouping related tests
- ใช้ test tags สำหรับ categorize และ filter tests
- ใช้ `aroundEach` สำหรับ wrap tests ใน context

### 5. CI/CD

- ใช้ `vitest run` สำหรับ CI (ไม่ใช่ watch mode)
- ตั้งค่า `retry` สำหรับ flaky tests ใน CI
- ใช้ `--detect-async-leaks` ขณะ debugging เท่านั้นเพราะมี runtime overhead
- ใช้ `coverage.changed` สำหรับ limit coverage report ใน CI

## Expected Outcome

- Vitest 4 ติดตั้งและทำงานได้
- Config รองรับ globals, projects, และ monorepo
- Tests รันได้ทั้งหมด
- เป็นไปตาม best practices จาก Vitest 4.1 official documentation


