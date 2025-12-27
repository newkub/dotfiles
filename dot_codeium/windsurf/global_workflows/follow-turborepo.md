---
auto_execution_mode: 3
---



1. bunx turbo link --yes
2. package.json (root)


``` json [package.json]
{
  "name" : "",        // @ai name ให้มีแค่ชือ่ folder ไม่ต้องมี @
  "packageManager" : "bun@", // @ai ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "globalConcurrency": 32,
  "scripts": {
    "start" : "turbo watch verify",
    "postinstall" : "bunx taze -r -w -i",
    "prepare": "bunx lefthook install",
    "dev": "turbo dev --ui=tui",
    "lint": "turbo lint",
    "test": "turbo test",
    "build": "turbo build",
    "verify": "turbo verify",
    "format": "turbo format"
  },
}
```


3. turbo.json

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
      "dependsOn": ["^format"]
    },
    "test": {
      "dependsOn": ["^lint"]
    },
    "build": {
      "dependsOn": ["^lint", "^test"],
      "outputs": [".output/**", "target/release/**", "dist/**"]
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

- /follow-package.json
- กำหนด name ให้ตรงกับ folder
- แต่ละ package.json กำหนด task ให้ตรงกับ scripts ที่มี turbo ใน package.json (root) 
- ทุก workspace ต้องมี package.json, README.md, .gitignore
- packages/ ต้องมี examples/, test/

5. .gitignore

- เพิ่ม .turbo ใน .gitignore





