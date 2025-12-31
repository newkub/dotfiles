---
trigger: always_on
---


## setup


1. package.json


``` json [package.json]
{
  "scripts" : {
    "test": "vitest --run",
    "test:coverage": "vitest run --coverage",
    "test:ui": "vitest --ui",
  }
}
```

2. vitest.config.ts


must have


``` ts [vitest.config.ts]
import { defineConfig } from 'vitest/config'
import { playwright } from '@vitest/browser-playwright'
import { defineVitestProject } from '@nuxt/test-utils/config'


export default defineConfig({
  plugins: [vue()],   // @ai ถ้ามีอย่างอื่นก็กำหนดให้เหมาะสม
  test: {
    environment: 'node', // @ai กำหนดให้เหมาะสมว่าจะใช้ node, edge-runtime, jsdom, happy-dom, nuxt
    coverage: {
      provider: 'v8',
      reporter: ['verbose', 'html']
    },
    typecheck: {
      checker: 'lint'
    },
  }
})
```


optional


``` ts [vitest.config.ts]
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

## write test

1. เขียน test ทุกไฟล์ใน utils/
2. เขียน test ทุกไฟล์ใน api/
3. เขียน test ทุกไฟล์ใน db/