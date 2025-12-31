---
description: แนวทางการพัฒนาโปรเจกต์ด้วย Next.js 15 (App Router)
---

## Setup

### config

#### `package.json`

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "biome check --write .",
    "postinstall": "bunx taze -r -w -i"
  }
}
```

#### `next.config.mjs`

```javascript
/ @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: {
    serverActions: true,
  },
};

export default nextConfig;
```

### Libraries

- Next.js 15 (App Router)
- Zod (schema) / types แยกเป็น single source of truth
- /follow-unocss (ถ้าใช้ UnoCSS)
- /follow-biome

## Project Structure

```plaintext
my-next-app/
├── app/                # Core of the application (App Router)
│   ├── (features)/     # Route Groups for organization
│   ├── api/            # API Route Handlers
│   ├── layout.tsx      # Root Layout (Server Component)
│   └── page.tsx        # Home Page (Server Component)
├── components/         # Reusable React components
│   ├── ui/             # Dumb UI Components (e.g., Button, Input)
│   └── features/       # Feature-specific components
├── lib/                # Utility functions, DB connection, etc.
├── types/              # TypeScript types & Zod schemas
├── actions/            # Server Actions for data mutations
├── middleware.ts       # Request Middleware
├── public/             # Static assets
├── .env.local          # Environment variables
├── next.config.mjs     # Next.js configuration
├── package.json        # Project dependencies and scripts
└── tsconfig.json       # TypeScript configuration
```

## Core Principles

- Server Components by Default: คอมโพเนนต์ทั้งหมดใน `app/` เป็น Server Components ซึ่งทำงานบนเซิร์ฟเวอร์เท่านั้น ทำให้สามารถดึงข้อมูลได้โดยตรงและปลอดภัย ลดขนาด JavaScript ที่ส่งให้ client
- Client Components Opt-in: สำหรับคอมโพเนนต์ที่ต้องการมีปฏิสัมพันธ์กับผู้ใช้ (state, events) ต้องประกาศ `'use client'` ที่บรรทัดบนสุดของไฟล์
- Server Actions: ฟังก์ชัน `'use server'` ที่ทำงานบนเซิร์ฟเวอร์อย่างปลอดภัย ใช้สำหรับการเปลี่ยนแปลงข้อมูล (data mutations) โดยไม่ต้องสร้าง API endpoints เพิ่มเติม
- Streaming with Suspense: ใช้ `loading.tsx` และ React Suspense เพื่อสร้าง UI ที่ตอบสนองได้ดีขึ้น โดยการแสดงผล UI ทันทีในส่วนที่พร้อม และแสดง loading state ในส่วนที่กำลังดึงข้อมูล
- Push Client Components to the Leaves: พยายามให้ Client Components มีขนาดเล็กและอยู่ที่ปลายสุดของ Component Tree เพื่อให้ส่วนใหญ่ของแอปยังคงเป็น Server Components
- Validate on the Server: ตรวจสอบข้อมูลนำเข้าทั้งหมดบนเซิร์ฟเวอร์เสมอ (ใน Server Actions หรือ API Routes) อย่าเชื่อถือข้อมูลที่มาจาก Client

## Folder Rules

### `app/`

เป็นศูนย์กลางของแอปพลิเคชัน จัดการ routing, layouts, และการดึงข้อมูลหลัก

- ควรทำ
    - ใช้ `async/await` ใน Server Components (`page.tsx`, `layout.tsx`) เพื่อดึงข้อมูลโดยตรง
    - ใช้ Route Groups `(folder)` เพื่อจัดระเบียบโค้ดโดยไม่กระทบ URL
    - กำหนด Metadata สำหรับ SEO ใน `layout.tsx` หรือ `page.tsx`
- ไม่ควรทำ
    - ใช้ Hooks (`useState`, `useEffect`) หรือ Browser APIs (`window`) ใน Server Components
    - ดึงข้อมูลใน Client Component โดยตรง (ควรทำใน Server Component แล้วส่งเป็น props)

### `components/`

เก็บ React components ที่ใช้ซ้ำได้ โดยแยกตามความรับผิดชอบ

- ควรทำ
    - วาง Dumb UI components ที่ไม่มี logic ใน `components/ui` และประกาศ `'use client'` หากจำเป็น
    - วาง Feature-specific components ใน `components/features`
    - ออกแบบให้รับ Props และส่ง Events (Props in, Events out)
- ไม่ควรทำ
    - ใส่ Business Logic ที่ซับซ้อน (ควรอยู่ใน `actions/` หรือ `lib/`)

### `lib/`

เก็บฟังก์ชัน Utility, การตั้งค่า, หรือโค้ดที่ใช้ร่วมกันและไม่เกี่ยวกับ React UI

- ควรทำ
    - สร้างฟังก์ชันให้เป็น Pure Functions ให้มากที่สุด
    - แยกไฟล์ตามหน้าที่ เช่น `lib/db.ts`, `lib/utils.ts`
- ไม่ควรทำ
    - Import React components หรือ Hooks เข้ามาในโฟลเดอร์นี้

### `types/`

เป็นศูนย์รวมของ TypeScript types และ Zod schemas

- ควรทำ
    - ใช้ `z.infer<>` จาก Zod schema เป็น Single Source of Truth สำหรับ Type
    - แยกประเภทของ Type เช่น `types/api.ts`, `types/db.ts`
- ไม่ควรทำ
    - Import DB-specific types เข้าไปใน Client Components โดยตรง

### `actions/`

จัดการ Data Mutations ผ่าน Server Actions

- ควรทำ
    - ขึ้นต้นไฟล์ด้วย `'use server'`
    - ตรวจสอบ Input ด้วย Zod schema เป็นอันดับแรก
    - จัดการข้อผิดพลาดด้วย `try-catch` และคืนค่าผลลัพธ์ที่ชัดเจน
    - เรียก `revalidatePath` หรือ `revalidateTag` หลังจากการทำงานสำเร็จ
- ไม่ควรทำ
    - เปิดเผยข้อมูลที่ละเอียดอ่อนใน error message

## Import Rules

```plaintext
app/ (route)    <-- components, actions, lib, types
components      <-- lib, types
actions         <-- lib, types
lib             <-- types
types           <-- (no internal dependencies)
```
