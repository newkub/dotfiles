---
description: Follow ast-grep setup by installing CLI and downloading config
auto_execution_mode: 3
---

1. bun i -d @ast-grep/cli 
2. git submodule add https://github.com/newkub/my-config/blob/main/sgconfig.yml
3. gh download https://github.com/newkub/my-config/blob/main/sgconfig.yml
4. กำหนดใน package.json ว่า scan : "sg scan -r"

