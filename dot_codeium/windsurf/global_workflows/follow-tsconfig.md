---
description: ตั้งค่า TypeScript config
title: follow-tsconfig
---

## 1. ตั้งค่า Module System

1. กำหนด ESNext modules
   - target: "ES2022"
   - module: "ESNext"
   - moduleResolution: "bundler"
   - lib: ["ESNext", "DOM"]

2. ติดตั้ง runtime types
   - @types/bun สำหรับ Bun
   - @types/node สำหรับ Node.js

## 2. ตั้งค่า Monorepo

1. สร้าง root tsconfig.json

```json
{
  "compilerOptions": {
    "composite": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "references": [
    { "path": "packages/core" },
    { "path": "packages/ui" }
  ]
}
```

2. สร้าง package tsconfig.json

```json
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist",
    "rootDir": "./src",
    "composite": true
  },
  "include": ["src/**/*"],
  "exclude": ["**/*.test.ts", "**/*.spec.ts", "**/*.spec.tsx"]
}
```

## 3. เปิด Type Safety

1. เปิด strict mode
   - strict: true
   - noImplicitAny: true
   - strictNullChecks: true
   - noImplicitReturns: true

2. เพิ่ม advanced checks
   - exactOptionalPropertyTypes: true
   - noUncheckedIndexedAccess: true
   - noImplicitOverride: true

## 4. ตั้งค่า Build Configs

1. สร้าง tsconfig.dev.json

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "noEmit": true,
    "incremental": true,
    "tsBuildInfoFile": ".tsbuildinfo"
  }
}
```

2. สร้าง tsconfig.build.json

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "noEmit": false,
    "declaration": true,
    "emitDeclarationOnly": true,
    "removeComments": true
  }
}
```

## 5. กำหนด Path Mapping

1. ตั้งค่า absolute imports

```json
{
  "compilerOptions": {
    "baseUrl": "./src",
    "paths": {
      "@/*": ["./*"],
      "@/components/*": ["components/*"],
      "@/utils/*": ["utils/*"],
      "@/types": ["types/index.ts"],
      "@/lib/*": ["lib/*"]
    }
  }
}
```

## 6. เพิ่ม Performance & Tooling

1. เปิด optimizations
   - isolatedModules: true
   - allowImportingTsExtensions: false

2. ตั้งค่า test config

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "noEmit": true,
    "types": ["vitest/globals", "node"]
  },
  "include": ["src/**/*", "**/*.test.ts", "**/*.spec.ts"]
}
```

## 7. ตรวจสอบและแก้ไข

1. รัน type checking
   - `tsc --noEmit` ตรวจสอบ types
   - `tsc --build` สำหรับ monorepo

2. แก้ปัญหา
   - เปิด skipLibCheck สำหรับ speed
   - ตรวจสอบ composite และ references
   - ใช้ incremental builds
