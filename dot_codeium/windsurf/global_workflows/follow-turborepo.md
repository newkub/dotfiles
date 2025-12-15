---
description: Guidelines for setting up a Turborepo project
auto_execution_mode: 3
---


## setup remote caching

- bunx turbo link --yes

## package.json (root)

1. bun add -d typescript @biomejs/biome lefthook taze turbo

2. scripts


``` json
{
  "name" : "repo",
  "packageManager" : "bun@", // ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
  "scripts": {
    "prepare": "lefthook install",
    "lint": "turbo lint",
    "build": "turbo build",
    "dev": "turbo dev",
    "test": "turbo test",
    "review": "turbo review",
    "format": "turbo format",
    "update:deps": "taze -r -w -i"
  },
}
```



## turbo.jsonc

``` json
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": [ // think],
  "tasks": {
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
    "lint": {},
    "test": {
      "dependsOn": ["^lint", "^build" ],
    },
    "review": {},
     "preview": {
      "dependsOn": ["^build"],
    },
   

  }
}
```

## workspace

- name ใน package.json ต้องตั้งเช่น name:"repo/workspace"
- /follow-package-json ทำให้เหมาะสม



