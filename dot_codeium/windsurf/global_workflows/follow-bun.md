---
auto_execution_mode: 3
---


1. bun add @types/bun

2. กำหนดใน package.json

``` json
{
	"packageManager": "", // ใช้ bun upgrade && bun -v เพื่อใช้ version ล่าสุดเสมอ
    "scripts": {
        "lint" : "biome lint --write",
        "format" : "biome format --write"
    }
}
```

3. กำหนดใน tsconfig.json 

``` json
 "compilerOptions": {
    "types": [ "@types/bun"]
  }
```




