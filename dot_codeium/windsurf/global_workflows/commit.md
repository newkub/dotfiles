---
trigger: manual
---
 
1. ทำ `/follow-windsurf-global-workflows`
2. ทำ `/follow-gitignore`
3. ทำ `/follow-lefthook` (ถ้าควรใช้)
4. commit ตาม conventional commit เป็นภาษาอังกฤษ เช่น feat(auth): add login with Google OAuth
  - `git status --porcelain`
  - `git diff`
  - `git diff --staged`
  - `git add -u`
  - `git commit -m ""`
  - `git log --oneline --graph --decorate`

หมายเหตุ
  - ระวัง `.gitignore` อะไรไม่ควร commit ให้ใส่ใน `.gitignore`
  - ถ้า commit แล้วติด lefthook ห้ามแก้ lefthook เพื่อให้ผ่าน ให้แก้ที่ต้นเหตุ
