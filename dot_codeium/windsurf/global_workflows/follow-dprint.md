---
trigger: always_on
---

- `bun add -d dprint`
- `gh download https://github.com/newkub/my-config/blob/main/dprint.json`
- กำหนด `format: "dprint fmt"` ใน `package.json`

```json [package.json]
{
  "scripts": {
    "format": "dprint fmt"
  }
}
```
