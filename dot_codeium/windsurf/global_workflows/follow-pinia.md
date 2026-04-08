---
title: Follow Pinia
description: แนวทางการใช้งาน Pinia สำหรับ state management ใน Vue applications
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการใช้งาน Pinia สำหรับ state management ใน Vue applications

## Execute

1. Setup Pinia Store

- ติดตั้ง Pinia dependency
- สร้าง stores directory
- กำหนด main store file
- Setup Pinia plugin ใน main.js

2. Define Store Structure

- ใช้ Composition API style (setup stores)
- กำหนด state, getters, actions
- ใช้ proper naming conventions
- แยก stores ตาม domain/feature

3. Implement State Management

- ใช้ ref/reactive สำหรับ state
- สร้าง getters ด้วย computed
-  implement actions สำหรับ mutations
- ใช้ $reset สำหรับ resetting state

4. Use Stores in Components

- ใช้ storeToRefs สำหรับ destructuring
- Access stores ใน setup functions
- ใช้ actions ใน event handlers
- จัดการ subscriptions ถ้าจำเป็น

5. Add Persistence (Optional)

- ติดตั้ง pinia-plugin-persistedstate
- กำหนด persist strategies
- เลือก fields ที่จะ persist
- Handle serialization

6. Test Stores

- เขียน unit tests สำหรับ stores
- Test actions และ state changes
- Mock external dependencies
- Test edge cases

## Rules

1. Setup Store Pattern

- ใช้ setup function pattern (ไม่ใช่ option stores)
- ใช้ arrow functions สำหรับ actions
- Return state ที่จำเป็นเท่านั้น
- ใช้ const สำหรับ store definition

2. State Naming

- ใช้ descriptive names สำหรับ state properties
- หลีกเลี่ยง generic names เช่น data, value
- ใช้ isLoading, hasError pattern สำหรับ async states
- กลุ่ม related state เข้าด้วยกัน

3. Action Conventions

- ใช้ async/await สำหรับ async actions
- Handle errors อย่างครบถ้วน
- Return values จาก actions เมื่อเหมาะสม
- ไม่ mutate state นอก actions

4. Getters Usage

- ใช้ getters สำหรับ derived state
- หลีกเลี่ยง duplicate computations
- Pass parameters ด้วย closure ถ้าจำเป็น
- Cache expensive computations

## Expected Outcome

- Pinia stores ที่ well-structured
- State management ที่ predictable
- Type-safe store usage
- Tested store logic
- Documentation สำหรับ store patterns
