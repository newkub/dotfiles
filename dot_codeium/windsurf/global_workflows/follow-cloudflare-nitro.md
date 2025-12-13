1. กำหนดใน nuxt.config.ts

``` ts
export default defineNuxtConfig({

	nitro: {
		prerender: {
				autoSubfolderIndex: false,
		},
		preset: "cloudflare_module",
		cloudflare: {
		deployConfig: true,
			nodeCompat: true,
		},
    },
				
});
```