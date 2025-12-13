---
description: Vue design system best practices for components, stores, and composables
auto_execution_mode: 3
---

- ทุก components ต้อง import useComponentMeta.ts
- ทุก components ต้อง import useTheme.config.ts
- ใน components, router ใช้จาก nuxt เลย ไม่ต้องใช้ vue router
- สร้าง stores ให้เหมาะสมว่าควรใช้อะไร และควรใช้ components หรือ composa
- ทุก components เขียนเขียน script setup lang=ts และให้ script อยู่ด้านบน template
- composables เขียนให้ดีตาม vue best practics และ nuxt best practics
- ใน composables ถ้ามี data fetching ใช้ useFetch, useAsyncData ให้เหมาะสม
- ใน components => ควร refactor อะไรไปใน composables บ้าง
- comopsables => ควร refactor อะไรไปใน utils บ้าง

