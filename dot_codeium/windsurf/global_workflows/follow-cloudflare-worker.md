---
title: Follow Cloudflare Worker
description: Deploy applications บน Cloudflare Workers พร้อม Wrangler
auto_execution_mode: 3
---

Deploy applications บน Cloudflare Workers platform พร้อม auto-configuration และ bindings

## Execute

### 1. Install Wrangler

1. รัน `bun add -D wrangler`
2. หรือใช้ `bunx wrangler` โดยไม่ต้องติดตั้ง

### 2. Configure Wrangler

`wrangler.jsonc`
```json
{
  "name": "my-worker",
  "main": "src/index.ts",
  "compatibility_date": "2024-09-19",
  "compatibility_flags": ["nodejs_compat"]
}
```

### 3. Auto Deploy

1. รัน `bunx wrangler deploy`
2. Wrangler จะ auto-detect framework จาก `package.json`
3. ยืนยัน settings ที่ detect ได้
4. Wrangler จะสร้าง `wrangler.jsonc` และ deploy ให้

### 4. Manual Configuration

`wrangler.jsonc` สำหรับ manual setup
```json
{
  "name": "my-worker",
  "main": "src/index.ts",
  "compatibility_date": "2024-09-19",
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

### 5. Development

1. รัน `bunx wrangler dev` เพื่อ start local dev server
2. ใช้ `--port 8787` สำหรับกำหนด port
3. ใช้ `--local` สำหรับ local-only mode
4. ใช้ `--remote` สำหรับ access remote resources

### 6. Environment Variables

1. ใช้ `wrangler secret put KEY_NAME` เพื่อ set secrets
2. ใช้ `wrangler vars put KEY_NAME` เพื่อ set variables
3. กำหนดใน `wrangler.jsonc` สำหรับ non-secret variables

### 7. CI/CD Deployment

`.github/workflows/deploy.yml`
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

### 8. Bindings Setup

1. **KV**: สร้าง namespace ใน dashboard แล้วกำหนด binding
2. **D1**: สร้าง database แล้วกำหนด `d1_databases`
3. **R2**: สร้าง bucket แล้วกำหนด `r2_buckets`
4. **Durable Objects**: กำหนด `durable_objects` ใน config

### 9. Preview Deployments

1. ใช้ `wrangler deploy --env staging` สำหรับ staging
2. สร้าง multiple environments ใน `wrangler.jsonc`
3. ใช้ Git integration สำหรับ preview deployments

## Rules

- **Compatibility Date**: กำหนด `compatibility_date` เสมอ
- **Node Compat**: ใช้ `nodejs_compat` flag ถ้าต้องการ Node.js APIs
- **Auto Config**: Wrangler 4.68.0+ รองรับ auto-configuration
- **Secrets**: ใช้ `wrangler secret` สำหรับ sensitive data ไม่ใช่ vars
- **Main Entry**: กำหนด `main` ใน config ชี้ไปยัง entry file
- **Routes**: กำหนด routes ถ้าต้องการ custom domain
- **Environment**: ใช้ environments สำหรับ dev/staging/prod
- **CI/CD**: ใช้ `CLOUDFLARE_API_TOKEN` สำหรับ automated deploy
- **Preview**: เปิดใช้งาน preview deployments สำหรับ testing
- **Bindings**: สร้าง resources ใน dashboard ก่อนกำหนด bindings

## Expected Outcome

1. Application ที่ deploy บน Cloudflare Workers ได้สำเร็จ
2. Configuration ที่รองรับ auto-detection และ manual setup
3. Bindings ที่เชื่อมต่อกับ KV, D1, R2, Durable Objects
4. CI/CD pipeline ที่ deploy อัตโนมัติ
5. Multiple environments สำหรับ dev/staging/prod
