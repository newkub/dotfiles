---
title: Run Release
description: ทำการ release package ไปยัง npm
auto_execution_mode: 3
---

ทำการ release package ไปยัง npm

## Goal

Release package ไปยัง npm ด้วยการตั้งค่าที่ถูกต้อง

## Execute

### 1. Check Package Configuration

1. ตรวจสอบว่า package.json มีข้อมูลต่อไปนี้อย่างน้อย

```json
{
  "name": "",
  "description": "",
  "version": "",
  "author": "",
  "private": false,
  "publishConfig": {
    "access": "public"
  },
  "license": "",
  "repository": {
    "type": "git",
    "url": ""
  },
  "homepage": "",
  "keywords": [],
  "scripts": {
    "prerelease": "bun run verify",
    "release": ""
  }
}
```

### 2. Setup Release Tool

1. ทำ `/follow-release-it`

### 3. Run Release

1. รัน release script

- bun run release

2. ถ้า release ไม่สำเร็จ ให้ทำข้อ 1 ใหม่จนกว่าจะผ่าน

## Rules

1. ตรวจสอบว่า package.json มีข้อมูลครบถ้วนก่อน release
2. ตรวจสอบว่ามีสิทธิ์ publish ไปยัง npm
3. ใช้ bun แทน npm เสมอ

## Expected Outcome

- Package ถูก release ไปยัง npm สำเร็จ
- Version ถูก bump อัตโนมัติ
- Changelog ถูกสร้างอัตโนมัติ
- Git tags ถูกสร้างอัตโนมัติ
