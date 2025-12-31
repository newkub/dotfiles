---
trigger: always_on
---

## Setup

### config

### Libraries

- `pinia`
- `pinia-plugin-persistedstate` (optional)

## Project Structure

```plaintext
src/
├── stores/
│   ├── user.store.ts
│   ├── cart.store.ts
│   └── index.ts
└── app/
```

## Core Principles

- ใช้ Composition API (setup stores) เท่านั้น ห้ามใช้ Options API
- State: `ref` หรือ `reactive`, Getters: `computed`, Actions: functions
- แยก store ตาม domain/feature
- business logic ทั้งหมดอยู่ใน actions
- ไม่ mutate state นอก store
- Test stores แยกจาก components

## Folder Rules

### `stores/`

- Do
  - ตั้งชื่อ `useXxxStore`
  - แยกไฟล์ `xxx.store.ts`
  - ใช้ `storeToRefs()` เมื่อ destructure state/getter
- Don't
  - ทำ circular dependency ระหว่าง store
  - persist state ทั้งหมดแบบไม่เลือก

```ts
import { defineStore, storeToRefs } from 'pinia'
import { computed, ref } from 'vue'

type User = { id: string; email: string }

export const useUserStore = defineStore('user', () => {
  const user = ref<User | null>(null)
  const isAuthenticated = computed(() => user.value !== null)

  async function fetchUser(id: string) {
    const data = { id, email: 'user@company.com' }
    user.value = data
  }

  return { user, isAuthenticated, fetchUser }
})

export const useUserStoreRefs = () => {
  const store = useUserStore()
  return { ...storeToRefs(store), actions: store }
}
```

### Store composition

```ts
import { defineStore } from 'pinia'
import { computed } from 'vue'
import { useUserStore } from './user.store'

export const useCartStore = defineStore('cart', () => {
  const userStore = useUserStore()
  const total = computed(() => (userStore.isAuthenticated ? 100 : 0))
  return { total }
})
```

### Persistence

```ts
export const useSessionStore = defineStore('session', {
  state: () => ({ token: null as string | null }),
  persist: {
    paths: ['token'],
  },
})
```

## Import Rules

```plaintext
components/pages  <-- stores
stores            <-- (avoid importing components)
```
