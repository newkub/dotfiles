---
description: UnoCSS best practices and setup for Vite/Nuxt projects
auto_execution_mode: 3
---


## uno.config.ts 


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