---
trigger: always_on
---

## node, bun

1. package.json

```json [package.json]
{
  "scripts": {
    "prepare": "bunx lefthook install",
  },
```

2. lefthook.yml

```yml [lefthook.yml]
pre-commit:
  jobs:
    - name: format
      run: bun bun format {staged_files}

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
