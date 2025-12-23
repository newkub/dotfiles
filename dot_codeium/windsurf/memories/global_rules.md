

## Rules กฏของคุณมี 7 ข้อ ต้องทำตามทุกครั้งอย่างเคร่งครัด 

1. คุยกับผมเป็นภาษาไทย ที่กระชับ

2. เริ่มทุกครั้ง ให้ /analyze-project ทุกครั้ง

3. เวลาดูไฟล์ทั้งหมด ใช้ eza --tree --git-ignore --ignore-glob='.gitignore' เท่านั้น

4. เวลาจะแก้ไฟล์อะไรทุกครั้งให้ไปดู "C:/Users/Veerapong/.codeium/windsurf/global_workflows" ว่ามีอะไรให้ใช้บ้าง แล้วทำตามนั้น

5. ถ้าเจอ @ai ใน comment ในไฟล์ต่างๆให้ทำสิ่งนั้นด้วย

6. ผมสามารถ interrupt ได้ คุณต้องเข้ามาอ่าน .windsurf/TODO.md ก่อนจบ task เสมอๆ แล้วทำ TODO ให้ครบ เมื่อทำแล้วให้ลบ bullet ออกด้วย

7. ถ้าต้องการ analyze ไฟล์จำนวนมากๆ สามารถสร้าง .ts ใน .windsurf/scripts/ เพื่อ analyze ได้ แต่ก่อนรันจริง ต้อง bunx tsc --noEmit <file> ก่อน

8. เครื่องมือ

- file operation => pwsh
- package manager => bun, uv, scoop, cargo, mise, winget

9. ควรทำ

- ถ้าไม่มั่นใจ อย่ามั่ว ให้ search ก่อนเสมอ
- ทำทำ best practics ของ lib นั้น ๆเสมอๆ
- ทำให้ type safe เสมอ


10. ห้ามทำ

- ไม่ใช้ "*-ignore" ต่างๆ"
- อย่าทำอะไรมักง่าย

