1. bun add wrangler

2. wrangler.jsonc


``` json [wrangler.jsonc]
{
  "$schema": "./node_modules/wrangler/config-schema.json",
  "routes": [
    {
      "pattern": "*.wrikka.com", // กำหนด * ตามชื่อ folder
      "custom_domain": true
    }
  ]
}
```

