---
title: Setup UnoCSS
description: ติดตั้งและตั้งค่า UnoCSS สำหรับโปรเจกต์
auto_execution_mode: 3
file-patterns:
  - "**/uno.config.ts"
  - "**/postcss.config.*"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/follow-unocss-theme"
  files:
    - "guidelines/css-framework-rules.md"
---

## Purpose

ติดตั้ง UnoCSS ให้พร้อมใช้งานในโปรเจกต์ พร้อม config พื้นฐานสำหรับ utility-first CSS

## Scope

- ติดตั้ง UnoCSS สำหรับ framework ต่างๆ (Next.js, Nuxt, Vite, HTML CDN)
- ตั้งค่า configuration files ตาม framework
- ใช้งาน UnoCSS utilities ได้ทันที
- ไม่รวม theme colors (ดู `/follow-unocss-theme`)

## Inputs

| Input | Details |
|-------|-----------|
| Framework | Next.js, Nuxt, Vite, หรือ HTML CDN |
| Project Path | โปรเจกต์ที่ต้องการติดตั้ง UnoCSS |

## Rules

| Category | Requirements |
|------|---------|
| Runtime | ใช้ `bun` เท่านั้น ห้ามใช้ npm/npx/yarn/pnpm |
| Config | สร้าง `uno.config.ts` สำหรับทุก framework |
| Import | ใช้ `@unocss all` ใน CSS entry file |
| Content | ระบุ path ที่ถูกต้องใน content/filesystem |

## Structure

### Framework Configurations

| Framework | Config Files |
|-----------|-------------|
| Next.js | `postcss.config.mjs`, `uno.config.ts`, `app/globals.css` |
| Nuxt | `nuxt.config.ts`, `uno.config.ts` |
| Vite | `vite.config.ts`, `uno.config.ts`, `src/style.css` |
| HTML CDN | Single HTML file with CDN links |

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | Prepare | Verify framework, read existing config |
| Execute | Install & Config | Install deps, create config files |
| Verify | Test | Validate UnoCSS works |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบสิทธิ์**
  - มีสิทธิ์เขียนไฟล์ใน project directory
  - ไม่มี process อื่น lock ไฟล์

- 0.2 **ระบุ Framework**
  - ยืนยัน framework ที่ใช้ (Next.js/Nuxt/Vite/HTML)
  - ตรวจสอบว่าโปรเจกต์มีโครงสร้างถูกต้อง

### Phase 1: Setup

- 1.1 **เตรียม Context**
  - อ่าน config ที่มีอยู่แล้ว
  - ตรวจสอบ dependencies ปัจจุบัน

### Phase 2: Execute

- 2.1 **Next.js Setup**
  - Install: `bun add -d unocss @unocss/postcss`
  - Create `postcss.config.mjs` with @unocss/postcss plugin
  - Create `uno.config.ts`:

    ```ts
    import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass, presetUno } from 'unocss'
    export default defineConfig({
      darkMode: 'class',
      presets: [presetUno(), presetWind4({ preflights: { reset: true } })],
      transformers: [transformerVariantGroup(), transformerDirectives(), transformerCompileClass()],
      content: { filesystem: ['./app/**/*.{html,js,ts,jsx,tsx}'] },
    })
    ```

  - Add `@unocss all` to `app/globals.css`

- 2.2 **Nuxt Setup**
  - Install: `bun add -d unocss @unocss/nuxt`
  - Add `@unocss/nuxt` to modules in `nuxt.config.ts`
  - Create `uno.config.ts`:

    ```ts
    import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'
    export default defineConfig({
      presets: [presetWind4({ preflights: { reset: true } })],
      transformers: [transformerVariantGroup(), transformerDirectives(), transformerCompileClass()],
    })
    ```

- 2.3 **Vite Setup**
  - Install: `bun add -d unocss`
  - Add `unocss()` plugin to `vite.config.ts`
  - Create `uno.config.ts`:

    ```ts
    import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass, presetUno } from 'unocss'
    export default defineConfig({
      presets: [presetUno(), presetWind4({ preflights: { reset: true } })],
      transformers: [transformerVariantGroup(), transformerDirectives(), transformerCompileClass()],
      content: { filesystem: ['./src/**/*.{html,js,ts,jsx,tsx,vue,svelte}'] },
    })
    ```

  - Add `@unocss all` to `src/style.css`

- 2.4 **HTML CDN Setup**
  - Create HTML with CDN:

    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <script src="https://cdn.jsdelivr.net/npm/@unocss/runtime"></script>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@unocss/reset/tailwind.min.css">
    </head>
    <body>
      <div class="text-2xl font-bold text-red-500">Hello UnoCSS!</div>
    </body>
    </html>
    ```

### Phase 3: Verify

- 3.1 **ตรวจสอบการตั้งค่า**
  - รัน dev server
  - ทดสอบใช้ UnoCSS utilities:

    ```html
    <div class="flex items-center justify-center p-4 bg-blue-500 text-white">
      Hello UnoCSS!
    </div>
    ```

  - ตรวจสอบว่า styles ถูก apply

## Outputs

| Output | Details |
|--------|-----------|
| Config File | `uno.config.ts` with presets and transformers |
| Framework Config | Files specific to framework (postcss.config.mjs, vite.config.ts, etc.) |
| CSS Import | Entry file with `@unocss all` |

## Expected Outcome

- UnoCSS ติดตั้งและทำงานได้
- Utilities ใช้งานได้ทันที (e.g., `flex`, `bg-blue-500`)
- Config files สร้างถูกต้อง
- Dev server รันได้โดยไม่มี error

## Reference

- `/follow-unocss-theme` - ตั้งค่า theme colors และ Design System
- [UnoCSS Documentation](https://unocss.dev/)
- `@write-markdown` - แนวทางการเขียน Markdown
