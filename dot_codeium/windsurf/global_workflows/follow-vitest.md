---
trigger: always_on
description: แนวทางการตั้งค่าและใช้งาน Vitest รวมถึง Vitest Projects สำหรับ monorepo
instruction:
  - ติดตั้ง Vitest และ dependencies ที่จำเป็น
  - ตั้งค่า package.json scripts สำหรับการรัน tests
  - สร้าง vitest.config.ts พร้อม configuration พื้นฐาน
  - กำหนด Vitest Projects สำหรับ monorepo ที่มีหลาย packages
  - เขียน test files สำหรับ source code
---

## 1. Installation (ใช้เสมอ)

1.1. ติดตั้ง Vitest ใน project

`ติดตั้ง Vitest` : ใช้ Bun เป็น package manager -> RUN bun add -D vitest

1.2. ติดตั้ง coverage provider

`ติดตั้ง coverage` : ต้องการ coverage reports -> RUN bun add -D @vitest/coverage-v8 หรือ @vitest/coverage-istanbul

1.3. ติดตั้ง dependencies เพิ่มเติมตามความต้องการ

`ติดตั้ง browser testing` : ต้องการ test ใน browser -> RUN bun add -D @vitest/browser @playwright/test

`ติดตั้ง Vue testing` : ใช้ Vue framework -> RUN bun add -D @vue/test-utils happy-dom

`ติดตั้ง Nuxt testing` : ใช้ Nuxt framework -> RUN bun add -D @nuxt/test-utils

---

## 2. Configuration (ใช้เสมอ)

2.1. ตั้งค่า package.json scripts

`เพิ่ม test scripts` : package.json ยังไม่มี scripts สำหรับ test -> ADD scripts ดังนี้:

```json [package.json]
{
  "scripts": {
    "test": "vitest",
    "test:run": "vitest --run",
    "test:coverage": "vitest run --coverage",
    "test:ui": "vitest --ui"
  }
}
```

2.2. สร้าง vitest.config.ts พื้นฐาน

`สร้าง config file` : ยังไม่มี vitest.config.ts -> CREATE file พร้อม configuration ดังนี้:

```ts [vitest.config.ts]
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html']
    }
  }
})
```

2.3. กำหนด environment ที่เหมาะสม

`เลือก environment` : ต้องเลือก environment ตามประเภทของ test:

- `node` : สำหรับ backend logic, utilities, pure functions
- `jsdom` หรือ `happy-dom` : สำหรับ frontend components, DOM manipulation
- `nuxt` : สำหรับ Nuxt application tests
- `edge-runtime` : สำหรับ edge functions

2.4. ตั้งค่า plugins ตามความต้องการ

`เพิ่ม plugins` : ใช้ framework หรือเครื่องมือเฉพาะทาง -> ADD plugins ใน config:

```ts [vitest.config.ts]
import vue from '@vitejs/plugin-vue'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [vue()], // หรือ [react()] สำหรับ React
  test: {
    // ... config
  }
})
```

---

## 3. Projects Configuration (ใช้เมื่อมีหลาย packages หรือ monorepo)

3.1. ตรวจสอบความเหมาะสมของการใช้งาน Vitest Projects

`ใช้ Projects` : มีหลาย packages หรือ workspaces ที่ต้อง test แยกกัน -> CONFIGURE projects ใน root vitest.config.ts

3.2. กำหนด glob patterns สำหรับ projects

`ระบุ projects` : มีโครงสร้าง monorepo -> DEFINE glob patterns สำหรับรวมทุก package:

```ts [vitest.config.ts]
export default defineConfig({
  test: {
    projects: [
      'packages/*/vitest.config.ts',
      'services/*/vitest.config.ts',
      'apps/*/vitest.config.ts',
      'utils/*/vitest.config.ts',
      'lib/*/vitest.config.ts',
      'cli/*/vitest.config.ts',
      'components/*/vitest.config.ts'
    ]
  }
})
```

3.3. ตั้งค่า extends เพื่อสืบทอดค่าจาก root config

`สืบทอด config` : ต้องการให้ projects สืบทอดค่าจาก root -> ADD extends: true:

```ts [vitest.config.ts]
export default defineConfig({
  plugins: [vue()],
  test: {
    pool: 'threads',
    projects: [
      {
        extends: true,
        test: {
          name: 'unit',
          include: ['**/*.unit.test.ts']
        }
      },
      {
        extends: false,
        test: {
          name: 'integration',
          include: ['**/*.integration.test.ts']
        }
      }
    ]
  }
})
```

3.4. กำหนด inline project configuration สำหรับ test types ที่แตกต่างกัน

`แยก test types` : มี test types หลายแบบ -> DEFINE inline projects:

```ts [vitest.config.ts]
export default defineConfig({
  test: {
    projects: [
      {
        test: {
          name: 'unit',
          include: ['test/unit/*.{test,spec}.ts'],
          environment: 'node'
        }
      },
      {
        test: {
          name: 'e2e',
          include: ['test/e2e/*.{test,spec}.ts'],
          environment: 'happy-dom'
        }
      }
    ]
  }
})
```

3.5. ตรวจสอบและแก้ไขปัญหาความซ้ำซ้อนของ project names

`แก้ duplicate names` : พบ project name ซ้ำกัน -> ADD negation patterns:

```ts [vitest.config.ts]
export default defineConfig({
  test: {
    projects: [
      'packages/*/vitest.config.ts',
      'utils/*/vitest.config.ts',
      '!utils/scripts/vitest.config.ts', // Exclude duplicate
      '!**/node_modules/**',
      '!**/dist/**'
    ]
  }
})
```

3.6. เพิ่ม scripts สำหรับรัน specific projects

`รัน specific project` : ต้องการ test เฉพาะ project หนึ่ง -> ADD script และใช้ flag --project:

```json [package.json]
{
  "scripts": {
    "test": "vitest",
    "test:project": "vitest --project"
  }
}
```

`รัน project` : ต้องการ test เฉพาะ @wpackages/async -> RUN bun run test --project @wpackages/async

`รันหลาย projects` : ต้องการ test หลาย projects -> RUN bun run test --project @wpackages/async --project @wpackages/cleanup

---

## 4. Write Tests (ใช้เมื่อต้องเขียน test สำหรับ source code)

4.1. วิเคราะห์โครงสร้างและระบุไฟล์ที่ต้องเขียน test

`ระบุ target files` : มีไฟล์ source code ที่ยังไม่มี test -> LIST ทุกไฟล์ใน directories ที่ระบุ

4.2. เขียน test files สำหรับ source code

`เขียน test` : พบไฟล์ที่ยังไม่มี test -> CREATE test file พร้อม:

- ใช้ describe เพื่อจัดกลุ่ม tests ตาม functionality
- ใช้ it เพื่อระบุ test case แต่ละอัน
- ใช้ expect เพื่อ assert ผลลัพธ์
- ตั้งชื่อ test ให้ชัดเจนและบอกว่าทำอะไร

```ts [example.test.ts]
import { describe, it, expect } from 'vitest'
import { myFunction } from './my-function'

describe('myFunction', () => {
  it('should return correct result when input is valid', () => {
    const result = myFunction('valid-input')
    expect(result).toBe('expected-output')
  })

  it('should throw error when input is invalid', () => {
    expect(() => myFunction('invalid-input')).toThrow()
  })
})
```

4.3. เขียน tests สำหรับทุกไฟล์ใน directories ที่ระบุ

`เขียน tests ใน utils/` : มีไฟล์ใน utils/ ที่ยังไม่มี test -> WRITE test files สำหรับทุกไฟล์

`เขียน tests ใน api/` : มีไฟล์ใน api/ ที่ยังไม่มี test -> WRITE test files สำหรับทุกไฟล์

`เขียน tests ใน db/` : มีไฟล์ใน db/ ที่ยังไม่มี test -> WRITE test files สำหรับทุกไฟล์

4.4. รัน tests เพื่อตรวจสอบ

`รัน tests` : เขียน tests เสร็จแล้ว -> RUN bun run test

`รัน coverage` : ต้องการดู coverage -> RUN bun run test:coverage

---

## 5. Best Practices (ใช้เสมอเมื่อทำงานกับ Vitest)

5.1. ใช้ globals เพื่อลดการ import

`ใช้ globals` : ต้องการลด boilerplate -> SET globals: true ใน config

5.2. จัดระเบียบ test files

`จัดระเบียบ tests` : มี tests จำนวนมาก -> ORGANIZE ตามโครงสร้าง:

- test/unit/ : สำหรับ unit tests
- test/integration/ : สำหรับ integration tests
- test/e2e/ : สำหรับ end-to-end tests

5.3. ใช้ mocking และ stubbing อย่างเหมาะสม

`mock dependencies` : ต้องการ test โดยไม่ต้องพึ่ง external services -> USE vi.mock() หรือ vi.fn()

5.4. ตรวจสอบ coverage อย่างสม่ำเสมอ

`ตรวจสอบ coverage` : ต้องการให้ code ถูกครอบคลุม -> RUN bun run test:coverage และตั้งเป้าหมาย coverage

5.5. ใช้ Vitest UI สำหรับ debugging

`ใช้ UI` : ต้องการ debug tests แบบ interactive -> RUN bun run test:ui