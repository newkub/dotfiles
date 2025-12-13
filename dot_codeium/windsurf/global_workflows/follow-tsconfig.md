
1. bun add -d typescript 
2. กำหนดใน package.json
``` json
{
   "scripts": {
      "lint" : "tsc --noEmit",
   }
}
```
3. ดูใน package.json

- ดู devpendencies, devDependencies ว่ามี type อะไรบ้าง ถ้ามี build-ins ไมต้องติดตั้ง แตถ้าไม่มีให้เพิ่ม types ใน compilerOptions ด้วย
- ถ้าใช้ nuxt => gh download https://github.com/newkub/templates/blob/main/templates/nuxt/tsconfig.json
- ถ้าใช้ next => gh download https://github.com/newkub/templates/blob/main/templates/next/tsconfig.json
