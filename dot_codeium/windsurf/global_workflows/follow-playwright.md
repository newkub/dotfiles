---
trigger: always_on
description: แนวทางการตั้งค่าและเขียน E2E tests ด้วย Playwright
instruction:
  - ตั้งค่า Playwright config ตาม best practices
  - ใช้ Page Object Model (POM) สำหรับ maintainability
  - เขียน tests ที่ reliable และ maintainable
---

## 1. Installation (ใช้เสมอ)

1.1. ติดตั้ง Playwright dependencies
1.2. ตั้งค่า scripts สำหรับ E2E testing

```bash
bun add -D @playwright/test
```

```json [package.json]
{
  "scripts": {
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:debug": "playwright test --debug",
    "test:e2e:headed": "playwright test --headed",
    "test:e2e:report": "playwright show-report"
  }
}
```

---

## 2. Configuration (ใช้เสมอ)

2.1. สร้าง `playwright.config.ts` ใน root ของ project
2.2. ตั้งค่า test directory และ parallel execution
2.3. ตั้งค่า reporters สำหรับ test results
2.4. ตั้งค่า browsers และ devices สำหรับ testing
2.5. ตั้งค่า web server สำหรับ development

```ts [playwright.config.ts]
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

---

## 3. Folder Rules (ใช้เสมอ)

3.1. `tests/e2e/` : เขียน E2E tests -> แยก test ตาม feature/page
3.2. `tests/pages/` : สร้าง Page Objects -> encapsulate selectors และ actions
3.3. `tests/fixtures/` : สร้าง test data -> ใช้สำหรับ mock data และ test data
3.4. `tests/utils/` : สร้าง test helpers -> ใช้สำหรับ reusable helper functions

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

---

## 4. Page Object Model (ใช้เสมอ)

4.1. `Page Class` : สร้าง Page Object -> encapsulate selectors และ actions
4.2. `Selectors` : ใช้ selectors -> ใช้ `data-testid` attributes
4.3. `Actions` : สร้าง actions -> สร้าง methods สำหรับ user interactions

```ts [tests/pages/login.page.ts]
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

---

## 5. Test Rules (ใช้เสมอ)

5.1. `test.describe` : จัดกลุ่ม tests -> ใช้ test.describe สำหรับ grouping
5.2. `Test Names` : ตั้งชื่อ tests -> เขียน test name ที่ชัดเจนและ descriptive
5.3. `Lifecycle Hooks` : setup/teardown -> ใช้ test.beforeEach และ test.afterEach
5.4. `Assertions` : assert results -> ใช้ expect อย่างชัดเจน

```ts [tests/e2e/auth.spec.ts]
import { test, expect } from '@playwright/test'
import { LoginPage } from '../pages/login.page'

test.describe('Login Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login')
  })

  test('should login successfully with valid credentials', async ({ page }) => {
    const loginPage = new LoginPage(page)
    await loginPage.login('user@example.com', 'password123')

    await expect(page).toHaveURL('/dashboard')
    await expect(page.locator('[data-testid="welcome-message"]')).toBeVisible()
  })
})
```

---

## 6. Best Practices (ใช้เสมอ)

6.1. `Selectors` : ใช้ selectors -> ใช้ `data-testid` attributes แทน CSS selectors

6.2. `Mocking` : mock external APIs -> ใช้ `page.route()` เมื่อจำเป็น

6.3. `Debugging` : debugging tests -> เปิด `trace`, `screenshot`, `video` สำหรับ debugging

6.4. `Performance` : รัน tests -> รันแบบ parallel และใช้ retries ใน CI

6.5. `Reliability` : เขียน reliable tests -> หลีกเลี่ยง hardcoded waits และใช้ auto-waiting

---

## 7. Import Rules (ใช้เสมอ)

7.1. `tests/e2e` : import dependencies -> import จาก tests/pages, tests/fixtures, tests/utils

7.2. `tests/pages` : import dependencies -> import จาก tests/utils

7.3. `tests/fixtures` : import dependencies -> ไม่มี internal dependencies

```plaintext
tests/e2e  <-- tests/pages, tests/fixtures, tests/utils
tests/pages <-- tests/utils
tests/fixtures <-- (no internal dependencies)
