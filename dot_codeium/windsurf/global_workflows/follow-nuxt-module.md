---
description: สร้าง Nuxt Module ใหม่
---

# สร้าง Nuxt Module ใหม่

## File Structure

```text
nuxt-modules/modules/w<module-name>/
├── src/
│   ├── module.ts
│   └── runtime/
│       ├── components/
│       ├── composables/
│       └── utils/
├── app/
│   └── app.vue
├── test/
├── package.json
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## package.json

```json
{
  "name": "@wrikka/w<module-name>",
  "version": "0.0.1",
  "description": "W<Module-Name> module for Nuxt",
  "type": "module",
  "exports": {
    ".": {
      "types": "./dist/module.d.ts",
      "import": "./dist/module.mjs",
      "require": "./dist/module.cjs"
    },
    "./runtime": {
      "import": "./src/runtime/index.ts",
      "types": "./src/runtime/index.ts"
    },
    "./runtime/*": {
      "import": "./src/runtime/*",
      "types": "./src/runtime/*"
    }
  },
  "main": "./dist/module.cjs",
  "types": "./dist/module.d.ts",
  "files": [
    "dist"
  ],
  "scripts": {
    "dev": "nuxt dev",
    "build": "nuxt-build-module",
    "format": "dprint fmt",
    "lint": "nuxt typecheck && oxlint --type-aware --fix",
    "test": "vitest",
    "test:coverage": "vitest run --coverage",
    "test:ui": "vitest --ui",
    "typecheck": "vue-tsc --noEmit",
    "prepare": "nuxt prepare",
    "prepublishOnly": "npm run build",
    "release": "release-it"
  },
  "dependencies": {
    "@nuxt/kit": "^4.3.1",
    "defu": "^6.1.4",
    "vue": "^3.5.29"
  },
  "devDependencies": {
    "@nuxt/module-builder": "^1.0.2",
    "@nuxt/test-utils": "^4.0.0",
    "vitest": "^4.0.18"
  },
  "peerDependencies": {
    "nuxt": "^4.3.1"
  },
  "overrides": {
    "vite": "npm:rolldown-vite@latest"
  }
}
```
