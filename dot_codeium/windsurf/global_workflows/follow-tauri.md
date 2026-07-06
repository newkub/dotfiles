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

แก้ไข `vite.config.ts` ให้ port 5173, ignore `src-tauri/`, envPrefix `VITE_`, `TAURI_`

### 4. Configure Tauri

แก้ไข `src-tauri/tauri.conf.json`: ตั้ง `productName`, `identifier`, `devUrl: http://localhost:5173`, `beforeDevCommand: bun run dev`, `beforeBuildCommand: bun run build`

กำหนด capabilities ใน `src-tauri/capabilities/default.json`: `["core:default", "fs:allow-read-file", "dialog:allow-open"]`

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

### 6. Add Plugins

ติดตั้ง official plugins ด้วย Tauri CLI:

```bash
bun run tauri add <plugin-name>
```

ติดตั้ง community plugins ด้วย:

```bash
bun add @tauri-apps/plugin-<plugin-name>
```

**Official Plugins (30+):** autostart, barcode-scanner, biometric, cli, clipboard-manager, deep-link, dialog, fs, geolocation, global-shortcut, haptics, http, localhost, log, nfc, notification, opener, os, persisted-scope, positioner, process, shell, single-instance, sql, store, stronghold, updater, upload, websocket, window-state

**Community Plugins (40+):** tauri-plugin-blec, tauri-plugin-cache, tauri-plugin-context-menu, tauri-plugin-device-info, tauri-plugin-graphql, tauri-plugin-iap, tauri-plugin-in-app-review, tauri-plugin-ios-photos, tauri-plugin-js, tauri-plugin-keep-screen-on, tauri-plugin-macos-permissions, tauri-plugin-mobile-sharetarget, tauri-plugin-mqtt, tauri-plugin-network, tauri-plugin-nosleep, tauri-plugin-ota, tauri-plugin-pinia, tauri-plugin-prevent-default, tauri-plugin-python, tauri-plugin-screenshots, tauri-plugin-serialport, tauri-plugin-sharesheet, tauri-plugin-svelte, tauri-plugin-system-info, tauri-plugin-tcp, tauri-plugin-theme, tauri-plugin-thermal-printer, tauri-plugin-tracing, tauri-plugin-udp, tauri-plugin-velesdb, tauri-plugin-view, taurpc

### 7. Build And Test

1. Development mode: `bun run tauri dev`
2. Production build: `bun run tauri build`
3. Platform specific: `bun run tauri build --target x86_64-apple-darwin`

## Rules

### Frontmatter

- title: Title Case
- description: ไม่เกิน 100 ตัวอักษร
- auto_execution_mode: 3
related_workflows:

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

