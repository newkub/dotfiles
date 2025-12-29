---
trigger: always_on
---

## package.json (root)

``` json [package.json]
{
  "name" : "",        // @ai เช่น @project/workspace
  "packageManager" : "bun@", // @ai ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "globalConcurrency": 32,
  "scripts": {
    "start" : "turbo watch verify",
    "postinstall" : "taze -r -w -i",
    "prepare": "lefthook install",
    "dev": "turbo dev --ui=tui",
    "format": "turbo format",
    "scan": "sg scan -r",
    "check:modules": "bunx node-modules-inspector",
    "lint": "turbo lint",
    "test": "turbo test",
    "build": "turbo build",
    "verify": "turbo verify",
    "clean" : "bunx rimraf */bun.lockb */node_modules"
  },
}
```

## turbo.json

กำหนด task ให้ครบตรงกับใน package.json (root)

``` json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies" // @ai กำหนดให้หน่อย
  "concurrency": "32",
  "tasks": {
    "start": {
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

- /follow-package.json
- กำหนด name ให้ตรงกับ folder
- แต่ละ package.json กำหนด task ให้ตรงกับ scripts ที่มี turbo ใน package.json (root)
- ทุก workspace ต้องมี package.json, README.md, .gitignore
- packages/ ต้องมี examples/, test/

## .gitignore

- เพิ่ม .turbo ใน .gitignore
