---
auto_execution_mode: 3
---


1. package.json


``` json [package.json]
{
  "scripts": {
    "prepare": "bunx lefthook install", 
  },
```

3. lefthook.yml

``` yml
pre-commit:
  jobs:
    # - name: format
    #   glob: "*.{js,ts,jsx,tsx,json,md,yml}"
    #   exclude: "bun.lockb"
    #   run: bun format {staged_files}

    # - name: lint
    #   glob: "*.{js,ts,jsx,tsx}"
    #   run: bun lint {staged_files}

    #  - name: check secret
    #   run: gitleaks dir {staged_files}

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


