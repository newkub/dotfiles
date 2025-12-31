---
trigger: manual
---

สามารถใช้ ast-grep ในการ replace && rewrite ได้

1. write rules 

- เขียน ast-grep rules ใน rules/this-project/
- เกี่ยวกับ ast-grep ทั้งหมด https://ast-grep.github.io/llms-full.txt

2. match

- ใช้ `ast-grep --patttern <file>` 
- ลองอ่าน
    - https://ast-grep.github.io/guide/rule-config.html
    - https://ast-grep.github.io/guide/rule-config/atomic-rule.html
    - https://ast-grep.github.io/guide/rule-config/composite-rule.html
    - https://ast-grep.github.io/guide/rule-config/utility-rule.html

3. rewrite 

- ใช้ `ast-grep --rewrite <file>` 
- ลองอ่าน
    - https://ast-grep.github.io/guide/rewrite/transform.html
    - https://ast-grep.github.io/guide/rewrite/rewriter.html

4. ให้ run test 