---
description: ตั้งค่าและใช้งาน tsdown สำหรับ bundle TypeScript libraries
title: follow-tsdown
---

## 1. Introduction

tsdown คือ library bundler ที่ออกแบบมาเพื่อความเรียบง่ายและความเร็ว พัฒนาด้วย Rolldown และ Oxc ให้ประสิทธิภาพสูงในการ bundle และสร้าง declaration files

### 1.1 Key Features

- **Blazing fast**: ใช้ Oxc และ Rolldown ในการ build และสร้าง .d.ts files
- **Powerful ecosystem**: รองรับ Rollup, Rolldown, unplugin และ Vite plugins
- **Easy to use**: มีค่าเริ่มต้นที่ชาญฉลาด พร้อมใช้งาน
- **Seamless migration**: ใช้งานร่วมกับ tsup ได้

## 2. Installation

### 2.1 Install Dependencies

ติดตั้ง tsdown เป็น dev dependency:

```bash
bun add -D tsdown
```

หากไม่ได้ใช้ `isolatedDeclarations` ต้องติดตั้ง TypeScript:

```bash
bun add -D typescript
```

### 2.2 Verify Installation

ตรวจสอบเวอร์ชัน:

```bash
bunx tsdown --version
```

## 3. Configuration

### 3.1 Basic Config

สร้างไฟล์ `tsdown.config.ts`:

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  entry: ['./src/index.ts'],
})
```

### 3.2 Advanced Config

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  dts: {
    sourcemap: true,
    vue: true // กำหนดถ้าใช้ vue
  },
  exports: true,
  entry: "./src/index.ts",
  format: "esm",
  clean: true,
  minify: true,
  plugins: [],
  hooks: {}
})
```

## 4. Package.json Setup

### 4.1 Scripts

กำหนด scripts ใน `package.json`:

```json
{
  "scripts": {
    "build": "tsdown"
  }
}
```

### 4.2 TypeScript Config

ตั้งค่า `tsconfig.json`:

```json
{
  "compilerOptions": {
    "isolatedDeclarations": true,
    "declarationMap": true
  }
}
```

## 5. Building

### 5.1 Build Command

รัน build:

```bash
bun run build
```

### 5.2 Watch Mode

ตรวจจับการเปลี่ยนแปลงและ build อัตโนมัติ:

```bash
bunx tsdown --watch
```

## 6. Output Formats

### 6.1 Available Formats

- **esm**: ECMAScript Module (default)
- **cjs**: CommonJS
- **iife**: Immediately Invoked Function Expression
- **umd**: Universal Module Definition

### 6.2 Multiple Formats

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  entry: ['./src/index.ts'],
  format: ['esm', 'cjs'],
})
```

## 7. Dependencies

### 7.1 Smart Externalization

- **dependencies**: ไม่ bundle (external)
- **peerDependencies**: ไม่ bundle (external)
- **devDependencies**: bundle ถ้าใช้งาน

### 7.2 Override Behavior

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  deps: {
    onlyBundle: ['lodash'], // bundle เฉพาะที่ระบุ
    neverBundle: ['react'], // ไม่ bundle เฉพาะที่ระบุ
    alwaysBundle: ['utils'] // bundle เสมอ
  }
})
```

## 8. Declaration Files

### 8.1 Auto-Enable

tsdown จะเปิดใช้ .d.ts generation อัตโนมัติถ้ามี `types` หรือ `typings` field ใน package.json

### 8.2 Performance Optimization

ใช้ `isolatedDeclarations` ใน tsconfig.json เพื่อประสิทธิภาพสูงสุด

## 9. Plugins

### 9.1 Using Plugins

```typescript
import { defineConfig } from 'tsdown'
import SomePlugin from 'some-plugin'

export default defineConfig({
  entry: ['./src/index.ts'],
  plugins: [SomePlugin()]
})
```

### 9.2 Supported Plugin Types

- Rolldown plugins
- Unplugin plugins
- Rollup plugins
- บางส่วนของ Vite plugins

## 10. Best Practices

### 10.1 Project Structure

```text
my-library/
├── src/
│   ├── index.ts
│   └── utils.ts
├── tsdown.config.ts
├── tsconfig.json
├── package.json
└── README.md
```

### 10.2 Entry Points

ใช้ entry points หลายจุด:

```typescript
import { defineConfig } from 'tsdown'

export default defineConfig({
  entry: {
    index: './src/index.ts',
    cli: './src/cli.ts'
  }
})
```

## 11. Migration from tsup

### 11.1 Config Changes

tsup และ tsdown มี config ที่คล้ายกัน สามารถ migrate ได้ง่าย

### 11.2 CLI Differences

- tsup: `tsup`
- tsdown: `tsdown`

Options ส่วนใหญ่เหมือนกัน

## 12. Resources

- [Official Documentation](https://tsdown.dev/)
- [GitHub Repository](https://github.com/rolldown/tsdown)
- [API Reference](https://tsdown.dev/reference/api/Interface.UserConfig)
