---
title: Git Push
description: ทำการ push commits ไปยัง remote repository
auto_execution_mode: 3
follow:
- "/git-push"
---

## Prompt

ใช้ workflow นี้เมื่อต้องการ push commits จาก local repository ไปยัง remote repository

## Purpose

- ส่ง commits ที่ทำใน local ไปยัง remote repository
- ตรวจสอบว่าไม่มี conflicts ก่อน push
- ยืนยันว่าโค้ดถูก push สำเร็จ

## Rules

- ต้อง pull ก่อน push เสมอเพื่อตรวจสอบ conflicts
- ถ้ามี conflicts ต้องแก้ไขก่อน push
- ต้องตรวจสอบว่า push สำเร็จจริง
- ไม่ push force โดยไม่จำเป็น

## Execute

1. check : ตรวจสอบสถานะ repository และ remote
   - รัน `git status` เพื่อดูสถานะ local repository
   - รัน `git log --oneline origin/HEAD..HEAD` เพื่อดู commits ที่จะ push
   - ตรวจสอบว่ามี commits ที่ต้องการ push หรือไม่

2. analyze : วิเคราะห์สถานการณ์ก่อน push
   - รัน `git fetch origin` เพื่ออัพเดทข้อมูล remote
   - วิเคราะห์ว่ามี commits บน remote ที่ local ไม่มีหรือไม่
   - ประเมินว่าจะมี conflicts หรือไม่

3. action : ดำเนินการ push
   - รัน `git pull --rebase` ก่อน push เสมอ (ถ้ามี commits บน remote)
   - แก้ไข conflicts ถ้ามี (rebase ใหม่จนกว่าจะผ่าน)
   - รัน `git push origin <branch>` เพื่อ push commits
   - รอให้ push เสร็จสมบูรณ์

4. validate : ตรวจสอบความถูกต้องหลัง push
   - ตรวจสอบว่าไม่มี error messages จาก git
   - ยืนยันว่า commits ปรากฏบน remote repository
   - ตรวจสอบว่าไม่มี conflicts เหลืออยู่

5. verify : ยืนยันผลลัพธ์สุดท้าย
   - รัน `git log --oneline origin/HEAD -5` เพื่อตรวจสอบ commits บน remote
   - รัน `git status` เพื่อยืนยันว่า local และ remote sync กัน
   - ตรวจสอบว่า commits ที่ push ถูกต้องครบถ้วน

6. review : ทบทวนผลลัพธ์
   - ตรวจสอบว่า commits ปรากฏใน remote repository ถูกต้อง
   - ยืนยันว่าไม่มีปัญหาที่ถูกมองข้าม
   - ตรวจสอบว่า workflow ทำงานได้ตามที่คาดหวัง

## Expected Outcome

- Commits ถูก push ไปยัง remote repository สำเร็จ
- Local repository และ remote อยู่ในสถานะ sync กัน
- ไม่มี conflicts เหลืออยู่
- ทีมสามารถดู commits ใหม่บน remote ได้
