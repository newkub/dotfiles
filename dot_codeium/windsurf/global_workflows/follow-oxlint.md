---
trigger: always_on
---


- ใช้ `oxlint` เมื่อใช้ vite, nextjs เท่านั้น
- `bun add -d oxlint oxlint-tsgolint`
- กำหนดใน `package.json`

```json [package.json]
{
  "scripts": {
    "lint": "oxlint --type-aware --fix"
  }
}
```

- `gh download https://github.com/newkub/my-config/blob/main/.oxlintrc.json`
