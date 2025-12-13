---
description: Guidelines for creating Vue components using script setup, UnoCSS, and other best practices
auto_execution_mode: 3
---

- ใช้ script setup lang=ts 
- ให้ scripts อยู่ด้านบน template
- refactor logic ไปที่ scripts ใน template ให้แค่แสดงผล
- ใช้ unocss ทั้งหมด ไม่ใช้ style, style scoped
- ใช้ class จาก uno.config.ts theme และไม่ต้องใช้ dark:
- ไม่ใช่ <svg> ให้ใช้ iconify json mdi (ดูว่าใช้จาก unocss หรือ nuxt icon)
- ถ้าใช้อะไรจาก vueuse ได้ ให้ใช้
- แยกเป็น components/ui แล้วนำมาใช้ 
- ใช้ https://vue-macros.dev/

