---
description: review-ts
auto_execution_mode: 1
---

- ใช้ **Type / Interface ชัดเจน**: กำหนดโครงสร้างข้อมูล เช่น `User` interface  
- ใช้ **Union / Literal Type** สำหรับค่าที่จำกัด เช่น `'admin' | 'user' | 'guest'`  
- ใช้ **Type-Safe API Response / Validation**: ใช้ Zod validate API data ก่อนนำเข้าระบบ  
- ใช้ **Readonly / Immutable Pattern**: เช่น `ReadonlyArray<User>` เพื่อป้องกันแก้ไขค่าโดยไม่ตั้งใจ  
- ใช้ **Conditional แบบ Type-Safe**: เช่น filter หรือ switch-case แบบ exhaustive check  
- ใช้ **never / Exhaustive Check** ใน switch-case เพื่อตรวจจับค่า union ใหม่ที่ไม่ได้ handle  
- ใช้ **Generic Function**: เช่น `findById<T extends { id: number }>` เพื่อ reusable function แบบ type-safe  
- แยก **Logic ออกจาก Component (Composable / Function)**: ทำให้ testable, reusable และ type-safe  
- ใช้ **Type Narrowing / Type Guards**: เช่น `typeof`, `in`, `Array.isArray` ก่อนใช้งานค่าที่อาจเป็นหลาย type  
- ใช้ **Optional / Null Safety**: เช่น `?` และ `??` เพื่อป้องกัน runtime error จาก undefined / null  
- ใช้ **as const กับ Array / Object literals**: เพื่อให้ literal type ถูกตรวจสอบ compile-time และ auto-complete  
