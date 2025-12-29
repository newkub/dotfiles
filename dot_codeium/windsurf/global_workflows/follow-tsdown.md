---
trigger: always_on
---

ใช้ tsdown กับทุก packages/

1. `bun add -d tsdown`

2. กำหนดใน `package.json`

```json [package.json]
{
  "scripts": {
    "build": "tsdown"
  }
}
```

3. `tsdown.config.ts`

```ts [tsdown.config.ts]
import type { TsDownConfig } from "tsdown";

export default defineConfig({
  dts: {
    sourcemap: true,
    vue: true // @ai กำหนดถ้าใช้ vue
  },
  exports: true,
  entry: "./src/index.ts",
  format: "esm",
  clean: true,
  minify: true,
  plugins: [],
  hooks: {}
});
```

4. กำหนดใน `tsconfig.json`

```json [tsconfig.json]
{
  "compilerOptions": {
    "isolatedDeclarations": true,
    "declarationMap": true
  }
}

```
