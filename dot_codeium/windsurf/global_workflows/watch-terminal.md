---
name: watch-terminal
description: Monitor terminal output และแก้ไข errors/warnings ที่เกิดขึ้นอัตโนมัติ
goal: รักษาความเสถียรของระบบโดยการตรวจจับและแก้ไขปัญหาจาก terminal output
outcome: Terminal ไม่มี errors/warnings ที่ยังไม่ได้แก้ไข และ UX/UI ถูกปรับปรุงให้ดีขึ้น
---

## Usage

1. เปิด terminal และรัน command ที่ต้องการ monitor
2. watch terminal output อย่างต่อเนื่อง
3. ถ้าพบ warning หรือ error:
   - ตรวจสอบประเภทของ error/warning
   - แก้ไข error หรือ warning ที่พบ
   - ปรับปรุง UX/UI ให้ดีขึ้นถ้าเกี่ยวข้อง
4. รักษาการ watch terminal ไปตลอด ไม่ออกจากการ monitor

## Notes

- ห้ามออกจากการ watch terminal จนกว่าจะแน่ใจว่าไม่มีปัญหา
- ต้องแก้ไขปัญหาที่พบทันที ไม่เก็บไว้ทำภายหลัง

