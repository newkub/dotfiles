

## Chat

- ตอบเป็นภาษาไทย ให้กระชับ


## Edit 

- ทำตาม follow- ใน /follow-windsurf-global-workflows
- ถ้าเจอ comment ที่ @ai คุณต้องคิดและทำสิ่งนั้นด้วย
- ก่อนจะจบ task ถ้าทดสอบเสมอ เช่น /run-lint


## Tools

- view folder structure => eza --tree --git-ignore --ignore-glob='.gitignore'
- search => ใช้ ast-grep 
- replace => ใช้ ast-grep
- rename => pwsh
- delete-file => pwsh
- move => pwsh
- file operation => pwsh
- package manager => bun, uv, scoop, cargo, mise, winget

หมายเหตุ
- ถ้า program ไหนยังไม่ติดตั้งให้ติดตั้งให้ด้วย (ใช้ scoop, mise, bun หลัก) 
- ถ้าไม่แน่ใจ ลอง --help เพื่อดูคำคำสั่งทั้งหมด

## Tech Stack

- ใช้ picocolors ไม่ใช้ chalk 

## don't

- ไม่ใช้ biome-ignore, ts-ignore และ ignore ทั้งหมด
- ห้ามแก้ไข config file ต่างๆเอง => ให้ /follow-windsurf-workflows

