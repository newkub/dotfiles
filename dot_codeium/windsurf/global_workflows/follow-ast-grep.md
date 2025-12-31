---
trigger: always_on
---


- `bun i -d @ast-grep/cli`
- สร้าง `sgconfig.yml`
- `git submodule add https://github.com/newkub/rules`
- `gh download https://github.com/newkub/my-config/blob/main/sgconfig.yml`
- กำหนดใน `package.json`

```json [package.json]
{
  "scripts": {
    "scan": "ast-grep scan -r"
  }
}

```
