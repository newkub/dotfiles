---
trigger: manual
---

1. /follow-config-file

2. รัน `test`  แล้วแก้ error / warning ทั้งหมดจนไม่มีเหลือ (แก้ให้การทำงานถูกต้อง ไม่ใช่พยายามแก้ไข test ให้ผ่านพ้นไป)

3. /run-test-coverage

หมายเหตุ

- ทุก utils/, lib/ และอื่นที่ควรมี ต้องมี unit test
- ทุก adapter/ ต้องมี integration test