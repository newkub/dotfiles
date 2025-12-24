---
auto_execution_mode: 3
---



## 1. Nuxt4 Folder Structure

- ให้สร้าง folder ต่างรอไว้เลย

```
my-nuxt-app/
├── app/                    # โค้ดฝั่ง Client ทั้งหมด
│   ├── assets/             # Assets ที่จะถูกประมวลผลโดย build tool (เช่น CSS, Fonts)
│   ├── components/         # Vue components ที่ใช้ซ้ำ (auto-imported)
│   ├── composables/        # ฟังก์ชันที่ใช้ซ้ำ (auto-imported)
│   ├── layouts/            # โครงสร้างหลักของหน้าเว็บ
│   ├── middleware/         # โค้ดที่ทำงานก่อนจะ render หน้า (auto-imported)
│   ├── pages/              # หน้าเว็บและ routing (file-based)
│   ├── plugins/            # Plugins ที่จะถูกโหลดเมื่อ Nuxt app เริ่มทำงาน
│   ├── stores/             # Pinia stores สำหรับ state management (auto-imported)
│   ├── app.vue             # Component หลักของแอปพลิเคชัน
│   └── error.vue           # หน้าสำหรับแสดงผลเมื่อเกิดข้อผิดพลาด
│
├── public/                 # Assets ที่ไม่ต้องผ่านการประมวลผล (เข้าถึงได้โดยตรง)
│   ├── favicon.ico
│   └── robots.txt
│
├── server/                 # โค้ดฝั่ง Server ทั้งหมด
│   ├── api/                # API endpoints
│   ├── db/                 # ส่วนจัดการฐานข้อมูล
│   ├── middleware/         # Middleware สำหรับฝั่ง server
│   └── utils/              # Utility functions สำหรับฝั่ง server
│
├── shared/                 # โค้ดที่ใช้ร่วมกันระหว่าง Client และ Server
│   ├── types/              # TypeScript types และ interfaces
│   └── utils/              # Utility functions
│
├── .gitignore              # ไฟล์และโฟลเดอร์ที่ Git จะไม่ติดตาม
├── nuxt.config.ts          # ไฟล์ตั้งค่าหลักของ Nuxt
├── uno.config.ts           # ไฟล์ตั้งค่า UnoCSS
├── package.json            # รายการ dependencies และ scripts
├── tsconfig.json           # ไฟล์ตั้งค่า TypeScript
└── README.md               # เอกสารเกี่ยวกับโปรเจกต์
```
## 2. package.json

ต้อง config ตามนี้เป็นอย่างน้อย

1. package.json

```json [package.json]
{
    "scripts": {
        "dev": "nuxt dev",
        "build": "nuxt build",
        "preview": "nuxt preview",
        "lint": "vue-tsc --noEmit", // @ai /follow-lint
        "postinstall": "nuxt prepare"
    }
}
```

## 3. `nuxt.config.ts`

ต้องกำหนดเหล่านี้ เป็นอย่างน้อย

```ts [nuxt.config.ts]
import checker from "vite-plugin-checker";

export default defineNuxtConfig({
    compatibilityDate: "", // @ai กำหนด ณ วันที่ปัจจุบัน
    devtools: { enabled: true },
    modules: [
        "@vue-macros/nuxt",
        "@nuxtjs/color-mode",
        "@vueuse/nuxt",
        "@unocss/nuxt",
        "@pinia/nuxt",
        "nuxt-mcp-dev",
        "@nuxt/icon",
        "@scalar/nuxt"
    ],



    scalar: {
        theme: 'nuxt',
    },

    icon: {
        serverBundle: {
            collections: ['mdi']
        }
    },

    nitro: {
        preset: "cloudflare_module",
        cloudflare: {
            deployConfig: true,
            nodeCompat: true,
            experimental: {
                openAPI: true,
            },
            "routes": [
                {
                    "pattern": "*.wrikka.com", // @ai กำหนด * ตามชื่อ folder
                    "custom_domain": true
                }
            ]
        },
    },
    vite: {
        plugins: [
            checker({
                overlay: {
                    initialIsOpen: false,
                },
                typescript: true,
                vueTsc: true,
                oxlint: true,
                biome: {
                    command: 'check',
                },
            }),
        ],
    }
});
```


## 4. tsconfig.json



```json [tsconfig.json]
{
  "extends": "./.nuxt/tsconfig.json",
  "compilerOptions": {
    "paths": {
      "~/shared/*": ["./shared/*"]
    }
  }
}

```

