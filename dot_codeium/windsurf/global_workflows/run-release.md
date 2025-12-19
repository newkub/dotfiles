---
auto_execution_mode: 3
---


## release to npm

release ด้วย release it

1. กำหนดใน package.json

- name ต้องชื่อว่า @newkub/<folder>-<workspace> เช่น @newkub/template-cli
- เพิ่ม keyword ให้เหมาะสม ให้รองรับ SEO
- กำหนด "private" : false
- กำหนด prerelease, release โดย prerelease กำหนดว่า bun check โดยทำตาม /run-check
- bun -v และกำหนด packageManager version ล่าสุด


2. /update-readme

3. /run-release


