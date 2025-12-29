---
trigger: always_on
---

- ทำให้ดีตาม composables api style
- อะไรควรเป็น interface บ้าง
- ทำให้ type safe
- type ของ ui ย้ายไปใน app/types
- ควรใช้อะไรจาก server/api ได้บ้าง และถ้าใช้ useFetch หรือ useAsyncData ไม่ใช้ fetch
- ให้จัดกลุ่มไฟล์ตามนี้เช่น composables,/useChat/index.ts, composables/useChat/useXXX โดยที่ index.ts สำหรับ reexport เท่านั้
