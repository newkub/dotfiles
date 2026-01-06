---
trigger: always_on
---

## package.json (root)

``` json [package.json]
{
  "name" : "",    // @ai ให้มีแค่ folder ไมต้องมี @ เช่น folder      
  "packageManager" : "bun@", // @ai ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "globalConcurrency": 32,
  "scripts": {
    "watch" : "turbo watch verify --ui=tui",
    "postinstall" : "taze -r -w -i",
    "prepare": "lefthook install",
    "dev": "turbo dev --ui=tui",
    "format": "turbo format",
    "scan": "sg scan -r", // @ai /follow-ast-grep
    "check:modules": "bunx node-modules-inspector",
    "lint": "turbo lint",
    "test": "turbo test",
    "build": "turbo build",
    "verify": "turbo verify"
  },
}
```



## turbo.json

กำหนด task ให้ครบตรงกับใน package.json (root)

``` json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": [], // @ai กำหนดให้เหมาะสม
  "tasks": {
    "watch": {
      "cache": false,
      "persistent": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "prepare": {
      "cache": false
    },
    "format": {
      "dependsOn": ["^prepare"]
    },
    "lint": {
      "dependsOn": ["^format"],
      "cache" : false
    },
    "test": {
      "dependsOn": ["^lint"],
      "cache" : true
    },
    "build": {
      "dependsOn": ["^lint"],
      "outputs": [],
      "cache" : false
    },
    "verify": {
      "dependsOn": ["^test"],
      "cache" : false
    },
    "preview": {
      "dependsOn": ["^verify"]
    }
  }
}
```

## package.json (workspace)

1. /follow-package.json
2. กำหนด name ให้ตรงกับ folder
3. แต่ละ package.json กำหนด task ให้ตรงกับ scripts ที่มี turbo ใน package.json (root)
4. ทุก workspace ต้องมี package.json, README.md, .gitignore และถ้าอยู่ไหน packages/ ต้องมี examples/

## .gitignore

- เพิ่ม .turbo ใน .gitignore