---
auto_execution_mode: 3
---


## package.json


``` json
{
	"scripts": {
		"dev" : "vite dev",
		"build" : "vite build",
		"preview" : "vite preview",
	}
}
```


## vite.config.ts

```ts
import { defineConfig } from 'vite';
import checker from 'vite-plugin-checker';
import tsconfigPaths from 'vite-tsconfig-paths';
import Unocss from '@unocss/vite';
import AutoImport from 'unplugin-auto-import/vite';
import Replace from 'unplugin-replace/vite';
import Unused from 'unplugin-unused/vite';
import TurboConsole from 'unplugin-turbo-console/vite';
import Terminal from 'vite-plugin-terminal';
import { analyzer } from 'vite-bundle-analyzer';
import Inspect from 'vite-plugin-inspect';
import AST from 'unplugin-ast/vite';
import Macros from 'unplugin-macros/vite';
import UnpluginIsolatedDecl from 'unplugin-isolated-decl/vite';
import Icons from 'unplugin-icons/vite';

export default defineConfig({
	plugins: [
		Unocss(),
		AutoImport({
			imports: ['vue'],
			dts: true
		}),
		AST(),
		Icons({
			autoInstall: true,
		}),
		UnpluginIsolatedDecl(),
		Macros(),
		Replace(),
		TurboConsole({}),
		Terminal(),
		analyzer(),
		Inspect(),
		Unused({
			include: [/\.([cm]?[jt]sx?|vue)$/],
			exclude: [/node_modules/],
			level: 'warning',
			ignore: {
				peerDependencies: ['vue'],
			},
			depKinds: ['dependencies', 'peerDependencies'],
		}),
		tsconfigPaths(),
		checker({
			overlay: {
				initialIsOpen: false,
			},
			typescript: true,
			vueTsc: true,
			oxlint: true,
		})
	]
});
```


## tsconfig.json

กำหนดใน tsconfig.json

``` json
 "compilerOptions": {
    "types": [ "vite/client"]
  }
```


