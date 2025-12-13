---
description: Follow Nuxt module best practices
auto_execution_mode: 3
---

1. ให้มี folder structure ตามนี้คือ

1. /follow-tsdown
2. /follow-gitignore
3. /follow-oxlint
4. /follow-release-it
5. /follow-vitest




- tsdown.config.ts
- .gitignore
- package.json
- README.md
- examples/
- src/
  - runtime
  - module.ts


2. ใน package.json


``` ts
{
  "name": "name",
  "version": "1.0.0",
  "description": "My new Nuxt module",
  "repository": "your-org/my-module",
  "license": "MIT",
  "type": "module",
  "scripts": {
    "prepack": "nuxt-module-build build",
    "dev": "npm run dev:prepare && nuxi dev playground",
    "build": "tsdown",
    "release": "release-it",
    "lint": "bunx vue tsc-noEmit && oxlint --fix",
    "test": "vitest run",
    "test:watch": "vitest watch"
  },
  "dependencies": {
    "@nuxt/kit": "^4.2.2"
  },
  "devDependencies": {
    "@nuxt/devtools": "^3.1.1",
    "@nuxt/module-builder": "^1.0.2",
    "@nuxt/schema": "^4.2.2",
    "@nuxt/test-utils": "^3.21.0",
    "@types/node": "latest",
    "changelogen": "^0.6.2",
    "nuxt": "^4.2.2",
    "typescript": "~5.9.3",
    "vitest": "^4.0.15",
    "vue-tsc": "^3.1.7"
  }
}

```