# Commit and Push Workflow

## Part 1: Commit Process

### 1.1 Execute Commit
ทำการ commit ไฟล์ที่เปลี่ยนแปลง

1. ใช้ `[commit](commit.md)` เพื่อ commit ไฟล์ที่เปลี่ยนแปลง
2. ตรวจสอบว่า commit message ถูกต้อง
3. ยืนยันว่า commit สำเร็จ
4. บันทึก commit hash สำหรับการติดตาม

## Part 2: Push Process

### 2.1 Execute Push
ทำการ push ไปยัง remote repository

1. รัน `git push` ไปยัง remote repository
2. ตรวจสอบว่า push สำเร็จ
3. ตรวจสอบว่า commits ปรากฏบน remote
4. ยืนยันว่า CI/CD เริ่มทำงาน

### 2.2 Handle Push Failures
จัดการกรณีที่ push ไม่สำเร็จ

1. ตรวจสอบสาเหตุของความล้มเหลว
2. แก้ไข conflicts ถ้ามี
3. รัน `git push` ใหม่จนกว่าจะสำเร็จ
4. ตรวจสอบว่าข้อมูลถูกส่งไปยัง remote

## Part 3: Verification

### 3.1 Post-Commit Verification
ตรวจสอบภายหลัง commit

1. ตรวจสอบว่า commit ปรากฏใน `git log`
2. ตรวจสอบว่า commit message ถูกต้อง
3. ตรวจสอบว่าไม่มีไฟล์ที่ถูกลืม
4. ตรวจสอบว่า repository state ถูกต้อง

### 3.2 Post-Push Verification
ตรวจสอบภายหลัง push

1. ตรวจสอบว่า commits ปรากฏบน remote repository
2. ตรวจสอบว่า CI/CD pipeline เริ่มทำงาน
3. ตรวจสอบว่าไม่มี build failures
4. ตรวจสอบว่า deployment สำเร็จ (ถ้ามี)

## Verification

1. ตรวจสอบว่า workflow สร้างสำเร็จใน `global_workflows/`
2. ทดสอบด้วยการอ้างอิง `[commit-and-push](commit-and-push.md)` ใน chat
3. ตรวจสอบว่า workflow ทำงานตามขั้นตอนที่ระบุ
4. ตรวจสอบว่า commit และ push สำเร็จทั้งสองขั้นตอน
