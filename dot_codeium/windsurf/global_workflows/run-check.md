---
auto_execution_mode: 3
---


## every project

1. ต้องมี README.md, .gitignore, .windsurf/rules/main.md 
2. ใช้ ast-grep ค้นหา "TODO" แล้วทำให้ครบ


## node, bun project

2. ใช้ ast-grep ค้นหา เพื่อลบ "biome-ignore", "ts-ignore" และ ignore แบบอื่นๆ แล้วลบ comment ignore เหล่านั้น
3. /follow-package-json
4. /run-lint
5. /run-build
6. /run-test
7. run check ใน package.json จนกว่าจะผ่าน
8. /update-readme



