---
auto_execution_mode: 3
---


1. package.json 

``` json [package.json]
{
  "name": "",     // @ai ชื่อให้ตรงกับ folder
  "packageManager": "", // @ai ใช้ bun upgrade && bun -v และกำหนด version ล่าสุด
  "type": "module",
  "scripts": {
    "start" : "bun --watch dev"
    "prepare" : "lefthook install",
    "postinstall" : "taze -w -r -i", 
    "dev": "bun run src/index.ts", 
    "lint": "tsc --noEmit && biome lint --write",
    "build": "bun build",
    "format": "biome format --write", 
    "test": "bun test",
    "verify" : "bun format && bun lint && bun test && bun audit && run build"
  },

```

หมายเหตุ

- ถ้าใช้ monorepo แล้ว ไม่ต้องมี lefthook, taze ที่ workspace

2. tsconfig.json

``` json
 "compilerOptions": {
    "types": [ "@types/bun"]
  }
```

3. /follow-bun-functional-programming






