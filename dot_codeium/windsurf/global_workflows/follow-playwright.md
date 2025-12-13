---
description: Playwright configuration, test structure, and best practices
auto_execution_mode: 3
---

## 1. playwright.config.ts

- ต้องมีไฟล์ `playwright.config.ts` ใน root ของ project
- ควรมี configuration ดังนี้:

```typescript
import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html'],
    ['json', { outputFile: 'test-results/results.json' }],
    ['junit', { outputFile: 'test-results/junit.xml' }],
  ],
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
})
```

## 2. โครงสร้างไฟล์ test

- สร้าง tests ใน `tests/` folder
- แยก test ตาม feature/page
- ใช้ Page Object Model pattern

```
tests/
├── e2e/
│   ├── auth.spec.ts
│   ├── cart.spec.ts
│   └── checkout.spec.ts
├── pages/
│   ├── login.page.ts
│   ├── home.page.ts
│   └── product.page.ts
├── fixtures/
│   ├── test-data.ts
│   └── mock-api.ts
└── utils/
    └── test-helpers.ts
```

## 3. การเขียน test ที่ดี

- ใช้ `test.describe` สำหรับจัดกลุ่ม tests
- ใช้ `test` สำหรับแต่ละ test case
- เขียน test name ให้ชัดเจน
- ใช้ Page Object Model
- ใช้ `test.beforeEach`, `test.afterEach` สำหรับ setup/teardown

```typescript
import { test, expect } from '@playwright/test'

test.describe('Login Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login')
  })

  test('should login successfully with valid credentials', async ({ page }) => {
    // Arrange
    await page.fill('[data-testid="email"]', 'user@example.com')
    await page.fill('[data-testid="password"]', 'password123')

    // Act
    await page.click('[data-testid="login-button"]')

    // Assert
    await expect(page).toHaveURL('/dashboard')
    await expect(page.locator('[data-testid="welcome-message"]')).toBeVisible()
  })

  test('should show error with invalid credentials', async ({ page }) => {
    await page.fill('[data-testid="email"]', 'invalid@example.com')
    await page.fill('[data-testid="password"]', 'wrongpassword')
    await page.click('[data-testid="login-button"]')

    await expect(page.locator('[data-testid="error-message"]')).toBeVisible()
    await expect(page.locator('[data-testid="error-message"]')).toContainText('Invalid credentials')
  })
})
```

## 4. Page Object Model

- สร้าง class สำหรับแต่ละ page
- Encapsulate selectors และ actions
- Re-use common interactions

```typescript
// pages/login.page.ts
import type { Page } from '@playwright/test'

export class LoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/login')
  }

  async login(email: string, password: string) {
    await this.page.fill('[data-testid="email"]', email)
    await this.page.fill('[data-testid="password"]', password)
    await this.page.click('[data-testid="login-button"]')
  }

  async getErrorMessage() {
    return this.page.locator('[data-testid="error-message"]')
  }
}

// ใช้งาน
import { test, expect } from '@playwright/test'
import { LoginPage } from './pages/login.page'

test('login test', async ({ page }) => {
  const loginPage = new LoginPage(page)
  await loginPage.goto()
  await loginPage.login('user@example.com', 'password123')
  await expect(page).toHaveURL('/dashboard')
})
```

## 5. Scripts ใน package.json

```json
{
  "scripts": {
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:debug": "playwright test --debug",
    "test:e2e:headed": "playwright test --headed",
    "test:e2e:report": "playwright show-report"
  },
  "devDependencies": {
    "@playwright/test": "latest"
  }
}
```

## Best Practices

- ใช้ `data-testid` attributes สำหรับ selectors
- หลีกเลี่ยง CSS selectors ที่ brittle
- ใช้ `waitForSelector` เมื่อจำเป็น
- ใช้ `screenshot` และ `video` สำหรับ debugging
- Run tests ใน parallel สำหรับ speed
- ใช้ `test.fixme()` สำหรับ flaky tests
- ใช้ `test.slow()` สำหรับ slow tests
- Mock external APIs ด้วย `page.route()`
- ใช้ fixtures สำหรับ reusable setup
- Test ใน multiple browsers
- ใช้ trace viewer สำหรับ debugging
- เก็บ test data แยกจาก test logic


