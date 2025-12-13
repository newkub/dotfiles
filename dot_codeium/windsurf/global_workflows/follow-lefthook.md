---
description: Install lefthook and download its configuration
auto_execution_mode: 3
---

1. bun i -d lefthook
2. กำหนด ใน package.json


``` json
{
  "scripts": {
    "prepare": "lefthook install", 
  },
```

3. รัน gh download https://github.com/newkub/my-config/blob/main/lefthook.yml

