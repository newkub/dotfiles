---
auto_execution_mode: 3
---



1. bunx turbo link --yes
2. /follow-package-json


3. turbo.jsonc

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


- กำหนด name ให้ตรงกับ folder
- กำหนด task ให้ตรง scripts ที่มี turbo ใน package.json (root) 
- ต้องมี examples/, test/, src/, package.json, README.md, tsconfig.json, biome.jsonc, .gitignore

5. .gitignore

- เพิ่ม .turbo ใน .gitignore





