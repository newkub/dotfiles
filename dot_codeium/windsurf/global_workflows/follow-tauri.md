---
trigger: always_on
---
 

 
## tauri + nuxt

1. /follow-nuxt

2. package.json

- bun add @tauri-apps/api
- bun add @tauri-apps/cli


3. nuxt.config.json

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

## tauri + vite

1. /follow-vite

2. vite.config.json

``` ts [vite.config.ts]
import { defineConfig } from "vite";
import tauri from "vite-plugin-tauri";

export default defineConfig({
  plugins: [
    tauri(),
  ],

});
