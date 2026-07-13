---
title: Follow Cloudflare Worker
description: Setup build และ deploy applications บน Cloudflare Workers พร้อม Wrangler
auto_execution_mode: 3
related:
  - /follow-wrangler-cli
  - /run-build
---

## Goal

Setup build แบบ auto และ deploy applications บน Cloudflare Workers platform พร้อม auto-configuration และ bindings

## Scope

ครอบคลุมการตั้งค่า Wrangler, build, typecheck, staging/production deploy, bindings, environment variables และ CI/CD

## Execute

### 1. Install And Configure Wrangler

ตั้งค่า Wrangler และ dependencies

1. รัน `bunx wrangler deploy` โดยไม่ต้องมี config file (Wrangler 4.55+ auto-detect)
2. Wrangler auto-detect framework จาก `package.json` และสร้าง `wrangler.jsonc`
3. ยืนยัน auto-detected settings หรือใช้ `bunx wrangler setup` สำหรับ configure โดยไม่ deploy
4. รัน `bun install` และติดตั้ง `wrangler`, `@cloudflare/workers-types`, `@cloudflare/vitest-pool-workers`
5. เพิ่ม scripts ลง `package.json`: `build`, `build:local`, `typecheck`, `types`, `dev`, `test`
6. รัน `bun run types` เพื่อ generate `worker-configuration.d.ts`

### 2. Configure Wrangler

กำหนด configuration สำหรับ manual setup ถ้าต้องการ

`wrangler.jsonc`:
```json
{
  "name": "my-worker",
  "main": "src/index.ts",
  "compatibility_date": "2024-09-19",
  "compatibility_flags": ["nodejs_compat"],
  "routes": [
    { "pattern": "example.com/*", "zone_name": "example.com" }
  ],
  "kv_namespaces": [
    { "binding": "CACHE", "id": "xxx" }
  ],
  "d1_databases": [
    { "binding": "DB", "database_name": "my-db" }
  ],
  "r2_buckets": [
    { "binding": "STORAGE", "bucket_name": "my-bucket" }
  ]
}
```

### 3. Typecheck And Build

ตรวจสอบ types และ build

1. รัน `bun run typecheck` และแก้ไข errors จนผ่าน
2. รัน `bun run build` หรือ `bun run build:local`
3. ตรวจสอบ build artifacts และ bundle size (limit 1 MB)
4. แก้ไข build errors จนผ่าน โดยวิเคราะห์และรัน build ซ้ำ

### 4. Setup Staging Environment

ตั้งค่า staging environment และ D1 databases

1. เพิ่ม staging environment ใน `wrangler.jsonc` หรือ `wrangler.toml`
2. สร้าง D1 databases: `wrangler d1 create project-name` และ `wrangler d1 create project-name-staging`
3. อัปเดท `database_id` ใน config ด้วย IDs ที่ได้
4. รัน migrations บนทั้งสอง databases

### 5. Development

รัน local dev server

1. รัน `bunx wrangler dev` เพื่อ start local dev server
2. ใช้ `--port 8787` สำหรับกำหนด port
3. ใช้ `--local` สำหรับ local-only mode
4. ใช้ `--remote` สำหรับ access remote resources

### 6. Deploy Staging First

Deploy ไป staging เพื่อทดสอบก่อน

1. รัน `wrangler deploy --env staging --dry-run`
2. ตรวจสอบ staging configuration
3. Deploy staging: `wrangler deploy --env staging`
4. Test staging environment ด้วย curl หรือ browser
5. แก้ไข issues ถ้ามี

### 7. Deploy Production

Deploy ไป production เมื่อ staging ผ่าน

1. รัน `wrangler deploy --dry-run`
2. ตรวจสอบ production configuration
3. Deploy production: `wrangler deploy`
4. Test production environment
5. Verify staging และ production ทำงานแยกกัน

### 8. Environment Variables And Bindings

ตั้งค่า secrets, variables และ bindings

1. ใช้ `wrangler secret put KEY_NAME` เพื่อ set secrets
2. ใช้ `wrangler vars put KEY_NAME` เพื่อ set non-secret variables
3. **KV**: สร้าง namespace ใน dashboard แล้วกำหนด binding
4. **D1**: สร้าง database แล้วกำหนด `d1_databases`
5. **R2**: สร้าง bucket แล้วกำหนด `r2_buckets`
6. **Durable Objects**: กำหนด `durable_objects` ใน config

### 9. CI/CD Deployment

ตั้งค่า automated deployment

`.github/workflows/deploy.yml`:
```yaml
name: Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: oven-sh/setup-bun@v1
      - run: bun install
      - run: bunx wrangler deploy
        env:
          CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
```

## Rules

### 1. Configuration

- กำหนด `compatibility_date` เป็นวันปัจจุบันเสมอ
- เปิดใช้งาน `nodejs_compat` flag สำหรับ Node.js modules
- ใช้ `wrangler types` generate `Env` interface ไม่ hand-write
- Re-run `wrangler types` เมื่อ add หรือ rename bindings
- กำหนด `main` ใน config ชี้ไปยัง entry file

### 2. Secrets And Observability

- ใช้ `wrangler secret put` สำหรับ secrets ไม่ hardcode
- ใช้ `vars` สำหรับ non-secret variables
- เปิดใช้งาน `observability.enabled` ใน config
- ตั้งค่า `head_sampling_rate` สำหรับ logs และ traces
- ใช้ structured JSON logging

### 3. Build Process

- Typecheck ล้มเหลว: แก้ไขก่อน build
- Build ล้มเหลว: วิเคราะห์และแก้ไข
- ทำซ้ำจนกว่าจะผ่าน
- Optimize bundle ถ้าเกิน 1 MB limit

### 4. Deployment

- Deploy staging ก่อน production เสมอ
- ใช้ `--dry-run` เพื่อตรวจสอบก่อน deploy จริง
- ใช้ environments สำหรับ dev/staging/prod
- ใช้ `CLOUDFLARE_API_TOKEN` สำหรับ automated deploy
- เปิดใช้งาน preview deployments สำหรับ testing

## Expected Outcome

- Wrangler config ตั้งค่าแบบ auto สำเร็จ
- Build script พร้อมใช้งาน
- Binding types generate อัตโนมัติ
- Typecheck และ build ผ่านไม่มี errors
- Bundle size อยู่ใน limit
- Staging และ production deploy สำเร็จ
- CI/CD pipeline ที่ deploy อัตโนมัติ
- Observability เปิดใช้งาน
