---
description: Install lefthook and download its configuration
auto_execution_mode: 3
---

1. package.json


``` json
{
  "scripts": {
    "prepare": "bunx lefthook install", 
  },
```

3. lefthook.yml

``` yml
pre-commit:
  jobs:
    - name: format 
      run: bun format {all_files}

    - name: lint
      run: bun lint {staged_files}

    - name: check secret
      run: gitleaks dir {staged_files}

pre-push:
  jobs:
    - name: test
      run: bun test

    - name: security
      run: bun audit

    - name: check-deps-security
      run: bun audit

    - name: check secret repo
      run: gitleaks git {all_files}


pre-rebase:
  jobs:
    - name: fetch-origin
      run: git fetch origin


pre-merge-commit:
  jobs:
    - name: run-build
      run: bun run build
    - name: verify-rebase
      run: test $(git merge-base HEAD origin/main) = $(git rev-parse origin/main)

```

