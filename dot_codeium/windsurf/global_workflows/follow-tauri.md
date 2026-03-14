---
description: ตั้งค่าและพัฒนา Desktop Applications ด้วย Tauri
title: follow-tauri
---

## Objective

ตั้งค่าและพัฒนา Desktop Applications ด้วย Tauri ร่วมกับ frontend frameworks ต่างๆ

## Scope

- ติดตั้ง Tauri และ dependencies ที่จำเป็น
- ตั้งค่า Tauri กับ frontend frameworks (Vite, Nuxt)
- สร้าง desktop application ด้วย web technologies
- ตั้งค่า configuration files สำหรับ development และ production

## Preconditions

- มี Rust ติดตั้งแล้ว
- เลือก frontend framework ที่จะใช้ (Vite, Nuxt)
- ทำตาม workflow ของ frontend framework ที่เลือกก่อน

## Execution

### 1. Create Tauri Project

สร้างโปรเจกต์ Tauri ใหม่:

```bash
bun create tauri-app
```

หรือใช้ command อื่น:
- npm: `npm create tauri-app@latest`
- yarn: `yarn create tauri-app`
- pnpm: `pnpm create tauri-app`
- cargo: `cargo create-tauri-app`

### 2. Install Dependencies

ติดตั้ง Tauri API สำหรับ frontend:

```bash
bun add @tauri-apps/api
```

ติดตั้ง Tauri CLI:

```bash
bun add -D @tauri-apps/cli
```

### 3. Configure Tauri with Frontend

เลือก framework ที่ใช้:

#### Tauri + Vite

##### Configure Vite

สร้าง/แก้ไข `vite.config.ts`:

```ts
import { defineConfig } from 'vite'

const host = process.env.TAURI_DEV_HOST

export default defineConfig({
  // prevent vite from obscuring rust errors
  clearScreen: false,
  server: {
    // make sure this port matches the devUrl port in tauri.conf.json file
    port: 5173,
    // Tauri expects a fixed port, fail if that port is not available
    strictPort: true,
    // if the host Tauri is expecting is set, use it
    host: host || false,
    hmr: host
      ? {
          protocol: 'ws',
          host,
          port: 1421,
        }
      : undefined,
    watch: {
      // tell vite to ignore watching `src-tauri`
      ignored: ['**/src-tauri/**'],
    },
  },
  // Env variables starting with the item of `envPrefix` will be exposed in tauri's source code through `import.meta.env`.
  envPrefix: ['VITE_', 'TAURI_ENV_*'],
  build: {
    // Tauri uses Chromium on Windows and WebKit on macOS and Linux
    target:
      process.env.TAURI_ENV_PLATFORM == 'windows'
        ? 'chrome105'
        : 'safari13',
    // don't minify for debug builds
    minify: !process.env.TAURI_ENV_DEBUG ? 'esbuild' : false,
    // produce sourcemaps for debug builds
    sourcemap: !!process.env.TAURI_ENV_DEBUG,
  },
})
```

##### Configure Tauri

สร้าง/แก้ไข `src-tauri/tauri.conf.json`:

```json
{
  "build": {
    "beforeDevCommand": "bun run dev",
    "beforeBuildCommand": "bun run build",
    "devUrl": "http://localhost:5173",
    "frontendDist": "../dist"
  }
}
```

#### Tauri + Nuxt

##### Configure Nuxt

สร้าง/แก้ไข `nuxt.config.ts`:

```ts
export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  // (optional) Enable the Nuxt devtools
  devtools: { enabled: true },
  // Enable SSG
  ssr: false,
  // Enables the development server to be discoverable by other devices when running on iOS physical devices
  devServer: {
    host: '0',
  },
  vite: {
    // Better support for Tauri CLI output
    clearScreen: false,
    // Enable environment variables
    envPrefix: ['VITE_', 'TAURI_'],
    server: {
      // Tauri requires a consistent port
      strictPort: true,
    },
  },
  // Avoids error [unhandledRejection] EMFILE: too many open files, watch
  ignore: ['**/src-tauri/**'],
})
```

##### Configure Tauri

สร้าง/แก้ไข `src-tauri/tauri.conf.json`:

```json
{
  "build": {
    "beforeDevCommand": "bun run dev",
    "beforeBuildCommand": "bun run generate",
    "devUrl": "http://localhost:3000",
    "frontendDist": "../dist"
  }
}
```

### 4. Update Package.json Scripts

เพิ่ม scripts ใน `package.json`:

```json
{
  "scripts": {
    "dev": "vite", // หรือ "nuxt dev" สำหรับ Nuxt
    "build": "vite build", // หรือ "nuxt generate" สำหรับ Nuxt
    "tauri:dev": "tauri dev",
    "tauri:build": "tauri build"
  }
}
```

### 5. Development

รัน development mode:

```bash
bun run tauri:dev
```

ครั้งแรกอาจใช้เวลาสักครู่เพื่อ download และ build Rust dependencies

### 6. Using Tauri APIs

ใช้งาน Tauri APIs ใน frontend:

```ts
import { invoke } from '@tauri-apps/api/tauri'
import { open } from '@tauri-apps/api/shell'
import { writeTextFile, readTextFile } from '@tauri-apps/api/fs'

// เรียกใช้ Rust functions
const result = await invoke('my_custom_command', { param: 'value' })

// เปิด URL
await open('https://tauri.app')

// เขียนไฟล์
await writeTextFile('file.txt', 'Hello Tauri!')

// อ่านไฟล์
const content = await readTextFile('file.txt')
```

### 7. Build for Production

สร้าง executable สำหรับ production:

```bash
bun run tauri:build
```

Output จะอยู่ใน `src-tauri/target/release/bundle/`

## Validation

ตรวจสอบการตั้งค่า:

### Development Test
- รัน `bun run tauri:dev` และตรวจสอบว่า app เปิดขึ้นมา
- ทดสอบการใช้ Tauri APIs ใน frontend
- ตรวจสอบว่า hot reload ทำงาน

### Production Build
- รัน `bun run tauri:build` และตรวจสอบว่าสร้าง executable ได้
- ทดสอบรัน executable ที่สร้างขึ้น
- ตรวจสอบขนาดไฟล์และ performance

### Debug Tools
- เปิด Developer Tools ด้วย `Ctrl+Shift+I` (Windows/Linux) หรือ `Cmd+Option+I` (macOS)
- ตรวจสอบ console สำหรับ errors
- ใช้ Rust debugger สำหรับ backend logic
