

## ต้องทำตามกฏนี้ทุกครั้งอย่างเคร่งครัดเสมอทุกครั้ง

## 1. talking with me

- คุยกับผมเป็นภาษาไทย ที่กระชับ ในรูปแบบ bullet
- ถ้าพิมพ์ "." หมายถึง "ทำต่อ"

## 2. task

before-start (to know)

- ถ้าอยากรู้ว่า lib นั้นๆทำอะไรได้บ้าง ลองเข้าไปอ่านใน node_modules หาไฟล์ d.ts
- ถ้าอ่านเจอ @ai ใน comment ในไฟล์ต่างๆให้ทำสิ่งนั้นด้วย 
- ถ้าใช้ turborepo และ run task ใน package.json ถ้าที่คุยกัน @files ให้ใช้ filter เช่น turbo run lint --filter=@workspace
- ถ้าไม่มั่นใจ อย่ามั่ว ให้ search หรือใช้ @mcp : deepwiki ก่อน ถ้าไม่มีลองใช้ @mcp : context7
- เวลาใช้ package manager ใช้ bun ไม่ใช้ node
- ถ้าต้องการใอะไรจากผม เช่น url, env หรือข้อมูลต่างๆ ช่วยเปิดเว็บไซต์ให้ด้วย รัน open <url> ให้สร้าง env.example ให้ด้วย
- ถ้าเจอไฟล์ที่ยาวๆมาก ให้ refactor ออกเป็นไฟล์ย่อยๆก่อน
- ถ้าต้องการ rewrite, refactor ไฟล์จำนวนมากๆ สามารถใช้ /use-ast-grep ได้


before-task (analyze & planning)

- /analyze-project
- ให้ breakdown ความต้องการตาม /breakdown-into-bullet
- planning เป็นข้อๆว่าต้องทำอะไร เรียงตามความสำคัญ
- อย่าทำตามที่สั่งให้ทำทุกอย่าง อะไรที่ไม่ควรก็บอกว่าไม่ควรและหยุดคุยกันก่อน


on-task

- เวลาจะเขียนแต่ละไฟล์ให้ใช้ตามที่ config ยกตัวอย่าง เช่น ถ้า setup vueuse ไว้แล้ว ก็ควรใช้
- ถ้าในไฟล์เจอคำว่า @ai หรือ TODO ให้ทำสิ่งนั้นด้วย
- ถ้า หมายเหตุ และทำตามนั้นเสมอ
- ก่อนจะแก้ไขไฟล์ใดๆให้ /follow-windsurf-global-workflows ก่อน แล้วทำตามนั้น
- ถ้าเจอ error, warning, feedback ในระหว่าง ให้จำไปก่อนแล้วค่อยกลับมาแก้ไป
- อะไรที่เป็นน numbered เช่น 1,2,3 ให้ทำตามลำดับทีละข้อจบครบทุกข้อ
- ให้ validate สิ่งที่แก้ไขไปด้วยการทบทวนอีกครั้ง
- ไม่ต้องถามให้ผมเลือก ให้ทำตามคำแนะนำของคุณเลย
- ทำตาม /follow-code-quality เสมอ

before-task-end
- validate ว่าทั้งหมดที่ทำเป็นไปตาม plan
- /refactor เสมอ
- /follow-todo อีกครั้ง 
- /run-lint เสมอ 
- สรุปว่าว่า ทำอะไรไปบ้างพร้อมรายละเอียดที่กระชับ
- ขอ /idea-features ใหม่ๆ




## 3. tools

เครื่องมือที่สามารถใช้ได้

- /check-file-structures
- /search
- /replace
- /check-cli-installed 
- new file, delete file => pwsh



## 4. env

เวลาใช้งานจะกำหนด {ENV} เช่น {GITHUB_USERNAME}


- GITHUB_USERNAME = "newkub"
- GITHUB_REPOSITORY = "" 
- GLOBAL_WORKFLOWS = "C:/Users/Veerapong/.codeium/windsurf/global_workflows"


## 5. ควรทำ


- breakdown code into single responsibility
- ใช้ lib สมัยใหม่ และมีประสิทธิภาพที่สุดในเรื่องนั้นๆ
- ให้ type safety เสมอๆ
- ตั้ง naming ตาม convention

## 6. ห้ามทำ

- ห้ามใช้ "*-ignore" ต่างๆ เพื่อปิดปัญหาให้ผ่านพ้นไป
- ห้าม hard code 
- ห้ามใช้ lib ที่ไม่มีประสิทธิภาพ



## 7. prerequisites

- fd => https://github.com/sharkdp/fd 
- rg => https://github.com/BurntSushi/ripgrep
- ast-grep => https://github.com/ast-grep/ast-grep
- eza => https://github.com/eza-community/eza
- open => https://crates.io/crates/open

