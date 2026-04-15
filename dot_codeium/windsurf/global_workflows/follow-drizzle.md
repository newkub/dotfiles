---
description: ตั้งค่าและใช้งาน Drizzle ORM สำหรับ TypeScript-first database operations ด้วย SQL-like syntax
auto_execution_mode: 3
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
| **Installation** | `bun add drizzle-orm` + driver ตาม runtime |
| **Dev Tools** | `bun add -D drizzle-kit` |
| **Config** | สร้าง `drizzle.config.ts` ด้วย `defineConfig` |
| **Schema** | กำหนด schema ในไฟล์แยก หรือใช้ glob patterns |
| **Migrations** | เลือก migration strategy ตาม use case |
| **Driver Selection** | ใช้ driver ที่เหมาะสมกับ runtime |

## Structure

### Directory Structure

```text
project/
├── drizzle.config.ts     # Drizzle config
├── src/
│   └── db/
│       ├── schema.ts     # Table definitions (หรือ schema/*.ts)
│       ├── migrations/   # Migration files
│       └── index.ts      # Database client
└── package.json
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | ติดตั้ง | Add packages ตาม runtime |
| Configure | กำหนดค่า | Config file ด้วย driver ที่ถูกต้อง |
| Schema | ออกแบบ | Define tables ด้วย column types ที่ถูกต้อง |
| Migrations | สร้าง | Generate & run ตาม strategy |
| Query | ใช้งาน | CRUD operations แบบ type-safe |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Bun ติดตั้งแล้ว
  - มี database server (PostgreSQL/MySQL/SQLite)
  - มี `package.json` อยู่แล้ว

### Phase 1: Setup

- 1.1 **ติดตั้ง Drizzle**
  - รัน `bun add drizzle-orm`
  - ติดตั้ง driver ตาม runtime และ database:
    - **Bun + SQLite**: `bun add` (ใช้ native `bun:sqlite`)
    - **Node.js + SQLite**: `bun add better-sqlite3`
    - **PostgreSQL**: `bun add postgres`
    - **MySQL**: `bun add mysql2`
    - **Turso/libsql**: `bun add @libsql/client`
  - รัน `bun add -D drizzle-kit`

### Phase 2: Configure

- 2.1 **สร้าง drizzle.config.ts**
  - สร้างไฟล์ `drizzle.config.ts`:

```ts [drizzle.config.ts]
import { defineConfig } from 'drizzle-kit'

export default defineConfig({
  schema: './src/db/schema.ts', // หรือใช้ glob: './src/db/**/*.ts'
  out: './src/db/migrations',
  dialect: 'postgresql', // หรือ 'mysql', 'sqlite'
  driver: 'postgres', // หรือ 'mysql2', 'better-sqlite', 'bun', 'turso'
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
})
```

- 2.2 **Driver Selection ตาม Runtime**

| Runtime | Database | Driver | Import Path |
|---------|----------|--------|-------------|
| Bun | SQLite | `bun` | `drizzle-orm/bun-sqlite` |
| Node.js | SQLite | `better-sqlite` | `drizzle-orm/better-sqlite3` |
| Any | PostgreSQL | `postgres` | `drizzle-orm/node-postgres` |
| Any | MySQL | `mysql2` | `drizzle-orm/mysql2` |
| Any | Turso | `turso` | `drizzle-orm/libsql` |

### Phase 3: Schema

- 3.1 **กำหนด Schema**
  - สร้าง `src/db/schema.ts` (หรือแยกเป็นหลายไฟล์ใน `schema/`):

```ts [src/db/schema.ts]
import { pgTable, serial, varchar, timestamp } from 'drizzle-orm/pg-core'
// สำหรับ SQLite: import { sqliteTable, text, integer } from 'drizzle-orm/sqlite-core'

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
  - สำหรับ Bun + SQLite:

```ts [src/db/index.ts]
import { drizzle } from 'drizzle-orm/bun-sqlite'
import Database from 'bun:sqlite'
import * as schema from './schema'

const sqlite = new Database('./data/app.db')
// Enable WAL mode สำหรับ performance
sqlite.exec('PRAGMA journal_mode = WAL')

export const db = drizzle(sqlite, { schema })
```

  - สำหรับ Node.js + SQLite:

```ts [src/db/index.ts]
import { drizzle } from 'drizzle-orm/better-sqlite3'
import Database from 'better-sqlite3'
import * as schema from './schema'

const sqlite = new Database('./data/app.db')
sqlite.pragma('journal_mode = WAL')

export const db = drizzle(sqlite, { schema })
```

  - สำหรับ PostgreSQL:

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

- 4.1 **เลือก Migration Strategy**

| Strategy | Command | Use Case |
|----------|---------|----------|
| **Push** | `drizzle-kit push` | Rapid prototyping, Development, Solo developers |
| **Generate + Migrate** | `drizzle-kit generate` + `drizzle-kit migrate` | Production, Teams, Code-first |
| **Pull** | `drizzle-kit pull` | Database-first, Existing database |

- 4.2 **Generate Migrations (Production)**
  - รัน `bunx drizzle-kit generate --name=migration_name`
  - ตรวจสอบไฟล์ migrations ใน `src/db/migrations/`
  - ไฟล์จะมี `migration.sql` และ `snapshot.json`

- 4.3 **Run Migrations (Production)**
  - รัน `bunx drizzle-kit migrate`
  - ตรวจสอบว่า migrations ถูกนำไปใช้แล้ว

- 4.4 **Push Schema (Development)**
  - รัน `bunx drizzle-kit push`
  - ใช้สำหรับ rapid prototyping และ development
  - Drizzle จะ sync schema โดยตรงไปยัง database

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

## Best Practices

### 1. **Driver Selection**
- ใช้ driver ที่เหมาะสมกับ runtime
- Bun runtime: ใช้ `bun:sqlite` (native support)
- Node.js: ใช้ `better-sqlite3` (synchronous, faster)

### 2. **Migration Strategy**
- **Development**: ใช้ `drizzle-kit push` สำหรับความเร็ว
- **Production**: ใช้ `drizzle-kit generate` + `drizzle-kit migrate` สำหรับความปลอดภัย
- **Teams**: ใช้ migration files เพื่อ version control

### 3. **Schema Organization**
- ใช้ single file สำหรับโปรเจกต์เล็ก
- ใช้ glob patterns สำหรับโปรเจกต์ใหญ่: `./src/db/**/*.ts`
- แยก schema ตาม feature หรือ domain

### 4. **Performance Optimization**
- ใช้ WAL mode สำหรับ SQLite: `PRAGMA journal_mode = WAL`
- สร้าง indexes สำหรับ columns ที่ query บ่อย
- ใช้ `inferSelect` และ `inferInsert` สำหรับ type safety

### 5. **Type Safety**
- ใช้ `$inferSelect` สำหรับ types ของ database records
- ใช้ `$inferInsert` สำหรับ types สำหรับ insert/update
- ใช้ Drizzle Query API แทน raw SQL เมื่อเป็นไปได้

## Outputs

| Output | Details |
|--------|-----------|
| drizzle.config.ts | ORM configuration ด้วย driver ที่ถูกต้อง |
| src/db/schema.ts | Table definitions หรือ schema/*.ts |
| src/db/index.ts | Database client ด้วย driver ที่เหมาะสม |
| migrations/ | Migration files (หรือ push สำหรับ dev) |

## Expected Outcome

- Drizzle ORM ติดตั้งและทำงานได้ด้วย driver ที่ถูกต้อง
- Schema กำหนดค่าถูกต้องตาม column types
- Migrations จัดการตาม strategy ที่เหมาะสม
- Type-safe queries ทำงานได้
- Performance ได้รับการ optimize ด้วย WAL mode และ indexes

## Reference

- [Drizzle ORM Documentation](https://orm.drizzle.team/)
- [SQLite Column Types](https://orm.drizzle.team/docs/column-types/sqlite)
- [Migration Fundamentals](https://orm.drizzle.team/docs/migrations)
- [Database Connection](https://orm.drizzle.team/docs/connect-overview)
- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/connect-workflows` - เชื่อมโยง workflows
