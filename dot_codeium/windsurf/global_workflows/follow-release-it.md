---
trigger: always_on
auto_execution_mode: 3
---



1. package.json

``` json [package..json]
{
    "scripts" : "release-it"
}
```

2. .releaseit.json

``` json [.releaseit.json]
{
  "git": {
    "commitMessage": "chore: release v${version}",
    "tagName": "v${version}",
    "requireCleanWorkingDir": false,
    "requireUpstream": false,
    "push": true,
    "commit": true,
    "tag": true
  },
  "npm": {
    "publish": true,
    "publishPath": "."
  },
  "github": {
    "release": false
  },
  "hooks": {
    "before:init": [
      "bun run pre-release"
    ],
    "after:release": [
      "echo Successfully released ${name}@${version} to npm!",
      "echo Install with: bun add ${name}"
    ]
  }
}
```

3. github/workflows/release-it.yml

``` yml
name: Auto Release Every Push

on:
  push:
    branches:
      - main

jobs:
  release:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v5
      - uses: oven-sh/setup-bun@v2
      - name: Auto Release
        run: release-it --ci --no-git.requireCleanWorkingDir --npm.publish
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```

4. open https://github.com/{GIHUB_USERNAME}/{GITHUB_REPOSITORY}/settings/secrets/actions
