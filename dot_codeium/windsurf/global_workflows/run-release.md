---
trigger: manual
auto_execution_mode: 3
---


## release to npm


1. package.json

ให้มีตามนี้เป็นอย่างน้อย


``` json [package.json]
{
   "name": "",
   "description": "",
   "version": "",
   "author": "",
   "private": false,
   "publishConfig": {
      "access": "public"
   },
   "license": "",
   "repository": {
      "type": "git",
      "url": ""
   },
   "homepage": "",
   "keywords": [],
   "scripts": {
      "prerelease" : "bun run verfiy",
      "release" : "" // @ai follow-release-it
   }
}
```

2. run release จนกว่าจะผ่าน
