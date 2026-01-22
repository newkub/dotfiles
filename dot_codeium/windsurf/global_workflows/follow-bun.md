---
trigger: always_on
description: ตั้งค่าและพัฒนาโปรเจกต์ Bun ด้วย TypeScript และ Effect-TS
instruction:
  - ตั้งค่า package.json ด้วย scripts พื้นฐานสำหรับ Bun
  - ทำตาม workflows ย่อยตามลำดับที่กำหนด
  - ใช้ Bun เป็น package manager
  - ใช้ Effect-TS สำหรับจัดการ side effects
condition:
  - ใช้เมื่อสร้างโปรเจกต์ Bun ใหม่
  - ใช้เมื่อพัฒนาโปรเจกต์ Bun
goal:
  - สร้างโปรเจกต์ Bun ที่มีโครงสร้างที่เหมาะสม
  - ใช้ TypeScript 5.x, Effect-TS และ strict mode
input:
  - โปรเจกต์ Bun ที่ต้องการตั้งค่าหรือพัฒนา
output:
  - โปรเจกต์ Bun ที่มี configuration ครบถ้วน
  - โครงสร้างโปรเจกต์ที่ถูกต้องตาม best practices
outcome:
  - โปรเจกต์ Bun พร้อมใช้งานด้วย TypeScript 5.x และ Effect-TS
  - โค้ดที่มีคุณภาพและเป็นไปตาม best practices
---

# การตั้งค่าและพัฒนาโปรเจกต์ Bun

## 0. การทำตาม Workflows ย่อย (ใช้เสมอ)

### 0.1. หลักการทำตาม Workflows ย่อย

- อ่านและทำตาม workflow ย่อยทั้งหมดให้ครบถ้วน
- ทำตามลำดับที่ระบุ รวมถึง dependencies ระหว่าง workflows
- ตรวจสอบความครบถ้วนของไฟล์และ configuration ที่ระบุ
- แจ้งเมื่อพบ workflow ย่อยที่ไม่มีอยู่

---

## 1. Installation (ใช้เสมอ)

### 1.1. ติดตั้ง Dependencies

**1.1.1. ติดตั้ง TypeScript 5.x**
- รัน: `bun add -D typescript @types/node`

**1.1.2. ติดตั้ง Effect-TS**
- รัน: `bun add effect @effect/schema`

**1.1.3. ติดตั้ง Development Tools**
- รัน: `bun add -D vitest @vitest/ui`

**1.1.4. ติดตั้ง Linting Tools**
- รัน: `bun add -D oxlint oxlint-tsgolint`

---

## 2. Package.json Setup (ใช้เสมอ)

### 2.1. สร้าง package.json

**2.1.1. สร้างไฟล package.json**
- สร้างไฟล์ `package.json` ใน root ของโปรเจกต์
- ตั้งค่า scripts พื้นฐานสำหรับ Bun

**2.1.2. Scripts ที่ต้องมี**
- `watch`: สำหรับ watch mode
- `prepare`: สำหรับ setup หลัง install
- `preinstall`: สำหรับ update dependencies
- `dev`: สำหรับ development
- `build`: สำหรับ production build
- `lint`: สำหรับ linting
- `test`: สำหรับ running tests
- `typecheck`: สำหรับ type checking
- `verify`: สำหรับ verify ก่อน deploy

**2.1.3. ตัวอย่าง package.json**

```json
{
  "type": "module",
  "engines": {
    "bun": ""
  },
  "scripts": {
    "watch": "bun --watch verify",
    "prepare": "lefthook install",
    "preinstall": "bun update --latest",
    "dev": "bun run src/index.ts",
    "build": "bun build src/index.ts --outdir ./dist --target bun",
    "lint": "oxlint --fix --type-aware",
    "test": "vitest",
    "typecheck": "tsc --noEmit",
    "verify": "bun run lint && bun run typecheck && bun run test && bun run build"
  }
}
```

---

## 3. Script Rules (ใช้เสมอ)

### 3.1. Scripts ที่ต้องมี

| Script | คำสั่ง | คำอธิบาย |
|--------|----------|-------------|
| `watch` | `bun --watch verify` | Watch mode |
| `prepare` | `lefthook install` | Setup หลัง install |
| `preinstall` | `bun update --latest` | Update dependencies |
| `dev` | `bun run src/index.ts` | Development |
| `build` | `bun build src/index.ts --outdir ./dist --target bun` | Production build |
| `lint` | `oxlint --fix --type-aware` | Linting |
| `test` | `vitest` | Running tests |
| `typecheck` | `tsc --noEmit` | Type checking |
| `verify` | `bun run lint && bun run typecheck && bun run test && bun run build` | Verify ก่อน deploy |

---

## 4. Configuration Files (ใช้เสมอ)

### 4.1. การตั้งค่า Configuration Files

**4.1.1. ลำดับการตั้งค่า**
- ทำตาม `/follow-config-file` เพื่อตั้งค่า `tsconfig.json`

**4.1.2. ความสำคัญของแต่ละ Configuration**
- `tsconfig.json`: TypeScript configuration
- `.oxlintrc.json`: Linting configuration (ทำตาม `/follow-oxlint`)

**4.1.3. ตัวอย่าง tsconfig.json**

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "useUnknownInCatchVariables": true,
    "skipLibCheck": false
  }
}
```

---

## 5. Project Structure (ใช้เสมอ)

### 5.1. วางโครงสร้างโปรเจกต์
- ทำตาม `/follow-project-structure`

### 5.2. Layers ที่ต้องสร้าง
- **Utils**: `/follow-typescript-utils` - Helper functions ใน `src/utils/`
- **Types**: `/follow-typescript-types` - Types และ Schema ใน `src/types/`
- **App**: `/follow-typescript-app` - Controllers และ UI ใน `src/app/`
- **Services**: `/follow-typescript-services` - Business logic ใน `src/services/`
- **Adapter**: `/follow-typescript-adapter` - External adapters ใน `src/adapter/`
- **Integrations**: `/follow-typescript-integrations` - Framework integrations ใน `src/integrations/`
- **Lib**: `/follow-typescript-lib` - Shared libraries ใน `src/lib/`
- **Error**: `/follow-typescript-error` - Error handling ใน `src/error/`

---

## 6. Core Principles (ใช้เสมอ)

### 6.1. Functional Programming
- **Pure Functions**: `utils/` และ `lib/` ไม่มี side effects
- **Immutability**: ข้อมูลเป็น immutable โดยค่าเริ่มต้น ใช้ `readonly`
- **Composition**: ฟังก์ชันถูกนำมาประกอบกัน
- **Effect Management**: Side effects จัดการโดย `Effect-TS` ใน `services/` หรือ `adapter/`

### 6.2. Type Safety
- หลีกเลี่ยง `any` ใช้ `unknown` แทนเมื่อจำเป็น
- ใช้ type hints อย่างชัดเจน
- ใช้ Schema จาก `@effect/schema` สำหรับ validation

### 6.3. Performance
- ใช้ `const` แทน `let` เมื่อเป็นไปได้
- ใช้ `readonly` สำหรับ arrays และ objects
- แยก hot paths

### 6.4. Workflow
- รัน `tsc --noEmit` สำหรับ type checking
- รัน `vitest` สำหรับ testing

### 6.5. Rust Integration
- ใช้ **napi-rs** สำหรับ Bun integration
- ใช้ **wasm-bindgen** สำหรับ WebAssembly

---

## 7. Import Rules (ใช้เสมอ)

### 7.1. ลำดับการ Import
```
types -> utils -> lib -> integrations -> services -> adapter -> app -> entry
```

### 7.2. กฎการ Import
- ทำตาม `/follow-project-structure`
- `app`: services, lib, utils, types
- `services`: adapter, integrations, lib, utils, types
- `adapter`: lib, utils, types
- `integrations`: lib, utils, types
- `lib`: utils, types
- `utils`: types
- `types`: ไม่มี internal dependencies

---

## 8. Libraries (ใช้เสมอ)

### 8.1. Libraries หลัก
- **TypeScript**: 5.x
- **effect-ts**: State management, error handling, side effects
- **@effect/schema**: Schema และ validation
- **vitest**: Testing framework
- **bun**: Package manager และ runtime
- **fetch**: HTTP client (built-in)

### 8.2. Libraries ตาม Layer
| Layer | Dependencies |
|-------|--------------|
| utils | ไม่มี external dependencies |
| types | ไม่มี external dependencies |
| lib | ไม่มี external dependencies |
| services | effect-ts, @effect/schema |
| adapter | fetch |
| integrations | effect-ts |
| app | effect-ts |
