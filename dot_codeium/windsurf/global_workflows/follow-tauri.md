---
title: Follow Tauri
description: ตั้งค่าและพัฒนา Desktop Applications ด้วย Tauri ร่วมกับ frontend frameworks
auto_execution_mode: 3
file-patterns:
  - "src-tauri/**/*.rs"
  - "tauri.conf.json"
  - "vite.config.ts"
follow:
  skills:
    - "@write-markdown"
  workflows:
    - "/validate"
    - "/connect-workflows"
---

## Purpose

ตั้งค่า Tauri สำหรับสร้าง Desktop Applications ด้วย web technologies (HTML, CSS, JS) และ Rust backend

## Scope

- ติดตั้ง Tauri และ dependencies
- กำหนดค่า Tauri กับ frontend frameworks (Vite, Nuxt)
- สร้าง desktop application ด้วย web technologies
- ตั้งค่า configuration files สำหรับ development และ production

## Inputs

| Input | Details |
|-------|-----------|
| Runtime | Bun + Rust |
| Frontend | Vite, Nuxt, หรืออื่นๆ |
| OS | Windows, macOS, Linux |

## Rules

| Category | Requirements |
|------|---------|
| **Frontend** | ทำตาม workflow ของ framework ที่เลือกก่อน |
| **Tauri API** | ติดตั้ง `@tauri-apps/api` |
| **CLI** | ติดตั้ง `@tauri-apps/cli` เป็น dev dependency |
| **Port** | Vite port ต้องตรงกับ tauri.conf.json |
| **Watch** | ต้อง ignore `src-tauri/` ใน Vite config |

## Structure

### Directory Structure

```text
project/
├── src-tauri/            # Rust backend
│   ├── Cargo.toml
│   ├── tauri.conf.json
│   └── src/
├── src/                  # Frontend source
├── vite.config.ts        # Vite config (ถ้าใช้ Vite)
└── package.json
```

### Phase Definitions

| Phase | Description | Main Activities |
|-------|-------------|---------------|
| Setup | สร้างโปรเจกต์ | Create tauri-app |
| Install | ติดตั้ง dependencies | Tauri API, CLI |
| Configure | กำหนดค่า | Vite + Tauri config |
| Develop | พัฒนา | Run dev server |
| Build | Build | Production build |

## Steps

### Phase 0: Precondition

- 0.1 **ตรวจสอบ Environment**
  - มี Rust ติดตั้งแล้ว (`rustc --version`)
  - มี Bun ติดตั้งแล้ว
  - เลือก frontend framework ที่จะใช้

### Phase 1: Setup

- 1.1 **สร้าง Tauri Project**
  - รัน `bun create tauri-app`
  - เลือก frontend framework ที่ต้องการ

### Phase 2: Install

- 2.1 **ติดตั้ง Tauri API**
  - รัน `bun add @tauri-apps/api`

- 2.2 **ติดตั้ง Tauri CLI**
  - รัน `bun add -D @tauri-apps/cli`

### Phase 3: Configure

- 3.1 **กำหนดค่า Vite** (ถ้าใช้ Vite)
  - แก้ไข `vite.config.ts`:

```ts [vite.config.ts]
import { defineConfig } from 'vite'

const host = process.env.TAURI_DEV_HOST

export default defineConfig({
  clearScreen: false,
  server: {
    port: 5173,
    strictPort: true,
    host: host || false,
    hmr: host
      ? {
          protocol: 'ws',
          host,
          port: 1421,
        }
      : undefined,
    watch: {
      ignored: ['**/src-tauri/**'],
    },
  },
  envPrefix: ['VITE_', 'TAURI_'],
})
```

### Phase 4: Develop

- 4.1 **รัน Development Server**
  - รัน `bun run tauri dev`
  - ตรวจสอบ app ทำงานได้

### Phase 5: Build

- 5.1 **Build Production**
  - รัน `bun run tauri build`
  - ตรวจสอบ binaries ใน `src-tauri/target/`

## Outputs

| Output | Details |
|--------|-----------|
| src-tauri/ | Rust backend code |
| Desktop App | Executables สำหรับ Windows/macOS/Linux |
| Config files | tauri.conf.json, vite.config.ts |

## Expected Outcome

- Tauri project สร้างสำเร็จ
- Dev server ทำงานได้
- Frontend และ Rust backend เชื่อมต่อกันได้
- Production build สร้าง executables ได้

## Reference

- `/validate` - ตรวจสอบความถูกต้องก่อนเริ่ม
- `/follow-vite` - ถ้าใช้ Vite
- `/follow-nuxt` - ถ้าใช้ Nuxt
- `/connect-workflows` - เชื่อมโยง workflows
