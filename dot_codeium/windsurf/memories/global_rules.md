

## ต้องทำตามกฏนี้ทุกครั้งอย่างเคร่งครัด 

1. คุยกับผมเป็นภาษาไทย ที่กระชับ ในรูปแบบ bullet


2. เวลาจะแก้ไฟล์อะไรทุกครั้งให้ไปดู "C:/Users/Veerapong/.codeium/windsurf/global_workflows" ว่ามีอะไรให้ใช้บ้าง แล้วทำตามนั้น

3. ถ้าอ่านเจอ @ai ใน comment ในไฟล์ต่างๆให้ทำสิ่งนั้นด้วย


4. ก่อนจบ task ต้องค้นหา TODO.md ถ้าไฟล์อยู่ใน workspace นั้นให้ทำ workspace นั้น ทำให้ครบ เมื่อทำแล้วลบเนื้อหาออกจาก TODO.md ด้วย (ห้ามลบไฟล์)

4. ทุกครั้งที่แก้ไขให้ /follow-framework

6. ก่อนจน task ต้องทำ
- /run-lint เสมอๆ 
- หา TODO.md ถ้าอยู่ใน workspace ไหนให้ทำที่นั้น และถ้าทำแล้วให้ลบเนื้อหาออกจาก TODO.md ด้วย (ห้ามลบไฟล์)

7. ถ้าต้องการ analyze ไฟล์จำนวนมากๆ สามารถสร้าง .ts ใน .windsurf/scripts/ เพื่อ analyze ได้ แต่ก่อนรันจริง ต้อง bunx tsc --noEmit <file> ก่อน

8. ถ้า ส่ง file, path ให้ ให้ทำใน workspace นั้นๆ ถ้าแต่ไม่ส่งให้ให้ทำที่ root 

9. เวลาทำอะไรคุณทำได้เลย เอาตามที่แนะนำ ไม่ต้องถามผมให้ตัดสินใจ ถ้าผมไม่ได้บอก

10. ถ้าพยายามแก้หลายรอบ ถ้าไม่มั่นใจ

- ใช้ @mcp : deepwiki ก่อน ถ้าไม่มีลองใช้ @mcp : context7

11. เวลา setup ใหม่ 
- ถ้าใช้ node, bun, rust ให้เริ่มจาก /follow-package-json 

12. เวลาสร้างอะไรใหม่ ให้สร้างแต่ละไฟล์ตาม folder ต่างๆที่เหมาะสมเลย อย่าสร้างอะไรยาวๆตั้งแต่ครั้งแรก  


12. เครื่องมือ

- file operation => pwsh
- package manager => bun, uv, scoop, cargo, mise, winget
- list all files => eza --tree --git-ignore --ignore-glob='.gitignore' 

12. ควรทำ

- ถ้าไม่มั่นใจ อย่ามั่ว ให้ search ก่อนเสมอ
- ทำตาม best practics ของ lib นั้นๆเสมอๆ
- ทำให้ type safe เสมอ


12. ห้ามทำ

- ไม่ใช้ "*-ignore" ต่างๆ"


