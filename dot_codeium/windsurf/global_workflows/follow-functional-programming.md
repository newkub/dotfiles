---
title: Follow Functional Programming
description: พัฒนาโปรเจกต์ด้วย functional programming principles พร้อม pure functions, immutability, composition
auto_execution_mode: 3
---

## Goal

พัฒนาโปรเจกต์ด้วย functional programming principles เพื่อลดความซับซ้อน เพิ่มความปลอดภัย และทำให้โค้ด test ได้ง่ายขึ้น

## Execute

### 1. Use Pure Functions

เขียนฟังก์ชันที่ pure เสมอเมื่อเป็นไปได้

1. หลีกเลี่ยง `side effects`: `API calls`, `DOM access`, `external state`
2. Return ค่าเดิมเสมอเมื่อ input เดิม
3. แยก pure logic จาก impure interactions
4. ใช้ `pure functions` สำหรับ business logic
5. ใช้ `impure functions` เฉพาะใน imperative shell

### 2. Enforce Immutability

ทำตาม `/follow-declarative-programming` เพื่อใช้ immutability

1. ใช้ `const` แทน `let/var` เสมอ
2. ใช้ `Readonly<>` type สำหรับ objects/arrays
3. ใช้ `readonly modifier` สำหรับ class properties
4. ใช้ `spread operator` แทน mutation
5. ใช้ `array methods` ที่ไม่ mutate: `map`, `filter`, `reduce`

### 3. Function Composition

ทำตาม `/follow-declarative-programming` เพื่อใช้ composition

1. เขียนฟังก์ชันขนาดเล็กที่ทำหน้าที่เดียว
2. ใช้ `higher-order functions`: `map`, `filter`, `reduce`
3. สร้าง `compose function` สำหรับ pipeline
4. ใช้ `type inference` สำหรับ type safety
5. ใช้ `generics` สำหรับ reusable composition

### 4. Type Safety

ทำตาม `/follow-typescript` เพื่อเพิ่มความปลอดภัย

1. ใช้ `function types` อย่างชัดเจน
2. ใช้ `generics` สำหรับ reusable functions
3. ใช้ `union types` สำหรับ multiple return types
4. ใช้ `type guards` สำหรับ type narrowing
5. ใช้ `discriminated unions` สำหรับ complex state

### 5. Separate Core and Shell

แยก functional core จาก imperative shell

1. ทำ business logic ใน `pure functions`
2. แยก `side effects` ไปที่ outer layer
3. ใช้ `dependency injection` สำหรับ impure dependencies
4. ทำ `I/O` ใน imperative shell เท่านั้น
5. ทำ validation ใน pure functions

### 6. Avoid Mutable State

หลีกเลี่ยง mutable state ที่ไม่จำเป็น

1. ใช้ `state machines` สำหรับ complex state
2. ใช้ `reducers` สำหรับ state updates
3. ใช้ `immutable data structures`
4. หลีกเลี่ยง `shared state`
5. ใช้ `message passing` แทน shared state

### 7. Error Handling

จัดการ errors ด้วย functional approach

1. ใช้ `Result/Either types` แทน exceptions
2. ใช้ `Option/Maybe types` สำหรับ nullable values
3. Propagate errors ผ่าน types ไม่ใช่ exceptions
4. ใช้ `typed error classes`
5. Handle errors อย่าง explicit

### 8. Testing

เขียน tests สำหรับ pure functions

1. `Pure functions` test ง่ายด้วย input/output
2. Mock impure dependencies ใน imperative shell
3. Test composition แยกจาก individual functions
4. ใช้ `property-based testing`
5. Test edge cases ด้วย pure functions

## Rules

### Pure Functions

ฟังก์ชันต้องเป็น pure เมื่อเป็นไปได้

- ไม่มี `side effects`
- Return ค่าเดิมเสมอเมื่อ input เดิม
- ไม่ access `external state`
- ไม่ mutate input parameters
- แยก pure logic จาก `I/O`

### Immutability

ทำตาม `/follow-declarative-programming` เพื่อใช้ immutability

- ใช้ `const` แทน `let/var`
- ใช้ `Readonly<>` type
- ใช้ `spread operator`
- ใช้ `array methods` ที่ไม่ mutate
- ไม่ mutate objects/arrays โดยตรง

### Function Composition

ทำตาม `/follow-declarative-programming` เพื่อใช้ composition

- ฟังก์ชันขนาดเล็ก single responsibility
- ใช้ `higher-order functions`
- ใช้ `pipeline pattern`
- Type-safe composition
- Reusable generic functions

### Type Safety

ทำตาม `/follow-typescript` เพื่อความปลอดภัย

- Explicit `function types`
- `Generics` สำหรับ reusability
- `Type guards` สำหรับ narrowing
- `Discriminated unions`
- Strict TypeScript config

### Core and Shell

แยก functional core จาก imperative shell

- Business logic เป็น `pure functions`
- `Side effects` ใน outer layer
- `Dependency injection`
- `I/O` เฉพาะใน shell
- Validation ใน pure functions

### State Management

จัดการ state ด้วย functional approach

- `Immutable state`
- `Reducers` สำหรับ updates
- `State machines`
- No shared state
- `Message passing`

### Error Handling

จัดการ errors ด้วย types ไม่ใช่ exceptions

- `Result/Either types`
- `Option/Maybe types`
- `Typed error classes`
- Explicit error propagation
- No try/catch ใน pure functions

## Expected Outcome

- Pure functions สำหรับ business logic
- Immutability ทั่วทั้ง codebase
- Function composition ที่ type-safe
- Clear separation ระหว่าง core และ shell
- Error handling ด้วย types
- State management ที่ predictable
- Tests ที่เขียนง่าย
- Code ที่ maintain ได้ง่าย
