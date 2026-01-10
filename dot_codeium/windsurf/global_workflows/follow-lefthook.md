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

lefthook.yml ต้องมีไฟล์เดียว และใช้ที่ root เสมอ ไม่ใช้ที่ workspace

```yml [lefthook.yml]
pre-commit:
  jobs:
    - name: install-deps
      run: bun install
    - name: format
      run: bun run format {staged_files}

pre-push:
  jobs:
    - name: test
      run: bun run test
    - name: build
      run: bun run build

pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin
    - name: rebase-check
      run: |
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})
        [ "$LOCAL" = "$REMOTE" ] && exit 0
        [ "$LOCAL" = "$BASE" ] && { echo "Branch behind, pull/rebase first!"; exit 1; }

post-receive:
  jobs:
    - name: open repo
      run: gh repo view --web

post-checkout:
  jobs:
    - name: install-deps
      run: bun install
```