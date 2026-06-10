---
title: Playwright Configuration
description: ติดตั้งและตั้งค่า Playwright สำหรับ E2E testing
auto_execution_mode: 3
related_workflows:
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
5. ตรวจสอบ Node.js version (>= v14.0.0)

### 2. Configuration

1. สร้าง `playwright.config.ts` ที่ root
2. ตั้งค่า browsers (chromium, firefox, webkit)
3. ตั้งค่า testDir สำหรับ test files location
4. ตั้งค่า timeout สำหรับ test execution
5. ตั้งค่า retries สำหรับ flaky tests
6. ตั้งค่า reporter (html, json, junit)

### 3. Monorepo Setup

1. ตั้งค่า testDir สำหรับแต่ละ workspace
2. ใช้ workspace protocol สำหรับ internal dependencies
3. ตั้งค่า `--project` เพื่อรัน tests บน workspace เฉพาะ
4. ใช้ shared fixtures ข้าม workspaces
5. ตั้งค่า config extends จาก root config

### 4. Writing Tests

1. ใช้ `test` จาก `@playwright/test`
2. ใช้ `page` fixture สำหรับ browser automation
3. ใช้ `expect` สำหรับ assertions
4. จัดระเบียบ test files ตาม features หรือ pages
5. ใช้ `test.describe` สำหรับ grouping related tests
6. ใช้ `test.beforeEach`, `test.afterEach` สำหรับ setup/teardown

### 5. Page Object Model

1. สร้าง Page Object classes สำหรับแต่ละ page
2. แยก selectors และ actions ออกจาก test files
3. ใช้ locators แทน selectors เดิม
4. ใช้ `page.locator()` สำหรับ element selection
5. ใช้ `waitFor()` สำหรับ waiting strategies

### 6. Assertions And Matchers

1. ใช้ `expect(page).toHaveURL()` สำหรับ URL assertions
2. ใช้ `expect(locator).toBeVisible()` สำหรับ visibility
3. ใช้ `expect(locator).toHaveText()` สำหรับ text content
4. ใช้ `expect(locator).toHaveCount()` สำหรับ element count
5. ใช้ `expect(apiResponse).toBeOK()` สำหรับ API assertions

### 7. Running Tests

1. รัน tests ด้วย `bunx playwright test`
2. รัน tests ใน headed mode ด้วย `--headed`
3. รัน tests ใน debug mode ด้วย `--debug`
4. รัน tests บน browser เฉพาะด้วย `--project`
5. รัน tests ใน watch mode ด้วย VS Code extension

### 8. CI/CD Integration

1. ติดตั้ง browsers ใน CI pipeline
2. ใช้ `--shard` สำหรับ parallel execution
3. ตั้งค่า retries สำหรับ CI environment
4. อัพโหลด test reports สำหรับ CI artifacts
5. ใช้ GitHub Actions หรือ GitLab CI

## Rules

### 1. Configuration Requirements

ต้องมี config file ที่ root:

- ต้องมี `playwright.config.ts` ที่ root
- ใช้ `bun add -D @playwright/test` สำหรับ installation
- รัน `bunx playwright install` เพื่อติดตั้ง browsers
- ตั้งค่า testDir ให้ชัดเจน
- ตั้งค่า timeout และ retries อย่างเหมาะสม
- ใช้ reporter ที่เหมาะสมกับ CI/CD

### 2. Test Organization

จัดระเบียบ test files:

- จัด test files ตาม features หรือ pages
- ใช้ `test.describe` สำหรับ grouping related tests
- ใช้ test names ที่ชัดเจนและ descriptive
- ใช้ `test.beforeEach`, `test.afterEach` สำหรับ isolated tests
- ใช้ Page Object Model สำหรับ reusable code

### 3. Selectors Strategy

ใช้ selectors อย่างเหมาะสม:

- ใช้ locators แทน selectors เดิม (`page.locator()`)
- ใช้ role-based selectors (`getByRole()`)
- ใช้ text-based selectors (`getByText()`)
- ใช้ test IDs (`getByTestId()`)
- หลีกเลี่ยง CSS selectors ที่ fragile

### 4. Best Practices

ทำตาม best practices:

- ใช้ auto-waiting ของ Playwright
- ใช้ `waitFor()` สำหรับ dynamic content
- ใช้ Page Object Model สำหรับ maintainability
- ใช้ fixtures สำหรับ shared setup
- ใช้ parallel execution สำหรับ performance

## Expected Outcome

- Playwright ติดตั้งและทำงานได้
- Config รองรับ browsers และ monorepo
- E2E tests รันได้ทั้งหมด
- เป็นไปตาม best practices จาก official documentation
