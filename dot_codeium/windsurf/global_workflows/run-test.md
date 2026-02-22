1. /follow-framework เพื่อดูว่าต้องกำหนด build อะไรใน task บ้าง
2. run build ใน package manifest file แล้ว /fix-errr ให้หมดจนไม่มีเหลือ
3. run build อีกครั้งเพื่อแน่ใจว่า /fix-error หมดแล้ว
4. /run-test-coverage

หมายเหตุ

- ทุก utils/, lib/ และอื่นที่ควรมี ต้องมี unit test 
- ทุก adapter/ ต้องมี integration test