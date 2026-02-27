---
description: commit และ push โค้ด
title: commit-and-push
---

## 1. Commit

1. commit ไฟล์ที่เปลี่ยนแปลง
   - ใช้ `/commit` เพื่อ commit
   - ตรวจสอบ commit message ถูกต้อง
   - ยืนยัน commit สำเร็จ
   - บันทึก commit hash

## 2. Push

1. push ไปยัง remote repository
   - รัน `git push`
   - ตรวจสอบ push สำเร็จ
   - ตรวจสอบ commits บน remote
   - ยืนยัน CI/CD เริ่มทำงาน

2. จัดการ push failures
   - ตรวจสอบสาเหตุล้มเหลว
   - แก้ไข conflicts
   - รัน `git push` ใหม่
   - ตรวจสอบข้อมูลส่งไป remote

## 3. ตรวจสอบ

1. ตรวจสอบ commit
   - ตรวจสอบ commit ใน `git log`
   - ตรวจสอบ commit message
   - ตรวจสอบไม่มีไฟล์ลืม
   - ตรวจสอบ repository state

2. ตรวจสอบ push
   - ตรวจสอบ commits บน remote
   - ตรวจสอบ CI/CD pipeline
   - ตรวจสอบไม่มี build failures
   - ตรวจสอบ deployment (ถ้ามี)
