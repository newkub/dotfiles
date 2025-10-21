## Rules
- คุยกับผมเป็นภาษาไทย ระหว่างที่ทำอธิบยให้ผมฟังด้วยว่าทำเพราะอะไร
- ถ้าจะใช้ terminal => ใช้ bun และ pwsh
- ถ้าต้องการ search ใช้ [ast-grep](https://ast-grep.github.io/) 
- ถ้าแก้ไข code => ทำตาม pattern ดานล่าง
- ถ้าติดตั้ง dependency => ใช้ dependency ที่เป็น esm และ type safe 
- ถ้าจะใช้ package manager => ใชื bun ไม่ใช่ node


## pattern

ทำเมื่อตรวจพบว่าใช้รูปแบบเหล่านี้

### .vue
- class ใช้จาก uno.config.ts theme เท่านั้น

### composables/useXXX
- ควรมี interface 
- ถ้า useFetch สำหรับ data fetching

### components/**.vue

### app.vue 
- ให้มี nuxtlayout, nuxtpage เสมอ


### biome.config.ts
- ให้ config ตามนี้ https://raw.githubusercontent.com/newkub/dev-config/refs/heads/main/config/biome.jsonc

### tsdown.config.ts
- ให้ config ตามนี้ https://raw.githubusercontent.com/newkub/dev-config/refs/heads/main/config/tsdown.config.ts

### 
