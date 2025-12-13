---
description: review-biome
auto_execution_mode: 1
---

ถ้าบอกว่า setup biome ให้ทำตามนี้
1. ni -d @biomejs/biome
2. กำหนด scripts ใน package.json
scripts : {
   lint : "biome lint --write",
   format : "biome format --write"
   
}
3. config biome.jsonc ตามนี้ https://raw.githubusercontent.com/newkub/dev-config/refs/heads/main/config/biome.jsonc