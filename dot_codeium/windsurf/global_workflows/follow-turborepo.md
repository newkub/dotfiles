---
description: Guidelines for setting up a Turborepo project
auto_execution_mode: 3
---

ทำ 3 ข้อนี้

## 1. package.json

- ให้มี name, version, private, packageManager, workspaces, scripts, etc. โดย scripts ต้องมีด้านล่างเป็นอย่างนี้
{
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "lint": "turbo lint",
    "format": "turbo format",
    "test": "turbo test",
    "update:deps": "taze -r -w && ni ",
    "review": "bun update:deps && bun format && bun lint && bun test && bun build"
  },
}

## 2. turbo.json

- ให้มี schema, tasks โดย tasks ให้มีตาม scripts ใน package.json

## 3. แต่ละ workspaces ต้องมี 

- scripts ที่ตรงกับ scripts ที่ root ที่เป็น turbo
- test/ สำหรับ vitest
- README.md
- tsconfig.json ที่ extends มาจาก root
- biome.json ที่มีแค่ root : true, extends : "//"
- ต้องการ examples

## 4. .gitignore ต้องมี .gitignore ที่ root

## 5. ที่ README.md ที่ root ให้มีไฟล์ แต่ไม่ต้องเขียนอะไร ให้ว่างไว้

