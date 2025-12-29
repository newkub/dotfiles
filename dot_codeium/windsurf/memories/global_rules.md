

## ต้องทำตามกฏนี้ทุกครั้งอย่างเคร่งครัดเสมอทุกครั้ง

1. talking with me

- คุยกับผมเป็นภาษาไทย ที่กระชับ ในรูปแบบ bullet
- ถ้าพิมพ์ "." หมายถึง "ทำต่อ"

2. task

must

- หา TODO.md ถ้าอยู่ใน workspace ไหนให้ทำที่นั้น และถ้าทำครบหมดแล้วให้ลบ TODO.md 
- ก่อนจบ task ต้อง /run-lint เสมอ 
- ก่อนจบ task ต้อง /follow-todo เสมอ 
- ถ้าไม่มั่นใจ อย่ามั่ว ให้ search หรือใช้ @mcp : deepwiki ก่อน ถ้าไม่มีลองใช้ @mcp : context7
- เวลาสร้างอะไรใหม่ อย่าสร้างอะไรยาวๆตั้งแต่ครั้งแรก ให้ break down แยกเป็นไฟล์น่อยๆ ตาม /follow-framework 
- ทุกครั้งที่มีการแก้ไขใน /windsurf-global-workflows ให้ทำตาม /update-windsurf-global-workflows เสมอ


if 

- ถ้าอ่านเจอ @ai ใน comment ในไฟล์ต่างๆให้ทำสิ่งนั้นด้วย 
- ถ้าใช้ turborepo และ run task ใน package.json ถ้าที่คุยกัน @files ให้ใช้ filter เช่น turbo run lint --filter=@workspace



5. tools

- /check-file-structures
- /search
- /replace
- /check-cli-installed 
- new file, delete file => pwsh


6. env

- GITHUB_USERNAME 
- GITHUB_REPOSITORY 

เวลาใช้งานจะกำหนด {ENV} เช่น {GITHUB_USERNAME}



7. ห้ามทำ

- ไม่ใช้ "*-ignore" ต่างๆ

8. prerequisites

- fd => https://github.com/sharkdp/fd 
- rg => https://github.com/BurntSushi/ripgrep
- ast-grep => https://github.com/ast-grep/ast-grep
- eza => https://github.com/eza-community/eza
- open => https://crates.io/crates/open

