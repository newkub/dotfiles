---
description: Refactor composables according to Vue Composition API best practices.
auto_execution_mode: 3
---

- เขียนให้ดีตาม vue composition api
- ทำให้ type safe กว่านี้ และแยก interface ไปใน  types/app หรือ shared/types 
- logic ที่ pure ย้ายไปใน shared/utils
- ใช้ vueuse ให้เต็มประสิทธิภาพ
- ถ้า package.json ใช้ nuxt ให้ใช้ useFetch หรือ useAsyncData
- อะไรควรใช้จาก server ให้ใช้จาก server/api
- อะไรที่ควรเป็น global store ย้ายไปใน stores/ แล้วนำมาไ

