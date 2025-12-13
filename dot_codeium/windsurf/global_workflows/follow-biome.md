---
description: Follow Biome configuration for root and workspace packages
auto_execution_mode: 3
---

1. bun add -d @biomejs/biome
2. กำหนดใน package.json

``` json
{
   "scripts": {
      "lint" : "biome lint --write",
      "format" : "biome format --write"
   }
}
```

3. gh download gh download https://github.com/newkub/my-config/blob/main/biome.json

4. ถ้าเป็น monorepo ใน workspace ต่างๆให้กำหนดอย่างนี้

``` json
{
   "root": false,
   "extends": "//",
}
```
