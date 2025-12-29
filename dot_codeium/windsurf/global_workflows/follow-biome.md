---
trigger: always_on
---

1. bun add -d @biomejs/biome
2. กำหนดใน package.json
```json [package.json]
{
    "scripts": {
       "lint" : "biome lint --write",
       "format" : "biome format --write"
    }
}
```
3. biome.jsonc
```json [biome.jsonc]
{
	"$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
	"vcs": {
		"enabled": true,
		"clientKind": "git",
		"useIgnoreFile": true
	},
	"assist": {
		"enabled": true,
		"actions": {
			"source": {
				"organizeImports": "on",
				"useSortedKeys": "on",
				"useSortedProperties": "on"
			}
		}
	},
	"formatter": {
		"enabled": true
	},
	"linter": {
		"enabled": true,
		"rules": {
			"recommended": true
		}
	}
}
```
4. ถ้าเป็น monorepo ใน workspace ต่างๆให้กำหนดอย่างนี้
```json [biome.jsonc]
{
   "root": false,
   "extends": "//",
}
```
