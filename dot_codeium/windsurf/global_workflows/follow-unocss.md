---
description: UnoCSS best practices and setup for Vite/Nuxt projects
auto_execution_mode: 3
---

1. uno.config.ts

ให้ config เหล่านี้ เป็นอย่างน้อย

``` ts
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

export default defineConfig({
	presets: [
		presetWind4({
			preflights: {
				reset: true,
			}
		}),
    transformers: [
      transformerVariantGroup(),
      transformerDirectives(),
      transformerCompileClass()
    ],
	],
})
```

