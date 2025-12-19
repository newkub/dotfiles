---
auto_execution_mode: 3
---



1. กำหนด bunx release-it ใน scripts package.json 

``` json [package..json]
{
    "scripts" : "bunx release-it"
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
      "echo ✅ Successfully released ${name}@${version} to npm!",
      "echo 📦 Install with: bun add ${name}"
    ]
  }
}
``` 



