---
trigger: always_on
---

## Setup

### config

#### `package.json`

```json [package.json]
{
  "engines": {
    "bun": ""
  },
  "scripts": {
    "dev": "bun run src/index.ts",
    "build": "bun build src/index.ts --target=bun --outdir dist",
    "lint": "tsc --noEmit",
    "test": "bun test"
  }
}
```

### Libraries


## Project Structure

```plaintext
src/
├── app/              # composition root
├── services/         # side effects
├── utils/            # pure helpers
└── index.ts
dist/
package.json
tsconfig.json
```

## Core Principles

- ใช้ `bun` เป็น package manager/runtime เป็นค่าเริ่มต้น
- แยก logic ออกจาก side effects (service vs utils)
- type-safe และรัน `tsc --noEmit` ใน `lint`

## Folder Rules

### `src/utils/`

- Do
  - pure functions
- Don't
  - ทำ I/O

```ts
export const clamp = (value: number, min: number, max: number) => {
  return Math.min(max, Math.max(min, value))
}
```

### `src/services/`

- Do
  - รวม side effects

```ts
export const readEnv = (key: string) => {
  const value = process.env[key]
  if (!value) throw new Error(`Missing env: ${key}`)
  return value
}
```

## Import Rules

```plaintext
app      <-- services, utils
services <-- utils
utils    <-- (no internal dependencies)
```
