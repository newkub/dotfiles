---
description: Follow Biome configuration for root and workspace packages
auto_execution_mode: 3
---

1. ลองดูใน package.json root ให้กำหนดตามนี้

{
  "$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
  "vcs": {
    "enabled": true,
    "clientKind": "git",
    "useIgnoreFile": true
  },
  "assist": {
    "enabled": true,
    "actions": {
      "source": {
        "organizeImports": "on",
        "useSortedAttributes": "on",
        "useSortedKeys": "on",
        "useSortedProperties": "on"
      }
    }
  },
  "files": {
    "includes": [
      "./**/*.js",
      "./**/*.jsx",
      "./**/*.ts",
      "./**/*.tsx",
      "./**/*.vue",
      "./**/*.vue-jsx",
      "./**/*.svelte",
      "./**/*.html",
      "./**/*.css",
      "./**/*.json",
      "./**/*.jsonc",
      "./**/*.md",
      "./**/*.mdx"
    ],
    "ignoreUnknown": true
  },
  "formatter": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true 
    },
    "domains": {
      "project": "recommended",
      "test": "recommended",
      "vue": "recommended"
    }
  }
}

2. ถ้าเป็น monorepo แต่ละ workspace ให้กำหนดแค่ 

{
   "root": false,
   "extends": "//",
}


3. ดูว่าแต่ละ workspace เป็นตามข้อ 2 ไหม ต้องไม่ใช้ให้ใช้ /use-scripts เพื่อดำเนินการ

