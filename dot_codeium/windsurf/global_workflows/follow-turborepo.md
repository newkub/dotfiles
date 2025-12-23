---
auto_execution_mode: 3
---



1. bunx turbo link --yes
2. package.json (root)

``` json
{
  "name" : "",        // @ai name ให้มีแค่ชือ่ folder ไม่ต้องมี @
  "packageManager" : "bun@", // @ai ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "scripts": {
    "start" : "turbo watch verify",
    "postinstall" : "taze -r -w -i",
    "prepare": "lefthook install",
    "lint": "turbo lint",
    "build": "turbo build",
    "dev": "turbo dev",
    "test": "turbo test",
    "verify": "turbo verify",
    "format": "turbo format"
  },
}
```

3. turbo.jsonc

กำหนด task ให้ครบตรงกับใน package.json (root)

``` json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": // @ai ดูให้หนอ่ย ควรมีอะไรบ้าง,
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
      "dependsOn": ["^format"]
    },
    "build": {
      "dependsOn": ["^lint"],
      "outputs": [".output/**", "target/release/**"]
    },
    "test": {
      "dependsOn": ["^build"]
    },
    "verify": {
      "dependsOn": ["^test"]
    },
    "preview": {
      "dependsOn": ["^verify"]
    }
  }
}
```

4. package.json (workspace)


- กำหนด name ให้ตรงกับ folder
- กำหนด task ให้ตรง scripts ที่มี turbo ใน package.json (root) 
- ต้องมี examples/, test/, src/, package.json, README.md, tsconfig.json, biome.jsonc, .gitignore

5. .gitignore

- เพิ่ม .turbo ใน .gitignore





