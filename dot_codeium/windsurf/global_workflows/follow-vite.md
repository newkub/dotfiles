---
trigger: always_on
description: "ตั้งค่าและพัฒนา Vite project ด้วย best practices"
instruction:
  - ตรวจสอบ framework ที่ใช้กับ Vite
  - ตั้งค่า base configuration ที่ซ้ำกัน
  - ทำตาม workflow ที่เหมาะสมกับ framework นั้น
  - refactor โค้ดให้ถูกต้อง
---

## 1. Framework Detection (ใช้เสมอ)

1.1. ตรวจสอบ framework ที่ใช้กับ Vite
   - ตรวจสอบ dependencies ใน package.json
   - ตรวจสอบไฟล์ components (.vue, .tsx, .svelte)

1.2. ระบุ framework ที่ใช้
   - Vue: มี vue ใน dependencies หรือมีไฟล์ .vue
   - React: มี react ใน dependencies หรือมีไฟล์ .tsx
   - Svelte: มี svelte ใน dependencies หรือมีไฟล์ .svelte
   - Solid: มี solid-js ใน dependencies

## 2. Base Configuration (ใช้เสมอ)

2.1. ตั้งค่า scripts ใน package.json

```json [package.json]
{
  "scripts": {
    "dev": "vite dev",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

2.2. ตั้งค่า vite.config.ts (base)

```ts [vite.config.ts]
import { defineConfig } from 'vite';
import checker from 'vite-plugin-checker';
import tsconfigPaths from 'vite-tsconfig-paths';
import Unocss from '@unocss/vite';
import AutoImport from 'unplugin-auto-import/vite';
import Replace from 'unplugin-replace/vite';
import Unused from 'unplugin-unused/vite';
import TurboConsole from 'unplugin-turbo-console/vite';
import Terminal from 'vite-plugin-terminal';
import { analyzer } from 'vite-bundle-analyzer';
import Inspect from 'vite-plugin-inspect';
import AST from 'unplugin-ast/vite';
import Macros from 'unplugin-macros/vite';
import UnpluginIsolatedDecl from 'unplugin-isolated-decl/vite';
import Icons from 'unplugin-icons/vite';
import { nitro } from "nitro/vite";

export default defineConfig({
  plugins: [
    nitro(),
    Unocss(), // @ai /follow-unocss
    AutoImport({
      imports: ['FRAMEWORK'], // @ai แทนที่ด้วย framework ที่ใช้
      dts: true
    }),
    AST(),
    Icons({
      autoInstall: true,
    }),
    UnpluginIsolatedDecl(),
    Macros(),
    Replace(),
    TurboConsole({}),
    Terminal(),
    analyzer(),
    Inspect(),
    Unused({
      include: [/\.([cm]?[jt]sx?|vue|svelte)$/],
      exclude: [/node_modules/],
      level: 'warning',
      ignore: {
        peerDependencies: ['FRAMEWORK'], // @ai แทนที่ด้วย framework ที่ใช้
      },
      depKinds: ['dependencies', 'peerDependencies'],
    }),
    tsconfigPaths(),
    checker({
      overlay: {
        initialIsOpen: false,
      },
      typescript: true,
      eslint: true,
      oxlint: true,
    })
  ]
});
```

2.3. ตั้งค่า tsconfig.json (base)

```json [tsconfig.json]
{
  "compilerOptions": {
    "types": ["vite/client", "FRAMEWORK"] // @ai แทนที่ด้วย framework ที่ใช้
  }
}
```

## 3. Framework-specific Configuration (ใช้เมื่อพบ framework)

3.1. Vue
   - เพิ่ม framework plugin: ไม่ต้องเพิ่ม (Vue ใช้ built-in)
   - แทนที่ FRAMEWORK ด้วย 'vue'
   - แทนที่ checker.vueTsc ด้วย true
   - ทำ /follow-vite-vue

3.2. React
   - เพิ่ม framework plugin: ไม่ต้องเพิ่ม (React ใช้ built-in)
   - แทนที่ FRAMEWORK ด้วย ['react', 'react-dom']
   - ทำ /follow-vite-react

3.3. Svelte
   - เพิ่ม framework plugin: svelte() จาก @sveltejs/vite-plugin-svelte
   - แทนที่ FRAMEWORK ด้วย 'svelte'
   - ทำ /follow-vite-svelte

3.4. Solid
   - เพิ่ม framework plugin: solid() จาก vite-plugin-solid
   - แทนที่ FRAMEWORK ด้วย 'solid-js'
   - ทำ /follow-vite-solid

## 4. Vite Plugin Checker Configuration (ใช้เสมอ)

4.1. ตั้งค่า checker ใน vite.config.ts

```ts [vite.config.ts]
import checker from "vite-plugin-checker";

export default defineConfig({
  plugins: [
    checker({
      overlay: {
        initialIsOpen: false,
      },
      oxlint: true,
      typescript: true,
      eslint: true,
      vueTsc: true, // @ai ถ้าใช้ Vue
    }),
  ],
});
```

4.2. ตั้งค่า checker ใน nuxt.config.ts (ถ้าใช้ Nuxt)

```ts [nuxt.config.ts]
import checker from "vite-plugin-checker";

export default defineNuxtConfig({
  vite: {
    plugins: [
      checker({
        overlay: {
          initialIsOpen: false,
        },
        biome: { command: "lint" },
        oxlint: true,
        typescript: true,
        vueTsc: true,
      }),
    ],
  },
});
```

## 5. Code Refactoring (ใช้เสมอ)

5.1. ทำ /refactor
   - refactor โค้ดให้ถูกต้องตาม framework

---

## หมายเหตุ

- ถ้าไม่พบ framework ใดๆ ให้ใช้ /follow-best-practices
- ตรวจสอบว่า Vite config เข้ากันได้กับ framework ที่ใช้
- ใช้ plugins ที่เหมาะสมกับ framework นั้นๆ
- FRAMEMARKER คือ placeholder ที่ต้องแทนที่ด้วย framework ที่ใช้จริง