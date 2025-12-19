---
auto_execution_mode: 3
---


1.  bun add -d vitest @vitest/coverage-v8 @vitest/browser-preview @vitest/browser-playwright @nuxt/test-utils

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

3. folder structure

``` 
test/
├── e2e/
│   └── ssr.test.ts
├── nuxt/
│   ├── components.test.ts
│   └── composables.test.ts
├── unit/
│   └── utils.test.ts
``` 

3. กำหนดใน vitest.config.ts เป็นอย่างน้อย

``` ts
import { defineConfig } from 'vitest/config'
import { playwright } from '@vitest/browser-playwright'
import { defineVitestProject } from '@nuxt/test-utils/config'


export default defineConfig({
  plugins: [vue()],   // ถ้ามีอย่างอื่นก็กำหนดให้เหมาะสม
  test: {
    projects: [
      {
        test: {
          name: 'unit',
          include: ['test/{e2e,unit}/*.{test,spec}.ts'],
          environment: 'node',
        },
      },
      await defineVitestProject({
        test: {
          name: 'nuxt',
          include: ['test/nuxt/*.{test,spec}.ts'],
          environment: 'nuxt',
        },
      }),
    environment: 'node', // กำหนดให้เหมาะสมว่าจะใช้ node, edge-runtime, jsdom
    coverage: {
      provider: 'v8',
      reporter: ['verbose']
    },
    typecheck: {
      checker: 'lint'
    },
    browser: {
      enabled: true,
      provider: playwright(),
      trace: 'on',
      headless: true,
       instances: [
        { browser: 'chromium' },
        { browser: 'firefox' },
        { browser: 'webkit' },
      ],
    },
  }
})
```

หมายเหตุ
- ถ้าใน package.json ใช้ nuxt ให้ใช้ environment: 'nuxt' และให้ bun i -d @nuxt/test-utils

``` ts
import { defineConfig } from 'vitest/config'
import { defineVitestConfig } from '@nuxt/test-utils/config'


export default defineConfig({
  test: {
    environment: 'nuxt',
  }
})
```



