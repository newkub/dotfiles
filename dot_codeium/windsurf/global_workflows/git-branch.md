---
title: Git Branch
description: จัดการ git branches ทั้งหมดรวมถึงการสร้าง แสดงรายการ เปลี่ยนชื่อ และลบ branches
auto_execution_mode: 3
---

จัดการ git branches ทั้งหมดเพื่อทำงานหลาย features พร้อมกัน แยก concerns และจัดการ releases อย่างมีระบบ

## Execute

### 1. List Branches

แสดงรายการ branches ทั้งหมด

1. รัน `git branch` เพื่อดู local branches ทั้งหมด
2. รัน `git branch -r` เพื่อดู remote branches ทั้งหมด
3. รัน `git branch -a` เพื่อดูทั้ง local และ remote branches
4. ใช้ `--list <pattern>` เพื่อ filter branches ตาม pattern

### 2. Create New Branch

สร้าง branch ใหม่

1. รัน `git branch <branch-name>` เพื่อสร้าง branch ใหม่
2. ระบุ base branch ด้วย `git branch <branch-name> <base-branch>`
3. ใช้ `git checkout -b <branch-name>` เพื่อสร้างและ switch ไปทันที
4. ตรวจสอบว่า branch ถูกสร้างจาก commit ที่ถูกต้อง

### 3. Switch Branch

สลับไปยัง branch อื่น

1. รัน `git checkout <branch-name>` เพื่อ switch ไปยัง branch
2. ใช้ `git switch <branch-name>` สำหรับ syntax ที่ชัดเจนกว่า
3. ตรวจสอบว่า working directory สะอาดก่อน switch
4. ตรวจสอบว่า branch ที่ต้องการ switch มีอยู่จริง

### 4. Rename Branch

เปลี่ยนชื่อ branch

1. รัน `git branch -m <old-name> <new-name>` เพื่อเปลี่ยนชื่อ local branch
2. รัน `git branch -m <new-name>` เพื่อเปลี่ยนชื่อ current branch
3. สำหรับ remote branch ใช้ `git push origin :<old-name> <new-name>`
4. อัพเดท tracking branch ด้วย `git branch -u origin/<new-name>`

### 5. Delete Branch

ลบ branch

1. รัน `git branch -d <branch-name>` เพื่อลบ local branch ที่ merge แล้ว
2. รัน `git branch -D <branch-name>` เพื่อลบ local branch บังคับ
3. รัน `git push origin --delete <branch-name>` เพื่อลบ remote branch
4. ตรวจสอบว่าไม่มี uncommitted changes ก่อนลบ

### 6. Merge Branch

รวม branch เข้าด้วยกัน

1. สลับไปยัง target branch
2. รัน `git merge <source-branch>` เพื่อ merge source branch
3. แก้ไข conflicts ถ้ามี
4. Commit merge result และ push ไปยัง remote

## Rules

### 1. Branch Naming Rules

ตั้งชื่อ branch ตาม convention

1. ใช้ lowercase และ hyphens สำหรับ multi-word names
2. ใช้ prefixes เพื่อระบุ purpose เช่น feature/, bugfix/, hotfix/
3. ระบุ issue ID หรือ ticket number ถ้ามี
4. หลีกเลี่ยงชื่อที่ขึ้นต้นด้วยตัวเลขหรือ special characters

### 2. Branch Management Rules

จัดการ branches อย่างมีระบบ

1. ลบ branches ที่ merge แล้วเสร็จเพื่อลดความสับสน
2. รักษา main branch ให้สะอาดและ stable
3. ใช้ feature branches สำหรับ development ใหม่
4. ใช้ release branches สำหรับการจัดการ releases

### 3. Branch Protection Rules

ปกป้อง critical branches

1. ตั้ง protected branches สำหรับ main และ release branches
2. กำหนด required reviews ก่อน merge
4. กำหนด required status checks ก่อน merge
5. จำกัดสิทธิ์ในการ push ไปยัง protected branches

### 4. Branch Cleanup Rules

ทำความสะอาด branches อย่างสม่ำเสมอ

1. ลบ branches ที่ merge แล้วหลังจาก review
2. ลบ branches ที่ไม่ได้ใช้งานเกิน 30 วัน
3. ลบ stale branches ที่ไม่มีการอัพเดท
4. รักษา branches ที่ยัง active อยู่เท่านั้น

### 5. Branch Tracking Rules

จัดการ tracking branches

1. ตั้งค่า upstream branch เมื่อ push ครั้งแรก
2. ใช้ `git branch -u origin/<branch>` เพื่อตั้งค่า tracking
3. ตรวจสอบ tracking status ด้วย `git branch -vv`
4. อัพเดท tracking branch เมื่อ remote branch เปลี่ยน
