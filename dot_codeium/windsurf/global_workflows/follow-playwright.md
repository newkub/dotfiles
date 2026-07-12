---
title: Playwright Configuration
description: ติดตั้งและตั้งค่า Playwright สำหรับ E2E testing
auto_execution_mode: 3
related:
  - /follow-vitest
  - /follow-typescript
  - /write-test
---

## Goal

ตั้งค่า Playwright เป็น E2E testing framework หลักสำหรับโปรเจกต์ web

## Scope

ติดตั้งและตั้งค่า Playwright สำหรับ end-to-end testing ในโปรเจกต์เดี่ยวและ monorepo

## Execute

### 1. Installation

1. ติดตั้ง Playwright ด้วย `bun add -D @playwright/test`
2. รัน `bunx playwright install` เพื่อติดตั้ง browsers
3. ติดตั้ง VS Code extension สำหรับ IDE integration
4. เพิ่ม test script ใน `package.json`
5. ตรวจสอบ Node.js version (>= v18.0.0)
6. อัพเดท Playwright เป็น latest version เสมอด้วย `bun add -D @playwright/test@latest`

### 2. Configuration

1. สร้าง `playwright.config.ts` ที่ root
2. ตั้งค่า browsers (chromium, firefox, webkit) ผ่าน `projects`
3. ตั้งค่า `testDir` สำหรับ test files location
4. ตั้งค่า `timeout` สำหรับ test execution (default 30,000ms)
5. ตั้งค่า `retries: process.env.CI ? 2 : 0` สำหรับ flaky tests
6. ตั้งค่า `workers: process.env.CI ? 4 : undefined` สำหรับ parallel execution
7. ตั้งค่า `fullyParallel: true` สำหรับ parallel tests within files
8. ตั้งค่า `trace: 'on-first-retry'` สำหรับ debugging
9. ตั้งค่า `screenshot: 'only-on-failure'` สำหรับ failure artifacts
10. ตั้งค่า `reporter` เป็น `html` สำหรับ local และ `blob` สำหรับ CI sharding
11. ตั้งค่า `forbidOnly: !!process.env.CI` สำหรับป้องกัน `test.only` ใน CI

### 3. Monorepo Setup

1. ตั้งค่า `testDir` สำหรับแต่ละ workspace
2. ใช้ workspace protocol สำหรับ internal dependencies
3. ตั้งค่า `--project` เพื่อรัน tests บน workspace เฉพาะ
4. ใช้ shared fixtures ข้าม workspaces
5. ตั้งค่า config extends จาก root config

### 4. Writing Tests

1. ใช้ `test` จาก `@playwright/test`
2. ใช้ `page` fixture สำหรับ browser automation
3. ใช้ `expect` สำหรับ web-first assertions ที่ auto-wait
4. จัดระเบียน test files ตาม features หรือ pages
5. ใช้ `test.describe` สำหรับ grouping related tests
6. ใช้ `test.beforeEach`, `test.afterEach` สำหรับ setup/teardown
7. ใช้ `test.describe.configure({ mode: 'parallel' })` สำหรับ parallel tests ใน file

### 5. Page Object Model

1. สร้าง Page Object classes สำหรับแต่ละ page
2. แยก selectors และ actions ออกจาก test files
3. ใช้ locators แทน selectors เดิม
4. ใช้ `page.locator()` สำหรับ element selection
5. ใช้ `waitFor()` สำหรับ waiting strategies

### 6. Locators Strategy

1. ใช้ `getByRole()` สำหรับ role-based selectors (preferred)
2. ใช้ `getByText()` สำหรับ text-based selectors
3. ใช้ `getByLabel()` สำหรับ form elements
4. ใช้ `getByTestId()` สำหรับ test IDs (เฉพาะเมื่อ role/text ไม่ได้)
5. หลีกเลี่ยง CSS selectors ที่ fragile
6. ใช้ `codegen` สำหรับ generate resilient locators
7. ใช้ locator chaining และ filtering สำหรับ narrow down

### 7. Assertions And Matchers

1. ใช้ `expect(page).toHaveURL()` สำหรับ URL assertions
2. ใช้ `expect(locator).toBeVisible()` สำหรับ visibility
3. ใช้ `expect(locator).toHaveText()` สำหรับ text content
4. ใช้ `expect(locator).toHaveCount()` สำหรับ element count
5. ใช้ `expect(apiResponse).toBeOK()` สำหรับ API assertions
6. ใช้ `expect(locator).toMatchAriaSnapshot()` สำหรับ accessibility tree verification

### 8. Authentication Setup

1. สร้าง setup project สำหรับ login ครั้งเดียว
2. บันทึก `storageState` ลง disk
3. ใช้ `storageState` ใน main project สำหรับเริ่มทุก test แบบ authenticated
4. ใช้ project `dependencies` สำหรับรัน setup ก่อน main tests
5. ใช้ `BrowserContext.setStorageState()` สำหรับ clear และ set state ใหม่

### 9. Running Tests

1. รัน tests ด้วย `bunx playwright test`
2. รัน tests ใน headed mode ด้วย `--headed`
3. รัน tests ใน debug mode ด้วย `--debug`
4. รัน tests บน browser เฉพาะด้วย `--project`
5. รัน tests ใน UI mode ด้วย `--ui` สำหรับ authoring และ debugging
6. ใช้ `--last-failed` สำหรับ re-run เฉพาะ tests ที่ fail

### 10. CI/CD Integration

1. ติดตั้ง browsers ใน CI pipeline ด้วย `bunx playwright install`
2. ใช้ `--shard=x/y` สำหรับ parallel execution ข้าม machines
3. ตั้งค่า `retries` สำหรับ CI environment
4. ใช้ `blob` reporter สำหรับ sharding และ `bunx playwright merge-reports` สำหรับรวม
5. อัพโหลด test reports สำหรับ CI artifacts
6. ใช้ GitHub Actions พร้อม `reuseExistingServer: true`
7. ใช้ `await using` syntax สำหรับ async disposables และ auto cleanup

## Rules

### 1. Configuration Requirements

ต้องมี config file ที่ root:

- ต้องมี `playwright.config.ts` ที่ root
- ใช้ `bun add -D @playwright/test` สำหรับ installation
- รัน `bunx playwright install` เพื่อติดตั้ง browsers
- ตั้งค่า `testDir` ให้ชัดเจน
- ตั้งค่า `fullyParallel: true` สำหรับ parallel execution
- ตั้งค่า `trace: 'on-first-retry'` สำหรับ debugging
- ตั้งค่า `screenshot: 'only-on-failure'` สำหรับ failure artifacts
- ใช้ `reporter` ที่เหมาะสมกับ environment (`html` local, `blob` CI)

### 2. Test Organization

จัดระเบียน test files:

- จัด test files ตาม features หรือ pages
- ใช้ `test.describe` สำหรับ grouping related tests
- ใช้ test names ที่ชัดเจนและ descriptive
- ใช้ `test.beforeEach`, `test.afterEach` สำหรับ isolated tests
- ใช้ Page Object Model สำหรับ reusable code

### 3. Selectors Strategy

ใช้ selectors อย่างเหมาะสม:

- ใช้ `getByRole()` เป็น preferred locator
- ใช้ `getByText()`, `getByLabel()` สำหรับ user-facing attributes
- ใช้ `getByTestId()` เฉพาะเมื่อ role/text ไม่เพียงพอ
- หลีกเลี่ยง CSS selectors ที่ fragile
- ใช้ `codegen` สำหรับ generate locators

### 4. Best Practices

ทำตาม best practices:

- ใช้ auto-waiting ของ Playwright (ไม่ใช้ `page.waitForTimeout()`)
- ใช้ web-first assertions ที่ auto-wait
- ใช้ Page Object Model สำหรับ maintainability
- ใช้ fixtures สำหรับ shared setup
- ใช้ `fullyParallel: true` สำหรับ performance
- ใช้ `request` fixture สำหรับ seed data ผ่าน API ไม่ใช่ UI
- ใช้ `storageState` สำหรับ authentication reuse
- หลีกเลี่ยง conditional logic (`if`, `try/catch`) ใน tests
- อัพเดท Playwright version เป็น latest เสมอ

### 5. CI/CD

- ใช้ `--shard=x/y` สำหรับแบ่ง tests ข้าม CI machines
- ใช้ `blob` reporter สำหรับ sharding และ `merge-reports` สำหรับรวม
- ตั้งค่า `forbidOnly: !!process.env.CI` สำหรับป้องกัน `test.only`
- ใช้ `reuseExistingServer: true` สำหรับ local iteration speed
- ติดตั้งเฉพาะ browsers ที่จำเป็นใน CI

## Expected Outcome

- Playwright ติดตั้งและทำงานได้
- Config รองรับ browsers, parallelism, และ monorepo
- E2E tests รันได้ทั้งหมด
- เป็นไปตาม best practices จาก Playwright 2026 official documentation
