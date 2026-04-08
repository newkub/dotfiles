---
title: Vue Composables Best Practices
description: แนวทางการเขียน Vue/Nuxt Composables
auto_execution_mode: 3
---

## Prompt

สร้างหรือปรับปรุง Vue/Nuxt Composables ให้มีคุณภาพสูง

## Execute

1. วิเคราะห์: ระบุหน้าที่ กำหนด inputs/outputs ระบุ state ที่ต้อง reactive
2. สร้าง: เขียนตาม pattern ใช้ TypeScript ครบถ้วน
3. ตรวจสอบ: ไม่มี mock data, cleanup ครบถ้วน

## Rules

### Naming
- ขึ้นต้นด้วย `use` เสมอ
- `use<Purpose>` หรือ `use<Feature><Action>` เช่น `useBookingList`
- boolean: `isLoading`, `hasError`
- async actions: `fetchUsers`, `saveBooking`

### Structure
```
composables/
├── core/
│   ├── use<Purpose>.ts      # useAsyncState, useLocalStorage
│   └── use<Utility>.ts      # useDebouncedRef
├── <feature>/
│   ├── use<Feature>List.ts   # useBookingList
│   ├── use<Feature>Detail.ts
│   └── use<Feature>Form.ts
├── ui/
│   └── use<UI>.ts           # useModal, useToast
├── utils/
│   └── use<Util>.ts
└── validation/
    └── use<Validation>.ts
```

**หลักการ:**
- `core/` → Pure composables (ใช้ทุกที่)
- `<feature>/` → Business logic เฉพาะ domain
- `ui/` → UI state
- `utils/` → Helpers ทั่วไป
- `validation/` → Form validation

### Pattern

```typescript
// Options (ถ้ามี > 2 params)
interface UseXOptions {
  id: string
  immediate?: boolean
}

// Return object
return {
  // State
  data, isLoading, error,
  // Computed
  isEmpty, hasData,
  // Actions
  refresh, cancel
}
```

### Async Pattern
```typescript
const error = ref<Error | null>(null)
const isLoading = ref(false)

async function fetch() {
  isLoading.value = true
  error.value = null
  try {
    data.value = await api.get()
  } catch (err) {
    error.value = err instanceof Error ? err : new Error(String(err))
  } finally {
    isLoading.value = false
  }
}
```

### Anti-Patterns
- ❌ Return reactive object โดยตรง
- ❌ Mutate parameters
- ❌ เรียก composable ใน if/else หรือ loop
- ❌ `$fetch` ใน composables (ใช้ `useFetch` หรือ `useAsyncData`)

### Data Fetching
- ใช้ `useFetch()` สำหรับ SSR
- ใช้ `useAsyncData()` ถ้าต้องการ control มากขึ้น
- ไม่ mock data

### Example
```typescript
export function useBookingList() {
  const { data: bookings, isLoading, error, refresh } = useAsyncState(
    () => $fetch('/api/bookings')
  )

  const sorted = computed(() => 
    bookings.value?.sort((a, b) => b.date - a.date)
  )

  return { bookings, isLoading, error, refresh, sorted }
}