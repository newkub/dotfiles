---
trigger: always_on
description: Follow Drizzle ORM (Postgres) best practices for this repo
---

# follow-drizzle

## 1) เป้าหมาย (10/10)

- **Single source of truth**: schema ใน `server/db/schema/*` เป็นแหล่งความจริงเดียว
- **Type-safe end-to-end**: query ต้อง import schema จากจุดเดียว
- **Reproducible migrations**: generate/migrate ทำซ้ำได้ รันใน CI ได้
- **Boundary ชัดเจน**: schema/query/transport แยกหน้าที่ ไม่ทำให้เกิด circular dependency

## 2) Dependencies & Scripts

### 2.1 Dependencies (ต้องมี)

- **Runtime**: `drizzle-orm`, `pg`
- **Dev**: `drizzle-kit`

### 2.2 Scripts (ตัวอย่างมาตรฐาน)

เพิ่ม scripts ใน `package.json` (root หรือ package ที่เป็น owner ของ db)

```json
{
  "scripts": {
    "drizzle": "drizzle-kit",
    "drizzle:generate": "drizzle-kit generate",
    "drizzle:migrate": "drizzle-kit migrate",
    "drizzle:studio": "drizzle-kit studio --host 0.0.0.0"
  }
}
```

- **หมายเหตุ**: หากเป็น monorepo ให้รันผ่าน turbo ด้วย `--filter=<workspace>`

## 3) Config: `drizzle.config.ts`

- **ห้าม hardcode credentials**
- ใช้ `DB_URL` เป็น `postgres://...` หรือ `postgresql://...`

```ts
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./server/db/schema/*",
  out: "./drizzle",
  dialect: "postgresql",
  dbCredentials: {
    url: process.env.DB_URL,
  },
});
```

## 4) โครงสร้างโฟลเดอร์ที่แนะนำ (Fit กับ repo)

> ให้ยึดตามแต่ละ app เป็นหลัก เช่น `apps/website/server/db/*`

```txt
apps/website/
  server/
    db/
      schema/
        user.schema.ts
        booking.schema.ts
        service.schema.ts
        review.schema.ts
      client.ts
      index.ts
drizzle/
  ...generated...
drizzle.config.ts
```

## 5) Rules: Schema Layer (สำคัญมาก)

- **Do**
  - แยก schema ตาม feature/boundary (เช่น `user`, `booking`, `service`, `review`)
  - export table/relations เป็น named export
  - ตั้งชื่อ table/column ให้ stable (เปลี่ยนชื่อ = migration)
- **Don’t**
  - import schema ข้าม feature แบบสุ่มจนเกิดวงจร (circular dependency)
  - ใส่ query หรือ business logic ในไฟล์ schema

### 5.1 ตัวอย่าง schema (Postgres)

```ts
import { pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: text("id").primaryKey(),
  email: text("email").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull(),
});
```

## 6) Rules: Index/Exports (ลดความปวดหัว import)

สร้าง `server/db/index.ts` เป็นจุดเดียวที่รวม export schema ทั้งหมด

```ts
export * from "./schema/user.schema";
export * from "./schema/booking.schema";
export * from "./schema/service.schema";
export * from "./schema/review.schema";
```

### 6.1 Import rules (บังคับ)

- `server/db/schema/*` **ห้าม** import จาก `server/*` อื่นๆ
- `server/*` **ต้อง** import schema/db จาก `server/db/index.ts` หรือ `server/db/client.ts` เท่านั้น
- `drizzle.config.ts` **ห้าม** import internal code

## 7) Client: DB connection & Drizzle client

แนวทางที่ดี:

- สร้าง `client.ts` ให้รับผิดชอบแค่การสร้าง client
- validate env `DB_URL` ตั้งแต่เริ่ม (fail fast)
- ใช้ connection pool (`pg.Pool`)

Pseudo-structure:

```ts
// server/db/client.ts
// 1) read env (DB_URL)
// 2) create pg Pool
// 3) create drizzle client
// 4) export db
```

## 8) Migration workflow (Reproducible)

- **Generate**: จาก schema -> sql artifacts
- **Migrate**: apply migrations ไปที่ database

คำสั่ง:

```bash
bun run drizzle:generate
bun run drizzle:migrate
```

### 8.1 CI recommendation

- ใช้ DB ชั่วคราว (เช่น postgres service)
- รัน `drizzle:generate` แล้วตรวจว่าไม่มี diff ที่ไม่ commit
- รัน `drizzle:migrate` แล้วรันทดสอบ

## 9) Query layer best practices

- สร้างไฟล์ query ตาม feature เช่น `server/db/queries/user.queries.ts`
- รับพารามิเตอร์เป็น type-safe (เช่น `UserId`)
- หลีกเลี่ยง `any` / stringly-typed SQL

## 10) Checklist ก่อน merge

- schema แยกตาม feature ไม่มี circular
- import schema ผ่าน `server/db/index.ts`
- migrations generate ได้ + migrate ได้
- ไม่มี hardcode secrets (`DB_URL` จาก env)
- รัน lint/test ผ่าน
