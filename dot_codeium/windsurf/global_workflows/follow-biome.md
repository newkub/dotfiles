---
description: ตั้งค่า Biome
title: follow-biome
---

## 1. ติดตั้ง

1. ติดตั้ง Biome CLI ผ่าน Bun
   - ใช้ dev dependency

## 2. กำหนดค่า

1. เพิ่ม scripts ใน `package.json`
   - `lint` สำหรับตรวจสอบและแก้ไข
   - `format` สำหรับจัดรูปแบบ

```json [package.json]
{
    "scripts": {
       "lint" : "biome lint --write",
       "format" : "biome format --write"
    }
}
```

2. สร้างไฟล์ `biome.jsonc`
   - ใช้ค่า default พื้นฐาน

```json [biome.jsonc]
{
	"$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
	"vcs": {
		"enabled": true,
		"clientKind": "git",
		"useIgnoreFile": true
	},
	"assist": {
		"enabled": true
	},
	"formatter": {
		"enabled": true
	},
	"linter": {
		"enabled": true,
		"rules": {
			"recommended": true
		}
	}
}
```

## 3. จัดการ monorepo

1. กำหนดค่าใน workspace ต่างๆ
   - ตั้ง `root: false`
   - extends จาก root config

```json [biome.jsonc]
{
   "root": false,
   "extends": "//",
}
```
