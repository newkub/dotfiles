---
trigger: always_on
---


1. `bun add -d oxlint oxlint-tsgolint`
2. package.json`

```json [package.json]
{
  "scripts": {
    "lint": "oxlint --fix --type-aware"
  }
}
```

3. .oxlintrc.json
- `gh download https://github.com/newkub/my-config/blob/main/.oxlintrc.json`

```json [.oxlintrc.json]
{
	"$schema": "./node_modules/oxlint/configuration_schema.json",
	"plugins": [
		"import",
		"oxc",
		"react",
		"unicorn",
		"react-perf",
		"vitest",
		"jsx-a11y",
        "nextjs",
        "import",
		"promise",
		"vitest",
		"typescript",
		"vue",
		"node"

	],
	"env": {
		"browser": true,
		"node" :true
	}
}
```

4. if monorepo

``` json [.oxlintrc.json]
{
  "extends": ["../.oxlintrc.json"]
}
```