---
auto_execution_mode: 3
---

1. package.json


``` json [package.json]
{
  "name": "",     // @ai ชื่อให้ตรงกับ folder
  "packageManager": "", // @ai ใช้ bun upgrade && bun -v และกำหนด version ล่าสุด
  "type": "module",
  "scripts": {
      "watch": "bun watch -- bunx biome lint --write",
      "start": "bun --watch dev",
      "postinstall": "bunx taze -w -r -i",
      "dev": "bun run src/index.ts",
      "lint": "tsc --noEmit && biome lint --write",
      "build": "bun build",
      "format": "biome format --write",
      "test": "bun test",
      "verify": "biome format --write && bun lint && bun test && bun audit && bun run build"
  }

```

3. /follow-tsconfig-json
4. /follow-bun-best-practics






