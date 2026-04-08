---
title: Follow Nuxt
description: สร้างหรือปรับปรุง Nuxt 3/4 project ด้วย Universal Rendering, Nitro server, Layers และ Modules
auto_execution_mode: 3
---

1. Project Requirements

วิเคราะห์โครงสร้างและความต้องการก่อนเริ่มพัฒนา

- ระบุ Project Location ใน monorepo เช่น `apps/web/`
- เลือก Nuxt Version ระหว่าง 3.x หรือ 4.x (default: 4.x)
- กำหนด Rendering Mode: SSR, SSG, CSR, หรือ Hybrid
- ตัดสินใจใช้ Database หรือไม่ (Drizzle ORM)
- เลือก UI Framework: UnoCSS, Tailwind, หรืออื่นๆ
- กำหนด Architecture: ใช้ Layers และ Modules หรือไม่

2. Setup and Development

ดำเนินการตั้งค่าและพัฒนาโปรเจกต์ตามมาตรฐาน

- สร้าง directory structure (`app/`, `layers/`, `server/`, `shared/`)
- ตั้งค่า `nuxt.config.ts` (extends, modules, nitro, typescript)
- สร้าง Layers สำหรับแต่ละ feature (ถ้าใช้ Layer architecture)
- ติดตั้ง dependencies ด้วย `bun add`
- สร้าง base components, layouts, composables
- สร้าง server layer (API routes, services, repositories)
- ตั้งค่า TypeScript, Biome, oxlint

3. Quality Verification

ตรวจสอบและยืนยันคุณภาพโค้ดและ build

- รัน `nuxt typecheck` ตรวจสอบ TypeScript errors
- รัน Biome และ oxlint ตรวจสอบ code quality
- รัน `nuxt build` และ `nuxt generate` ยืนยัน build ผ่าน
- ทดสอบ dev server รันได้โดยไม่มี errors
- ตรวจสอบ HMR และ auto-imports ทำงานถูกต้อง

4. Directory Structure

ใช้ app/ directory และ layers/ ตามมาตรฐาน Nuxt 4

- ใช้ `app/` directory (Nuxt 4 structure)
- สร้าง `layers/` สำหรับ feature-based architecture
- จัดกลุ่ม components, composables ตาม feature ในแต่ละ Layer
- ใช้ auto-imports สำหรับ components และ composables
- แยก business logic เป็น services และ repositories ใน `server/`

5. Code Standards

กำหนดมาตรฐานการเขียนโค้ดสำหรับทุกส่วนของโปรเจกต์

- Vue components: ใช้ `script setup lang="ts"`, script อยู่บน template
- Composables: ชื่อขึ้นต้นด้วย `use`, อยู่ใน `composables/` หรือ `layers/[feature]/composables/`
- Server API: ใช้ `defineEventHandler` หรือ `defineNitroPlugin`
- Types: ไม่ใช้ `any`, กำหนด types ชัดเจนใน `shared/types/`
- Import: Auto-import สำหรับ Nuxt built-ins, barrel export สำหรับ shared

6. Config Requirements

ตั้งค่าไฟล์ config ตามมาตรฐานที่กำหนด

- `nuxt.config.ts`: compatibilityDate, extends (layers), modules, nitro preset
- `package.json`: scripts (build, dev, generate, lint, format, test), type: module
- `tsconfig.json`: references Nuxt generated configs, strict mode
- Layer barrel: ทุก folder ต้องมี index.ts สำหรับ exports
- Data flow: Pages → Components → Composables → Stores → API → Services → Repositories → DB

7. Performance Optimization

ปรับปรุงประสิทธิภาพของ Nuxt application

- ใช้ Vue DevTools performance tab วิเคราะห์ component render times
- ใช้ computed properties อย่างมีประสิทธิภาพ
- หลีกเลี่ยง deep reactivity ถ้าไม่จำเป็น
- ใช้ `v-once` สำหรับ static content
- implement virtual scrolling สำหรับ long lists
- ใช้ `keep-alive` สำหรับ expensive components
- ใช้ tree-shaking อย่างเต็มที่
- ใช้ dynamic imports สำหรับ routes
- ใช้ Pinia stores อย่างมีประสิทธิภาพ

8. Related Workflows

- `/follow-nuxt-architecture` - โครงสร้างโปรเจกต์ Nuxt มาตรฐาน
- `/validate` - ตรวจสอบความถูกต้องของ project structure
- `/analyze-project` - วิเคราะห์โครงสร้าง project
- `/optimize-workflows` - ปรับปรุง workflow files
- `/follow-nuxt-modules` - ตั้งค่า Nuxt modules
- `/follow-vue` - แนวทางการพัฒนา Vue components

## Execute

1. Setup Phase

เตรียมความพร้อมก่อนเริ่มพัฒนา

- ตรวจสอบสภาพแวดล้อมและเครื่องมือที่จำเป็น
- สร้าง backup หรือ commit ก่อนเริ่ม
- รัน tests เดิมให้ผ่านทั้งหมดก่อนเริ่ม (ถ้ามี)

2. Analysis Phase

วิเคราะห์ความต้องการของโปรเจกต์

- ระบุ Project Location และ Nuxt Version
- กำหนด Rendering Mode และ UI Framework
- วางแผนโครงสร้าง Layers และ Modules
- ประเมิน dependencies ที่จำเป็น

3. Development Phase

ดำเนินการตั้งค่าและพัฒนา

- สร้าง directory structure ตามที่วางแปลง
- ตั้งค่า `nuxt.config.ts` และ config อื่นๆ
- ติดตั้ง dependencies ด้วย `bun add`
- สร้าง base components, layouts, composables
- สร้าง server layer (API, services, repositories)
- สร้าง Layers สำหรับแต่ละ feature (ถ้าใช้)

4. Verification Phase

ตรวจสอบความถูกต้องและคุณภาพ

- รัน `nuxt typecheck` ตรวจสอบ TypeScript errors
- รัน Biome และ oxlint ตรวจสอบ code quality
- รัน `nuxt build` และ `nuxt generate` ยืนยัน build ผ่าน
- ทดสอบ dev server รันได้โดยไม่มี errors
- ตรวจสอบ HMR และ auto-imports ทำงานถูกต้อง

## Rules

1. Architecture Standards

กำหนดมาตรฐานโครงสร้างโปรเจกต์

- ใช้ `app/` directory สำหรับ Nuxt 4
- สร้าง `layers/` สำหรับ feature-based architecture
- แยก business logic ออกจาก presentation
- ใช้ Clean Architecture principles

2. Code Style Standards

กำหนดมาตรฐานการเขียนโค้ด

- Vue components ใช้ `script setup lang="ts"` เท่านั้น
- Composables ต้องมี prefix `use`
- ไม่ใช้ `any` โดยเด็ดขาด
- ใช้ barrel exports สำหรับทุก folder

3. Import and Dependencies

กำหนดมาตรฐานการ import และ dependencies

- ใช้ auto-imports สำหรับ Nuxt built-ins
- ใช้ barrel export สำหรับ shared modules
- ไม่ใช้ relative path ใน cross-layer imports
- ใช้ import alias หรือ package name

4. Testing and Quality

กำหนดมาตรฐานการทดสอบและคุณภาพ

- รัน type checker ก่อน commit
- รัน linter และ formatter อย่างสม่ำเสมอ
- เขียน tests สำหรับ critical paths
- รักษา code coverage ไม่ให้ลดลง

5. Performance Standards

กำหนดมาตรฐานประสิทธิภาพ

- วัด performance ก่อนและหลัง optimize
- ใช้ Vue DevTools วิเคราะห์ bottlenecks
- หลีกเลี่ยง premature optimization
- validate improvements ด้วย data
