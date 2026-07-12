---
title: UnoCSS
description: ติดตั้งและตั้งค่า UnoCSS v66 พร้อม presetWind4 และ transformers
auto_execution_mode: 3
related:
  - /follow-unocss-theme
  - /follow-vite
  - /follow-typescript
---

## Goal

สร้าง UnoCSS configuration ที่พร้อมใช้งานด้วย presetWind4, transformers และรองรับทุก framework

## Scope

ใช้สำหรับติดตั้งและตั้งค่า UnoCSS v66+ บน Next.js, Nuxt, Vite, Astro, และ HTML CDN

## Execute

### 1. Prepare

1. ตรวจสอบ framework ที่ใช้ (Next.js, Nuxt, Vite, Astro, HTML)
2. อ่าน config ที่มีอยู่แล้ว
3. ระบุตำแหน่ง CSS entry point
4. ตรวจสอบ UnoCSS version (ต้องเป็น v66+)

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

4. สำหรับ Astro ติดตั้งเพิ่ม:

   ```bash
   bun add -d @unocss/astro
   ```

5. สำหรับ Icons ติดตั้ง iconify collections:

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
   content: { filesystem: ['./src/**/*.{html,js,ts,jsx,tsx,vue,svelte,astro}'] }
   ```

### 4. Setup Framework Integration

1. **Next.js**: สร้าง `postcss.config.mjs` และเพิ่ม `@unocss all;` ใน `app/globals.css`
2. **Nuxt**: เพิ่ม `@unocss/nuxt` module ใน `nuxt.config.ts`
3. **Vite**: เพิ่ม UnoCSS plugin ใน `vite.config.ts` และ `@unocss all;` ใน `src/style.css`
4. **Astro**: เพิ่ม UnoCSS integration ใน `astro.config.mjs`

### 5. Use presetWind4 Features

ใช้ features ใหม่ของ presetWind4 (v66+)

1. Theme variables generate แบบ on-demand เป็น CSS custom properties
2. ใช้ bracket syntax สำหรับ theme values (เช่น `text-[--my-color]`)
3. ใช้ `zoom-*` utility สำหรับ zoom scaling
4. ใช้ `supports-*` variants สำหรับ feature queries
5. ใช้ enhanced border utilities พร้อม color และ size options ใหม่
6. Dark mode ทำงานผ่าน CSS custom properties อัตโนมัติ

### 6. Use Transformers

ใช้ transformers สำหรับ functionality เพิ่มเติม

1. `transformerVariantGroup`: Group utilities (เช่น `hover:(bg-gray-400 font-medium)`)
2. `transformerDirectives`: ใช้ `@apply`, `@screen`, `theme()` directives
3. `transformerAttributifyJsx`: สำหรับ JSX attributify (ใช้ oxc parser ใหม่)

### 7. Use Additional Presets (Optional)

ใช้ presets เพิ่มเติมตามความต้องการ

1. `presetWebFonts`: โหลด web fonts พร้อม local font processor และ onDownload callback
2. `presetTypography`: สำหรับ prose styling
3. `presetAttributify`: สำหรับ attributify mode
4. `presetTagify`: สำหรับ tagify mode
5. `presetRemToPx`: แปลง rem เป็น px

### 8. Setup Language Server (Optional)

1. ใช้ `@unocss/language-server` สำหรับ IDE support
2. ใช้ `@unocss/twoslash` สำหรับ TypeScript twoslash integration

### 9. Verify

1. รัน dev server และทดสอบใช้ utilities เช่น `flex`, `bg-blue-500`, `i-mdi-home`
2. ตรวจสอบ CSS custom properties generate ถูกต้อง
3. ตรวจสอบ dark mode ทำงานผ่าน CSS variables
4. ตรวจสอบ transformers ทำงาน (variant groups, directives)

## Rules

### Installation

ติดตั้ง dependencies ที่จำเป็น:

- ติดตั้ง `unocss` v66+ สำหรับทุก framework
- สำหรับ Next.js ติดตั้ง `@unocss/postcss`
- สำหรับ Nuxt ติดตั้ง `@unocss/nuxt`
- สำหรับ Astro ติดตั้ง `@unocss/astro`
- ใช้ `bun` สำหรับ package management

### Configuration

ตั้งค่า UnoCSS ตาม best practices:

- ใช้ `presetWind4` เป็น preset หลัก (theme keys ปรับจาก presetWind3)
- ใช้ `presetIcons` สำหรับ icon bundler ด้วย collections import
- ใช้ default settings ของ presetWind4 (preflights และ theme อัตโนมัติ)
- เพิ่ม transformers: `transformerVariantGroup`, `transformerDirectives`
- ตั้งค่า `content.filesystem` ตาม framework ที่ใช้
- Theme variables generate เป็น CSS custom properties แบบ on-demand

### Framework Integration

ตั้งค่า framework integration ตาม table:

| Framework | Config Files | CSS Entry |
|-----------|--------------|-----------|
| Next.js | `postcss.config.mjs`, `uno.config.ts` | `app/globals.css` |
| Nuxt | `nuxt.config.ts`, `uno.config.ts` | Auto |
| Vite | `vite.config.ts`, `uno.config.ts` | `src/style.css` |
| Astro | `astro.config.mjs`, `uno.config.ts` | Auto |
| HTML | Single HTML file | Inline |

### Transformers

ใช้ transformers สำหรับ functionality เพิ่มเติม:

- `transformerVariantGroup`: Group utilities (เช่น `hover:(bg-gray-400 font-medium)`)
- `transformerDirectives`: ใช้ `@apply`, `@screen`, `theme()` directives
- `transformerAttributifyJsx`: JSX attributify ด้วย oxc parser

### presetWind4 Features

ใช้ features ของ presetWind4:

- Theme parse ใน all bracket syntax rules
- CSS custom properties generate on-demand
- Enhanced border utilities (color และ size options)
- `zoom-*` utility สำหรับ zoom scaling
- `supports-*` variants สำหรับ feature queries
- Dark mode ผ่าน CSS variables อัตโนมัติ

### Migration From presetWind3

Migration จาก presetWind3:

- Theme keys ปรับเปลี่ยน (ดูตารางใน official docs)
- `breakpoint` key แทน keys เดิม
- CSS custom properties generate แบบ on-demand
- ไม่ต้อง import `@unocss/reset` (preflights อัตโนมัติ)

## Expected Outcome

1. UnoCSS v66+ ติดตั้งและทำงานได้พร้อม presetWind4
2. CSS reset ทำงานผ่าน preflights โดยไม่ต้อง import `@unocss/reset`
3. Theme variables generate แบบ on-demand เป็น CSS custom properties
4. Transformers ทำงานได้ (variant groups, directives, attributify JSX)
5. Dev server รันได้โดยไม่มี error
6. Utilities ใช้งานได้ทันที (e.g., `flex`, `bg-blue-500`, `i-mdi-home`)
7. Dark mode ทำงานผ่าน CSS variables
8. Language server และ twoslash integration (ถ้าติดตั้ง)

