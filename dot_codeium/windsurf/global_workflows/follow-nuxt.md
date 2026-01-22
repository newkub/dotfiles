
---
trigger: always_on
description: ตั้งค่าและพัฒนาโปรเจกต์ Nuxt
instruction:
  - ตั้งค่า package.json ด้วย scripts พื้นฐานสำหรับ Nuxt
  - ทำตาม workflows ย่อยตามลำดับที่กำหนด
  - ใช้ Bun เป็น package manager
condition:
  - ใช้เมื่อสร้างโปรเจกต์ Nuxt ใหม่
  - ใช้เมื่อพัฒนาโปรเจกต์ Nuxt
goal:
  - สร้างโปรเจกต์ Nuxt ที่มีโครงสร้างที่เหมาะสม
  - ใช้ VueUse, UnoCSS, Pinia
  - ใช้ TypeScript และ strict mode
input:
  - โปรเจกต์ Nuxt ที่ต้องการตั้งค่าหรือพัฒนา
output:
  - โปรเจกต์ Nuxt ที่มี configuration ครบถ้วน
  - โครงสร้างโปรเจกต์ที่ถูกต้องตาม best practices
outcome:
  - โปรเจกต์ Nuxt พร้อมใช้งานด้วย VueUse, UnoCSS, Pinia
  - โค้ดที่มีคุณภาพและเป็นไปตาม best practices
---

# การตั้งค่าและพัฒนาโปรเจกต์ Nuxt

## 0. การทำตาม Workflows ย่อย (ใช้เสมอ)

### 0.1. หลักการทำตาม Workflows ย่อย

**0.1.1. การอ่านและปฏิบัติตาม Workflows**
- เมื่อพบคำสั่ง `ทำตาม /workflow-name` ให้เข้าไปอ่าน workflow นั้นทันที
- อ่านเนื้อหาทั้งหมดของ workflow ที่เกี่ยวข้อง
- ทำตามขั้นตอนทั้งหมดใน workflow นั้นให้ครบถ้วน
- ห้ามข้ามขั้นตอนใดๆ ใน workflow ย่อย
- ห้ามสันนิษฐานเนื้อหาของ workflow ย่อยโดยไม่อ่าน

**0.1.2. ลำดับการทำงาน**
- ทำตาม workflows ย่อยตามลำดับที่ระบุใน workflow หลัก
- หาก workflow ย่อยมีการอ้างถึง workflow อื่น ให้ทำตามลำดับเชื่อมโยงนั้น
- **ก่อนลงมือทำงาน ให้อ่าน `/refactor-nuxt` ก่อนเสมอ**
- **ถ้าใช้ Nuxt ให้ทำตาม `/refactor-nuxt` เสมอ**
- **ทำ `/refactor-nuxt` หลังสุดหลังจากทำครบทุก workflow ย่อย**
- **หลังทำเสร็จงาน ให้ตรวจสอบ `/refactor-nuxt` อีกครั้งว่าทำครบถ้วนแล้ว**
- ยืนยันว่าทำครบทุก workflow ย่อยก่อนดำเนินการต่อ

**0.1.3. การตรวจสอบความครบถ้วน**
- หลังจากทำตาม workflow ย่อยแต่ละตัว ตรวจสอบว่า:
  - สร้างไฟล์ทั้งหมดที่ระบุ
  - ตั้งค่า configuration ทั้งหมดที่ระบุ
  - ทำตามขั้นตอนทั้งหมดที่ระบุ
- หากพบ workflow ย่อยที่ไม่มีอยู่ แจ้งให้ผู้ใช้ทราบ

**0.1.4. การจัดการ Dependencies ระหว่าง Workflows**
- หาก workflow ย่อยตัวหนึ่งต้องการผลลัพธ์จาก workflow ย่อยอื่น
- ต้องทำ workflow ย่อยที่เป็น dependency ก่อน
- ตรวจสอบว่าผลลัพธ์จาก workflow ก่อนหน้าพร้อมใช้งานก่อนทำต่อ

---

## 1. Import Rules (ใช้เสมอ)

### 1.1. Aliases

**1.1.1. ความหมายของแต่ละ Alias**
- `~/` หมายถึง `app/` เป็น path หลักสำหรับโฟลเดอร์ app
- `#shared/` หมายถึง `shared/` เป็น path สำหรับโฟลเดอร์ shared
- `~~/` หมายถึง root project เป็น path สำหรับโฟลเดอร์หลักของโปรเจกต์

**1.1.2. วิธีการใช้งาน**
- `การ import จาก app` : ต้องการ component หรือ composable -> IMPORT ด้วย `~/components/Example.vue`
- `การ import จาก shared` : ต้องการ type หรือ utility ที่ใช้ร่วมกัน -> IMPORT ด้วย `#shared/types/index.ts`
- `การ import จาก root` : ต้องการ config หรือไฟล์จากโฟลเดอร์หลัก -> IMPORT ด้วย `~~/package.json`
- `การ import จาก server` : ต้องการ server API หรือ utils -> IMPORT ด้วย `~/server/api/example.ts`

**1.1.3. ตัวอย่างการใช้งาน**

````typescript
// Example 1: Import component จาก app
import Button from '~/components/Button.vue'

// Example 2: Import type จาก shared
import type { User } from '#shared/types/user'

// Example 3: Import config จาก root
import config from '~~/config/app'

// Example 4: Import จาก shared ใน server
import type { ApiResponse } from '#shared/types/api'
````

**1.1.4. การใช้งานใน Server**
- `การ import จาก app/shared/root` : อยู่ใน server และต้องการไฟล์จากส่วนอื่น -> IMPORT ด้วย alias เดียวกับ app
- `การ import จาก server/` : อยู่ใน server และต้องการไฟล์ใน server -> IMPORT ด้วย `~/server/...`
- `การ import จาก shared` : อยู่ใน server และต้องการ type ที่ใช้ร่วมกัน -> IMPORT ด้วย `#shared/...`

---

## 2. Package.json Setup (ใช้เสมอ)

### 2.1. การตั้งค่า Package.json

**2.1.1. ทำตาม Workflows ที่เกี่ยวข้อง**
- ทำตาม `/follow-package-json` เพื่อตั้งค่า `package.json` พื้นฐาน
- ทำตาม `/follow-vitest` เพื่อตั้งค่าการทดสอบ

**2.1.2. สร้าง package.json**
- สร้างไฟล์ `package.json` ใน root ของโปรเจกต์
- ตั้งค่า scripts พื้นฐานสำหรับ Nuxt
- เพิ่ม scripts สำหรับ testing ตาม `/follow-vitest`

**2.1.3. Scripts ที่ต้องมี**
- `dev`: สำหรับ development
- `build`: สำหรับ production build
- `preview`: สำหรับ preview production build
- `format`: สำหรับ formatting code
- `lint`: สำหรับ type checking
- `test`: สำหรับรัน tests (ตาม `/follow-vitest`)
- `postinstall`: สำหรับ prepare Nuxt

**2.1.4. ตัวอย่าง package.json**

```json
{
    "scripts": {
        "dev": "nuxt dev",
        "build": "nuxt build",
        "preview": "nuxt preview",
        "format": "dprint fmt",
        "lint": "nuxt typecheck",
        "test": "vitest",
        "postinstall": "nuxt prepare"
    }
}
```

---

## 3. Configuration Files (ใช้เสมอ)

### 3.1. การตั้งค่า Configuration Files

**3.1.1. ลำดับการตั้งค่า**
- ทำตาม `/follow-nuxt-config-ts` เพื่อตั้งค่า `nuxt.config.ts`
- ทำตาม `/follow-tsconfig-nuxt` เพื่อตั้งค่า `tsconfig.json`
- ทำตาม `/follow-unocss-nuxt` เพื่อตั้งค่า UnoCSS
- ทำตาม `/follow-oxlint` เพื่อตั้งค่า oxlint
- ทำตาม `/follow-dprint` เพื่อตั้งค่า dprint

**3.1.2. ความสำคัญของแต่ละ Configuration**
- `nuxt.config.ts`: Configuration หลักของ Nuxt
- `tsconfig.json`: TypeScript configuration
- `uno.config.ts`: UnoCSS configuration
- `.oxlintrc.json`: Linting rules
- `dprint.json`: Code formatting rules

---

## 4. Project Structure (ใช้เสมอ)

### 4.1. Utils Functions

**4.1.1. สร้างโครงสร้าง utils**
- ทำตาม `/follow-utils` เพื่อสร้างโครงสร้าง utils functions
- สร้างไฟล์ใน `app/utils/` หรือ `shared/utils/`
- แบ่ง utils เป็นหมวดหมู่ตามฟังก์ชัน

### 4.2. Project Architecture

**4.2.1. วางโครงสร้างโปรเจกต์**
- ทำตาม `/follow-nuxt-architecture` เพื่อวางโครงสร้างโปรเจกต์
- กำหนดโครงสร้างโฟลเดอร์และไฟล์
- กำหนดความสัมพันธ์ระหว่างส่วนต่างๆ

### 4.3. Components

**4.3.1. สร้างโครงสร้าง components**
- ทำตาม `/follow-nuxt-components` เพื่อสร้างโครงสร้าง components
- สร้าง components ใน `app/components/`
- แบ่ง components เป็นหมวดหมู่ตามฟังก์ชัน

### 4.4. Composables

**4.4.1. สร้างโครงสร้าง composables**
- ทำตาม `/follow-nuxt-composables` เพื่อสร้างโครงสร้าง composables
- สร้าง composables ใน `app/composables/`
- ใช้ VueUse และ Vue Macros

### 4.5. App.vue

**4.5.1. ตั้งค่า app.vue**
- ทำตาม `/follow-nuxt-app-vue` เพื่อตั้งค่า `app.vue`
- ตั้งค่า VueUse, Vue Macros, UnoCSS, Pinia

### 4.6. Pages

**4.6.1. สร้างโครงสร้าง pages**
- ทำตาม `/follow-nuxt-pages` เพื่อสร้างโครงสร้าง pages
- สร้าง pages ใน `app/pages/`
- ใช้ file-based routing

### 4.7. Layouts

**4.7.1. สร้างโครงสร้าง layouts**
- ทำตาม `/follow-nuxt-layouts` เพื่อสร้างโครงสร้าง layouts
- สร้าง layouts ใน `app/layouts/`
- ใช้ VueUse, Vue Macros, UnoCSS, Pinia

### 4.8. Stores

**4.8.1. สร้างโครงสร้าง stores**
- ทำตาม `/follow-nuxt-stores` เพื่อสร้างโครงสร้าง stores
- สร้าง stores ใน `app/stores/`
- ใช้ Pinia สำหรับ state management

### 4.9. Server API

**4.9.1. สร้างโครงสร้าง server API**
- ทำตาม `/follow-nuxt-server-api` เพื่อสร้างโครงสร้าง server API
- สร้าง API routes ใน `server/api/`
- ใช้ Nitro สำหรับ server-side

### 4.10. Server Middleware

**4.10.1. สร้างโครงสร้าง server middleware**
- ทำตาม `/follow-nuxt-server-middleware` เพื่อสร้างโครงสร้าง server middleware
- สร้าง middleware ใน `server/middleware/`
- ใช้สำหรับ request/response handling

### 4.11. Database Layer

**4.11.1. สร้างโครงสร้าง database layer**
- ทำตาม `/follow-drizzle-nuxt` เพื่อสร้างโครงสร้าง database layer
- ใช้ Drizzle ORM สำหรับ database operations
- สร้าง models ใน `server/db/`

### 4.12. Shared Types

**4.12.1. สร้างโครงสร้าง shared types**
- ทำตาม `/follow-shared-types` เพื่อสร้างโครงสร้าง shared types
- สร้าง types ใน `shared/types/`
- ใช้ร่วมกันระหว่าง client และ server

### 4.13. Server Composables

**4.13.1. สร้างโครงสร้าง server composables**
- สร้าง composables ใน `server/composables/`
- ใช้สำหรับ server-side logic ที่ใช้ร่วมกัน
- ใช้กับ server API และ server middleware
- ตั้งชื่อด้วย `use` prefix (เช่น `useHabitEntries`, `useAuth`)