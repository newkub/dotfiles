---
trigger: always_on
---
 
## 1. Project Structure

```plaintext
.
├── docs/
├── examples/
├── scripts/          # Release or other scripts
├── src/
│   ├── module.ts
│   └── runtime/
│       ├── assets/     # Static assets
│       ├── components/
│       ├── composables/
│       ├── plugins/
│       ├── templates/
│       └── utils/
├── .gitignore
├── package.json
├── tsconfig.json
└── tsdown.config.ts  # Build configuration
```

## 2. Development

-   ใช้ `@nuxt/kit`: เป็นเครื่องมือหลักสำหรับสร้างโมดูล มี utilities ที่จำเป็นครบถ้วน
-   แยก Runtime Code: โค้ดที่ต้องใช้ในฝั่ง client หรือ server ของ Nuxt app ควรอยู่ใน `src/runtime/` เพื่อให้ tree-shaking ทำงานได้ดี
-   Module Options: ออกแบบ options ให้ยืดหยุ่นและมี type-safety โดยกำหนด schema ใน `meta.configKey` และ interface ใน `module.ts`
-   Auto-imports: ใช้ `addImportsDir` และ `addComponentsDir` เพื่อให้ composables และ components ถูก import อัตโนมัติ
-   Templates: ใช้ `addTemplate` สำหรับการสร้างไฟล์แบบ dynamic (เช่น plugins ที่ต้องใช้ options จากผู้ใช้)


## `src/module.ts`

```typescript
import { defineNuxtModule, createResolver, addPlugin } from '@nuxt/kit'

export default defineNuxtModule({
  meta: {
    name: 'my-module',
    configKey: 'myModule'
  },
  defaults: {
    // Default options
  },
  setup (options, nuxt) {
    const resolver = createResolver(import.meta.url)

    // Add runtime plugin
    addPlugin(resolver.resolve('./runtime/plugin'))

    // ... add other logic here
  }
})
```


## 3. Publishing

- /follow-release-it