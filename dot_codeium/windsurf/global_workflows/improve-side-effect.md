---
title: Improve Side Effect
description: ปรับปรุงการจัดการ side effects ด้วย functional programming patterns
auto_execution_mode: 3
related_workflows:
  - /follow-functional-programming
  - /follow-functional-core-imperative-shell
---

## Goal

ปรับปรุงการจัดการ side effects ด้วย functional programming patterns เพื่อให้โค้ด test ได้ง่าย, maintain ได้ง่าย, และ predictable

## Scope

ใช้สำหรับปรับปรุง functions ที่มี side effects: database operations, API calls, file I/O, logging, external state mutations, time operations, และ randomness

## Execute

### 0. Analyze Project

วิเคราะห์โปรเจกต์อย่างลึกซึ้งก่อนเริ่มปรับปรุง side effects

1. ทำ `/use-scripts` ในการ `/deep-analyze` เพื่อวิเคราะห์โปรเจกต์อย่างลึกซึ้งครบทุกมิติ
2. รับผลลัพธ์จาก deep analysis เพื่อใช้ในการวางแผนการปรับปรุง side effects

### 1. Analyze Side Effects

วิเคราะห์ side effects ทั้งหมดใน codebase และจัดกลุ่มตามประเภท

1. ทำ `/use-ast-grep` หา patterns ตามหมวดหมู่: database, logging, time, randomness, external APIs, file I/O, browser storage, timers, environment
2. จัดกลุ่ม side effects ตามประเภท: database, I/O, external services, time, randomness, environment

### 2. Separate Pure And Impure

แยก pure functions จาก impure functions

1. ทำ `/follow-functional-programming` เพื่อเข้าใจ pure/impure separation
2. ทำ `/follow-functional-core-imperative-shell` เพื่อแยก core และ shell
3. แยก business logic ที่เป็น pure ออกจาก side effects
4. สร้าง pure functions สำหรับ calculations, validations, transformations
5. ย้าย side effects ไปที่ outer layer (imperative shell)
6. ใช้ dependency injection สำหรับ impure dependencies

### 3. Apply Functional Patterns

ใช้ functional programming patterns สำหรับ side effect management

1. แยก pure logic จาก side effects อย่างชัดเจน
2. แยก query functions จาก execution
3. แยก query building จาก query execution
4. สร้าง service abstractions สำหรับ impure operations

### 4. Remove Impurities

ลบหรือ wrap impurities

1. ลบ `console.log` ที่ไม่จำเป็น
2. ใช้ structured logging library แทน console.log
3. ใช้ dependency injection สำหรับ `Date` และ `Math.random`
4. สร้าง service abstractions: `Clock`, `Random`, `Env`, `Logger`

### 5. Verify Improvements

ตรวจสอบผลลัพธ์

1. ทำ `/run-typecheck` เพื่อตรวจสอบ types
2. ทำ `/run-lint` เพื่อตรวจสอบ code quality
3. ทำ `/run-test` เพื่อตรวจสอบความถูกต้อง

## Rules

### 1. Pure Functions First

เขียน pure functions ก่อนเสมอ

- Business logic ต้องเป็น pure functions
- Pure functions ต้องไม่มี side effects
- Pure functions ต้อง return ค่าเดิมเมื่อ input เดิม
- Test pure functions ด้วย input/output เท่านั้น

### 2. Separate Core And Shell

แยก functional core จาก imperative shell

- Core: pure business logic
- Shell: side effects และ I/O
- ใช้ dependency injection สำหรับ impure dependencies
- Shell เรียก core และจัดการ side effects
- ทำตาม `/follow-functional-core-imperative-shell`

### 3. Functional Patterns

ใช้ functional programming patterns อย่างถูกต้อง

- ใช้ dependency injection สำหรับ impure dependencies
- ใช้ Result/Either patterns สำหรับ error handling
- ใช้ retry logic สำหรับ transient failures
- ใช้ timeout handling สำหรับ external calls
- ใช้ typed errors แทน generic errors
- ใช้ resource management patterns สำหรับ cleanup
- ใช้ concurrency patterns สำหรับ parallel operations

### 4. Service Abstractions

สร้าง service abstractions สำหรับ impure operations

- สร้าง interfaces สำหรับ external dependencies
- ใช้ dependency injection สำหรับ services
- Services ต้องเป็น thin wrappers ของ external libs
- Pure logic อยู่ใน core layer
- Services อยู่ใน shell layer

### 5. Resource Management

จัดการ resources อย่างเหมาะสม

- ใช้ RAII pattern สำหรับ resource cleanup
- ปิด database connections อย่างชัดเจน
- ปิด file handles อย่างชัดเจน
- Cleanup timers และ intervals
- Cleanup event listeners

### 6. Caching Strategy

ใช้ caching อย่างเหมาะสม

- Cache operations ที่ read-heavy และ expensive
- ใช้ memoization สำหรับ pure functions
- ใช้ cache invalidation ที่เหมาะสม
- ใช้ TTL สำหรับ cache entries
- ใช้ cache keys ที่ deterministic

### 7. Testability

ทำให้โค้ด test ได้ง่าย

- Pure functions test ง่ายด้วย input/output
- Mock impure dependencies ด้วย dependency injection
- Test side effects แยกจาก pure logic

### 8. Immutability

รักษา immutability

- ไม่ mutate input parameters
- ใช้ `Readonly<>` type สำหรับ inputs
- ใช้ spread operator แทน mutation
- ใช้ array methods ที่ไม่ mutate

## Expected Outcome

- Pure functions สำหรับ business logic
- Side effects ถูกจัดการด้วย dependency injection
- Clear separation ระหว่าง core และ shell
- Service abstractions สำหรับ impure operations
- Resource management ที่เหมาะสม
- Caching strategy สำหรับ expensive operations
- Error handling ด้วย functional patterns
- Concurrency patterns สำหรับ parallel operations
- Code ที่ test ได้ง่าย
- Code ที่ maintain ได้ง่าย
- Predictable side effects
- No console.log ใน production code
- Time และ randomness ที่ controllable
- Environment variables ที่ injectable
- Logging ที่ structured และ controllable
