---
description: follow nuxt best practics
auto_execution_mode: 3
---

follow ทำตามกฏเหล่านี้อย่างเคร่งครัด (Nuxt 4)

## Nuxt 4 Project Structure

```
my-nuxt-app/
├── app/                    # Client code
│   ├── assets/             # CSS, images (processed)
│   ├── components/         # Vue components (auto-import)
│   ├── composables/        # Composition API (auto-import)
│   ├── layouts/            # Layout components
│   ├── middleware/         # Route middleware
│   ├── pages/              # File-based routing
│   ├── plugins/            # Vue/Nuxt plugins
│   ├── utils/              # Helpers (auto-import)
│   ├── app.vue             # Root component
│   ├── app.config.ts       # Runtime config
│   └── error.vue           # Error page
├── content/                # Nuxt Content (optional)
├── public/                 # Static files
├── shared/                 # Client + Server shared
│   ├── types/              # Shared types
│   └── utils/              # Shared utils
├── server/                 # Server code
│   ├── api/                # API endpoints
│   ├── middleware/         # Server middleware
│   └── utils/              # Server utils
├── nuxt.config.ts
└── tsconfig.json
```

## Core Concepts

### Architecture Overview
```
                ┌────────────────────────────────────────────────┐
                │   Nuxt 4 Architecture (Auto-imports + SSR)     │
                └────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │shared/types/ │
                              └──────┬───────┘
                                     │ TypeScript types (client + server)
                                     │
                      ┌──────────────┼──────────────┐
                      │              │              │
                      ▼              ▼              ▼
              ┌───────────────┐           ┌─────────────────┐
              │  Client Side  │           │   Server Side   │
              └───────────────┘           └─────────────────┘

         ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
         │composable│  │  stores/ │  │server/api│  │server/   │
         └─────┬────┘  └─────┬────┘  └─────┬────┘  │utils/    │
               │             │             │       └──────────┘
               │             │             │        • Helpers
               │ • useState  │ • Pinia     │        • DB utils
               │ • useFetch  │ • Setup     │        • Validators
               │ • useAsync  │ • Reactive  │
               │ • useRoute  │ • Global    │        • Event handlers
               │ • useCookie │             │        • DB queries
               │             │             │        • Business logic
               └──────┬──────┴──────┬──────┘
                      │             │
           ┌──────────┼─────────────┼──────────┐
           │          │             │          │
           ▼          ▼             ▼          ▼
      ┌─────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
      │app/utils│ │ plugins/ │ │middleware│ │  pages/  │
      └─────────┘ └──────────┘ └──────────┘ └─────┬────┘
       • Helpers   • Vue        • Route      │
       • Format    • Global     • Auth       │ • index.vue
       • Pure fn   • .client    • Redirects  │ • [id].vue
                   • .server    • *.global   │ • [...slug].vue
                                              │ • error.vue
           │            │            │        │
           └────────────┬────────────┴────────┘
                        │
              ┌─────────┼─────────┐
              │                   │
              ▼                   ▼
        ┌───────────┐       ┌──────────┐
        │components/│       │ layouts/ │
        └─────┬─────┘       └──────────┘
              │              • default.vue
              │ • Base       • custom.vue
              │ • UI         • <NuxtLayout>
              │ • Form       • <slot />
              │ (auto-import)
              │
              └─────────┬─────────┘
                        │
              ┌─────────┼─────────┐
              │                   │
              ▼                   ▼
        ┌──────────┐        ┌──────────┐
        │app.config│        │  Build   │
        └──────────┘        └──────────┘
         • Runtime           • Nitro
         • Theme             • Auto-imports
         • Constants         • Type generation
              │
              ▼
    ┌─────────────────────────────────────┐
    │    Data & State Management          │
    └─────────────────────────────────────┘
              │
     ┌────────┼────────┐
     │        │        │
     ▼        ▼        ▼
┌──────────┐ ┌──────────┐ ┌──────────┐
│ Database │ │ External │ │  Cache   │
└──────────┘ └──────────┘ └──────────┘
 • Prisma     • $fetch     • Nitro
 • Drizzle    • useFetch   • Route rules
 • SQL        • API calls  • State cache
```

### Core Principles
- **New Structure**: `app/` separated from root → faster file watchers, better IDE
- **Auto-imports**: Components, composables, utils - no import statements needed
- **File-based Routing**: `app/pages/` → automatic routes
- **Shared Code**: `shared/` directory for code used by both client & server
- **TypeScript Projects**: Separate tsconfig for app, server, shared (better inference)
- **Smart Data Fetching**: `useFetch/useAsyncData` with auto-share, auto-cleanup, reactive keys
- **SSR-First**: Server-side rendering by default, hydration on client

### Data Flow
```
shared/types → composables → components
       ↓             ↓
   server/api ←— app/pages (SSR)
       ↓
   stores (Pinia - global state)
```

### Key Technologies
- **Framework**: Nuxt 4 (Vue 3 + Composition API)
- **Styling**: UnoCSS (utility-first, no runtime)
- **Icons**: UnoCSS + Iconify (@iconify-json/mdi)
- **State**: Pinia (setup stores, Composition API style)
- **Database**: Prisma (type-safe ORM)
- **Validation**: Zod (runtime schema validation)
- **Testing**: Vitest + @vue/test-utils

## Folder Rules

### app/components/
- <Purpose> => Vue components (auto-import)
- <Do> => `<script setup lang="ts">`, Composition API, folders `ui/form/`, `defineProps/defineEmits<T>()`
- <Don't> => business logic (→composables), API ตรง, Options API, ชื่อเดี่ยว, `any`
- <Naming> => `PascalCase.vue`, Subfolder `ui/Button.vue`→`<UiButton/>`
- <Type Safety> => typed props, `defineProps<Props>()`, ห้าม `any`
- <Styling> => UnoCSS classes จาก `uno.config.ts`, สร้าง shortcuts ใน theme, ห้าม inline/hardcode
- <Icons> => `presetIcons` + `@iconify-json/mdi`, ใช้ class `i-mdi-{icon-name}`
- <Testing> => Vitest + @vue/test-utils
- <Example>
```vue
<script setup lang="ts">
interface Props{title:string}
interface Emits{(e:'click',id:string):void}
defineProps<Props>()
const emit=defineEmits<Emits>()
</script>
<template>
  <div class="card">
    <h1 class="text-lg font-bold">{{title}}</h1>
    <button class="btn-primary flex items-center gap-2" @click="emit('click','123')">
      <div class="i-mdi-home text-xl"/>Click
    </button>
  </div>
</template>
```

---

### app/composables/
- <Purpose> => Composition API helpers (auto-import)
- <Do> => prefix `use`, return reactive+functions, `useState` (SSR-safe), export named
- <Don't> => export default, side effects, `any`
- <Naming> => `usePascalCase.ts`, return destructurable
- <Type Safety> => return type ทุก composable
- <Built-in> => `useState/useFetch/useAsyncData/useRoute/useCookie/useHead`
<Example>
```typescript
export const useCounter=(init=0)=>{
  const count=useState('counter',()=>init)
  return {count:readonly(count),increment:()=>count.value++}
}
```

---

### app/pages/
<Purpose> => File-based routing
<Do> => kebab-case, `definePageMeta()`, dynamic `[id]/[...slug]`, `useFetch`, `useSeoMeta`
<Don't> => business logic (→composables), PascalCase
<Naming> => `kebab-case.vue`, Dynamic `[id]`, Catch-all `[...slug]`
<Type Safety> => Type route params
<Example>
```vue
<script setup lang="ts">
definePageMeta({layout:'dashboard',middleware:'auth'})
useSeoMeta({title:'Users'})
const {data:users}=await useFetch<User[]>('/api/users')
</script>
<template>
  <div><h1>Users</h1>
    <ul><li v-for="u in users" :key="u.id">{{u.name}}</li></ul>
  </div>
</template>
```

---

### app/layouts/
<Purpose> => Page layout wrappers
<Do> => `<slot/>`, `default.vue`, shared UI
<Don't> => page-specific logic
<Naming> => `kebab-case.vue`, Default `default.vue`
<Example>
```vue
<template>
  <div><header><nav><NuxtLink to="/">Home</NuxtLink></nav></header>
  <main><slot/></main></div>
</template>
```

---

### app/stores/ (Pinia)
<Purpose> => Global state management
<Do> => Pinia setup stores, prefix `usePascalCaseStore`, `defineStore()`, export functions
<Don't> => local state, Options API, `any`
<Naming> => `usePascalCaseStore.ts`, Actions `camelCase` กริยา
<Type Safety> => type state, actions
<Example>
```typescript
export const useUserStore=defineStore('user',()=>{
  const user=ref<User|null>(null)
  const isLoggedIn=computed(()=>!!user.value)
  const login=async(creds)=>{
    const data=await $fetch('/api/auth/login',{method:'POST',body:creds})
    user.value=data.user
  }
  return {user:readonly(user),isLoggedIn,login}
})
```

---

### server/api/
<Do> => `defineEventHandler()`, `*.get/post.ts`
<Libraries> => **Prisma**, **Zod**
<Example>
```typescript
export default defineEventHandler(async(e)=>{
  return await db.user.findUnique({where:{id:getRouterParam(e,'id')}})
})
```

### server/middleware/
<Do> => `defineEventHandler()`, logging/auth
<Example> => `defineEventHandler(e=>console.log(`[${e.method}] ${e.path}`))`

### app/middleware/
<Do> => `defineNuxtRouteMiddleware()`, `navigateTo()`
<Example>
```typescript
export default defineNuxtRouteMiddleware(to=>{
  const {isLoggedIn}=useUserStore()
  if(!isLoggedIn&&to.path!=='/login')return navigateTo('/login')
})
```

### shared/types/
<Do> => types shared client+server
<Example> => `export interface User{id:string;name:string;email:string}`

### app/plugins/
<Do> => `defineNuxtPlugin()`, `.client/.server.ts`
<Example>
```typescript
export default defineNuxtPlugin(()=>{
  const api=$fetch.create({baseURL:'/api'})
  return {provide:{api}}
})
```

---

## Configuration Files

### app.config.ts
```typescript
export default defineAppConfig({theme:{primary:'#3b82f6'}})
```

### error.vue
```vue
<script setup lang="ts">
defineProps<{error:{statusCode:number}}>()
</script>
<template>
  <div><h1>{{error.statusCode}}</h1></div>
</template>
```

### nuxt.config.ts
```typescript
export default defineNuxtConfig({
  devtools: { enabled: true },
  
  modules: [
    '@unocss/nuxt',
    '@pinia/nuxt',
    '@vueuse/nuxt'
  ],
  
  css: [
    '@unocss/reset/tailwind-compat.css',
    '~/assets/token.css'
  ],
  
  runtimeConfig: {
    apiSecret: process.env.API_SECRET, // server-only
    public: {
      apiBase: '/api' // client + server
    }
  },
  
  typescript: {
    strict: true
  },
  
  vite: {
    plugins: [
      checker({
        overlay: { initialIsOpen: false },
        typescript: true,
        vueTsc: true,
        biome: { command: 'lint' }
      })
    ]
  }
})
```

### tsconfig.json
- รัน /setup-tsconfig
**Note**: Auto-generated, แยก projects app/server/shared → autocompletion + type inference ดีกว่า

### uno.config.ts
```typescript
import { defineConfig, presetWind, presetIcons } from 'unocss'
export default defineConfig({
  presets: [
    presetWind(),
    presetIcons({
      collections: {
        mdi: () => import('@iconify-json/mdi/icons.json').then(i => i.default)
      }
    })
  ],
  shortcuts: {
    'btn-primary': 'px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700',
    'btn-secondary': 'px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-700',
    'card': 'p-4 bg-white rounded shadow',
    'input-field': 'px-3 py-2 border rounded focus:outline-blue-500'
  },
  theme: { colors: { primary: '#3b82f6', secondary: '#6b7280' } }
})
```