---
description: UnoCSS best practices and setup for Vite/Nuxt projects
auto_execution_mode: 3
---

1. ติดตั้ง

ถ้าใช้ nuxt 
- bun add -d unocss @unocss/nuxt

ถ้าใช้ next
- bun add -d unocss @unocss/postcss
- กำหนดใน postcss.config.mjs

``` [postcss.config.mjs]
export default {
  plugins: {
    '@unocss/postcss': {
      content: ['./app/**/*.{html,js,ts,jsx,tsx}'],
    },
  },
}
```
- import `@unocss all` ใน global css

2. กำหนด uno.config.ts

ให้ config เหล่านี้ เป็นอย่างน้อย

``` ts
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'
import { createExternalPackageIconLoader } from '@iconify/utils/lib/loader/external-pkg'


export default defineConfig({
	presets: [
		presetWind4({
			preflights: {
				reset: true,
			}
		}),
		presetIcons({
			autoInstall: true,
			collections: createExternalPackageIconLoader('@iconify-json/mdi')
			collections: createExternalPackageIconLoader('@iconify-json/logos')
		})
		transformers: [
			transformerVariantGroup(),
			transformerDirectives(),
			transformerCompileClass()
		],
	],
})
```

