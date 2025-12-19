---
auto_execution_mode: 3
---


## setup 

1. bunx turbo link --yes

2. package.json (root)

- bun add -d typescript @biomejs/biome lefthook taze turbo

``` json
{
  "name" : "repo",
  "packageManager" : "bun@", // ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "scripts": {
    "start" : "turbo watch check",
    "postinstall" : "taze -r -w -i",
    "prepare": "lefthook install",
    "lint": "turbo lint",
    "build": "turbo build",
    "dev": "turbo dev --ui tui",
    "test": "turbo test",
    "check": "turbo check",
    "format": "turbo format",
    "update:deps": "taze -r -w -i"
  },
}
```

3. turbo.jsonc

``` json [turbo.json]
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": // think,
  "tasks": {
     "start": {
      "cache": false,
      "persistent": true
    },
     "dev": {
      "cache": false,
      "persistent": true
    },
     "build": {
      "dependsOn": ["^lint"],
    },
    "format": {
      "dependsOn": [],
    },
    "lint": {
      "cache": true
    },
    "test": {
      "dependsOn": ["^lint", "^build" ],
    },
    "check": {},
     "check": {
      "dependsOn": ["^build"],
    }, 
  }
}
```

4. เพิ่ม .turbo ใน .gitignore

## check

- name ใน package.json ต้องตั้งเช่น name:"repo/workspace"
- /follow-package-json ทำให้เหมาะสม




