---
auto_execution_mode: 3
---


1. /follow-package-json 
2. refactor

- refactor pages => components, composables
- refactor layouts => components, composables
- refactor components => smaller components, composables, shared/utils
- refactor composables => smaller composables, shared/utils
- refactor stores => composables, shared/types (or keep in `app/stores/` if complex)
- refactor app/middleware => composables, shared/utils
- refactor plugins => composables, shared/utils
- refactor server/api => server/utils, server/db
- refactor server/middleware => server/utils
- refactor server/db => shared/types, server/utils
- refactor app.vue => layouts, components
- refactor error.vue => layouts, components

4. แต่ะไฟล์ให้ทำตาม rules ด้านล่าง

- app.vue
 - กำหนด max-width
 - ใช้ <NuxtLayout>, <NuxtPage> เสมอ

- `pages/`
  - Data Fetching: ใช้ `useAsyncData` หรือ `useFetch` เป็นหลัก
    - ใส่ `key` ที่ไม่ซ้ำกันเสมอเพื่อป้องกัน data ซ้ำซ้อน
    - จัดการ error state และ loading state ให้ครบถ้วน
    - พิจารณาใช้ `lazy: true` สำหรับ non-critical data เพื่อปรับปรุง LCP (Largest Contentful Paint)
  - Component Composition: รักษา page component ให้เล็กและอ่านง่าย
    - แยก logic ที่ซับซ้อนและนำกลับมาใช้ใหม่ได้ไปที่ `composables/`
    - แยก UI ที่ซับซ้อนเป็น `components/` ย่อยๆ

- `components/`: Auto-imported Vue components.
  - Structure: ใช้ `<script setup lang="ts">` และ `<script>` อยู่ด้านบน `<template>`
  - Reusability: ออกแบบ component เพื่อการนำกลับมาใช้ใหม่ (reusability) และไม่ขึ้นตรงกับ page ใด page หนึ่ง
    - หลีกเลี่ยงการใช้ logic ที่ผูกกับ route หรือ page ปัจจุบันโดยตรง
  - Props & Emits:
    - กำหนด type ของ props ให้ชัดเจนด้วย `defineProps<{...}>()`
    - กำหนด events ที่ component สามารถส่งออกได้ด้วย `defineEmits<{...}>()`
  - Organization: จัดกลุ่มตาม feature หรือ domain เพื่อให้ง่ายต่อการค้นหา
    - เช่น `components/ui/`, `components/products/`, `components/auth/`
  - Styling:
    - เน้นใช้ UnoCSS เป็นหลัก
    - ใช้ `<style scoped>` เมื่อจำเป็นสำหรับ component-specific overrides จริงๆ เท่านั้น
  - Client-side Rendering:
    - ใช้ `.client.vue` หรือ `<ClientOnly>` สำหรับ component ที่ต้องทำงานบน client เท่านั้น (เช่น component ที่ใช้ browser-specific APIs อย่าง `window` หรือ `document`)

- `composables/`: Reusable logic (auto-imported).
  - Naming: ตั้งชื่อไฟล์ขึ้นต้นด้วย `use` เช่น `useAuth.ts`, `useCart.ts`
  - Scope: เป็นที่รวมของ business logic, state management, และ data fetching logic
  - State Management:
    - ใช้ `useState` สำหรับ state ง่ายๆ ที่แชร์กันระหว่าง components
    - ใช้ Pinia สำหรับ global state ที่ซับซ้อนและต้องการ devtools
  - SSR Safety:
    - ใช้ `useState` เพื่อสร้าง state ที่ปลอดภัยในการทำงานฝั่ง SSR
    - Pinia จะจัดการเรื่องนี้ให้โดยอัตโนมัติ ไม่ต้องกังวลเรื่อง state รั่วข้าม requests

- `server/`: Server-side logic (Nitro).
  - `api/`: สำหรับสร้าง API endpoints
    - ไฟล์ `server/api/products/[id].get.ts` จะ map ไปที่ `GET /api/products/:id`
    - ใช้ `defineEventHandler` ในการสร้าง handler
    - ต้องมี test file (.spec.ts) ด้วย Vitest
  - `db/`: สำหรับส่วนจัดการฐานข้อมูล
    - เช่น logic เกี่ยวกับการเชื่อมต่อ, query, หรือ schema definition
  - `middleware/`: Server middleware ที่ทำงานทุก request ที่เข้ามา
    - เหมาะสำหรับ authentication, logging, หรือการเพิ่มข้อมูลลงใน event context
  - `utils/`: Server-only utility functions
    - ฟังก์ชันที่ใช้ภายใน server routes/api เท่านั้น และจะไม่ถูก bundle ไปกับ client-side code
  - Secrets & Runtime Config:
    - จัดการ environment variables และ secrets ผ่าน `useRuntimeConfig()`
    - ข้อมูลใน `runtimeConfig` (default) จะอยู่ฝั่ง server เท่านั้น
    - ข้อมูลที่ต้องการให้ client เข้าถึงได้ ต้องใส่ไว้ใน `runtimeConfig.public`

- `shared/utils/`: Utilities ที่แชร์ระหว่าง server และ client (auto-imported)
  - เป็นที่เก็บ utility functions ที่สามารถใช้ได้ทั้งฝั่ง server และ client (isomorphic)
  - ควรเป็น pure functions (ไม่มี side effects) เพื่อให้ predictable และทดสอบง่าย
  - เช่น `formatDate()`, `calculateDiscount()`

- `shared/types/`: สำหรับเก็บ TypeScript type definitions
  - สำหรับเก็บ TypeScript type definitions และ interfaces
  - ใช้ Zod, Valibot, or ArkType ในการสร้าง schema เพื่อ validate ข้อมูลที่รับมาจาก API หรือ form input
    - ช่วยป้องกัน runtime errors และเพิ่มความปลอดภัยของข้อมูล

notes
- ถ้าใช้ import ใช้ alias แบบ @ 
