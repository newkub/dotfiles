---
auto_execution_mode: 3
---


# แนวทางการพัฒนาโปรเจกต์ด้วย Nuxt.js

เอกสารนี้สรุปแนวทางปฏิบัติที่ดีที่สุดสำหรับการพัฒนาแอปพลิเคชันด้วย Nuxt.js โดยมีเป้าหมายเพื่อสร้างโค้ดที่สะอาด, บำรุงรักษาง่าย และมีประสิทธิภาพสูง

## 1. แนวคิดหลัก (Core Concepts)

- **Component-Based Architecture:** สร้าง UI จากส่วนประกอบย่อยที่นำกลับมาใช้ใหม่ได้ (Components) ทำให้โค้ดเป็นสัดส่วนและจัดการง่าย
- **Composition API:** ใช้ฟังก์ชัน `setup` และ `composables` เพื่อจัดระเบียบและแยก Logic ที่ซับซ้อนออกจาก UI ทำให้โค้ดอ่านง่ายและทดสอบได้สะดวก
- **File-based Routing:** Nuxt สร้าง Routing ให้อัตโนมัติจากโครงสร้างไฟล์ในโฟลเดอร์ `pages/` ช่วยลดความซับซ้อนในการตั้งค่า
- **Auto-imports:** Components, Composables, และ Utilities จะถูก import ให้อัตโนมัติ ทำให้โค้ดกระชับขึ้นและลด Boilerplate
- **Universal Rendering:** โค้ดสามารถทำงานได้ทั้งบน Server (SSR) และ Client (CSR) เพื่อเพิ่มประสิทธิภาพ SEO และลดเวลาในการโหลดครั้งแรก
- **Isomorphic Code:** เขียนฟังก์ชัน (ใน `shared/`) ที่สามารถทำงานได้ทั้งในฝั่ง Server และ Client โดยไม่ต้องแก้ไข

## 2. โครงสร้างโปรเจกต์ (Project Structure)

โครงสร้างที่ชัดเจนช่วยให้ทีมทำงานร่วมกันได้ง่ายและหาโค้ดเจอได้รวดเร็ว

```plaintext
my-nuxt-app/
├── app/         # โค้ดฝั่ง Client ทั้งหมด
│   ├── components/  # Vue components ที่ใช้ซ้ำ (auto-imported)
│   ├── composables/ # ฟังก์ชัน Composition API ที่ใช้ซ้ำ (auto-imported)
│   ├── layouts/     # โครงสร้างหลักของหน้าเว็บ
│   ├── pages/       # หน้าเว็บและ Routing (file-based)
│   └── app.vue      # Component หลักของแอปพลิเคชัน
│
├── server/      # โค้ดฝั่ง Server ทั้งหมด
│   ├── api/         # API endpoints (e.g., /api/users)
│   └── utils/       # Utility functions สำหรับฝั่ง Server เท่านั้น
│
├── shared/      # โค้ดที่ใช้ร่วมกันระหว่าง Client และ Server
│   ├── types/       # TypeScript types และ interfaces
│   └── utils/       # Utility functions ที่ใช้ได้ทั้งสองฝั่ง
│
├── public/      # Assets ที่ไม่ต้องผ่านการประมวลผล (e.g., favicon.ico)
└── nuxt.config.ts # ไฟล์ตั้งค่าหลักของ Nuxt
```

## 3. กฎและตัวอย่าง (Folder Rules & Examples)

### `shared/types/`
- **หน้าที่:** กำหนดโครงสร้างข้อมูลหลักด้วย TypeScript Interfaces หรือ Types และ Schema สำหรับ Validation
- **Do:**
    - ใช้ Zod, Valibot, หรือ ArkType เพื่อสร้าง Schema ที่ตรวจสอบความถูกต้องของข้อมูล
    - Export Type และ Schema เพื่อให้ `composables` และ `server/api` นำไปใช้ได้
- **Don't:**
    - ใส่ Logic การทำงานใดๆ ในไฟล์เหล่านี้

```typescript
// shared/types/user.ts
import { z } from 'zod';

export const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(2),
  email: z.string().email(),
});

export type User = z.infer<typeof UserSchema>;
```

### `shared/utils/`
- **หน้าที่:** เก็บฟังก์ชันบริสุทธิ์ (Pure Functions) ที่ใช้ได้ทั้งฝั่ง Client และ Server
- **Do:**
    - สร้างฟังก์ชันที่รับ Input และคืนค่า Output โดยไม่มี Side Effects
    - เหมาะสำหรับฟังก์ชันจัดรูปแบบข้อมูล, คำนวณ, หรือจัดการข้อความ
- **Don't:**
    - เรียกใช้ Browser/Node-specific APIs (เช่น `window` หรือ `process`)

```typescript
// shared/utils/formatters.ts
export function formatDate(date: Date): string {
  return new Intl.DateTimeFormat('en-US').format(date);
}
```

### `composables/`
- **หน้าที่:** เป็นหัวใจของ Business Logic ฝั่ง Client, จัดการ State, และดึงข้อมูลจาก API
- **Do:**
    - ตั้งชื่อด้วย `use...` (เช่น `useUser`, `useCart`)
    - ใช้ `useFetch` หรือ `useAsyncData` สำหรับการดึงข้อมูล
    - ใช้ `useState` สำหรับ State ง่ายๆ หรือ Pinia สำหรับ State ที่ซับซ้อน
- **Don't:**
    - ใส่โค้ดที่จัดการ DOM โดยตรง (ควรทำใน Component)

```typescript
// composables/useUser.ts
import type { User } from '~/shared/types/user';

export const useUser = (userId: string) => {
  return useFetch<User>(`/api/users/${userId}`, {
    // Zod validation can be added here with .transform
  });
};
```

### `components/`
- **หน้าที่:** สร้าง UI ที่นำกลับมาใช้ใหม่ได้
- **Do:**
    - ออกแบบ Component ให้รับ Props และส่ง Events (Props in, Events out)
    - จัดกลุ่มตาม Feature (เช่น `components/products/Card.vue`)
    - ใช้ UnoCSS สำหรับ Styling เป็นหลัก
- **Don't:**
    - ดึงข้อมูลโดยตรง (ควรทำผ่าน `composables`)
    - ใส่ Business Logic ที่ซับซ้อน

```vue
<!-- components/UserProfile.vue -->
<script setup lang="ts">
import type { User } from '~/shared/types/user';

defineProps<{ user: User }>();
</script>

<template>
  <div>
    <h1>{{ user.name }}</h1>
    <p>{{ user.email }}</p>
  </div>
</template>
```

### `pages/`
- **หน้าที่:** ประกอบ `components` และ `composables` เข้าด้วยกันเพื่อสร้างหน้าเว็บที่สมบูรณ์
- **Do:**
    - เรียกใช้ `composables` เพื่อดึงข้อมูลและจัดการ State
    - ส่งข้อมูลที่ได้ไปยัง `components` ผ่าน Props
    - จัดการ Loading และ Error states
- **Don't:**
    - เขียน UI ที่ซับซ้อนโดยตรง (ควรแยกเป็น Component)

```vue
<!-- pages/users/[id].vue -->
<script setup lang="ts">
const route = useRoute();
const { data: user, pending, error } = useUser(route.params.id as string);
</script>

<template>
  <div>
    <p v-if="pending">Loading...</p>
    <p v-else-if="error">Error loading user.</p>
    <UserProfile v-else-if="user" :user="user" />
  </div>
</template>
```

### `server/api/`
- **หน้าที่:** สร้าง API Endpoints เพื่อจัดการข้อมูลฝั่ง Server
- **Do:**
    - ใช้ `defineEventHandler` เพื่อสร้าง Route Handler
    - อ่านและตรวจสอบข้อมูลนำเข้า (เช่น `body`, `params`) โดยใช้ Schema จาก `shared/types/`
    - แยก Logic ที่ซับซ้อน (เช่น การติดต่อฐานข้อมูล) ไปไว้ใน `server/utils/`
- **Don't:**
    - เขียน Business Logic ทั้งหมดลงในไฟล์เดียว

```typescript
// server/api/users/[id].get.ts
import { UserSchema } from '~/shared/types/user';

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id');
  // Fetch user from database...
  const user = await db.users.find(id);

  // Validate output before sending
  return UserSchema.parse(user);
});
```

## 4. การตั้งค่าโปรเจกต์ (Project Setup)

- **`package.json`**: กำหนด Scripts สำหรับการพัฒนา, build, และ linting
```json
{
  "scripts": {
    "dev": "nuxt dev",
    "build": "nuxt build",
    "lint": "vue-tsc --noEmit && biome lint --write",
    "postinstall": "bunx taze -r -w -i && nuxt prepare"
  }
}
```

- **`nuxt.config.ts`**: เปิดใช้งาน Modules ที่จำเป็น เช่น `@unocss/nuxt`, `@pinia/nuxt`, และ `@vueuse/nuxt`

- **`tsconfig.json`**: ตั้งค่าให้ `extends` จาก `./.nuxt/tsconfig.json` เพื่อให้ Type-checking ทำงานได้ถูกต้อง

## 5. แนวปฏิบัติที่ดีที่สุด (Best Practices)

- **Refactor Driven by Responsibility:** เมื่อไฟล์หรือฟังก์ชันทำหน้าที่หลายอย่างเกินไป ให้แยกมันออกตามหน้าที่ เช่น แยก Logic จาก Component ไปที่ Composable, แยกการเชื่อมต่อ Database ออกจาก API Endpoint
- **Type Safety End-to-End:** ใช้ Schema Validation (เช่น Zod) ทั้งในฝั่ง Server (ก่อนตอบกลับ) และฝั่ง Client (หลังรับข้อมูล) เพื่อให้แน่ใจว่าข้อมูลถูกต้องเสมอ
- **Error Handling:** จัดการข้อผิดพลาดในทุกขั้นตอน, ตั้งแต่ `server/api` จนถึง `composables` และแสดงผลที่เหมาะสมใน `pages`
