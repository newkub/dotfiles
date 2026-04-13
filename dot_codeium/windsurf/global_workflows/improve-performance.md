---
title: Improve Performance
description: Optimize application performance with caching, lazy loading และ scalability patterns
auto_execution_mode: 3
---

ปรับปรุง performance และ scalability ของ application ให้รองรับ load สูงและตอบสนองเร็ว

## Goal

เพิ่ม performance ของ application ด้วย optimization techniques และรองรับการขยายตัวของระบบ

## Execute

### 1. Prepare

1. รัน `/follow-principles` เพื่อดู principles มาตรฐาน
2. ตั้งค่า performance monitoring tools - ใช้ `web-vitals` library หรือ `@nuxtjs/web-vitals`
3. สร้าง performance baselines ปัจจุบัน - ใช้ `lighthouse`, `PageSpeed Insights API`
4. ระบุ critical user journeys ที่ต้อง optimize - ใช้ `playwright` หรือ `cypress` record flows
5. กำหนด performance budgets (LCP, FID/INP, CLS) - ใช้ `lighthouse-ci`, `bundlewatch`

### 2. Frontend Optimization

1. Code splitting - ใช้ `Vite` dynamic imports `import()` หรือ `@loadable/component`
2. Lazy loading - ใช้ `vue-lazyload`, `react-lazyload` หรือ native `loading="lazy"`
3. Tree shaking - ใช้ `Vite`/`Rollup` built-in, `babel-plugin-lodash` สำหรับ libraries
4. Asset optimization - ใช้ `sharp`, `squoosh` สำหรับ images; `subset-font` สำหรับ fonts
5. Caching strategy - ใช้ `workbox` สำหรับ service workers; `stale-while-revalidate` pattern
6. Preloading - ใช้ `vite-plugin-preload` หรือ native `<link rel="preload">`
7. Virtualization - ใช้ `vue-virtual-scroller`, `react-window` หรือ `react-virtualized`
8. Debouncing/Throttling - ใช้ `lodash-es/debounce`, `use-debounce`, `vueuse/useThrottleFn`
9. Memoization - ใช้ native `useMemo`, `computed` หรือ `reselect` สำหรับ complex selectors
10. Third-party script management - ใช้ `partytown` สำหรับ offload scripts, `defer`/`async`

### 3. Backend Optimization

1. Database query optimization - ใช้ `drizzle-orm` กับ indexes; `dataloader` สำหรับ N+1 prevention
2. Caching layers - ใช้ `ioredis` สำหรับ Redis; `cloudflare` หรือ `aws-cloudfront` สำหรับ CDN
3. Connection pooling - ใช้ `pg-pool` สำหรับ PostgreSQL; `mysql2/promise` สำหรับ MySQL
4. Async processing - ใช้ `bullmq` หรือ `bull` สำหรับ job queues
5. Read replicas - ใช้ `prisma` read replicas หรือ `knex` replica configurations
6. API response optimization - ใช้ `cursor-pagination` หรือ `offset-pagination` libraries
7. Compression - ใช้ `compression` middleware หรือ `brotli` ใน nginx
8. Keep-alive connections - ใช้ `http-agent` หรือ `undici` pool settings

### 4. Scalability Implementation

1. Stateless services - ไม่เก็บ state บน server ใช้ `jwt` หรือ `redis` สำหรับ sessions
2. Horizontal scaling - ใช้ `docker swarm`, `kubernetes` หรือ `railway` auto-scaling
3. Load balancing - ใช้ `nginx`, `traefik` หรือ cloud load balancers (`aws-alb`, `cloudflare`)
4. Auto-scaling - ใช้ `kubernetes HPA`, `aws auto scaling groups`, `railway` native
5. Circuit breakers - ใช้ `opossum` หรือ `cockatiel` สำหรับ circuit breaker pattern
6. Bulkheads - ใช้ `worker threads` หรือ `piscina` สำหรับ isolate workloads
7. Graceful degradation - ใช้ `fallback` patterns กับ `zod` validate responses
8. Database partitioning - ใช้ `pg_partman` สำหรับ PostgreSQL หรือ `mysql partitions`
9. Throttling - ใช้ `express-rate-limit`, `fastify-rate-limit` หรือ `nestjs-throttler`
10. Regional deployment - ใช้ `fly.io`, `vercel edge`, `cloudflare workers` สำหรับ edge deployment

### 5. Monitoring & Validation

1. ติดตาม Core Web Vitals (LCP, INP, CLS) - ใช้ `web-vitals` library ส่งไป `Sentry` หรือ `Datadog`
2. ตั้งค่า performance alerts - ใช้ `lighthouse-ci` กับ GitHub Actions หรือ `sentry performance`
3. Load testing สำหรับ validate scalability - ใช้ `k6`, `artillery` หรือ `autocannon`
4. Bundle analysis ตรวจสอบขนาด - ใช้ `vite-plugin-inspect`, `sonda`, `webpack-bundle-analyzer`
5. ทดสอบบน slow networks (3G) - ใช้ `playwright` network throttling หรือ Chrome DevTools
6. สร้าง performance dashboards - ใช้ `grafana`, `datadog`, `newrelic` หรือ `plausible`

## Rules

1. Performance Budgets

- LCP (Largest Contentful Paint) < 2.5s
- INP (Interaction to Next Paint) < 200ms
- CLS (Cumulative Layout Shift) < 0.1
- Time to First Byte (TTFB) < 600ms
- First Contentful Paint (FCP) < 1.8s
- Total Blocking Time (TBT) < 200ms

2. Optimization Priority

- Optimize สำหรับ user experience ไม่ใช่ metrics อย่างเดียว
- Progressive enhancement - ทำงานได้พื้นฐานโดยไม่มี JS
- Mobile-first optimization
- Connection adaptive - ปรับตาม network speed

3. Caching Strategy

- Cache static assets นาน (1 year)
- API responses cache ตาม freshness requirements
- Stale-while-revalidate สำหรับ semi-static content
- ETag และ Last-Modified สำหรับ conditional requests
- Cache busting ด้วย content hashing

4. Database Optimization

- Indexes บน frequently queried columns
- Covering indexes สำหรับ common queries
- Query batching ลด round trips
- Connection pooling จำกัด connections
- N+1 query prevention ด้วย eager loading

5. Scalability Patterns

- Stateless services เท่านั้น
- Shared nothing architecture
- Queue-based load leveling
- Event-driven architecture สำหรับ decoupling
- CQRS ถ้า read/write patterns ต่างกันมาก

6. Bundle Optimization

- Code splitting ตาม routes
- Dynamic imports สำหรับ heavy components
- Tree shaking ลบ unused code
- Analyze bundle ด้วย `vite-plugin-inspect` หรือ `Sonda`
- Duplicate dependency detection

## Expected Outcome

1. Core Web Vitals ที่ผ่านเกณฑ์ทุกตัว
2. Load time ที่ลดลงอย่างน้อย 30%
3. Bundle size ที่ optimized
4. API response time ที่ลดลง
5. System ที่รองรับ traffic spikes
6. Auto-scaling ที่ทำงานได้ดี
7. Graceful degradation ที่ผู้ใช้ไม่รู้สึก
8. Performance monitoring ที่ครบถ้วน
