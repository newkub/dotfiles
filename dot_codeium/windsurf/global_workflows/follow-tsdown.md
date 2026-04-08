---
title: Follow Tsdown
description: ตั้งค่าและใช้งาน tsdown สำหรับ bundle TypeScript libraries ด้วย Rolldown - รองรับทุก config options และ plugin ecosystems
auto_execution_mode: 3
---

## Prompt

ตั้งค่า tsdown เป็น library bundler ที่ออกแบบมาเพื่อความเร็วสูงและ type declarations generation โดยใช้ Rolldown

รองรับการติดตั้ง tsdown, กำหนดค่า tsdown.config.ts, เพิ่ม build scripts ใน package.json, และรองรับ multiple output formats (ESM, CJS, IIFE, UMD)

ไม่รวม Application bundling (ใช้ Vite หรือ frameworks อื่น) และ CSS/Asset bundling ที่ซับซ้อน

## Execute

1. วิเคราะห์โปรเจกต์และความต้องการ

- ตรวจสอบว่าเป็น TypeScript library project
- ยืนยันว่ามี Bun ติดตั้งแล้ว
- ตรวจสอบว่ามี package.json อยู่แล้ว
- ระบุ output formats ที่ต้องการ (ESM, CJS, IIFE)

2. ดำเนินการตั้งค่า tsdown

- ติดตั้ง tsdown ด้วยคำสั่ง `bun add -D tsdown`
- สร้างไฟล์ tsdown.config.ts พร้อมกำหนด entry, format, dts generation
- เพิ่ม build scripts ใน package.json (build, build:watch)
- รัน build เพื่อตรวจสอบว่าทำงานได้ถูกต้อง

3. ตรวจสอบความถูกต้องและยืนยันว่าพร้อมใช้งาน

- ตรวจสอบ output ใน dist/ ว่าสร้างถูกต้อง
- ยืนยันว่า type declarations (.d.ts) สร้างครบถ้วน
- ทดสอบ build scripts ว่าทำงานได้

## Rules

1. การติดตั้ง

- ใช้คำสั่ง `bun add -D tsdown` เท่านั้น
- ติดตั้ง unplugin-vue/rolldown หากต้องการ build Vue components
- ตรวจสอบ installation สำเร็จก่อนดำเนินการต่อ

2. การกำหนดค่า

- สร้างไฟล์ `tsdown.config.ts` ใช้ TypeScript format
- ระบุ `entry` เป็น array เช่น `['./src/index.ts']`
- กำหนด output formats เป็น array เช่น `['esm', 'cjs']`
- Enable dts generation ด้วย `dts: true` หรือ `dts: { vue: true }`

3. Build Scripts

- เพิ่ม script `"build": "tsdown"` ใน package.json
- เพิ่ม script `"build:watch": "tsdown --watch"` สำหรับ development
- เพิ่ม script `"watch": "tsdown --watch"` สำหรับ shortcut

4. Output Configuration

- เปิดใช้ `clean: true` เพื่อล้าง dist ก่อน build
- เปิดใช้ `treeshake: true` สำหรับ tree shaking
- เปิดใช้ `minify: true` สำหรับ production build

5. โครงสร้างไฟล์

```text
project/
├── tsdown.config.ts      # Bundle config
├── package.json          # Build scripts
├── src/
│   └── index.ts          # Entry point
└── dist/                 # Output
```

6. Expected Output

- tsdown.config.ts สร้างถูกต้อง
- package.json มี build scripts ครบถ้วน
- dist/ มี bundled files (ESM + CJS)
- dist/*.d.ts มี type declarations ครบถ้วน

## Configuration Options Reference

### Core Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `entry` | `string \| string[] \| Record<string, string>` | `['src/index.ts']` | Entry point(s) for bundling |
| `format` | `'esm' \| 'cjs' \| 'iife' \| 'umd' \| array` | `'esm'` | Output format(s) |
| `outDir` | `string` | `'dist'` | Output directory |
| `platform` | `'node' \| 'neutral' \| 'browser'` | `'node'` | Target platform |
| `target` | `string \| string[] \| false` | - | Compilation target (e.g., 'node18', 'es2020') |

### Type Declaration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `dts` | `boolean \| DtsOptions` | auto-detect | Enable .d.ts generation |
| `dts.vue` | `boolean` | - | Support Vue SFC type generation |
| `tsconfig` | `string \| boolean` | - | Path to tsconfig.json |

### Dependency Handling

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `deps.neverBundle` | `string[]` | - | Packages to never bundle (external) |
| `deps.alwaysBundle` | `string[]` | - | Packages to always bundle |
| `external` | `string \| RegExp \| array` | - | External dependencies (deprecated, use deps) |

### Output Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `clean` | `boolean \| string[]` | `true` | Clean directories before build |
| `sourcemap` | `boolean \| Sourcemap` | `false` | Generate source maps |
| `minify` | `boolean \| 'dce-only' \| MinifyOptions` | `false` | Minify output |
| `treeshake` | `boolean \| TreeshakingOptions` | `true` | Tree shaking configuration |
| `splitting` | `boolean` | `true` | Code splitting |
| `hash` | `boolean` | `true` | Append hash to chunk filenames |
| `fixedExtension` | `boolean` | `true` (node) | Use .cjs/.mjs extensions |

### Plugin Options

| Option | Type | Description |
|--------|------|-------------|
| `plugins` | `RolldownPluginOption[]` | Rollup/Rolldown plugins |
| `alias` | `Record<string, string>` | Path aliases |
| `define` | `Record<string, string>` | Compile-time defines |
| `loader` | `ModuleTypes` | File loaders |
| `globImport` | `boolean` | Enable import.meta.glob |

### Advanced Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `bundle` | `boolean` | `true` | Bundle mode (deprecated, use unbundle) |
| `unbundle` | `boolean` | `false` | Unbundle mode (mirror input structure) |
| `shims` | `boolean` | `false` | Add shims for CJS/ESM interop |
| `cjsDefault` | `boolean` | `true` | CJS default export handling |
| `nodeProtocol` | `boolean \| 'strip'` | `false` | Handle node: protocol |
| `workspace` | `boolean \| string[]` | - | Enable workspace mode |
| `watch` | `boolean \| string[]` | `false` | Watch mode |
| `write` | `boolean` | `true` | Write files to disk |

### Quality/Reporting Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `attw` | `boolean \| AttwOptions` | `false` | Run arethetypeswrong |
| `publint` | `boolean \| PublintOptions` | `false` | Run publint |
| `report` | `boolean \| ReportOptions` | `true` | Enable size reporting |
| `unused` | `boolean \| UnusedOptions` | `false` | Check unused dependencies |
| `checks` | `object` | - | Warning control |
| `failOnWarn` | `boolean` | `false` | Fail on warnings |

### Hooks & Lifecycle

| Option | Type | Description |
|--------|------|-------------|
| `hooks` | `TsdownHooks \| function` | Build hooks |
| `onSuccess` | `string \| function` | Command after successful build |

## Supported Plugin Ecosystems

tsdown รองรับ plugins จากหลาย ecosystems:

### 1. Rolldown Plugins (Native)
- Built-in support เพราะ tsdown สร้างบน Rolldown
- ใช้ได้ทันทีไม่มีปัญหา compatibility

### 2. Unplugin Plugins
- [unplugin](https://unplugin.unjs.io/) framework รองรับหลาย bundlers
- Plugins ที่ขึ้นต้นด้วย `unplugin-` ใช้ได้กับ tsdown
- ตัวอย่าง: `unplugin-vue`, `unplugin-icons`, `unplugin-auto-import`

### 3. Rollup Plugins
- Rolldown compatible กับ Rollup plugin API
- ใช้ Rollup plugins ได้โดยไม่ต้องแก้ไข
- หากมี TypeScript errors ให้ใช้ `// @ts-expect-error` หรือ `as any`

### 4. Vite Plugins (Limited)
- Vite plugins ที่ไม่พึ่ง Vite-specific APIs ใช้ได้
- Plugins ที่พึ่ง Vite internals อาจไม่ทำงาน

### Common Plugins

| Plugin | Purpose | Install |
|--------|---------|---------|
| `unplugin-vue/rolldown` | Vue SFC support | `bun add -D unplugin-vue` |
| `@rollup/plugin-json` | JSON imports | `bun add -D @rollup/plugin-json` |
| `@rollup/plugin-node-resolve` | Node resolve | built-in |
| `@rollup/plugin-commonjs` | CJS support | built-in |

## Configuration Templates

### Basic Library

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  entry: ['./src/index.ts'],
  format: ['esm', 'cjs'],
  dts: true,
  clean: true,
  treeshake: true
})
```

### Vue Library

```typescript
import { defineConfig } from 'tsdown'
import Vue from 'unplugin-vue/rolldown'

export default defineConfig({
  entry: ['./src/index.ts'],
  format: ['esm'],
  plugins: [
    Vue({ isProduction: true })
  ],
  dts: {
    vue: true
  },
  clean: true,
  treeshake: true,
  deps: {
    neverBundle: [
      'vue',
      'vue-router',
      '@vueuse/core'
    ]
  }
})
```

### Nuxt Module

```typescript
import { defineConfig } from 'tsdown'
import Vue from 'unplugin-vue/rolldown'

export default defineConfig({
  entry: ['./src/module.ts'],
  format: ['esm'],
  platform: 'neutral',
  plugins: [
    Vue({ isProduction: true })
  ],
  dts: {
    vue: true
  },
  clean: true,
  treeshake: true,
  deps: {
    neverBundle: [
      '@nuxt/kit',
      '@nuxt/schema',
      'vue',
      'vue-router',
      '@vueuse/core',
      'defu',
      '#app',
      '#imports'
    ]
  }
})
```

### Monorepo Workspace

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  workspace: true,
  entry: ['./packages/*/src/index.ts'],
  format: ['esm', 'cjs'],
  dts: true,
  clean: true
})
```

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows
- [tsdown Documentation](https://github.com/sxzz/tsdown)
- [tsdown.dev](https://tsdown.dev)
