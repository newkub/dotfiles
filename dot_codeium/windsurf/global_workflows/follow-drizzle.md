---
description: Follow Drizzle ORM best practices
auto_execution_mode: 3
---



## package.json

ติดตั้ง bun i drizzle-orm, bun i drizzle-kit และกำหนด scripts เหมือนในด้านล่าง

```json
{
    "scripts": {
        "drizzle": "drizzle-kit",
        "drizzle:migrate": "drizzle-kit migrate",
        "drizzle:generate": "drizzle-kit generate",
        "drizzle:studio": "drizzle-kit studio"
    },
}

```

## drizzle.config.ts

กำหนดใน drizzle.config.ts ว่าอย่างนี้

```ts
import { defineConfig } from "drizzle-kit";
 
export default defineConfig({
  schema: "./server/db/schema*",
  out: "./drizzle",
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DB_URL,
  }
});
```