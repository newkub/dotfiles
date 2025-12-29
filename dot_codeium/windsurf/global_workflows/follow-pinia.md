---
trigger: always_on
auto_execution_mode: 3
---

## Best Practices

### 1. Setup Store Pattern

- ใช้ Composition API (setup stores) เท่านั้น ห้ามใช้ Options API
- State: `ref` หรือ `reactive`, Getters: `computed`, Actions: functions
- ตั้งชื่อ `useXxxStore` และแยกไฟล์ `xxx.store.ts`

```typescript
export const useUserStore = defineStore('user', () => {
  const user = ref<User | null>(null)
  const isAuthenticated = computed(() => user.value !== null)

  async function fetchUser(id: string) {
    const data = await api.getUser(id)
    user.value = data
  }

  return { user, isAuthenticated, fetchUser }
})
```

### 2. Store Composition

- เรียกใช้ store อื่นใน setup function ได้
- ระวัง circular dependencies

```typescript
export const useCartStore = defineStore('cart', () => {
  const userStore = useUserStore()
  const total = computed(() =>
    userStore.isAuthenticated ? calculateTotal() : 0
  )
  return { total }
})
```

### 3. Persistence

- ใช้ `pinia-plugin-persistedstate` สำหรับ localStorage
- ระบุ `paths` เฉพาะ state ที่ต้องการ persist

```typescript
export const useUserStore = defineStore('user', () => {
  // ...
}, {
  persist: {
    paths: ['user'], // เฉพาะ user, ไม่ persist loading states
  },
})
```

### 4. Component Usage

- ใช้ `storeToRefs()` เมื่อ destructure เพื่อรักษา reactivity

```typescript
const userStore = useUserStore()
const { user, isAuthenticated } = storeToRefs(userStore)
const { fetchUser } = userStore // actions ไม่ต้อง storeToRefs
```

### 5. Key Points

- แยก store ตาม domain/feature
- business logic ทั้งหมดอยู่ใน actions
- ไม่ mutate state นอก store
- Test stores แยกจาก components
