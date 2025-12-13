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


- ให้มี schema, tasks โดย tasks ให้มีตาม scripts ใน package.json

## 3. workspaces


1. /follow-setup-base-project
2. ใน package.json 
- มี name ที่ตรงกับ folder
- มี scripts ที่ตรงกับ turbo ใน package.json (root)
3. /follow-build-package


