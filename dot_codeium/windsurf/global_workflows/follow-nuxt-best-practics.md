---
description: follow-nuxt-best-practics
auto_execution_mode: 1
---

refactor ไฟล์ที่เลือก


- ui => components/
- functions => compoables/
- data => server/
- types => types/

## app/*.vue
- ใช้ script setup lang="ts"
- ให้ script อยู่ด้านบน template
- class ใช้จาก uno.config.ts theme เท่านั้น ไม่ใช้ style, style scope และไม่ต้องใช้ d
- ใช้ theme จาก uno.config.ts เท่านั้น
- ไม่ควร import types ที่ถ้า ถ้า import ผ่าน compoables/ หรือ store/ ที่มี type ติดมาแล้ว 
- ไม่ใช่ <svg> ใช้จาก iconiy json mdi ทั้งหมด



## app/compoables/*.ts
- อะไรที่เป็น data server ควรใช้จาก server/
- ถ้า compoables ต้องใช้ในหลาย components ให้แยก type ใน compoables ไปใน types/
- อะไรที่เป็น useXXX จาก pages ให้ใช้ folder ใน compoables และให้มี index.ts สำหรับ reexport

## app/store
- logic ต้อง import จาก compoables