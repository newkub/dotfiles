
1. ดูว่าใช้ lib อะไรได้บ้าง เช่นจาก vueuse, unjs, unplugins หรืออะไรได้บ้าง
2. ใช้ nuxt default import alias
3. ใช้ nuxt autoimport 
4. /refactor
5. /refactor-vue
6. /refactor-ts
7. ไม่ใช้ svg โดยตรง ใช้ nuxt icon แทน


# โครงสร้างโปรเจกต์ Nuxt

├── .nuxt/
├── .output/
├── app/
│   ├── assets/
│   ├── components/
│   ├── composables/
│   ├── layouts/
│   ├── middleware/
│   ├── pages/
│   ├── plugins/
│   └── utils/
├── app.vue
├── app.config.ts
├── error.vue
├── content/
├── layers/
├── modules/
├── node_modules/
├── public/
├── server/
├── shared/
├── .env
├── .gitignore
├── .nuxtignore
├── .nuxtrc
├── nuxt.config.ts
├── package.json
├── tsconfig.json
├── README.md
└── biome.jsonc