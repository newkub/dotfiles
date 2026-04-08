---
title: Follow Drizzle
description: ตั้งค่าและใช้งาน Drizzle ORM สำหรับ TypeScript-first database operations ด้วย SQL-like syntax
auto_execution_mode: 3
file-patterns:
  - "drizzle.config.ts"
  - "src/db/**/*.ts"
  - "package.json"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า Drizzle ORM สำหรับ type-safe database operations ด้วย SQL-like syntax, zero dependencies และ excellent TypeScript support

## Scope

- ติดตั้ง Drizzle ORM และ Kit
- กำหนดค่า `drizzle.config.ts`
- สร้าง database schema และ migrations
- ใช้งาน query builder แบบ type-safe

## Inputs

| Input | Details |
|-------|-----------|
| Package Manager | Bun |
| Database | PostgreSQL, MySQL, SQLite |
| Runtime | Node.js, Bun, Edge |

## Rules

| Category | Requirements |
|------|---------|
| **Installation** | `bun add drizzle-orm` + driver |
| **Dev Tools** | `bun add -D drizzle-kit` |
| **Config** | สร้าง `drizzle.config.ts` |
| **Schema** | กำหนด schema ในไฟล์แยก |
| **Migrations** | ใช้ drizzle-kit สำหรับ migrations |

## Structure

### Directory Structure

```text
project/
├── drizzle.config.ts     # Drizzle config
├── src/
│   └── db/
│       ├── schema.ts     # Table definitions
│       ├── migrations/   # Migration files
│       └── index.ts      # Database client
└── package.json
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add packages |
| Configure | กำหนดค่า | Config file |
| Schema | ออกแบบ | Define tables |
| Migrations | สร้าง | Generate & run |
| Query | ใช้งาน | CRUD operations |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี database server (PostgreSQL/MySQL/SQLite)
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Drizzle**
  - รัน `bun add drizzle-orm`
  - ติดตั้ง driver ตาม database:
    - PostgreSQL: `bun add postgres`
    - MySQL: `bun add mysql2`
    - SQLite: `bun add better-sqlite3`
  - รัน `bun add -D drizzle-kit`

### Phase 2: Configure

- 2.1 **สร้าง drizzle.config.ts**
  - สร้างไฟล์ `drizzle.config.ts`:

```ts [drizzle.config.ts]
import { defineConfig } from 'drizzle-kit'

export default defineConfig({
  schema: './src/db/schema.ts',
  out: './src/db/migrations',
  dialect: 'postgresql', // หรือ 'mysql', 'sqlite'
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
})
```

### Phase 3: Schema

- 3.1 **กำหนด Schema**
  - สร้าง `src/db/schema.ts`:

```ts [src/db/schema.ts]
import { pgTable, serial, varchar, timestamp } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull().unique(),
  name: varchar('name', { length: 255 }),
  createdAt: timestamp('created_at').defaultNow(),
})

export type User = typeof users.$inferSelect
export type NewUser = typeof users.$inferInsert
```

- 3.2 **สร้าง Database Client**
  - สร้าง `src/db/index.ts`:

```ts [src/db/index.ts]
import { drizzle } from 'drizzle-orm/node-postgres'
import { Client } from 'pg'
import * as schema from './schema'

const client = new Client({
  connectionString: process.env.DATABASE_URL,
})

await client.connect()
export const db = drizzle(client, { schema })
```

### Phase 4: Migrations

- 4.1 **Generate Migrations**
  - รัน `bunx drizzle-kit generate`
  - ตรวจสอบไฟล์ migrations ใน `src/db/migrations/`

- 4.2 **Run Migrations**
  - รัน `bunx drizzle-kit migrate`
  - หรือใช้ `bunx drizzle-kit push` สำหรับ development

### Phase 5: Query

- 5.1 **ใช้งาน Database**
  - Example CRUD operations:

```ts
import { db } from './db'
import { users } from './db/schema'
import { eq } from 'drizzle-orm'

// Create
const newUser = await db.insert(users).values({
  email: 'user@example.com',
  name: 'John Doe',
}).returning()

// Read
const allUsers = await db.select().from(users)
const user = await db.select().from(users).where(eq(users.id, 1))

// Update
await db.update(users)
  .set({ name: 'Jane Doe' })
  .where(eq(users.id, 1))

// Delete
await db.delete(users).where(eq(users.id, 1))
```

## Outputs

| Output | Details |
|--------|-----------|
| drizzle.config.ts | ORM configuration |
| src/db/schema.ts | Table definitions |
| src/db/index.ts | Database client |
| migrations/ | Migration files |

## Expected Outcome

- Drizzle ORM ติดตั้งและทำงานได้
- Schema กำหนดค่าถูกต้อง
- Migrations สร้างและรันได้
- Type-safe queries ทำงานได้

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows
