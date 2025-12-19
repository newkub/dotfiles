---
auto_execution_mode: 3
---


follow ทำตามกฏเหล่านี้อย่างเคร่งครัด


## Functional with ts project structure 

```markdown
src/
├── components/    # ส่วนประกอบการแสดงผล (Pure Functions)
│   ├── Button.ts
│   ├── Panel.ts
│   └── index.ts
├── services/      # Effect Handlers (Effect-TS) - จัดการ side effects
│   ├── file-system.service.ts
│   ├── logger.service.ts
│   ├── api.service.ts
│   └── index.ts
├── config/        # การตั้งค่าและกำหนดรูปแบบข้อมูล
│   ├── theme.config.ts
│   ├── display.config.ts
│   └── index.ts
├── types/         # รูปแบบข้อมูลทั่วทั้งระบบ (ใช้ผ่าน config เท่านั้น)
│   ├── display.ts
│   ├── input.ts
│   └── index.ts
├── utils/         # Pure Functions (ไม่มี side effects)
│   ├── string-helper.ts
│   ├── array-utils.ts
│   └── index.ts
├── lib/           # Third-party wrappers (optional)
│   ├── picocolors.lib.ts
│   ├── clack.lib.ts
│   └── index.ts
├── constant/      # ค่าคงที่และข้อมูลตายตัว
│   ├── color.const.ts
│   ├── border.const.ts
│   └── index.ts
├── app.ts         # จุดเริ่มต้นโปรแกรม
└── index.ts       # ประตูหลักของโปรแกรม
package.json       # รายการไลบรารีและคำสั่งต่างๆ
tsconfig.json      # การตั้งค่า TypeScript
```

## Core Concepts

### Architecture Overview
```
            ┌────────────────────────────────────────────────────┐
            │  Functional TypeScript CLI/TUI (Effect-TS)         │
            └────────────────────────────────────────────────────┘

                              ┌──────────┐
                              │  types/  │
                              └─────┬────┘
                                    │ Effect Schema
                                    │ • Runtime validation
                                    │ • Type derivation
                                    │ • Branded types
                                    │ • Schema composition
                                    │
                         ┌──────────┼──────────┐
                         │                     │
                         ▼                     ▼
                    ┌──────────┐          ┌──────────┐
                    │constant/ │          │ config/  │
                    └─────┬────┘          └─────┬────┘
                          │                     │
                          │ • Compile-time      │ • c12 loader
                          │ • Immutable         │ • Type bridge
                          │ • Frozen objects    │ • Validation
                          │ • as const          │ • Load config
                          │                     │
                          └──────────┬──────────┘
                                     │
                  ┌──────────────────┼──────────────────┐
                  │                  │                  │
                  ▼                  ▼                  ▼
          ┌───────────────┐  ┌──────────────┐  ┌──────────────┐
          │  Pure Layer   │  │ Effect Layer │  │   lib/       │
          └───────────────┘  └──────────────┘  └──────────────┘

       ┌──────────┐                  ┌───────────┐
       │components│                  │ services/ │
       └─────┬────┘                  └─────┬─────┘
             │                             │
             │ • Pure functions            │ • Effect-TS
             │ • String output             │ • I/O operations
             │ • Composition               │ • File system
             │ • No side effects           │ • Network
             │ • Testable                  │ • Logging
             │                             │ • Error handling
             │                             │
        ┌────┴────┐                   ┌────┴─────┐
        │         │                   │          │
        ▼         ▼                   ▼          ▼
   ┌────────┐ ┌────────┐        ┌─────────┐ ┌─────────┐
   │ utils/ │ │  lib/  │        │ Context │ │  Layer  │
   └────────┘ └────────┘        └─────────┘ └─────────┘
    • Remeda   • picocolors      • DI        • Service
    • map      • clack           • Tags      • Runtime
    • filter   • 3rd-party       • Env       • Compose
    • pipe
    • curry
        │         │                   │          │
        └────┬────┴───────────────────┴────┬─────┘
             │                             │
             └──────────────┬──────────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │  Application    │
                   └─────────────────┘
                            │
                 ┌──────────┼──────────┐
                 │                     │
                 ▼                     ▼
            ┌─────────┐           ┌─────────┐
            │ app.ts  │           │index.ts │
            └─────────┘           └─────────┘
             • Compose layers      • CLI entry
             • Setup effects       • Public API
             • Run program         • Exports
             • Error handling      • CLI runner
                 │                     │
                 └──────────┬──────────┘
                            │
                            ▼
          ┌─────────────────────────────────────┐
          │      Data Flow & Execution          │
          └─────────────────────────────────────┘
                            │
          Schema → Config → Pure → Effect → App
          Validate  Bridge  Render I/O     Run
                            │
                            ▼
          ┌─────────────────────────────────────┐
          │       Testing Strategy              │
          └─────────────────────────────────────┘
                            │
            ┌───────────────┼───────────────┐
            │               │               │
            ▼               ▼               ▼
       ┌─────────┐     ┌─────────┐    ┌──────────┐
       │  Pure   │     │ Effect  │    │Integration│
       └─────────┘     └─────────┘    └──────────┘
        • Unit test     • Mock layers  • E2E tests
        • Fast          • Test effects • Full flow
        • Deterministic • Error paths  • Real services
        • No mocks      • Retry logic  • Vitest
```

### Core Principles
- **Data Flow**: `types` → `constant` → `config` → `components`
- **Pure Functions**: All functions in `utils/` have no side effects
- **Single Entry Point**: All folders use `config/` as the only way to access types
- **Separation of Concerns**: Each folder has a specific responsibility
- **Type Safety**: Effect Schema for runtime validation, TypeScript for compile-time

### Import Rules
```
components  ← config ← types + constant
services    ← config + types (Effect-TS for side effects)
utils       ← (No dependencies - pure functions only)
lib         ← (No dependencies - third-party wrappers)
```

## Folder Rules

### components/
- <Purpose> => CLI TUI components, pure rendering
- <Do> => import จาก `config/` เท่านั้น, pure functions, composition
- <Don't> => ห้าม import `types/` ตรง, side effects, mutable state
- <Naming> => ไฟล์ `PascalCase.ts`
- <Type Safety> => type signature ครบ, ห้าม `any`
- <Functional> => pure, immutable, composition
- <Testing> => unit test ทุกฟังก์ชัน

### types/ (Effect Schema)
- <Purpose> => schemas, type derivation, runtime validation
- <Do> => `Schema.Struct/Array/Union/Literal`, derive `Schema.Schema.Type<T>`
- <Don't> => ใช้ตรงใน components (ผ่าน config/), `any`
- <Naming> => `kebab-case.ts`, Schema `PascalCaseSchema`
- <Validation> => `Schema.decodeUnknown`, branded types
- <Testing> => `decodeUnknownSync`
- <Example>
```typescript
export const ColorSchema=Schema.Literal('red','green','blue')
export const ConfigSchema=Schema.Struct({color:ColorSchema,width:Schema.Number})
export type Color=Schema.Schema.Type<typeof ColorSchema>
```

### utils/
- <Purpose> => pure functions, functional helpers
- <Do> => pure functions (no side effects), immutable, composition, curry
- <Don't> => side effects, mutate input, global state, Effect-TS
- <Naming> => ไฟล์ `kebab-case.ts`, ฟังก์ชัน `camelCase`
- <Type Safety> => type signature ครบ, generics, ห้าม `any`
- <Functional> => Pure, Immutable, Composition
- <Testing> => unit test ทุกฟังก์ชัน, coverage ≥ 90%
<Example>
```typescript
export const processUsers=(users:readonly User[])=>R.pipe(
  users,R.filter(u=>u.age>=18),R.map(u=>({...u,name:u.name.toUpperCase()}))
)
```

### config/ (c12)
- <Purpose> => config management, type bridge
- <Do> => import จาก `types/`+`constant/`, `as const`, `Object.freeze`
- <Don't> => business logic, mutate
- <Naming> => `kebab-case.config.ts`
- <Type Safety> => `as const`, `satisfies`
- <Testing> => `Object.isFrozen`
<Example>
```typescript
const cfg={color:'blue',width:80}as const satisfies DisplayConfig
export const defaultDisplayConfig=Object.freeze(cfg)
```

### constant/
- <Purpose> => compile-time constants
- <Do> => `as const`, `Object.freeze`, `UPPER_SNAKE_CASE`
- <Don't> => ใช้ตรงใน components (ผ่าน config/), mutable
- <Naming> => ไฟล์ `kebab-case.const.ts`
- <Type Safety> => `as const`, union types
- <Immutability> => `Object.freeze`, `readonly`
- <Testing> => `Object.isFrozen`

### services/ (Effect-TS)
- <Purpose> => Side effects handler (I/O, network)
- <Do> => `Effect<A,E,R>`, combinators, `Effect.gen`, Layer (DI)
- <Don't> => business logic ไม่เกี่ยวข้อง, run ตรง (ทำที่ app.ts)
- <Naming> => `kebab-case.service.ts`, `PascalCaseService`
- <Testing> => `Effect.runPromise`, mock `Layer.succeed`
- <Example>
```typescript
class LogError extends Error{readonly _tag='LogError'}
interface LoggerService{readonly log:(m:string)=>Effect.Effect<void,LogError>}
const LoggerService=Context.GenericTag<LoggerService>('LoggerService')
const makeLogger=Effect.sync(():LoggerService=>({log:(m)=>Effect.void}))
export const LoggerServiceLive=Layer.effect(LoggerService,makeLogger)
```

### lib/
- <Purpose> => wrap third-party libraries (picocolors, clack)
- <Do> => wrap APIs, type-safe interfaces, re-export เฉพาะจำเป็น
- <Don't> => side effects (ใช้ services/), export raw objects
- <Naming> => ไฟล์ `kebab-case.lib.ts`, ฟังก์ชัน `camelCase`
- <Type Safety> => wrap types, type definitions
- <Testing> => ไม่ต้อง (test ใน services/)

### Root Files

#### package.json
```json
{"name":"functional-ts-cli","type":"module","main":"dist/index.js",
"scripts":{"build":"tsdown --watch --exports --dts","dev":"bun --watch src/index.ts",
"test":"vitest","lint":"biome lint --write"},
"dependencies":{"effect":"latest","@effect/schema":"latest","c12":"latest","remeda":"latest"},
"devDependencies":{"@biomejs/biome":"latest","@vitest/coverage-v8":"latest","tsdown":"latest","vitest":"latest"}}
```

#### tsconfig.json
- รัน /setup-tsconfig

#### app.ts
```typescript
const AppLayer=Layer.mergeAll(LoggerServiceLive)
const program=Effect.gen(function*(){
  yield* log('Starting...')
  return 'done'
})
export const runApp=()=>program.pipe(Effect.provide(AppLayer))
```

#### index.ts
```typescript
export {Button} from './components/index.js'
export type {DisplayConfig} from './types/display.js'
if(import.meta.main)Effect.runPromise(runApp())
```

#### vitest.config.ts
```typescript
import {defineConfig} from 'vitest/config'
export default defineConfig({
  test:{coverage:{provider:'v8',reporter:['text','html'],threshold:{lines:90}}}
})
```

#### Testing Examples
```typescript
// Pure: utils test
test('processUsers',()=>{
  const users=[{id:'1',name:'john',age:25},{id:'2',name:'jane',age:17}]
  expect(processUsers(users)).toEqual([{id:'1',name:'JOHN',age:25}])
})

// Schema: validation test
test('ColorSchema',()=>{
  expect(Schema.decodeUnknownSync(ColorSchema)('red')).toBe('red')
  expect(()=>Schema.decodeUnknownSync(ColorSchema)('x')).toThrow()
})

// Effect: mock test
const TestLogger=Layer.succeed(LoggerService,{log:()=>Effect.void})
test('logger',async()=>{
  const p=Effect.gen(function*(){yield* LoggerService;return 'ok'})
  expect(await Effect.runPromise(p.pipe(Effect.provide(TestLogger)))).toBe('ok')
})
```



