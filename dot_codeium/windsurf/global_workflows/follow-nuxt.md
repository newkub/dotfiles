---
trigger: always_on
---
 
 
 
 
## Setup

### config

#### `package.json`

```json [package.json]
{
    "scripts": {
        "dev": "nuxt dev",
        "build": "nuxt build",
        "preview": "nuxt preview",
        "lint": "vue-tsc --noEmit", // @ai และ /follow-oxlint
        "postinstall": "nuxt prepare"
    }
}
```

#### `nuxt.config.ts`

```ts [nuxt.config.ts]
import checker from "vite-plugin-checker";

export default defineNuxtConfig({
    compatibilityDate: "latest", 
    devtools: { enabled: true },
    modules: [
        "@vue-macros/nuxt",
        "@nuxtjs/color-mode",
        "@vueuse/nuxt",
        "@unocss/nuxt",
        "@pinia/nuxt",
        "nuxt-mcp-dev",
        "@nuxt/icon",
        "@scalar/nuxt"
    ],

    alias: {
        '~/shared': './shared'
    },

    typescript: {
		strict: true,
		typeCheck: true,
	},

    scalar: {
        url: 'https://registry.scalar.com/@scalar/apis/galaxy?format=yaml',
    },

    icon: {
        serverBundle: {
            collections: ['mdi']
        }
    },

    nitro: {
        preset: "cloudflare_module", // @ai bun add wrangler ด้วย
        cloudflare: {
            deployConfig: true,
            nodeCompat: true,
            wrangler : {
                routes: [
					{
						pattern: "*wrikka.com", // @ai กำหนด * ตามชื่อ folder
						custom_domain: true,
					},
				]
            }
        },
    },
    vite: {
        plugins: [
            checker({
                overlay: {
                    initialIsOpen: false,
                },
                typescript: true,
                vueTsc: true,
                oxlint: true,
                /*
                biome: {
                    command: 'check',
                },*/
            }),
        ],
    }
});
```

### Libraries

- /follow-unocss
- /follow-vitest

## Project Structure

```
my-nuxt-app/
├── app/                      # Client-side application
│   ├── assets/               # Unprocessed files (styles, fonts)
│   ├── components/           # Reusable Vue components
│   ├── composables/          # Reusable composition functions (business logic)
│   │   ├── core/             # Standalone business logic
│   │   ├── facade/           # UX/flow logic, orchestrates core composables
│   │   └── services/         # API wrappers
│   ├── layouts/              # Page layouts
│   ├── middleware/           # Client-side route middleware
│   ├── pages/                # Application pages (routes)
│   ├── plugins/              # Vue plugins
│   ├── stores/               # Pinia stores for state management
│   ├── utils/                # Client-side utility functions
│   └── app.vue               # Main application component
├── public/                   # Publicly accessible files
│   ├── favicon.ico
│   ├── robots.txt
│   ├── sitemap.xml           # Recommended for SEO
│   ├── site.webmanifest    # Recommended for PWA
│   └── .well-known/
│       └── security.txt      # Recommended for security contact
├── server/                   # Server-side logic (Nitro)
│   ├── api/                  # API endpoints
│   ├── db/                   # Database queries and transactions only
│   ├── middleware/           # Server-side middleware
│   ├── plugins/              # Server plugins
│   ├── routes/               # Custom server routes
│   └── utils/                # Server-side business logic
├── shared/                   # Code shared between client and server
│   ├── types/                # TypeScript types and validation schemas
│   └── utils/                # Pure utility functions
├── .gitignore
├── nuxt.config.ts            # Nuxt configuration
├── uno.config.ts             # UnoCSS configuration
├── package.json
├── tsconfig.json
└── README.md

```

## Core Principles

- ใช้ `vueuse`, `vue-macros` เสมอถ้าเป็นไปได้
- ใช้ `pinia` สำหรับการจัดการ State ที่ซับซ้อน

## Folder Rules

### `shared/types/`

กำหนดโครงสร้างข้อมูลหลักด้วย TypeScript Interfaces หรือ Types และ Schema สำหรับ Validation

- Do
    - ใช้ Zod, Valibot, หรือ ArkType เพื่อสร้าง Schema ที่ตรวจสอบความถูกต้องของข้อมูล
    - Export Type และ Schema เพื่อให้ `composables` และ `server/api` นำไปใช้ได้
- Don't
    - ใส่ Logic การทำงานใดๆ ในไฟล์เหล่านี้

```ts
import { z } from 'zod'

export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
})

export type User = z.infer<typeof UserSchema>
```

### `shared/utils/`

เก็บฟังก์ชันบริสุทธิ์ (Pure Functions) ที่ใช้ได้ทั้งฝั่ง Client และ Server

- Do
    - สร้างฟังก์ชันที่รับ Input และคืนค่า Output โดยไม่มี Side Effects
    - เหมาะสำหรับฟังก์ชันจัดรูปแบบข้อมูล, คำนวณ, หรือจัดการข้อความ
- Don't
    - เรียกใช้ Browser/Node-specific APIs (เช่น `window` หรือ `process`)

```ts
export const clamp = (value: number, min: number, max: number): number => {
  return Math.min(max, Math.max(min, value))
}
```

### `app/composables/`

เป็นหัวใจของ Business Logic ฝั่ง Client แนะนำให้แบ่งเป็น Layer เพื่อรองรับการขยายตัว

- **`services/`**: ทำหน้าที่เป็น Wrapper หรือ Adapter สำหรับ `useFetch` เพื่อติดต่อกับ API ปลายทางโดยเฉพาะ ควรจัดการแค่การเรียก API, ส่งข้อมูล, และคืนค่า ไม่ควรมี Business Logic อื่นๆ
- **`core/`**: เก็บ Business Logic หลักที่ทำงานแบบเดี่ยวๆ (Standalone) ไม่ขึ้นกับหน้าใดหน้าหนึ่งโดยตรง เช่น `useAuth`, `useCart`
- **`facade/`**: ทำหน้าที่ประสานงาน (Orchestration) ระหว่าง `core` composables หลายๆ ตัว เพื่อสร้าง Flow การทำงานที่ซับซ้อนสำหรับหน้า Page หรือ Feature นั้นๆ ช่วยให้ Page ไม่ต้องรับรู้ Logic ที่ซับซ้อนเกินไป

- Do
    - ตั้งชื่อด้วย `use...` (เช่น `useUser`, `useCart`)
    - ใช้ `useFetch` ใน `services/`
    - ใช้ `useState` หรือ Pinia ใน `core/`
- Don't
    - ใส่โค้ดที่จัดการ DOM โดยตรง (ควรทำใน Component)
    - เรียก `useFetch` โดยตรงจาก Page หรือ Component (ควรเรียกผ่าน `services/`)

```ts
export const useUserService = () => {
  const getUser = (id: string) => {
    return useFetch(`/api/users/${id}`)
  }

  return { getUser }
}
```

### `app/components/`

สร้าง UI ที่นำกลับมาใช้ใหม่ได้

- Do
    - ออกแบบ Component ให้รับ Props และส่ง Events (Props in, Events out)
    - จัดกลุ่มตาม Feature (เช่น `components/products/Card.vue`)
    - ใช้ UnoCSS สำหรับ Styling เป็นหลัก
- Don't
    - ดึงข้อมูลโดยตรง (ควรทำผ่าน `composables`)
    - ใส่ Business Logic ที่ซับซ้อน

```vue
<script setup lang="ts">
defineProps<{ label: string }>()

const emit = defineEmits<{ click: [] }>()
</script>

<template>
  <button type="button" @click="emit('click')">{{ label }}</button>
</template>
```

### `app/pages/`

ประกอบ `components` และ `composables` เข้าด้วยกันเพื่อสร้างหน้าเว็บที่สมบูรณ์

- Do
    - เรียกใช้ `composables` เพื่อดึงข้อมูลและจัดการ State
    - ส่งข้อมูลที่ได้ไปยัง `components` ผ่าน Props
    - จัดการ Loading และ Error states
- Don't
    - เขียน UI ที่ซับซ้อนโดยตรง (ควรแยกเป็น Component)

```vue
<script setup lang="ts">
const { data, pending, error } = await useFetch('/api/health')
</script>

<template>
  <div v-if="pending">Loading...</div>
  <div v-else-if="error">Error</div>
  <pre v-else>{{ data }}</pre>
</template>
```

### `app/utils/`

เก็บฟังก์ชันที่ใช้เฉพาะฝั่ง Client เท่านั้น

- Do
    - สร้างฟังก์ชันที่ทำงานกับ DOM หรือ Browser APIs (เช่น `window`)
    - เหมาะสำหรับฟังก์ชันจัดการ UI ที่ซับซ้อน หรือ Logic ที่ไม่เกี่ยวกับ State
- Don't
    - ใส่ Business Logic ที่ควรอยู่ใน `composables`

### `server/db/`

จัดการเฉพาะการเชื่อมต่อ, Query, และ Transaction กับฐานข้อมูลเท่านั้น

- Do
    - สร้างฟังก์ชันสำหรับ CRUD (Create, Read, Update, Delete) ที่รับ Parameter และคืนค่าข้อมูล
    - ใช้ ORM (เช่น Prisma, Drizzle) หรือ Query Builder ภายใน Directory นี้
- Don't
    - ใส่ Business Logic ที่ไม่เกี่ยวกับการ Query ข้อมูลโดยตรง

```ts
export const getUserById = async (db: unknown, id: string) => {
  return { id }
}
```

### `server/utils/`

เก็บ Business Logic ที่ทำงานฝั่ง Server โดยเฉพาะ

- Do
    - เรียกใช้ฟังก์ชันจาก `server/db/` เพื่อดึงและจัดการข้อมูล
    - ประมวลผลข้อมูล, ตรวจสอบสิทธิ์, หรือทำงานที่ซับซ้อนก่อนจะส่ง Response กลับไป
- Don't
    - เขียนโค้ด Query ฐานข้อมูลโดยตรงใน Directory นี้

### `server/api/`

สร้าง API Endpoints เพื่อจัดการข้อมูลฝั่ง Server ทำหน้าที่เป็น Controller

- Do
    - ใช้ `defineEventHandler` เพื่อสร้าง Route Handler
    - อ่านและตรวจสอบข้อมูลนำเข้า (เช่น `body`, `params`) โดยใช้ Schema จาก `shared/types/`
    - เรียกใช้ Logic จาก `server/utils/` เพื่อทำงาน
- Don't
    - เขียน Business Logic หรือ Query ฐานข้อมูลทั้งหมดลงในไฟล์เดียว

```ts
import { z } from 'zod'

const ParamsSchema = z.object({ id: z.string() })

export default defineEventHandler(async (event) => {
  const params = ParamsSchema.parse(event.context.params)
  return { id: params.id }
})
```

### `server/routes/`

กำหนด Custom Server Routes นอกเหนือจาก `server/api`

- Do
    - ใช้สำหรับสร้าง Webhooks หรือ Routes ที่ต้องการการปรับแต่งเป็นพิเศษ
    - ตั้งชื่อไฟล์ตาม URL Path (เช่น `server/routes/sitemap.xml.ts`)

### `server/middleware/`

ทำงานก่อน Server Routes เพื่อจัดการ Request ขาเข้า

- Do
    - ใช้สำหรับ Authentication, Logging, หรือการเพิ่มข้อมูลให้กับ Request
    - ตั้งชื่อไฟล์ตามลำดับการทำงาน (เช่น `01.auth.ts`, `02.logger.ts`)

### `server/plugins/`

ขยายความสามารถของ Nitro Server (เซิร์ฟเวอร์ของ Nuxt)

- Do
    - ใช้สำหรับเชื่อมต่อกับ Database, ตั้งค่า Services, หรือทำงานตอน Server เริ่มต้น
    - ตั้งชื่อไฟล์ตามสิ่งที่ทำ (เช่น `database.ts`)

## Import Rules

เพื่อให้การแบ่ง Layer มีประสิทธิภาพ เราต้องมีวินัยในการ Import:

```plaintext
# Client-side (app/)
pages       <-- components, composables/facade
components  <-- composables/core
composables/facade <-- composables/core
composables/core   <-- composables/services, shared/types
composables/services <-- shared/types

# Server-side (server/)
api         <-- server/utils, shared/types
utils       <-- server/db, shared/types
db          <-- shared/types

# Shared
shared      <-- (No internal dependencies from app/ or server/)
```
