---
description: Follow these rules for Nuxt 2 project structure and data flow
auto_execution_mode: 3
---

## setup ที่ต้องมีเสมอ

1. /follow-lefthook
2. /follow-unocss
3. /follow-dprint
4. /follow-oxlint
5. /follow-lefthook
6. /run-prepare
7. /follow-cloudflare-nitro

## package.json

1. /follow-package-json
2. bun i -d vue-tsc

## nuxt.config.ts

ต้องกำหนดเหล่านี้ และติดตั้งให้ด้วย

``` ts
import checker from "vite-plugin-checker";


export default defineNuxtConfig({
	compatibilityDate: "2025-05-15",
	devtools: { enabled: true },
	modules: [
        "nuxt-mcp-dev",
		"@pinia/nuxt",
		"@unocss/nuxt",
        "@nuxt/icon",
		"@vueuse/nuxt",
		"@nuxtjs/color-mode",
        "@vue-macros/nuxt"
	],
    nitro : {
        preset: "cloudflare_module",
        cloudflare: {
            deployConfig: true,
            nodeCompat: true,
            "routes": [
            {
                "pattern": "*.wrikka.com", // กำหนด * ตามชื่อ folder
                "custom_domain": true
            }
            ]
        },
    },
    icon: {
        serverBundle: {
            collections: ['mdi'] 
            }
        },


	typescript: {
		typeCheck: true,
		strict: true,
	},
	vite : {
		 plugins: [
            checker({
                overlay: {
                    initialIsOpen: false,
                },
                typescript: true,
                vueTsc: true,
                oxlint: true,
            }),
        ],
	}
});
```

## folder structure

### components
- /follow-vue-components


### app/pages
- ใช้หรือย้ายอะไรไปใน app/components ได้บ้าง
- ใช้หรือย้ายอะไรไปใน app/composables ได้บ้าง 
- ใช้ https://vue-macros.dev/

### types/app
- มีเพื่อให้ composables ใช้เท่านั้น ถ้า pages จะใช้ ให้ใช้่ผ่าน composables ที่ติด type ไปด้วย
- สร้างให้เข้ากับ app/composables
- เขียนตาม vue compositiona api



### stores
- มีเพื่อให้ composables ใช้เท่านั้น ใช้เท่านั้น 
- ให้มีชื่อ folder ตาม composables/ แต่ไม่ต้อมี use เช่น stores/task แต่ละ folder มี index เพื่อ reexport และมี file ต่างๆแยกย่อยๆใน folder
- types ทั้งหมดย้ายไปใน app/types หรือ shared/types

### composables
- สร้างขึ้นเพื่อให้ pages, components ใช้เท่านั้น
- อะไรที่ควรทำเป็น global state ย้ายไปใน stores
- ให้มี folder ตาม pages/ แต่ละ folder มี index เพื่อ reexport เท่านั้น
- types ทั้งหมดย้ายไปใน app/types หรือ shared/types
- ใช้ server/api จริงๆ

### server/api
-  ให้มี folder ตาม composlabes/ แต่ละ folder มี index เพื่อ reexport เท่านั้น
- ใช้จาก server/db
- ทำให้ดีตามที่ควรจะเป็น และทำให้เข้ากับ @composables 

### app.config.ts
- ใน composables ควรย้ายอะไรมาใช้ app.config.ts บ้าง 

### server/db
- ให้มี server/index.ts, server/queries, server/schema
- server/db/queries => ใช้ drizzle + effect

## server/lib





