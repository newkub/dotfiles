---
trigger: always_on
---
 
 
 
 
 
 
## for nuxt

1. package.json

ที่ต้องกำหนดแค่นี้ และที่เหลือตาม /follow-nuxt

``` json [package.json]
{
  "name": "desktop",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "nuxt dev"
  },
  "dependencies": {
    "@tauri-apps/api": "^2.9.1"
  },
  "devDependencies": {
    "@tauri-apps/cli": "^2.9.6"
  }
}
```

2. nuxt.config.json

``` ts [nuxt.config.ts]
import tauri from 'vite-plugin-tauri'

export default defineNuxtConfig({
  devServer: {
    host: '0.0.0.0',
  },
  vite: {
    plugins: [
      tauri(),
    ],
  },

```

## for vite

1. vite.config.json

``` ts [vite.config.ts]
import { defineConfig } from "vite";
import tauri from "vite-plugin-tauri";

export default defineConfig({
  plugins: [
    tauri(),
  ],

});
