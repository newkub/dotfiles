---
title: Create Tauri Desktop Applications
description: สร้าง Desktop Applications ด้วย Tauri, Vite, React และ Rust backend
auto_execution_mode: 3
---

## Goal

สร้าง Tauri desktop application ที่ใช้ web frontend (Vite + React) ร่วมกับ Rust backend สำหรับ cross-platform desktop apps

## Execute

### 1. Setup Environment

1. ตรวจสอบ Rust ติดตั้งแล้ว: `rustc --version`
2. ตรวจสอบ Bun ติดตั้งแล้ว: `bun --version`
3. ยืนยัน WebView2 บน Windows (ติดตั้งอัตโนมัติตอน run ครั้งแรก)

### 2. Install Dependencies

1. รัน `bun install`
2. ติดตั้ง Tauri API: `bun add @tauri-apps/api`
3. ติดตั้ง Tauri CLI: `bun add -D @tauri-apps/cli`

### 3. Configure Vite

แก้ไข `vite.config.ts`:

```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

const host = process.env.TAURI_DEV_HOST

export default defineConfig({
  plugins: [react()],
  clearScreen: false,
  server: {
    port: 5173,
    strictPort: true,
    host: host || false,
    hmr: host ? { protocol: 'ws', host, port: 1421 } : undefined,
    watch: { ignored: ['**/src-tauri/**'] },
  },
  envPrefix: ['VITE_', 'TAURI_'],
})
```

### 4. Configure Tauri

แก้ไข `src-tauri/tauri.conf.json`:

```json
{
  "productName": "{project-name}",
  "identifier": "com.company.{project-name}",
  "build": {
    "frontendDist": "../dist",
    "devUrl": "http://localhost:5173",
    "beforeDevCommand": "bun run dev",
    "beforeBuildCommand": "bun run build"
  },
  "app": {
    "windows": [{ "title": "{project-name}", "width": 1200, "height": 800 }],
    "security": { "csp": null }
  },
  "bundle": {
    "active": true,
    "targets": "all",
    "icon": ["icons/32x32.png", "icons/128x128.png", "icons/icon.ico"]
  }
}
```

กำหนด capabilities ใน `src-tauri/capabilities/default.json`:

```json
{
  "identifier": "default",
  "permissions": ["core:default", "fs:allow-read-file", "dialog:allow-open"]
}
```

### 5. Develop IPC Commands

1. สร้าง Rust command ใน `src-tauri/src/lib.rs`:

```rust
#[tauri::command]
fn greet(name: &str) -> String {
  format!("Hello, {}!", name)
}
```

2. Register command:

```rust
tauri::Builder::default()
  .invoke_handler(tauri::generate_handler![greet])
  .run(tauri::generate_context!())
```

3. เรียกใช้จาก frontend:

```typescript
import { invoke } from '@tauri-apps/api/core'
const response = await invoke('greet', { name: 'World' })
```

### 6. Build And Test

1. Development mode: `bun run tauri dev`
2. Production build: `bun run tauri build`
3. Platform specific: `bun run tauri build --target x86_64-apple-darwin`

## Rules

### Frontmatter

- title: Title Case
- description: ไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3

### Project Structure

```
desktop-apps/{project}/
├── src/                    # Frontend
│   ├── components/
│   ├── hooks/
│   ├── App.tsx
│   └── main.tsx
├── src-tauri/              # Rust backend
│   ├── src/
│   │   ├── main.rs
│   │   └── lib.rs
│   ├── Cargo.toml
│   ├── tauri.conf.json
│   └── capabilities/
├── vite.config.ts
├── package.json
└── index.html
```

### Standards

- ใช้ `bun` สำหรับทุก commands
- Vite port ต้องตรงกับ `tauri.conf.json` (default: 5173)
- Vite ต้อง ignore `src-tauri/`
- IPC ใช้ `invoke()` สำหรับ frontend → backend
- กำหนด capabilities ใน `tauri.conf.json`

### IPC Pattern

| Direction | Method |
|-----------|--------|
| Frontend → Backend | `invoke('command', args)` |
| Backend → Frontend | Events |

## Expected Outcome

- Tauri project สร้างสำเร็จด้วย `bun create tauri-app`
- Dev server ทำงานได้ที่ `bun run tauri dev`
- Frontend และ Rust backend เชื่อมต่อกันผ่าน IPC
- Production build สร้าง executables ได้
