---
title: UnoCSS
description: ติดตั้งและตั้งค่า UnoCSS พร้อม presetWind4 และ transformers
auto_execution_mode: 3
related_workflows:
  - /follow-unocss-theme
  - /follow-formatter
---

## Goal

สร้าง UnoCSS configuration ที่พร้อมใช้งานด้วย presetWind4, transformers และรองรับทุก framework

## Scope

ใช้สำหรับติดตั้งและตั้งค่า UnoCSS บน Next.js, Nuxt, Vite, และ HTML CDN

## Execute

### 1. Prepare

1. ตรวจสอบ framework ที่ใช้ (Next.js, Nuxt, Vite, HTML)
2. อ่าน config ที่มีอยู่แล้ว
3. ระบุตำแหน่ง CSS entry point

### 2. Install Dependencies

1. ติดตั้ง UnoCSS:

   ```bash
   bun add -d unocss
   ```

2. สำหรับ Next.js ติดตั้งเพิ่ม:

   ```bash
   bun add -d @unocss/postcss
   ```

3. สำหรับ Nuxt ติดตั้งเพิ่ม:

   ```bash
   bun add -d @unocss/nuxt
   ```

4. สำหรับ Icons ติดตั้ง iconify collections:

   ```bash
   bun add -d @iconify-json/mdi
   ```

### 3. Configure

ตั้งค่า UnoCSS config พื้นฐาน

1. สร้าง `uno.config.ts` พื้นฐาน:

   ```ts
   import { defineConfig, presetWind4, presetIcons, transformerVariantGroup, transformerDirectives } from 'unocss'

   export default defineConfig({
     presets: [
       presetWind4(),
       presetIcons({
         collections: {
           mdi: () => import('@iconify-json/mdi/icons.json').then(i => i.default),
         },
       }),
     ],
     transformers: [
       transformerVariantGroup(),
       transformerDirectives(),
     ],
   })
   ```

2. สำหรับ Next.js เพิ่ม content path:

   ```ts
   content: { filesystem: ['./app/**/*.{html,js,ts,jsx,tsx}'] }
   ```

3. สำหรับ Vite เพิ่ม content path:

   ```ts
   content: { filesystem: ['./src/**/*.{html,js,ts,jsx,tsx,vue,svelte}'] }
   ```

### 4. Setup Framework Integration

1. **Next.js**: สร้าง `postcss.config.mjs` และเพิ่ม `@unocss all;` ใน `app/globals.css`
2. **Nuxt**: เพิ่ม `@unocss/nuxt` module ใน `nuxt.config.ts`
3. **Vite**: เพิ่ม UnoCSS plugin ใน `vite.config.ts` และ `@unocss all;` ใน `src/style.css`

### 5. Verify

รัน dev server และทดสอบใช้ utilities เช่น `flex`, `bg-blue-500`, `i-mdi-home`

## Rules

### Installation

ติดตั้ง dependencies ที่จำเป็น:

- ติดตั้ง `unocss` สำหรับทุก framework (presetWind4 import จาก unocss ตรงๆ)
- สำหรับ Next.js ติดตั้ง `@unocss/postcss`
- สำหรับ Nuxt ติดตั้ง `@unocss/nuxt`
- ใช้ `bun` สำหรับ package management

### Configuration

ตั้งค่า UnoCSS ตาม best practices:

- ใช้ `presetWind4` เป็น preset หลัก
- ใช้ `presetIcons` สำหรับ icon bundler ด้วย collections import
- ใช้ default settings ของ presetWind4 (preflights และ theme จะถูกตั้งค่าอัตโนมัติ)
- เพิ่ม transformers 2 ตัว: `transformerVariantGroup`, `transformerDirectives`
- ตั้งค่า `content.filesystem` ตาม framework ที่ใช้

### Framework Integration

ตั้งค่า framework integration ตาม table:

| Framework | Config Files | CSS Entry |
|-----------|--------------|-----------|
| Next.js | `postcss.config.mjs`, `uno.config.ts` | `app/globals.css` |
| Nuxt | `nuxt.config.ts`, `uno.config.ts` | Auto |
| Vite | `vite.config.ts`, `uno.config.ts` | `src/style.css` |
| HTML | Single HTML file | Inline |

### Transformers

ใช้ transformers สำหรับ functionality เพิ่มเติม:

- `transformerVariantGroup`: Group utilities (เช่น `hover:(bg-gray-400 font-medium)`)
- `transformerDirectives`: ใช้ `@apply`, `@screen`, `theme()` directives

## Expected Outcome

1. UnoCSS ติดตั้งและทำงานได้พร้อม presetWind4
2. CSS reset ทำงานผ่าน preflights โดยไม่ต้อง import `@unocss/reset`
3. Theme variables generate แบบ on-demand ลดขนาด CSS
4. Transformers ทำงานได้ (variant groups, directives)
5. Dev server รันได้โดยไม่มี error
6. Utilities ใช้งานได้ทันที (e.g., `flex`, `bg-blue-500`)

