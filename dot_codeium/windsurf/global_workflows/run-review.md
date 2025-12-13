---
description: Define and run the review script in package.json.
auto_execution_mode: 3
---

1. กำหนด review ใน package.json

"scripts": {
    "review": "bunx taze -r && bun run lint && bun run build && bun run test"
 },



2. /run-review

