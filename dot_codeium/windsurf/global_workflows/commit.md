---
trigger: manual
descrition : "commit"
---

1. /follow-gitignore
2. /run-lint
3. split commit ให้หมดจนไม่มีเหลือ ตาม conventional commit 

- git status --porcelain
- git diff
- git diff --staged
- git add -u
- git commit -m ""

4. ตรวจสอบว่าไม่มีอะไรให้ commit แล้ว

- git status --porcelain

5. ถ้ายังมีไฟล์ที่ไม่ได้ commit ให้ทำข้อ 3 ใหม่

6. แสดง commit ทั้งหมด

- git log --oneline --graph --decorate


หมายเหตุ
- ถ้า commit แล้วติด lefthook ห้ามแก้ lefthook เพื่อให้ผ่าน ให้แก้ที่ต้นเหตุ
