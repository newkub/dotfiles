---
title: Follow Nuxt
description: แนวทางการพัฒนาโปรเจกต์ Nuxt ตาม Best Practices
auto_execution_mode: 3

file-patterns:
  - "**/*.vue"
  - "**/*.ts"
  - "**/nuxt.config.ts"

follow:
  skills:
    - "@refactor"
    - "@refactor-vue"
    - "@refactor-ts"

  workflows:
    - "/refactor"
    - "/refactor-vue"
    - "/refactor-ts"
    - "/follow-biome"
    - "/follow-nuxt-composables"
---

## Purpose

กำหนดแนวทางการพัฒนาโปรเจกต์ Nuxt ให้เป็นมาตรฐาน ใช้ best practices และ NuxtHub สำหรับ full-stack deployment

## Steps

### Phase 1: Setup

1. **ตรวจสอบ Library และ Config**

   | Library | ใช้สำหรับ |
   |---------|-----------|
   | `@vueuse/nuxt` | Vue composition utilities |
   | `@unocss/nuxt` | Atomic CSS engine |
   | `@nuxt/icon` | Icon system |
   | `@nuxthub/core` | Cloudflare integration, Database, KV, Blob |

   - ใช้ `bun` เป็น package manager
   - ใช้ `~/` สำหรับ import alias
   - ไม่ต้อง import composables/components ที่อยู่ใน `composables/` และ `components/`

2. **ตั้งค่า NuxtHub**

   ```typescript
   // nuxt.config.ts
   export default defineNuxtConfig({
     modules: ['@nuxthub/core'],
     hub: {
       database: true,    // PostgreSQL/SQLite/MySQL
       kv: true,          // Key-Value storage
       blob: true,        // File storage
       cache: true,       // Caching
     },
     nitro: {
       experimental: {
         wasm: true       // WebAssembly support
       }
     }
   })
   ```

### Phase 2: Analyze

3. **วิเคราะห์โครงสร้างโปรเจกต์**

   ```text
   ├── app/
   │   ├── app.vue              # Root component
   │   ├── app.config.ts        # Runtime app config
   │   ├── error.vue            # Error page
   │   ├── assets/              # CSS, fonts, images
   │   ├── components/          # Vue components (auto-imported)
   │   │   ├── ui/              # UI primitives
   │   │   └── [feature]/       # Feature-specific
   │   ├── composables/         # ดู /follow-nuxt-composables
   │   ├── layouts/             # Page layouts
   │   ├── middleware/          # Route middleware
   │   ├── pages/               # File-based routes
   │   ├── plugins/             # Vue plugins
   │   └── utils/               # Helper functions
   ├── modules/                 # Local modules
   │   └── [module-name]/
   │       ├── index.ts
   │       └── runtime/
   ├── server/
   │   ├── api/                 # API routes (/api/*)
   │   ├── routes/              # Server routes (/*)
   │   ├── middleware/          # Server middleware
   │   ├── plugins/             # Nitro plugins
   │   └── utils/               # Server utilities
   ├── .data/                   # NuxtHub local data
   ├── nuxt.config.ts
   └── wrangler.jsonc           # Cloudflare config
   ```

4. **ตรวจสอบ Config Files**

   | ไฟล์ | สิ่งสำคัญ |
   |------|----------|
   | `package.json` | `bun`, `"type": "module"`, `@nuxthub/core` |
   | `nuxt.config.ts` | TypeScript, modules, hub config |
   | `wrangler.jsonc` | Cloudflare deployment config |
   | `tsconfig.json` | Nuxt-generated types |
   | `biome.jsonc` | VCS enabled |

### Phase 3: Execute

5. **สร้าง app.vue และ app.config.ts**

   ```vue
   <!-- app.vue -->
   <template>
     <NuxtLayout>
       <NuxtPage />
     </NuxtLayout>
   </template>
   ```

   ```typescript
   // app.config.ts
   export default defineAppConfig({
     theme: {
       primaryColor: '#3b82f6',
     },
   })
   ```

6. **จัดโครงสร้าง Components**

   - `ui/` - UI primitives (Button, Input, Card)
   - `[feature]/` - Feature-specific components
   - `shared/` - Shared across features
   - ใช้ `script setup lang="ts"`
   - Script อยู่ด้านบน template

7. **จัดโครงสร้าง Composables**

   ดูรายละเอียดที่ `/follow-nuxt-composables`:

   | ชั้น | โฟลเดอร์ | ตัวอย่าง |
   |------|----------|----------|
   | 1 | `primitives/` | `useLocalStorage()`, `useDebounce()` |
   | 2 | `state/` | `useAuthStore()`, `useThemeStore()` |
   | 3 | `ui/` | `useModal()`, `useDropdown()` |
   | 4 | `features/` | `useUserProfile()`, `useCheckout()` |
   | 5 | `domain/` | `useOrderManagement()` |

8. **สร้าง Server Structure**

   ```typescript
   // server/api/users/index.get.ts
   export default defineEventHandler(async (event) => {
     const query = await getValidatedQuery(event, z.object({
       page: z.number().default(1)
     }).parse)
     const db = hubDatabase()
     return { users }
   })

   // server/plugins/database.ts
   export default defineNitroPlugin(async (nitroApp) => {
     // Initialize database connection
   })

   // server/utils/db.ts
   export function useDB() {
     return hubDatabase()
   }
   ```

   - `api/` - API routes สำหรับ `/api/*`
   - `routes/` - Server routes สำหรับ `/*`
   - `middleware/` - Server middleware (logging, auth)
   - `plugins/` - Nitro plugins
   - `utils/` - Server utilities

9. **สร้าง Local Modules**

   ```typescript
   // modules/auth/index.ts
   import { createResolver, defineNuxtModule } from 'nuxt/kit'

   export default defineNuxtModule({
     meta: { name: 'auth' },
     setup() {
       const resolver = createResolver(import.meta.url)
       // Add components, composables, server handlers
     },
   })
   ```

10. **ตั้งค่า Environment**

    ```typescript
    // nuxt.config.ts
    runtimeConfig: {
      apiSecret: process.env.NUXT_API_SECRET,
      public: {
        apiBase: process.env.NUXT_PUBLIC_API_BASE
      }
    }
    ```

    - ใช้ `NUXT_PUBLIC_` prefix สำหรับค่าที่ expose ไป client
    - ใช้ `NUXT_HUB_PROJECT_SECRET_KEY` สำหรับ NuxtHub
    - สร้าง `.env.example`

11. **ตรวจสอบ Error & SEO**

    ```vue
    <!-- error.vue -->
    <template>
      <div>
        <h1>{{ error.statusCode }}</h1>
        <p>{{ error.message }}</p>
        <button @click="handleError">Go Home</button>
      </div>
    </template>
    ```

    - สร้าง `error.vue` สำหรับ global error handling
    - ใช้ `useHead` และ `useSeoMeta`
    - ตั้งค่า `titleTemplate`

12. **ตรวจสอบ Middleware & Layouts**

    ```typescript
    // middleware/auth.ts
    export default defineNuxtRouteMiddleware((to, from) => {
      if (!useUser().isLoggedIn) return navigateTo('/login')
    })
    ```

    - Middleware ใช้ `defineNuxtRouteMiddleware`
    - Layouts ใช้ `<slot />`

13. **ใช้ NuxtHub Features**

    ```typescript
    // Database
    const db = hubDatabase()
    const result = await db.exec('SELECT * FROM users')

    // KV Storage
    const kv = hubKV()
    await kv.set('key', 'value')
    const value = await kv.get('key')

    // Blob Storage
    const blob = hubBlob()
    await blob.put('file.txt', file)
    ```

14. **ตรวจสอบ Deployment**

    ```typescript
    // nuxt.config.ts
    nitro: {
      preset: 'cloudflare_module',
      cloudflare: { deployConfig: true, nodeCompat: true }
    }
    ```

    - ใช้ `cloudflare_module` preset
    - ตั้งค่า `wrangler.jsonc` สำหรับ Cloudflare

### Phase 4: Verify

15. **รัน Refactor Workflows**
    - /refactor
    - /refactor-vue
    - /refactor-ts

16. **ตรวจสอบความสมบูรณ์**
    - รัน `bun run lint`
    - รัน `bun run build`
    - รัน `bun run dev` เพื่อทดสอบ

## Expected Outcome

- โปรเจกต์ใช้ Nuxt + NuxtHub ecosystem ได้อย่างเต็มประสิทธิภาพ
- โครงสร้างโปรเจกต์เป็นมาตรฐาน (app.vue, app.config.ts, modules, server)
- Composables และ Server API มี patterns ที่ consistent
- Code ผ่าน Biome lint/format

## Reference

- `/refactor` - แนวทางการ refactor code
- `/refactor-vue` - แนวทางการ refactor Vue components
- `/refactor-ts` - แนวทางการ refactor TypeScript
- `/follow-biome` - ตั้งค่าและใช้งาน Biome
- `/follow-nuxt-composables` - แนวทางจัดโครงสร้าง Composables
- [Nuxt Documentation](https://nuxt.com/docs)
- [NuxtHub Documentation](https://hub.nuxt.com/docs)
