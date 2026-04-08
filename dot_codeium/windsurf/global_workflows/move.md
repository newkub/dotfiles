---
title: Move
description: ย้ายไฟล์หรือโฟลเดอร์อย่างปลอดภัยพร้อมอัพเดท references
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการย้ายไฟล์หรือโฟลเดอร์อย่างปลอดภัย พร้อมอัพเดท references ที่เกี่ยวข้อง

## Execute

1. Identify Move Target

- ระบุไฟล์หรือโฟลเดอร์ที่ต้องการย้าย
- กำหนด destination ที่เหมาะสม
- ตรวจสอบว่า destination ไม่มี conflicts
- สำรองข้อมูลก่อนย้าย

2. Update References

- หา all references ที่ชี้ไปยัง source
- อัพเดท imports, paths, links
- แก้ไข configuration files
- อัพเดท documentation

3. Execute Move

- ใช้ git mv สำหรับ tracked files
- หรือใช้ mv แล้ว stage changes
- ยืนยันการย้ายสำเร็จ
- ตรวจสอบ file permissions

4. Verify Results

- รัน tests เพื่อยืนยันว่าไม่มี broken links
- ตรวจสอบ imports ทำงานได้
- ยืนยัน builds ผ่าน
- Review changes ก่อน commit

## Rules

1. Safety First

- สำรองก่อนย้ายเสมอ
- ใช้ git mv สำหรับ tracked files
- ไม่ overwrite ไฟล์ที่มีอยู่
- Test หลังย้ายทุกครั้ง

2. Complete Updates

- อัพเดททุก references ที่เกี่ยวข้อง
- ไม่ทิ้ง broken imports
- แก้ไขทั้ง code และ config
- Update documentation

3. Atomic Operations

- ย้ายทีละ operation
- Stage changes ทั้งหมดพร้อมกัน
- Commit เป็นกลุ่มที่เกี่ยวข้องกัน
- มี rollback plan

## Expected Outcome

- ไฟล์/โฟลเดอร์ถูกย้ายสำเร็จ
- ทุก references อัพเดทถูกต้อง
- ไม่มี broken functionality
- Changes พร้อม commit
