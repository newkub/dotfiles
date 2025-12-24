---
auto_execution_mode: 3
---

## 1. /follow-gitignore
## 2. /follow-lefthook
## 3. commit ตาม conventional เป็นภาษาอังกฤษ โดย split commit เป็นกลุ่มๆ 


1. ตรวจสอบสถานะและความเปลี่ยนแปลง

- git status -s          # ดูสถานะไฟล์
- git diff                # diff ของไฟล์ที่ยังไม่ได้ stage
- git diff --staged       # diff ของไฟล์ที่ stage แล้ว

2. การเปลี่ยนแปลงแบบเลือกได้ (Split Commit)

- git add -p

3. ตรวจสอบความเรียบร้อยของ staged files

- git status -s
- git diff             # diff ของไฟล์ที่ยังไม่ staged
- git diff --staged    # diff ของไฟล์ที่ stage แล้ว

4. Commit ตาม Conventional Commit เช่น 

- git commit -m "type(scope): short description"

5. ตรวจสอบสุดท้าย

git log --oneline --graph --decorate



