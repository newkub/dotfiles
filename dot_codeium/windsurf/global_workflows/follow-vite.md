---
title: Follow Vite
description: แนวทางการพัฒนาด้วย Vite 7+ build tool สำหรับ modern web applications
auto_execution_mode: 3
related_workflows:
  - /follow-typescript
  - /follow-tsdown
  - /follow-unocss
  - /follow-vitest
  - /follow-vite-plugin-checker
---

## Goal

กำหนดแนวทางการพัฒนาด้วย Vite 7+ ให้มีประสิทธิภาพสูงสุด ทั้ง dev experience และ production builds

## Scope

ติดตั้งและตั้งค่า Vite 7+ สำหรับ modern web applications ทั้ง single project และ monorepo

**หมายเหตุ:** สำหรับ TypeScript library build ให้ใช้ `/follow-tsdown` แทน

## Execute

### 1. Installation

1. ติดตั้ง Vite ด้วย `bun add -D vite`
2. ตรวจสอบ Node.js version >= 20.19+ หรือ 22.12+ (Vite 7 เป็น ESM-only)
3. รัน dev server ด้วย `bunx vite`
4. สำหรับ VitePress ใช้ `bunx vitepress dev`

### 2. Configuration

1. สร้าง `vite.config.ts` ด้วย `defineConfig` สำหรับ IntelliSense
2. ใช้ conditional config ผ่าน function signature `defineConfig(({ command, mode }) => ({...}))`
3. ตั้งค่า plugins สำหรับ framework ที่ใช้
4. กำหนด build options สำหรับ production
5. ตั้งค่า server options สำหรับ development
6. ใช้ path aliases ด้วย absolute paths เสมอใน `resolve.alias`
7. เปิดใช้ `resolve.tsconfigPaths: true` สำหรับ auto-resolve tsconfig paths
8. ตั้งค่า `envPrefix` สำหรับ custom environment variable prefix

### 3. Default Plugins

ติดตั้ง plugins ตาม use cases

Framework Plugins:
- Vue: `@vitejs/plugin-vue`, `@vitejs/plugin-vue-jsx`
- React: `@vitejs/plugin-react`
- Solid: `vite-plugin-solid`
- Svelte: `@sveltejs/vite-plugin-svelte`

Build Optimization:
- `@vitejs/plugin-legacy` - สำหรับ legacy browser support
- `vite-plugin-pwa` - PWA support
- `rollup-plugin-visualizer` - bundle analysis

Development Experience:
- `vite-plugin-checker` - TypeScript/ESLint checking (ทำ `/follow-vite-plugin-checker`)
- `vite-plugin-inspect` - plugin inspection และ transform timing
- `unplugin-auto-import` - auto import APIs

CSS/Styling:
- `unocss/vite` - UnoCSS integration (ทำ `/follow-unocss`)
- LightningCSS - สำหรับ native CSS processing (เร็วกว่า PostCSS)

Utility:
- `unplugin-vue-components` - auto component registration
- `unplugin-icons` - icon auto import

### 4. Development

1. รัน dev server ด้วย `bunx vite` หรือ `bun run dev`
2. ใช้ HMR สำหรับ fast refresh โดยไม่ต้อง reload ทั้งหน้า
3. ตั้งค่า `server.proxy` สำหรับ API requests
4. ใช้ `.env` files: `.env`, `.env.local`, `.env.[mode]`, `.env.[mode].local`
5. เข้าถึง env ผ่าน `import.meta.env.VITE_*`
6. ตั้งค่า `server.warmup.clientFiles` สำหรับ pre-transform ไฟล์ที่ใช้บ่อย
7. ใช้ `server.open: true` เพื่อ warm up entry point อัตโนมัติ
8. ใช้ `vite --profile` และ `vite --debug plugin-transform` สำหรับ profiling

### 5. Build

1. รัน build ด้วย `bunx vite build`
2. ใช้ `build.target: 'baseline-widely-available'` (Vite 7 default) สำหรับ browser compatibility
3. เปิดใช้ Rolldown bundler ผ่าน `experimental.rolldown: true` สำหรับ 4-16x faster builds
4. ใช้ `build.rolldownOptions.output.codeSplitting` สำหรับ chunking strategy
5. กำหนด `build.assetsInlineLimit` ด้วย callback สำหรับ fine-grained asset inlining
6. ใช้ `build.rollupOptions.output.manualChunks` สำหรับ vendor splitting
7. ตั้งค่า `build.minify: 'esbuild'` (fast) หรือ `'terser'` (smaller)
8. ใช้ `esbuild.drop: ['console', 'debugger']` ใน production mode
9. ตั้งค่า `chunkSizeWarningLimit` สำหรับ bundle size monitoring
10. ใช้ `vite build --watch` สำหรับ rebuild on file changes

### 6. Performance Optimization

1. **Audit plugins**: ตรวจสอบว่า community plugins ไม่ทำงานหนักใน `buildStart`, `config`, `configResolved` hooks
2. **Reduce resolve operations**: ใช้ explicit import paths เช่น `import './Component.jsx'` แทน `import './Component'`
3. **Avoid barrel files**: import จากไฟล์ตรงๆ เช่น `import { slash } from './utils/slash.js'` แทน `import { slash } from './utils'`
4. **Warm up files**: ใช้ `server.warmup.clientFiles` สำหรับไฟล์ที่ใช้บ่อยและ transform ช้า
5. **Use lesser or native tooling**: ใช้ CSS แทน Sass/Less เมื่อได้ และ import SVG เป็น string/URL แทน component
6. **TypeScript**: เปิด `moduleResolution: "bundler"` และ `allowImportingTsExtensions: true`
7. **Optimize deps**: ใช้ `optimizeDeps.include` สำหรับ deps ที่ Vite อาจ miss และ `optimizeDeps.exclude` สำหรับ ESM deps
8. **Profile**: ใช้ `vite --profile` แล้วกด `p + enter` สำหรับบันทึก `.cpuprofile`

### 7. Monorepo Setup

1. Vite ตรวจจับ linked packages อัตโนมัติและ treat เป็น source code
2. หาก linked dependency ไม่ใช่ ESM ให้เพิ่มใน `optimizeDeps.include`
3. ใช้ `server.fs.allow` สำหรับ restrict file system access
4. ตั้งค่า `resolve.alias` ด้วย absolute paths สำหรับ workspace packages
5. ใช้ `server.fs.strict: false` หากต้องการ access นอก workspace

### 8. SSR Considerations

1. ใช้ `import.meta.env.SSR` สำหรับ conditional logic
2. Dependencies ถูก externalize โดย default สำหรับ SSR
3. ใช้ `ssr.noExternal` และ `ssr.external` สำหรับ control externalization
4. โครงสร้างไฟล์: `entry-client.js`, `entry-server.js`, `server.js`
5. ใช้ Environment API สำหรับ multi-environment builds (client, server, edge)

### 9. Testing Setup

1. ใช้ Vitest สำหรับ unit/integration testing (ทำ `/follow-vitest`)
2. Vitest ใช้ Vite config โดยตรง ไม่ต้อง config ซ้ำ
3. ใช้ `import.meta.env.VITEST` สำหรับ conditional test logic
4. รัน coverage ด้วย `vitest run --coverage`

### 10. Deployment

1. ตั้งค่า `base` สำหรับ public base path
2. ใช้ relative base สำหรับ deploy ได้หลายที่โดยไม่ต้อง rebuild
3. ตั้งค่า `Cache-Control: no-cache` สำหรับ HTML files
4. ใช้ long-term caching สำหรับ assets (มี hash ใน filename)
5. จัดการ `vite:preloadError` event สำหรับ handle stale chunks หลัง deploy
6. ใช้ `vite preview` สำหรับ test production build ในเครื่อง

## Rules

### 1. Configuration Requirements

- ต้องมี `vite.config.ts` ด้วย `defineConfig` ที่ root
- ใช้ `bun add -D vite` สำหรับ installation
- ตรวจสอบ Node.js >= 20.19+ หรือ 22.12+
- ใช้ conditional config สำหรับ environment-specific options
- ใช้ `defineConfig(({ command, mode }) => ({...}))` สำหรับ flexibility

### 2. Development Experience

- ใช้ HMR สำหรับ instant updates โดยไม่ reload ทั้งหน้า
- ตั้งค่า `server.proxy` สำหรับ API requests
- ใช้ `.env.[mode]` files สำหรับ environment-specific config
- ตั้งค่า `server.warmup` สำหรับ pre-transform ไฟล์ที่ใช้บ่อย
- ใช้ path aliases ด้วย absolute paths

### 3. Build Optimization

- ใช้ `build.target: 'baseline-widely-available'` (Vite 7 default)
- เปิดใช้ Rolldown ผ่าน `experimental.rolldown: true`
- ใช้ `manualChunks` สำหรับ vendor splitting
- ใช้ `esbuild.drop` สำหรับ remove console/debugger ใน production
- ตั้งค่า `chunkSizeWarningLimit` สำหรับ monitor bundle size
- ใช้ `rollup-plugin-visualizer` สำหรับ analyze bundle

### 4. Performance Rules

- หลีกเลี่ยง barrel files - import จากไฟล์ตรงๆ
- ใช้ explicit import paths พร้อม extension
- เปิด `moduleResolution: "bundler"` ใน tsconfig
- Audit community plugins สำหรับ performance impact
- ใช้ native tooling (LightningCSS) เมื่อได้

### 5. Environment Variables

- ใช้ prefix `VITE_` (default) หรือกำหนดผ่าน `envPrefix`
- เข้าถึงผ่าน `import.meta.env.VITE_*`
- ใช้ `.env.local` สำหรับ local overrides (ไม่ commit)
- ใช้ `define` option สำหรับ compile-time constants
- ไม่ hardcode secrets ใน env files ที่ commit

## Expected Outcome

- Vite 7+ ติดตั้งและทำงานได้ด้วย Rolldown bundler
- Dev server ที่มี HMR และ warmup optimization
- Production builds ที่ optimized ด้วย baseline-widely-available target
- Performance profiling และ bundle analysis
- Configuration ที่เหมาะสมกับ project และ monorepo
- Test setup ที่ integrate กับ Vitest

