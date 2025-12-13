---
description: Guidelines for package.json in a monorepo (root and workspaces)
auto_execution_mode: 3
---



## package.json

ถ้าเป็น package

- /follow-tsdown
- /follow-build-package
- /follow-release-it

ถ้าเป็น turborepo
- /follow-turborepo

ทุก project
- /follow-node-module-inspector
- /follow-unocss
- /follow-lefthook
- /run-prepare

ถ้าเป็น nuxt,vue
- /follow-unocss
- /follow-nuxt
- /follow-pinia
- /follow-vitest

ถ้าเป็น vite
- /follow-vite

ถ้าเป็น next
- /follow-next





## package.json in root


ต้องมีสิงเหล่านี้เป็นอย่างน้อย โดยมีหมายเหตุคือ 
- ต้workspace ต้องตรงกับ folder ที่สร้าง
- packageManager เช็ค bun -v เพื่อใช้ bun lastest version
- ติดตั้ง dependencies ตาม scripts ด้วย
- /follow-turborepo 

{
  "name": "tui",
  "type": "module",
  "packageManager": "bun@1.3.1",
  "workspace": [
    "examples/*",
    "packages/*"
  ],
  "scripts": {
    "dev": "turbo dev",
    "build": "turbo build",
    "lint": "turbo lint",
    "format": "turbo review",
    "test": "turbo test",
    "update:deps": "bunx taze -r -w && ni",
    "review": "bun update:deps && turbo format && turbo lint && turbo test"
  },



## package.json in workspace

ต้องมีสิงเหล่านี้เป็นอย่างน้อย โดยมีหมายเหตุคือ 

- ไม่ต้องมี packageManager
- ไม่ต้องมี workspace
- ให้มี script ตาม package.json root แต่ใช้ bun run

{
  "name": "tui",
  "type": "module",
  "scripts": {
    "dev": "",
    "build": "",
    "lint": ",
    "format": "",
    "test": "",
    "update:deps": "",
    "review": ""
  },

