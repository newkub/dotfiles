---
title: Delete
description: ลบ files หรือ folders และแก้ไข references ที่เกี่ยวข้องทั้งหมด
auto_execution_mode: 3
---

## Prompt

ใช้ workflow นี้เมื่อต้องการลบ files หรือ folders และแก้ไข references ที่เกี่ยวข้องทั้งหมด

## Execute

1. Identify Targets

- ระบุ files/folders ที่ต้องการลบ
- ตรวจสอบ dependencies
- หา files ที่ reference ถึง targets
- ประเมิน impact

2. Find References

- ใช้ grep_search หา imports
- หา hardcoded paths
- ตรวจสอบ configuration files
- หา documentation references

3. Update References

- ลบ imports ที่ไม่จำเป็น
- แก้ไข paths ใน configs
- อัพเดท documentation
- แก้ไข tests ที่เกี่ยวข้อง

4. Delete Files

- ใช้ git rm สำหรับ tracked files
- ลบ folders อย่างระมัดระวัง
- ยืนยันการลบ
- ตรวจสอบไม่มี leftovers

5. Verify Changes

- รัน tests
- Build project
- ตรวจสอบว่าไม่มี broken references
- Commit changes

## Rules

1. Safety First

- สำรองก่อนลบ
- ใช้ git rm แทน rm
- ตรวจสอบ twice
- ไม่ใช้ rm -rf

2. Complete Cleanup

- ลบ references ทั้งหมด
- อัพเดท imports
- แก้ไข configs
- Update documentation

3. Verification

- รัน tests หลังลบ
- Build project
- ตรวจสอบ runtime
- ไม่มี broken links

## Expected Outcome

- Files/folders ถูกลบสำเร็จ
- References ถูกอัพเดท
- Project ทำงานได้ตามปกติ
- No broken dependencies
