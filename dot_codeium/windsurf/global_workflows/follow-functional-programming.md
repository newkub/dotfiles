---
title: Follow Functional Programming
description: พัฒนาโปรเจกต์ด้วย functional programming principles พร้อม pure functions, immutability, composition
auto_execution_mode: 3
related_workflows:
  - /follow-declarative-programming
  - /follow-typescript
  - /write-test
---

## Goal

พัฒนาโปรเจกต์ด้วย functional programming principles เพื่อลดความซับซ้อน เพิ่มความปลอดภัย และทำให้โค้ด test ได้ง่ายขึ้น

## Scope

ใช้สำหรับทุก workspace เพื่อเขียนโค้ดด้วย functional programming principles

## Execute

### 1. Use Pure Functions

เขียนฟังก์ชันที่ pure เสมอเมื่อเป็นไปได้:

- หลีกเลี่ยง `side effects`: `API calls`, `DOM access`, `external state`
- Return ค่าเดิมเสมอเมื่อ input เดิม
- แยก pure logic จาก impure interactions
- ใช้ `pure functions` สำหรับ business logic
- ใช้ `impure functions` เฉพาะใน imperative shell

### 2. Enforce Immutability

ทำตาม `/follow-declarative-programming` เพื่อใช้ immutability:

- ใช้ `const` แทน `let/var` เสมอ
- ใช้ `Readonly<>` type สำหรับ objects/arrays
- ใช้ `readonly modifier` สำหรับ class properties
- ใช้ `spread operator` แทน mutation
- ใช้ `array methods` ที่ไม่ mutate: `map`, `filter`, `reduce`

### 3. Function Composition

ทำตาม `/follow-declarative-programming` เพื่อใช้ composition:

- เขียนฟังก์ชันขนาดเล็กที่ทำหน้าที่เดียว
- ใช้ `higher-order functions`: `map`, `filter`, `reduce`
- สร้าง `compose function` สำหรับ pipeline
- ใช้ `type inference` สำหรับ type safety
- ใช้ `generics` สำหรับ reusable composition

### 4. Type Safety

ทำตาม `/follow-typescript` เพื่อเพิ่มความปลอดภัย:

- ใช้ `function types` อย่างชัดเจน
- ใช้ `generics` สำหรับ reusable functions
- ใช้ `union types` สำหรับ multiple return types
- ใช้ `type guards` สำหรับ type narrowing
- ใช้ `discriminated unions` สำหรับ complex state

### 5. Separate Core and Shell

แยก functional core จาก imperative shell:

- ทำ business logic ใน `pure functions`
- แยก `side effects` ไปที่ outer layer
- ใช้ `dependency injection` สำหรับ impure dependencies
- ทำ `I/O` ใน imperative shell เท่านั้น
- ทำ validation ใน pure functions

### 6. Avoid Mutable State

หลีกเลี่ยง mutable state ที่ไม่จำเป็น:

- ใช้ `state machines` สำหรับ complex state
- ใช้ `reducers` สำหรับ state updates
- ใช้ `immutable data structures`
- หลีกเลี่ยง `shared state`
- ใช้ `message passing` แทน shared state

### 7. Error Handling

จัดการ errors ด้วย functional approach:

- ใช้ `Result/Either types` แทน exceptions
- ใช้ `Option/Maybe types` สำหรับ nullable values
- Propagate errors ผ่าน types ไม่ใช่ exceptions
- ใช้ `typed error classes`
- Handle errors อย่าง explicit

### 8. Testing

ทำ `/write-test` เพื่อเขียน tests สำหรับ pure functions:

- `Pure functions` test ง่ายด้วย input/output
- Mock impure dependencies ใน imperative shell
- Test composition แยกจาก individual functions
- ใช้ `property-based testing`
- Test edge cases ด้วย pure functions

## Rules

### 1. Reference-Based Rules

ทำตาม Execute sections สำหรับ implementation details:

- Pure Functions: ทำตาม Execute section 1
- Immutability: ทำตาม `/follow-declarative-programming`
- Function Composition: ทำตาม `/follow-declarative-programming`
- Type Safety: ทำตาม `/follow-typescript`
- Core and Shell: ทำตาม Execute section 5
- State Management: ทำตาม Execute section 6
- Error Handling: ทำตาม Execute section 7
- Testing: ทำตาม `/write-test`

### 2. Core Principles

หลักการหลักของ functional programming:

- Pure functions เสมอเมื่อเป็นไปได้
- Immutability ทั่วทั้ง codebase
- Function composition สำหรับ complex logic
- Type safety สำหรับ reliability
- Separation ระหว่าง pure และ impure code

## Expected Outcome

- Pure functions สำหรับ business logic
- Immutability ทั่วทั้ง codebase
- Function composition ที่ type-safe
- Clear separation ระหว่าง core และ shell
- Error handling ด้วย types
- State management ที่ predictable
- Tests ที่เขียนง่าย
- Code ที่ maintain ได้ง่าย

