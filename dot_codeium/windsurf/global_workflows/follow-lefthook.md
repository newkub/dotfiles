---
trigger: always_on
---

## {node, bun} ecosystem

ให้ตั้งค่าตามนี้เสมอ

1. package.json

```json [package.json]
{
  "scripts": {
    "prepare": "lefthook install",
  },
```

2. lefthook.yml

```yml [lefthook.yml]
pre-commit:
  jobs:
    - name: format
      run: bun run format 

pre-push:
  jobs:
    - name: build
      run: bun run build

pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin

post-receive:
  jobs:
    - name: open repo
      run: gh repo view --web

post-checkout:
  jobs:
    - name: install
      run: bun install
