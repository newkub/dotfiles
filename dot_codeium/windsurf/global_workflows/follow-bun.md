bun## Setup

### config

#### `package.json`

เป็นไฟล์เริ่มต้นที่สำคัญที่สุดในการกำหนดค่าโปรเจกต์

- /follow-package-json: ปฏิบัติตามแนวทางทั่วไปในการตั้งค่า `package.json`
- กำหนด `engines`: ระบุเวอร์ชันของ Bun ที่ใช้ เพื่อความสอดคล้องกันในทุกสภาพแวดล้อม
- ตั้งค่า `scripts` พื้นฐาน: กำหนด script ที่จำเป็นสำหรับการพัฒนา, lint, build, และ test



### Libraries

- Core: `effect` - สำหรับจัดการ Side Effects, Asynchronous Operations, และ Dependencies
- Schema & Validation: `@effect/schema` หรือ `zod` - สำหรับการสร้างและตรวจสอบความถูกต้องของข้อมูล

## Project Structure

โปรเจกต์นี้ใช้แนวทาง functional programming โดยมีการแบ่งแยกหน้าที่ (separation of concerns) อย่างชัดเจน โครงสร้างถูกออกแบบมาให้เป็น modular, scalable และง่ายต่อการบำรุงรักษา

```markdown
src/
├── components/    # Pure Functions สำหรับการแสดงผล
│   ├── Button.ts
│   ├── Panel.ts
│   └── index.ts
├── services/      # Effect Handlers สำหรับ side effects
│   ├── file-system.service.ts
│   ├── logger.service.ts
│   ├── api.service.ts
│   ├── index.ts
├── config/        # การจัดการการตั้งค่า
│   ├── theme.config.ts
│   ├── display.config.ts
│   └── index.ts
├── types/         # การกำหนด Type และ Schema
│   ├── display.ts
│   ├── input.ts
│   └── index.ts
├── utils/         # Pure Functions สำหรับฟังก์ชันช่วยเหลือ
│   ├── string-helper.ts
│   ├── array-utils.ts
│   └── index.ts
├── lib/           # Wrappers สำหรับไลบรารีภายนอก
│   ├── picocolors.lib.ts
│   ├── clack.lib.ts
│   └── index.ts
├── constant/      # ค่าคงที่ตอน compile-time
│   ├── color.const.ts
│   ├── border.const.ts
│   └── index.ts
├── app.ts         # Entry point หลักของแอปพลิเคชัน
├── error.ts       # Custom error types
└── index.ts       # Entry point สำหรับ Public API
package.json       # Dependencies และ scripts
tsconfig.json      # การตั้งค่า TypeScript
```

## Core Principles

- Pure Functions: ฟังก์ชันทั้งหมดใน `utils/` ไม่มี side effects
- Immutability: ข้อมูลเป็น immutable โดยค่าเริ่มต้น
- Composition: ฟังก์ชันต่างๆ ถูกนำมาประกอบกันเพื่อสร้างฟังก์ชันที่ซับซ้อนขึ้น
- Effect Management: Side effects ถูกจัดการโดยใช้ `Effect-TS`

## Folder Rules

#### `components/`

สร้างส่วนประกอบ UI ที่สามารถแสดงผลได้ (Pure Functions)

- ควรทำ
    - สร้างฟังก์ชันที่รับ `props` และคืนค่าเป็น `string` หรือ `void`
    - ทำให้เป็น Pure Functions ที่มีการ composition
    - Import จาก `config/` เท่านั้น
- ไม่ควรทำ
    - มี Side Effects ภายใน component

```typescript
// src/components/Button.ts
interface ButtonProps {
  label: string;
  onClick: () => void; // Side effect จัดการโดย caller
}

export const Button = (props: ButtonProps): string => {
  return `<button>${props.label}</button>`;
};
```

#### `services/`

จัดการ Side Effects ทั้งหมดของแอปพลิเคชัน

- ควรทำ
    - ใช้ `Effect-TS` ในการสร้างและจัดการ Effects ทั้งหมด
- ไม่ควรทำ
    - ใส่ Business Logic ที่ไม่เกี่ยวกับ Side Effects

```typescript
// src/services/api.service.ts
import { Effect } from 'effect';

interface User {
  id: number;
  name: string;
}

export const getUser = (id: number): Effect.Effect<User, Error> =>
  Effect.tryPromise({
    try: () => fetch(`https://api.example.com/users/${id}`).then(res => res.json()),
    catch: (unknown) => new Error(`Failed to fetch user: ${unknown}`),
  });
```

#### `utils/`

รวมฟังก์ชันช่วยเหลือที่เป็น Pure Functions

- ควรทำ
    - สร้างฟังก์ชันที่ไม่มี side effects, immutable, composition, และ curry
- ไม่ควรทำ
    - มี Side Effects ใดๆ เด็ดขาด

```typescript
// src/utils/string-helper.ts
export const capitalize = (s: string): string => {
  return s.charAt(0).toUpperCase() + s.slice(1);
};
```

#### `config/`

จัดการการตั้งค่าและกำหนดรูปแบบข้อมูล

- ควรทำ
    - Import จาก `types/` และ `constant/`
    - ใช้ `as const` และ `Object.freeze` เพื่อให้ข้อมูลเป็น immutable
- ไม่ควรทำ
    - ใส่ Logic การทำงานใดๆ

```typescript
// src/config/theme.config.ts
import { THEME } from '../constant/theme.const';

export const AppTheme = Object.freeze({
  primaryColor: THEME.BLUE,
  backgroundColor: THEME.WHITE,
});
```
