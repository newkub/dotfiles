---
auto_execution_mode: 3
---


### `shared/types/`
- หน้าที่ กำหนดโครงสร้างข้อมูลหลักด้วย TypeScript Interfaces หรือ Types และ Schema สำหรับ Validation
- Do
    - ใช้ Zod, Valibot, หรือ ArkType เพื่อสร้าง Schema ที่ตรวจสอบความถูกต้องของข้อมูล
    - Export Type และ Schema เพื่อให้ `composables` และ `server/api` นำไปใช้ได้
- Don't
    - ใส่ Logic การทำงานใดๆ ในไฟล์เหล่านี้


### `shared/utils/`
- หน้าที่ เก็บฟังก์ชันบริสุทธิ์ (Pure Functions) ที่ใช้ได้ทั้งฝั่ง Client และ Server
- Do
    - สร้างฟังก์ชันที่รับ Input และคืนค่า Output โดยไม่มี Side Effects
    - เหมาะสำหรับฟังก์ชันจัดรูปแบบข้อมูล, คำนวณ, หรือจัดการข้อความ
- Don't
    - เรียกใช้ Browser/Node-specific APIs (เช่น `window` หรือ `process`)


### `app/composables/`
- หน้าที่ เป็นหัวใจของ Business Logic ฝั่ง Client, จัดการ State, และดึงข้อมูลจาก API
- Do
    - ตั้งชื่อด้วย `use...` (เช่น `useUser`, `useCart`)
    - ใช้ `useFetch` หรือ `useAsyncData` สำหรับการดึงข้อมูล
    - ใช้ `useState` สำหรับ State ง่ายๆ หรือ Pinia สำหรับ State ที่ซับซ้อน
- Don't
    - ใส่โค้ดที่จัดการ DOM โดยตรง (ควรทำใน Component)


### `app/components/`
- หน้าที่ สร้าง UI ที่นำกลับมาใช้ใหม่ได้
- Do
    - ออกแบบ Component ให้รับ Props และส่ง Events (Props in, Events out)
    - จัดกลุ่มตาม Feature (เช่น `components/products/Card.vue`)
    - ใช้ UnoCSS สำหรับ Styling เป็นหลัก
- Don't
    - ดึงข้อมูลโดยตรง (ควรทำผ่าน `composables`)
    - ใส่ Business Logic ที่ซับซ้อน


### `app/pages/`
- หน้าที่ ประกอบ `components` และ `composables` เข้าด้วยกันเพื่อสร้างหน้าเว็บที่สมบูรณ์
- Do
    - เรียกใช้ `composables` เพื่อดึงข้อมูลและจัดการ State
    - ส่งข้อมูลที่ได้ไปยัง `components` ผ่าน Props
    - จัดการ Loading และ Error states
- Don't
    - เขียน UI ที่ซับซ้อนโดยตรง (ควรแยกเป็น Component)


### `server/api/`
- หน้าที่ สร้าง API Endpoints เพื่อจัดการข้อมูลฝั่ง Server
- Do
    - ใช้ `defineEventHandler` เพื่อสร้าง Route Handler
    - อ่านและตรวจสอบข้อมูลนำเข้า (เช่น `body`, `params`) โดยใช้ Schema จาก `shared/types/`
    - แยก Logic ที่ซับซ้อน (เช่น การติดต่อฐานข้อมูล) ไปไว้ใน `server/utils/`
- Don't
    - เขียน Business Logic ทั้งหมดลงในไฟล์เดียว

