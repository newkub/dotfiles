---
trigger: always_on
---

## Setup

### config

#### `playwright.config.ts`

- ต้องมีไฟล์ `playwright.config.ts` ใน root ของ project

```ts
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
    command: 'bun run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
})
```

#### `package.json`

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

### Libraries

- `@playwright/test`

## Project Structure

```plaintext
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

## Core Principles

- ใช้ `test.describe` สำหรับจัดกลุ่ม tests
- เขียน test name ให้ชัดเจน
- ใช้ `test.beforeEach`, `test.afterEach` สำหรับ setup/teardown
- ใช้ Page Object Model (POM) เพื่อแยก selector/actions ออกจาก test

## Folder Rules

### `tests/e2e/`

- Do
  - แยก test ตาม feature/page
  - assert ด้วย `expect` ให้ชัดเจน

### `tests/pages/`

- Do
  - Encapsulate selectors + actions
  - Reuse common interactions

```ts
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

  getErrorMessage() {
    return this.page.locator('[data-testid="error-message"]')
  }
}
```

### Example test

```ts
import { test, expect } from '@playwright/test'

test.describe('Login Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login')
  })

  test('should login successfully with valid credentials', async ({ page }) => {
    await page.fill('[data-testid="email"]', 'user@example.com')
    await page.fill('[data-testid="password"]', 'password123')
    await page.click('[data-testid="login-button"]')

    await expect(page).toHaveURL('/dashboard')
    await expect(page.locator('[data-testid="welcome-message"]')).toBeVisible()
  })
})
```

### Best Practices

- ใช้ `data-testid` attributes สำหรับ selectors
- หลีกเลี่ยง CSS selectors ที่ brittle
- ใช้ `page.route()` mock external APIs เมื่อจำเป็น
- เปิด `trace`, `screenshot`, `video` สำหรับ debugging
- รันแบบ parallel เพื่อ speed และใช้ retries ใน CI

## Import Rules

```plaintext
tests/e2e  <-- tests/pages, tests/fixtures, tests/utils
tests/pages <-- tests/utils
tests/fixtures <-- (no internal dependencies)
```
