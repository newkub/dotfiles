---
trigger: manual
---
 
1. ทำ /follow-gitignore
2. ทำ/follow-lefthook (ถ้าควรใช้)
3. split commit 

แบ่ง commit ออกเป็นย่อยๆ ค่อย commit ทีละส่วน


  - `git status --porcelain`
  - `git diff`
  - `git diff --staged`
  - `git add -u`
  - `git commit -m ""`

4. commit ให้หมดจนไม่มีเหลือ ทำข้อ 3 ใหม่  

5. ตรวจสอบว่าไม่มีอะไรที่ commit ได้แล้ว

  - `git log --oneline --graph --decorate`



หมายเหตุ
  - ระวัง `.gitignore` อะไรไม่ควร commit ให้ใส่ใน `.gitignore`
  - ถ้า commit แล้วติด lefthook ห้ามแก้ lefthook เพื่อให้ผ่าน ให้แก้ที่ต้นเหตุ
