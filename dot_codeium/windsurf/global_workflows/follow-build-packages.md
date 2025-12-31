---
trigger: always_on
---

## Setup

### config

### Libraries

- /follow-turborepo
- /follow-tsdown
- /follow-vitest
- /follow-bun-functional-programming หรือ /follow-node-functional-programming

## Project Structure

```plaintext
packages/
  my-lib/
    src/
    test/
    examples/
    package.json
```

## Core Principles

- เริ่มจาก `/analyze-project` และ `/use-packages`
- เลือก runtime:
  - Node: `/follow-node-functional-programming`
  - Bun: `/follow-bun-functional-programming`
- build/test/lint ต้องรันผ่าน pipeline เดียวกันใน monorepo

## Folder Rules

### `packages/*/src/`

- Do
  - แยกไฟล์ตาม single responsibility

### `packages/*/test/`

- Do
  - ทุกไฟล์ใน `utils/` ต้องมี `file.test.ts` และ `file.usage.ts`

```ts
export const add = (a: number, b: number) => a + b
```

## Import Rules

```plaintext
packages/*/src <-- packages/*/src (ผ่าน public API)
tests/examples <-- src
```
