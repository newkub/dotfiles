---
auto_execution_mode: 3
---


## Rules 

- ทุก .vue ต้องใช้ class ที่ตรงกับ uno.config.theme
- ใน uno.config.ts theme ต้องรองรับ theme และ color ใช้hsl โดยกำหนดให้ตรงกับ assets/theme.css
- สร้าง theme.css ให้ตรงกับ unoconfig theme
- 

## uno.config.ts 


``` ts
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

export default defineConfig({
	presets: [
		presetWind4({
			preflights: { 
				reset: true, 
			} 
		}),
	],
	transformers: [
		transformerVariantGroup(),
		transformerDirectives(),
		transformerCompileClass()
	],
})
```

## for next 

1. bun add -d unocss @unocss/postcss

2. postcss.config.ts 

``` ts [postcss.config.mjs]
export default {
  plugins: {
    '@unocss/postcss': {
      content: ['./app/**/*.{html,js,ts,jsx,tsx}'],
    },
  },
}
```
3. import `@unocss all` ใน global css




## for nuxt

1. bun add -d unocss @unocss/nuxt

2. nuxt.config.ts

``` ts
export default defineNuxtConfig({
  modules: [
    '@unocss/nuxt',
  ],
})
