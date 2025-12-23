---
auto_execution_mode: 3
---


# แนวทางการพัฒนาโปรเจกต์ด้วย Next.js 15 (App Router)

เอกสารนี้เป็นแนวทางสำหรับการพัฒนาโปรเจกต์ด้วย Next.js โดยเน้นที่ App Router เพื่อสร้างแอปพลิเคชันที่มีประสิทธิภาพ, บำรุงรักษาง่าย, และทันสมัย

## 1. แนวคิดหลัก (Core Concepts)

- **Server Components by Default:** คอมโพเนนต์ทั้งหมดใน `app/` เป็น Server Components ซึ่งทำงานบนเซิร์ฟเวอร์เท่านั้น ทำให้สามารถดึงข้อมูลได้โดยตรงและปลอดภัย ลดขนาด JavaScript ที่ส่งให้ client
- **Client Components Opt-in:** สำหรับคอมโพเนントที่ต้องการ tương tác กับผู้ใช้ (เช่น state, event listeners) ต้องประกาศ `'use client'` ที่บรรทัดบนสุดของไฟล์อย่างชัดเจน
- **Server Actions:** ฟังก์ชันที่ทำงานบนเซิร์ฟเวอร์อย่างปลอดภัย ใช้สำหรับการเปลี่ยนแปลงข้อมูล (data mutations) โดยไม่ต้องสร้าง API endpoints เพิ่มเติม และต้องประกาศ `'use server'`
- **File-based Routing:** ระบบ Routing ถูกสร้างขึ้นอัตโนมัติตามโครงสร้างโฟลเดอร์ภายใน `app/` โดยใช้ชื่อไฟล์พิเศษเช่น `page.tsx`, `layout.tsx`
- **Composition:** สร้าง UI ที่ซับซ้อนโดยการประกอบ Server และ Client Components เข้าด้วยกัน โดย Server Components สามารถ import Client Components ได้

## 2. โครงสร้างโปรเจกต์ (Project Structure)

โครงสร้างที่แนะนำถูกออกแบบมาเพื่อแยกส่วนของโค้ดตามหน้าที่อย่างชัดเจน:

```plaintext
my-next-app/
├── app/             # App Router: Routing, Layouts, Pages
│   ├── (features)/  # Route Groups สำหรับจัดระเบียบ
│   ├── api/         # API Route Handlers
│   ├── layout.tsx   # Root Layout (Server Component)
│   └── page.tsx     # Home Page (Server Component)
├── components/      # Shared React Components
│   ├── ui/          # Dumb UI Components (e.g., Button, Input)
│   └── features/    # Feature-specific components
├── lib/             # Utility functions, DB connection, etc.
├── types/           # TypeScript types & Zod schemas
├── actions/         # Server Actions
├── middleware.ts    # Request Middleware
├── public/          # Static assets
├── next.config.mjs  # Next.js configuration
└── package.json     # Project dependencies and scripts
```

## 3. กฎและตัวอย่าง (Folder Rules & Examples)

### `app/`
- **หน้าที่:** เป็นศูนย์กลางของแอปพลิเคชัน จัดการ routing, layouts, และการดึงข้อมูลหลัก
- **Do:**
    - ใช้ `async/await` ใน Server Components (`page.tsx`, `layout.tsx`) เพื่อดึงข้อมูลโดยตรง
    - ใช้ Route Groups `(folder)` เพื่อจัดระเบียบโค้ดโดยไม่กระทบ URL
    - กำหนด Metadata สำหรับ SEO ใน `layout.tsx` หรือ `page.tsx`
- **Don't:**
    - ใช้ Hooks (`useState`, `useEffect`) หรือ Browser APIs (`window`) ใน Server Components
    - ดึงข้อมูลใน Client Component โดยตรง (ควรทำใน Server Component แล้วส่งเป็น props)

```tsx
// app/page.tsx (Server Component)
async function getPosts() {
  const res = await fetch('https://api.example.com/posts');
  return res.json();
}

export default async function HomePage() {
  const posts = await getPosts();
  return <ul>{posts.map(post => <li key={post.id}>{post.title}</li>)}</ul>;
}
```

### `components/`
- **หน้าที่:** เก็บ React components ที่ใช้ซ้ำได้ โดยแยกตามความรับผิดชอบ
- **Do:**
    - วาง Dumb UI components ที่ไม่มี logic ใน `components/ui` และประกาศ `'use client'` หากจำเป็น
    - วาง Feature-specific components ใน `components/features`
    - ออกแบบให้รับ Props และส่ง Events (Props in, Events out)
- **Don't:**
    - ใส่ Business Logic ที่ซับซ้อน (ควรอยู่ใน `actions/` หรือ `lib/`)

```tsx
// components/ui/CounterButton.tsx (Client Component)
'use client';

import { useState } from 'react';

export function CounterButton() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

### `lib/`
- **หน้าที่:** เก็บฟังก์ชัน Utility, การตั้งค่า, หรือโค้ดที่ใช้ร่วมกันและไม่เกี่ยวกับ React UI
- **Do:**
    - สร้างฟังก์ชันให้เป็น Pure Functions ให้มากที่สุด
    - แยกไฟล์ตามหน้าที่ เช่น `lib/db.ts`, `lib/utils.ts`
- **Don't:**
    - Import React components หรือ Hooks เข้ามาในโฟลเดอร์นี้

```typescript
// lib/utils.ts
export function formatDate(date: Date): string {
  return new Intl.DateTimeFormat('en-US').format(date);
}
```

### `types/`
- **หน้าที่:** เป็นศูนย์รวมของ TypeScript types และ Zod schemas
- **Do:**
    - ใช้ `z.infer<>` จาก Zod schema เป็น Single Source of Truth สำหรับ Type
    - แยกประเภทของ Type เช่น `types/api.ts`, `types/db.ts`
- **Don't:**
    - Import DB-specific types เข้าไปใน Client Components โดยตรง

```typescript
// types/user.ts
import { z } from 'zod';

export const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(2),
});

export type User = z.infer<typeof UserSchema>;
```

### `actions/`
- **หน้าที่:** จัดการ Data Mutations ผ่าน Server Actions
- **Do:**
    - ขึ้นต้นไฟล์ด้วย `'use server'`
    - ตรวจสอบ Input ด้วย Zod schema เป็นอันดับแรก
    - จัดการข้อผิดพลาดด้วย `try-catch` และคืนค่าผลลัพธ์ที่ชัดเจน
    - เรียก `revalidatePath` หรือ `revalidateTag` หลังจากการทำงานสำเร็จ
- **Don't:**
    - เปิดเผยข้อมูลที่ละเอียดอ่อนใน error message

```typescript
// actions/createUser.ts
'use server';

import { revalidatePath } from 'next/cache';
import { UserSchema } from '@/types/user';

export async function createUser(formData: FormData) {
  const validatedFields = UserSchema.safeParse({
    name: formData.get('name'),
  });

  if (!validatedFields.success) {
    return { error: 'Invalid name' };
  }

  // ... save to database
  revalidatePath('/');
  return { success: true };
}
```

## 4. การตั้งค่าโปรเจกต์ (Project Setup)

- **`package.json`**: กำหนด Scripts สำหรับการพัฒนา, build, และ linting
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

- **`next.config.mjs`**: เปิดใช้งานฟีเจอร์ที่สำคัญเช่น `serverActions` และตั้งค่าอื่นๆ
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: {
    serverActions: true,
  },
};

export default nextConfig;
```

## 5. แนวปฏิบัติที่ดีที่สุด (Best Practices)

- **Push Client Components to the Leaves:** พยายามให้ Client Components มีขนาดเล็กและอยู่ที่ปลายสุดของ Component Tree เพื่อให้ส่วนใหญ่ของแอปยังคงเป็น Server Components
- **Validate on the Server:** ตรวจสอบข้อมูลนำเข้าทั้งหมดบนเซิร์ฟเวอร์เสมอ (ใน Server Actions หรือ API Routes) อย่าเชื่อถือข้อมูลที่มาจาก Client
- **Use Streaming with Suspense:** ใช้ `loading.tsx` และ React Suspense เพื่อสร้าง UI ที่ตอบสนองได้ดีขึ้น โดยการแสดงผลเนื้อหาแบบ streaming ขณะที่ข้อมูลกำลังถูกโหลด
