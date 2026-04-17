---
description: แนวทางการพัฒนาด้วย Vite build tool สำหรับ modern web projects
title: Vite Best Practices
auto_execution_mode: 3
---

## Goal

กำหนดแนวทางการพัฒนาด้วย Vite ให้มีประสิทธิภาพสูงสุด

## Execute

### 1. Installation

1. ติดตั้ง Vite ด้วย `bun add -D vite` หรือใช้ `bun create vite` สำหรับ scaffolding
2. ตรวจสอบ Node.js version >= 20.19+ หรือ 22.12+
3. เลือก template ที่ต้องการ: vanilla, vue, react, preact, lit, svelte, solid, qwik
4. สร้าง project ด้วย `bun create vite my-app --template <template>`
5. รัน dev server ด้วย `bunx vite`

### 2. Configuration

1. สร้าง `vite.config.ts` หรือใช้ default configuration
2. ตั้งค่า plugins สำหรับ framework ที่ใช้
3. กำหนด build options สำหรับ production
4. ตั้งค่า server options สำหรับ development
5. ใช้ path aliases สำหรับ clean imports

### 3. Development

1. รัน dev server ด้วย `bunx vite` หรือ `bun run dev`
2. ใช้ Hot Module Replacement (HMR) สำหรับ fast refresh
3. ตั้งค่า proxy สำหรับ API requests
4. ใช้ environment variables ด้วย `.env` files
5. ตั้งค่า source maps สำหรับ debugging

### 4. Build

1. รัน build ด้วย `bunx vite build`
2. ตั้งค่า target browsers สำหรับ production
3. ใช้ Rolldown สำหรับ optimized builds
4. ตั้งค่า code splitting สำหรับ performance
5. กำหนด assets naming และ output directory

### 5. Best Practices

1. ใช้ ES modules แทน CommonJS
2. ใช้ plugins สำหรับ framework-specific features
3. ตั้งค่า proper caching headers
4. ใช้ lazy loading สำหรับ large bundles
5. ตรวจสอบ bundle size ด้วย build analyzer

## Rules

- ต้องมี `vite.config.ts` หรือใช้ default configuration
- ใช้ `bun add -D vite` สำหรับ installation
- ตรวจสอบ Node.js version compatibility
- ใช้ HMR สำหรับ development experience
- ตั้งค่า proper build targets
- ใช้ plugins สำหรับ framework integration
- ตรวจสอบ browser support สำหรับ production

## Expected Outcome

- Vite ติดตั้งและทำงานได้
- Development server ที่มี HMR
- Production builds ที่ optimized
- Configuration ที่เหมาะสมกับ project
- Performance ที่ดีขึ้น
