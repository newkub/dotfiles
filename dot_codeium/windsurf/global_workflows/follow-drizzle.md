---
trigger: always_on
---

# follow-drizzle

> อ่านและใช้งานที่นี่: `/compact-content`

## 1) เป้าหมาย

- **Single source of truth**: schema ใน `server/db/schema/*` เป็นแหล่งความจริงเดียว
- **Type-safe end-to-end**: query import schema จากจุดเดียว
- **Reproducible migrations**: generate/migrate ทำซ้ำได้ รัน CI ได้
- **Boundary ชัดเจน**: schema/query/transport แยกหน้าที่ ไม่ circular dependency

## 2) Dependencies & Scripts

### 2.1 Dependencies

- **Runtime**: `drizzle-orm`, `pg`
- **Dev**: `drizzle-kit`

### 2.2 Scripts

เพิ่มใน `package.json` (root/owner ของ db)

```json
{
  "scripts": {
    "db:generate": "drizzle-kit generate",
    "db:migrate": "drizzle-kit migrate",
    "db:pull": "drizzle-kit pull",
    "db:push": "drizzle-kit push",
    "db:studio": "drizzle-kit studio --host 0.0.0.0"
  }
}
```

> Monorepo: รันผ่าน turbo `--filter=<workspace>`

## 3) Config: `drizzle.config.ts`

- ห้าม hardcode credentials
- ใช้ `DB_URL` เป็น `postgres://...` หรือ `postgresql://...`

```ts
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./server/db/schema/*",
  out: "./drizzle",
  dialect: "postgresql",
  dbCredentials: { url: process.env.DB_URL },
});
```

## 4) โครงสร้างโฟลเดอร์

> ยึดตาม app เป็นหลัก เช่น `apps/website/server/db/*`

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
drizzle.config.ts
```

## 5) Rules: Schema Layer

- **Do**: แยก schema ตาม feature, export named, ตั้งชื่อ stable
- **Don't**: import ข้าม feature (circular), ใส่ query/business logic

### 5.1 ตัวอย่าง schema (Postgres)

```ts
import { pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: text("id").primaryKey(),
  email: text("email").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).notNull(),
});
```

## 6) Rules: Index/Exports

สร้าง `server/db/index.ts` เป็นจุดเดียวรวม export schema

```ts
export * from "./schema/user.schema";
export * from "./schema/booking.schema";
export * from "./schema/service.schema";
export * from "./schema/review.schema";
```

### 6.1 Import rules

- `server/db/schema/*` **ห้าม** import จาก `server/*`
- `server/*` **ต้อง** import จาก `server/db/index.ts` / `client.ts`
- `drizzle.config.ts` **ห้าม** import internal code

## 7) Client: DB connection & Drizzle client

- สร้าง `client.ts` รับผิดชอบการสร้าง client
- validate `DB_URL` ตั้งแต่เริ่ม (fail fast)
- ใช้ connection pool (`pg.Pool`)

```ts
// server/db/client.ts
// 1) read env (DB_URL)
// 2) create pg Pool
// 3) create drizzle client
// 4) export db
```

## 8) Migration workflow

- **Generate**: schema -> sql artifacts
- **Migrate**: apply migrations ไป database

```bash
bun run drizzle:generate
bun run drizzle:migrate
```

### 8.1 CI recommendation

- ใช้ DB ชั่วคราว (postgres service)
- รัน `drizzle:generate` ตรวจไม่มี diff ที่ไม่ commit
- รัน `drizzle:migrate` แล้วรันทดสอบ

## 9) Query layer best practices

- สร้างไฟล์ query ตาม feature เช่น `server/db/queries/user.queries.ts`
- รับพารามิเตอร์เป็น type-safe (เช่น `UserId`)
- หลีกเลี่ยง `any` / stringly-typed SQL

## 10) Checklist ก่อน merge

- schema แยกตาม feature ไม่มี circular
- import schema ผ่าน `server/db/index.ts`
- migrations generate + migrate ได้
- ไม่มี hardcode secrets (`DB_URL` จาก env)
- รัน lint/test ผ่าน
