---
trigger: manual
description: "ทำการ release package ไปยัง npm"
instruction:
  - ตั้งค่า package.json ให้ถูกต้อง
  - ทำตาม /follow-release-it
  - รัน release จนกว่าจะผ่าน
---


## 1. Package Configuration (ใช้เสมอ)

1.1. ตรวจสอบว่า package.json มีข้อมูลต่อไปนี้อย่างน้อย


``` json [package.json]
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
      "prerelease" : "bun run verfiy",
      "release" : "" // @ai follow-release-it
   }
}
```

## 2. Release-it Setup (ใช้เสมอ)

2.1. ทำ /follow-release-it

## 3. Running Release (ใช้เสมอ)

3.1. รัน release script
   - bun run release

3.2. ถ้า release ไม่สำเร็จ ให้ทำข้อ 3.1 ใหม่จนกว่าจะผ่าน

---

## หมายเหตุ (ใช้เสมอ)

1. ตรวจสอบว่า package.json มีข้อมูลครบถ้วนก่อน release
2. ตรวจสอบว่ามีสิทธิ์ publish ไปยัง npm
