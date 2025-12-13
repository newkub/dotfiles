---
description: refactor TypeScript code ให้ดีขึ้น มีประสิทธิภาพ และ maintainable
auto_execution_mode: 1
---

## 1. วิเคราะห์ Project Structure
ดูก่อนว่า project นี้ใช้อะไร:
- Vue 3 + Composition API
- Nuxt 3
- State Management (Pinia/Vuex)
- UI Framework (UnoCSS/Tailwind)

## 2. Code Quality & Standards

### Type Safety
- เพิ่ม interface สำหรับ object ทั้งหมด
- ใช้ strict TypeScript config
- หลีกเลี่ยง `any` type ให้มากที่สุด
- ใช้ Generic Types ให้เหมาะสม
- เพิ่ม return types สำหรับ functions

### Import Organization
- จัดกลุ่ม imports: external libraries → internal modules → relative imports
- ใช้ absolute imports แทน relative paths เมื่อเป็นไปได้
- ลบ unused imports

## 3. Vue/Nuxt Specific Refactoring

### ถ้าเป็น Nuxt Project
- **Data Fetching**: ใช้ `useAsyncData` หรือ `useFetch` แทน `fetch` โดยตรง (สามารถใช้กับ `$fetch` ได้)
- **Composables**: สร้างใน `composables/` directory ตามโครงสร้าง Nuxt
- **State Management**: ใช้ Pinia ใน Composables พร้อม Typesafe Stores
- **Error Handling**: ใช้ `throw createError()` แทน `try/catch` สำหรับ server errors
- **Config**: ใช้ `useRuntimeConfig()` สำหรับ Environment Variables
- **Optimization**: ทำให้ Composables เป็น Pure และ Reusable
- **Type Inference**: เพิ่มสำหรับ Vue/Nuxt APIs เช่น `useRoute()`, `useRouter()`

### ถ้าเป็น Vue Project
- **Data Fetching**: ใช้ `useAsyncData` จาก VueUse แทน `fetch`
- **Composables**: สร้างใน `composables/` หรือ `hooks/` directory
- **State Management**: ใช้ Pinia หรือ provide/inject
- **Error Handling**: ใช้ `try/catch` พร้อม proper error types

## 4. Performance Optimization

### Script Setup Optimization
- ใช้ `<script setup lang="ts">` ทั้งหมด
- เลื่อน complex logic จาก template ไป script
- ใช้ `computed` แทน methods สำหรับ derived data
- ใช้ `readonly` สำหรับ data ที่ไม่เปลี่ยนแปลง

### Code Splitting
- แยก utilities functions ออกมาเป็นไฟล์แยก
- สร้าง shared types ใน `types/` directory
- ใช้ dynamic imports สำหรับ heavy components

## 5. Code Patterns Refactoring

### Loop Optimization
- เปลี่ยน `forEach` เป็น `for` loop ปกติ: `for (let i = 0; i < array.length; i++)`
- ใช้ `for...of` สำหรับ simple iterations
- ใช้ array methods (`map`, `filter`, `reduce`) เมื่อเหมาะสม

### Function Improvements
- แยก large functions เป็น smaller functions
- ใช้ pure functions เมื่อเป็นไปได้
- เพิ่ม proper parameter typing
- ใช้ object destructuring สำหรับ parameters

## 6. Error Handling & Validation

### Robust Error Handling
- เพิ่ม proper error types
- ใช้ Result/Either pattern สำหรับ functions ที่อาจ fail
- เพิ่ม input validation
- ใช้ assertion operators (`!`) เมื่อแน่ใจ

### Runtime Validation
- ใช้ Zod หรือ สำหรับ schema validation
- Validate API responses
- Type guards สำหรับ unknown data

// turbo
## 7. Run Code Quality Tools
```bash
bun run lint
bun run format
bun unused
```

## 8. Final Review
- ตรวจสอบว่าทุก component มี proper TypeScript types
- ทดสอบ build ผ่าน: `bun run build`
- ตรวจสอบ performance ด้วย dev tools
- Review code ครั้งสุดท้ายสำหรับ consistency
- ใช้ `bun unused` เพื่อลบ dependencies ที่ไม่ใช้