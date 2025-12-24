---
auto_execution_mode: 3
---


ใช้ oxlint เมื่อใช้ vite, nextjs เท่านั้น

1. bun add -d oxlint oxlint-tsgolint
2. กำหนดใน package.json 

``` json
{
   "scripts": {
      "lint" : "tsc --noEmit && oxlint --type-aware --fix",
   }
}
```

3. gh download https://github.com/newkub/my-config/blob/main/.oxlintrc.json
