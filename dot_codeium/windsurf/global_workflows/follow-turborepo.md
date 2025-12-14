---
description: Guidelines for setting up a Turborepo project
auto_execution_mode: 3
---


## 1. install

1. bunx turbo link --yes

## 2. root

2. กำหนดใน package.json


``` json [package.json (root)]
{
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "lint": "turbo lint",
    "format": "turbo format",
    "test": "turbo test",
    "update:deps": "taze -r -w && ni ",
    "review": "bun update:deps && bun format && bun lint && bun test && bun build"
  },
}
```

3. กำหนดใน turbo.json

- ให้มี config เหล่านี้เป็นอย่างน้อย
- ที่ tasks กำหนดให้ตรงกับ scripts ใน package.json 
     

``` json
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "stream",
  "globalDependencies": [
    // ปรับเปลี่ยนเพิ่มได้
    "**/.env.*local",
    "**/nuxt.config.*",
    "**/app.config.*",
    "**/tailwind.config.*",
    "**/uno.config.*"
  ],
  "tasks": {
    "format": {
      "dependsOn": [],
      "cache" : true
    },
    "lint": {
      "dependsOn": ["^build"],
      "cache": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "build": {
      "dependsOn": ["^build"],
      "cache": true
    },
    
    "test": {
      "dependsOn": ["^build"],
      "cache" : true
    },
     "preview": {
      "dependsOn": ["^build"],
      "otputs": [],
      "cache": false
    },
   

  }
}
```



## 3. workspaces


1. /follow-setup-project
2. /follow-build-package


