---
title: Setup UnoCSS
description: ติดตั้งและตั้งค่า UnoCSS พร้อม presetWind4 และ transformers
auto_execution_mode: 3
---

## Goal

สร้าง UnoCSS configuration ที่พร้อมใช้งานด้วย presetWind4, transformers และรองรับทุก framework

## Execute

### 1. Prepare

1. ตรวจสอบ framework ที่ใช้ (Next.js, Nuxt, Vite, HTML)
2. อ่าน config ที่มีอยู่แล้ว
3. ระบุตำแหน่ง CSS entry point

### 2. Install Dependencies

1. ติดตั้ง UnoCSS และ presetWind4:

   ```bash
   bun add -d unocss @unocss/preset-wind4
   ```

2. สำหรับ Next.js ติดตั้งเพิ่ม:

   ```bash
   bun add -d @unocss/postcss
   ```

3. สำหรับ Nuxt ติดตั้งเพิ่ม:

   ```bash
   bun add -d @unocss/nuxt
   ```

### 3. Configure

1. สร้าง `uno.config.ts` พื้นฐาน:

   ```ts
   import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

   export default defineConfig({
     darkMode: 'class',
     presets: [
       presetWind4({
         preflights: {
           reset: true,
           theme: 'on-demand',
         },
       }),
     ],
     transformers: [
       transformerVariantGroup(),
       transformerDirectives(),
       transformerCompileClass(),
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

1. **Next.js**: สร้าง `postcss.config.mjs`

   ```js
   export default {
     plugins: {
       '@unocss/postcss': {},
     },
   }
   ```

2. **Next.js**: ใน `app/globals.css` เพิ่ม:

   ```css
   @unocss all;
   ```

3. **Nuxt**: ใน `nuxt.config.ts` เพิ่ม:

   ```ts
   export default defineNuxtConfig({
     modules: ['@unocss/nuxt'],
     unocss: {
       nuxtLayers: true,
     },
   })
   ```

4. **Vite**: ใน `vite.config.ts` เพิ่ม:

   ```ts
   import UnoCSS from 'unocss/vite'

   export default defineConfig({
     plugins: [UnoCSS()],
   })
   ```

5. **Vite**: ใน `src/style.css` เพิ่ม:

   ```css
   @unocss all;
   ```

6. **HTML CDN**: สร้าง HTML file:

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

### 5. Verify

1. รัน dev server
2. ทดสอบใช้ UnoCSS utilities:

   ```html
   <div class="flex items-center justify-center p-4 bg-blue-500 text-white">
     Hello UnoCSS!
   </div>
   ```

3. ตรวจสอบว่า styles ถูก apply

## Rules

### Installation

- ใช้ `bun` เท่านั้น ห้ามใช้ npm/npx/yarn/pnpm
- ติดตั้ง `unocss` และ `@unocss/preset-wind4` สำหรับทุก framework
- ใช้ `preflights.reset: true` แทนการ import `@unocss/reset`

### Configuration

- ใช้ `presetWind4` เป็น preset หลัก
- ใช้ `preflights.theme: 'on-demand'` เพื่อ generate theme keys เฉพาะที่ใช้
- เพิ่ม transformers 3 ตัว: `transformerVariantGroup`, `transformerDirectives`, `transformerCompileClass`
- กำหนด `darkMode: 'class'` สำหรับ manual dark mode toggle

### Framework

| Framework | Config Files | CSS Entry |
|-----------|--------------|-----------|
| Next.js | `postcss.config.mjs`, `uno.config.ts` | `app/globals.css` |
| Nuxt | `nuxt.config.ts`, `uno.config.ts` | Auto |
| Vite | `vite.config.ts`, `uno.config.ts` | `src/style.css` |
| HTML | Single HTML file | Inline |

## Expected Outcome

1. UnoCSS ติดตั้งและทำงานได้พร้อม presetWind4
2. CSS reset ทำงานผ่าน preflights โดยไม่ต้อง import `@unocss/reset`
3. Theme variables generate แบบ on-demand ลดขนาด CSS
4. Transformers ทำงานได้ (variant groups, directives, compile class)
5. Dev server รันได้โดยไม่มี error
6. Utilities ใช้งานได้ทันที (e.g., `flex`, `bg-blue-500`)
