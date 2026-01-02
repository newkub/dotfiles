---
trigger: always_on

---


## Rules





## unocss + next


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





## unocss + nuxt


1. bun add -d unocss @unocss/nuxt


2. nuxt.config.ts


``` ts
export default defineNuxtConfig({
  modules: [
    '@unocss/nuxt',
  ],
})
```


3. uno.config.ts


``` ts [uno.config.ts]
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

export default defineConfig({
	presets: [
		presetWind4({
			preflights: {
        darkMode : class,
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


## unocss + vite


1. bun add -d unocss

2. vite.config.ts


``` ts [vite.config.ts]
import unocss from '@unocss/vite';

export default defineConfig({
  plugins: [
    unocss(),
  ],
})
```



3. uno.config.ts


``` ts [uno.config.ts]
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

export default defineConfig({
	presets: [
		presetWind4({
			preflights: {
        darkMode : class,
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


## unocss + html



```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Modern Vue App</title>
  <script src="https://cdn.jsdelivr.net/npm/@unocss/runtime"></script>
  <script src="https://cdn.jsdelivr.net/npm/vue"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@unocss/reset/tailwind.min.css">


</head>
<body >
  <script type="module">
    const { createApp, ref } = Vue;

    createApp({
      setup() {
        const message = ref('Hello, Vue!');
        const count = ref(0);

        const increment = () => count.value++;
        const decrement = () => count.value--;

        return {
          message,
          count,
          increment,
          decrement
        };
      }
    }).mount('#app');
  </script>


</body>
</html>
