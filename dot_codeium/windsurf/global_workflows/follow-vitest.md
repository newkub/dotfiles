---
description: Vitest Best Practices - Comprehensive Rules
auto_execution_mode: 3
---


## 1. vite in workspace

1.  bun add -d vitest @vitest/coverage-v8 @vitest/browser-preview @vitest/browser-playwright

2. กำหนดใน package.json

``` json
{
  "scripts" : {
    "test": "vitest run",
    "test:watch": "vitest watch",
    "test:coverage": "vitest run --coverage",
    "test:ui": "vitest --ui",
  }
}
``` 

3. กำหนดใน vitest.config.ts

``` ts
import { defineConfig } from 'vitest/config'
import { playwright } from '@vitest/browser-playwright'

export default defineConfig({
  test: {
    environment: 'node',
    globals: true,
    env: {
      NODE_ENV: 'test'
    },
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html']
    },
    testTimeout: 10000,
    typecheck: {
      checker: 'lint'
    },
    browser: {
      provider: playwright(),
      enabled: true,
      headless: true,
      instances: [{ browser: 'chromium' }]
    },
  }
})
```

## 2. vite monorepo workspace (ถ้ามี)

1. สร้าง vitest.config.ts ที่ root โดย projects: ให้กำหนดเหมือนที่กำหนดใน workspace

``` ts [vitest.ts]
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    projects: ['packages/*'],
  },
})
```

