---
trigger: always_on
---

## Setup

### unocss + next

1. bun add -d unocss @unocss/postcss

2. postcss.config.mjs
``` ts
export default {
  plugins: {
    '@unocss/postcss': {
      content: ['./app/**/*.{html,js,ts,jsx,tsx}'],
    },
  },
}
```

3. uno.config.ts
``` ts
import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass, presetUno } from 'unocss'

export default defineConfig({
  darkMode: 'class',
  presets: [
    presetUno(),
    presetWind4({
      preflights: {
        reset: true,
      },
    }),
  ],
  transformers: [
    transformerVariantGroup(),
    transformerDirectives(),
    transformerCompileClass(),
  ],
  content: {
    filesystem: ['./app/**/*.{html,js,ts,jsx,tsx}'],
  },
})
```

4. import `@unocss/all` ใน global css (app/globals.css)
``` css
@unocss all;
```

### unocss + nuxt

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
``` ts
import { defineConfig, presetIcons, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass } from 'unocss'

export default defineConfig({
  presets: [
    presetWind4({
      preflights: {
        reset: true,
      },
    }),
  ],
  transformers: [
    transformerVariantGroup(),
    transformerDirectives(),
    transformerCompileClass(),
  ],
})
```

### unocss + vite

1. bun add -d unocss

2. vite.config.ts
``` ts
import unocss from '@unocss/vite'

export default defineConfig({
  plugins: [
    unocss(),
  ],
})
```

3. uno.config.ts
``` ts
import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass, presetUno } from 'unocss'

export default defineConfig({
  darkMode: 'class',
  presets: [
    presetUno(),
    presetWind4({
      preflights: {
        reset: true,
      },
    }),
  ],
  transformers: [
    transformerVariantGroup(),
    transformerDirectives(),
    transformerCompileClass(),
  ],
  content: {
    filesystem: ['./src/**/*.{html,js,ts,jsx,tsx,vue,svelte}'],
  },
})
```

4. import `@unocss/all` ใน main css (src/style.css)
``` css
@unocss all;
```

### unocss + html (CDN)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UnoCSS CDN</title>
  <script src="https://cdn.jsdelivr.net/npm/@unocss/runtime"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@unocss/reset/tailwind.min.css">
</head>
<body>
  <div class="text-2xl font-bold text-red-500">Hello UnoCSS!</div>
</body>
</html>
```

## Configuration

### Global CSS (app/globals.css หรือ src/style.css)

กำหนด CSS variables ให้ตรงกับ theme ใน uno.config.ts:

``` css
@unocss all;

:root {
  /* สีหลัก */
  --color-primary: 221 83% 53%;
  --color-primary-hover: 221 83% 45%;
  --color-primary-active: 221 83% 37%;
  --color-primary-foreground: 0 0% 100%;

  --color-secondary: 238 84% 67%;
  --color-secondary-hover: 238 84% 59%;
  --color-secondary-active: 238 84% 51%;
  --color-secondary-foreground: 0 0% 100%;

  /* สีสถานะ */
  --color-success: 142 76% 36%;
  --color-success-foreground: 0 0% 100%;

  --color-warning: 38 92% 50%;
  --color-warning-foreground: 0 0% 100%;

  /* สี action - destructive */
  --color-destructive: 0 84% 60%;
  --color-destructive-hover: 0 84% 56%;
  --color-destructive-active: 0 84% 52%;
  --color-destructive-foreground: 0 0% 100%;

  /* สีพื้นฐาน */
  --color-background: 0 0% 100%;
  --color-foreground: 220 13% 18%;

  /* สี surface */
  --color-surface: 0 0% 100%;
  --color-surface-elevated: 0 0% 100%;
  --color-surface-foreground: 220 13% 18%;

  /* สี interaction */
  --color-muted: 220 13% 96%;
  --color-muted-foreground: 220 13% 42%;

  --color-accent: 221 83% 53%;
  --color-accent-hover: 221 83% 45%;
  --color-accent-foreground: 0 0% 100%;

  /* สีขอบและ focus */
  --color-border: 220 13% 82%;
  --color-border-hover: 220 13% 60%;
  --color-focus: 221 83% 53%;

  /* สี overlay */
  --color-overlay: 0 0% 0%;

  /* สี skeleton */
  --color-skeleton: 220 13% 82%;
  --color-skeleton-shine: 220 13% 96%;
}

.dark {
  /* สีหลัก */
  --color-primary: 221 83% 63%;
  --color-primary-hover: 221 83% 55%;
  --color-primary-active: 221 83% 47%;
  --color-primary-foreground: 0 0% 100%;

  --color-secondary: 238 84% 77%;
  --color-secondary-hover: 238 84% 69%;
  --color-secondary-active: 238 84% 61%;
  --color-secondary-foreground: 0 0% 100%;

  /* สีสถานะ */
  --color-success: 142 76% 46%;
  --color-success-foreground: 0 0% 100%;

  --color-warning: 38 92% 60%;
  --color-warning-foreground: 0 0% 100%;

  /* สี action - destructive */
  --color-destructive: 0 84% 70%;
  --color-destructive-hover: 0 84% 66%;
  --color-destructive-active: 0 84% 62%;
  --color-destructive-foreground: 0 0% 100%;

  /* สีพื้นฐาน */
  --color-background: 220 13% 7%;
  --color-foreground: 220 13% 97%;

  /* สี surface */
  --color-surface: 220 13% 10%;
  --color-surface-elevated: 220 13% 15%;
  --color-surface-foreground: 220 13% 97%;

  /* สี interaction */
  --color-muted: 220 13% 22%;
  --color-muted-foreground: 220 13% 60%;

  --color-accent: 221 83% 63%;
  --color-accent-hover: 221 83% 55%;
  --color-accent-foreground: 0 0% 100%;

  /* สีขอบและ focus */
  --color-border: 220 13% 30%;
  --color-border-hover: 220 13% 42%;
  --color-focus: 221 83% 63%;

  /* สี overlay */
  --color-overlay: 0 0% 0%;

  /* สี skeleton */
  --color-skeleton: 220 13% 30%;
  --color-skeleton-shine: 220 13% 22%;
}
```

**รูปแบบการตั้งชื่อ:**
- `--color-{name}` - สี default
- `--color-{name}-hover` - สีเมื่อ hover
- `--color-{name}-active` - สีเมื่อ active
- `--color-{name}-foreground` - สีข้อความบนพื้นหลัง

### uno.config.ts 

``` ts
import { defineConfig, presetWind4, transformerVariantGroup, transformerDirectives, transformerCompileClass, presetUno } from 'unocss'

export default defineConfig({

  // Presets
  presets: [
    presetWind4({
      preflights: {
        reset: true,
        preflights: { 
          theme: { 
            mode: 'on-demand',
          }
      }, 
      },
    }), 
  ],

  // Transformers
  transformers: [
    transformerVariantGroup(), // group:()
    transformerDirectives(), // @apply, @screen
    transformerCompileClass(), // compile class
  ],

  // Theme
  theme: {
    colors: {
      primary: {
        DEFAULT: 'hsl(var(--color-primary))',
        hover: 'hsl(var(--color-primary-hover))',
        active: 'hsl(var(--color-primary-active))',
        foreground: 'hsl(var(--color-primary-foreground))',
      },
      secondary: {
        DEFAULT: 'hsl(var(--color-secondary))',
        hover: 'hsl(var(--color-secondary-hover))',
        active: 'hsl(var(--color-secondary-active))',
        foreground: 'hsl(var(--color-secondary-foreground))',
      },
      success: {
        DEFAULT: 'hsl(var(--color-success))',
        foreground: 'hsl(var(--color-success-foreground))',
      },
      warning: {
        DEFAULT: 'hsl(var(--color-warning))',
        foreground: 'hsl(var(--color-warning-foreground))',
      },
      destructive: {
        DEFAULT: 'hsl(var(--color-destructive))',
        hover: 'hsl(var(--color-destructive-hover))',
        active: 'hsl(var(--color-destructive-active))',
        foreground: 'hsl(var(--color-destructive-foreground))',
      },
      background: {
        DEFAULT: 'hsl(var(--color-background))',
      },
      foreground: {
        DEFAULT: 'hsl(var(--color-foreground))',
      },
      surface: {
        DEFAULT: 'hsl(var(--color-surface))',
        elevated: 'hsl(var(--color-surface-elevated))',
        foreground: 'hsl(var(--color-surface-foreground))',
      },
      muted: {
        DEFAULT: 'hsl(var(--color-muted))',
        foreground: 'hsl(var(--color-muted-foreground))',
      },
      accent: {
        DEFAULT: 'hsl(var(--color-accent))',
        hover: 'hsl(var(--color-accent-hover))',
        foreground: 'hsl(var(--color-accent-foreground))',
      },
      border: {
        DEFAULT: 'hsl(var(--color-border))',
        hover: 'hsl(var(--color-border-hover))',
      },
      focus: {
        DEFAULT: 'hsl(var(--color-focus))',
      },
      overlay: {
        DEFAULT: 'hsl(var(--color-overlay))',
      },
      skeleton: {
        DEFAULT: 'hsl(var(--color-skeleton))',
        shine: 'hsl(var(--color-skeleton-shine))',
      },
    },
  },

})
```
