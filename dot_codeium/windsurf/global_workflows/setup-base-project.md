
ทำเหล่านี้ให้ครบทุกข้อ 

1. กำหนดใน package.json ตามนี้

``` json
{
  "name": "", // ต้องตรงกับชื่อ folder
  "packageManager": "bun@1.3.4",
  "type": "module",
  "scripts": {
    "prepare": "lefthook install && bun update:deps && bun format", 
    "postinstall" : "bun prepare"
    "dev": "",
    "build": "",
    "lint": "biome lint --write",
    "format": "biome format --write", 
    "scan": "sg scan -r",
    "test": "vitest",
    "update:deps": "taze -r -w -i", 
    "review" : "bun prepare && bun update:deps && bun lint && bun build && bun test"
  },
```



2. /follow-lefthook
3. /follow-biome
4. /follow-release-it (ถ้าเป็น package)
5. /follow-ast-grep
6. /follow-readme
6. /follow-tsconfig
7. /follow-gitignore

