---
trigger: always_on
---

## Setup

### config

#### `package.json`

```json [package.json]
{
  "scripts": {
    "drizzle": "drizzle-kit",
    "drizzle:migrate": "drizzle-kit migrate",
    "drizzle:generate": "drizzle-kit generate",
    "drizzle:studio": "drizzle-kit studio"
  }
}
```

#### `drizzle.config.ts`

```ts [drizzle.config.ts]
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./server/db/schema*",
  out: "./drizzle",
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DB_URL
  }
});
```

### Libraries

- `drizzle-orm`
- `drizzle-kit`

## Project Structure

```plaintext
server/
└── db/
    ├── schema/                # schema split by feature
    │   ├── auth.schema.ts
    │   └── billing.schema.ts
    ├── index.ts               # exports db client + schema
    └── migrations/            # optional (ถ้าแยกเอง)
drizzle/                       # generated artifacts (out)
drizzle.config.ts
```

## Core Principles

- schema เป็น single source of truth
- แยก schema ตาม feature/boundary ไม่ยัดไฟล์เดียว
- query layer ต้อง type-safe (import schema จากจุดเดียว)
- migration ต้อง reproducible (รันใน CI ได้)

## Folder Rules

### `server/db/schema/`

- Do
  - แยกไฟล์ตาม feature
  - export table/schema แบบชัดเจน
- Don't
  - สร้าง circular dependency ใน schema

```ts
import { pgTable, text } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: text('id').primaryKey(),
  email: text('email').notNull(),
})
```

### `server/db/index.ts`

- Do
  - เป็นจุดรวม export client + schema

```ts
export * from './schema/auth.schema'
export * from './schema/billing.schema'
```

## Import Rules

```plaintext
server/db/index.ts   <-- server/db/schema/*
server/*             <-- server/db/index.ts
drizzle.config.ts    <-- (no internal deps)
```
