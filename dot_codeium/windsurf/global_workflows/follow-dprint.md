---
title: Follow Dprint
description: ตั้งค่าและใช้งาน dprint สำหรับ formatting code หลายภาษาด้วย pluggable architecture
auto_execution_mode: 3
---

## Execute

1. Precondition Check

ตรวจสอบ environment ก่อนเริ่มติดตั้ง

- ตรวจสอบว่ามี Bun ติดตั้งแล้ว
- ตรวจสอบว่ามี package.json อยู่แล้ว
- ตรวจสอบว่า project มี structure ที่ถูกต้อง

2. Install Dprint

ติดตั้ง dprint ด้วย Bun

- รันคำสั่ง `bun add -D dprint` เพื่อติดตั้ง dprint เป็น dev dependency
- ตรวจสอบว่า installation สำเร็จโดยตรวจสอบ bun.lock และ package.json
- ตรวจสอบว่าสามารถรัน `dprint --version` ได้

3. Create Configuration File

สร้าง dprint.json config file

- ดาวน์โหลด config จาก reference repository ด้วย `gh download https://github.com/newkub/my-config/blob/main/dprint.json`
- หรือสร้าง dprint.json ใหม่ด้วย configuration พื้นฐาน:

```json [dprint.json]
{
  "includes": [
    "**/*.{ts,tsx,js,jsx,json,md,rs,toml,yaml,yml,css,scss,sass,less,html,vue,svelte,astro,py,go,php}"
  ],
  "excludes": [
    "**/node_modules",
    "**/dist",
    "**/.git"
  ],
  "plugins": [
    "https://plugins.dprint.dev/typescript-0.95.13.wasm",
    "https://plugins.dprint.dev/json-0.21.1.wasm",
    "https://plugins.dprint.dev/markdown-0.16.3.wasm",
    "https://plugins.dprint.dev/toml-0.5.4.wasm",
    "https://plugins.dprint.dev/pretty_yaml-0.2.0.wasm",
    "https://plugins.dprint.dev/dockerfile-0.3.1.wasm",
    "https://plugins.dprint.dev/rustfmt-0.6.2.wasm",
    "https://plugins.dprint.dev/malva-0.4.0.wasm",
    "https://plugins.dprint.dev/markup_fmt-0.7.0.wasm",
    "https://plugins.dprint.dev/ruff-0.2.0.wasm",
    "https://plugins.dprint.dev/gofmt-0.3.0.wasm",
    "https://plugins.dprint.dev/mago-0.1.0.wasm"
  ]
}
```

- ตรวจสอบว่า dprint.json ถูกสร้างขึ้นอย่างถูกต้อง
- ปรับแต่ง configuration ตามความต้องการของ project (ถ้าจำเป็น)

4. Add Format Scripts

เพิ่ม scripts ใน package.json

- เพิ่ม script `format` สำหรับ format files อัตโนมัติ

```json [package.json]
{
  "scripts": {
    "format": "dprint fmt"
  }
}
```

- ตรวจสอบว่า scripts ถูกเพิ่มเข้าไปใน package.json อย่างถูกต้อง
- ตรวจสอบว่าไม่มี conflict กับ scripts ที่มีอยู่แล้ว

5. Verify Installation

ทดสอบการทำงานของ dprint

- รัน `bun run format` เพื่อ format files ทั้งหมด
- ตรวจสอบว่า dprint ทำงานได้ถูกต้องกับทุก file types ที่ระบุ
- ตรวจสอบว่า plugins ถูก download และใช้งานได้

## Rules

ต้องปฏิบัติตามกฏและข้อกำหนดเหล่านี้เสมอ

- ต้องใช้ Bun เป็น package manager เสมอสำหรับการติดตั้ง dprint
- ต้องติดตั้ง dprint เป็น dev dependency เสมอด้วย flag -D
- ต้องดาวน์โหลด config จาก reference repository ก่อน ถ้ามี
- ต้องระบุ plugins สำหรับทุกภาษาที่ต้องการรองรับ
- ต้องกำหนด excludes patterns สำหรับ node_modules, dist, .git เสมอ
- ต้องเพิ่ม format script ใน package.json
- ต้องใช้ indentWidth: 2 สำหรับ TypeScript และ JSON
- ต้องใช้ lineWidth: 100 สำหรับ TypeScript
- ต้องใช้ quoteStyle: alwaysSingle สำหรับ TypeScript
- ต้องใช้ semiColons: asi สำหรับ TypeScript
