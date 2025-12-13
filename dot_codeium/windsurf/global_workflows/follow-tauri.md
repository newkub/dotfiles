1. ใช้ vue plugins tauri 
- bun i -d vite-plugin-tauri @tauri-apps/cli
- เพิ่มใน vite.config.json

``` ts
import { defineConfig } from "vite";
import tauri from "vite-plugin-tauri"; // 1. import the plugin

export default defineConfig({
  plugins: [
    tauri(), 
  ],

});
```
- สร้าง vite.config.tauri.ts
``` ts
import { defineConfig, mergeConfig } from "vite";
import baseViteConfig from "./vite.config";
import tauri from "vite-plugin-tauri";

export default defineConfig(
  mergeConfig(baseViteConfig, {
    plugins: [tauri()],

    // optional but recommended
    clearScreen: false,
    server: {
      open: false,
    },
  }),
);

```
- กำหนดใน package.json

``` json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "dev:tauri": "vite --config vite.config.tauri.js",
    "build:tauri": "vite build --config vite.config.tauri.ts",
    "preview": "vite preview"
  },
  
}

```