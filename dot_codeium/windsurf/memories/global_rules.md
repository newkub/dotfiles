---
trigger: always_on
description: Global Development Rules & Guidelines
instruction:
  - Follow prerequisites and tool requirements
  - Use pwsh shell and bun package manager
  - Follow task workflow phases
  - Apply best practices
  - Avoid prohibited actions
---

## 1. Task With Me (ใช้ทุกงาน)
1.1. `ภาษา` : สื่อสารระหว่างทำงาน -> ใช้ภาษาไทย
1.2. `การสั่งทำต่อ` : พิมพ์ "." -> ทำงานต่อจากสถานะล่าสุด
1.3. `การใช้ ENV` : มีการใช้ {} -> อ้างอิงค่า ENV จาก section "ENV"

---

## 2. Task Workflow Phases (ใช้ทุกงาน)

### 2.1. BEFORE_TASK (ใช้ก่อนเริ่มงาน)
2.1.1. `การเตรียมโปรเจกต์` : ก่อนเริ่มงาน -> ทำ /prepare-project
2.1.2. `การวิเคราะห์โปรเจกต์` : ก่อนเริ่มลงมือแก้/เพิ่มโค้ด -> ทำ /analyze-project
2.1.3. `การวางแผน` : งานมีหลายขั้นตอน หรือแตะหลายไฟล์ -> ทำ PLANNING ให้เป็น task ย่อยๆจำนวนมาก และทำให้ครบ
2.1.4. `การ breakdown ก่อน planning` : ก่อนเริ่ม planning -> BREAKDOWN เป็น numbered list เป็นข้อๆ ที่ชัดเจน

### 2.2. ON_TASK (ใช้ระหว่างทำงาน)
2.2.1. `การดูโครงสร้าง` : เริ่มสำรวจหรือยังไม่มั่นใจจุดแก้ไข -> ดูโครงสร้างโปรเจกต์ด้วย /check-file-structures
2.2.2. `การแตกงานสร้างไฟล์` : ต้องสร้างของใหม่ -> BREAKDOWN เป็นไฟล์ย่อยๆ โดยเรียง config file, types, ui, function, io และหลีกเลี่ยงไฟล์ยาว
2.2.3. `การใช้เครื่องมือ` : ต้องใช้ CLI ใดๆ -> ตรวจสอบก่อนด้วย /check-cli-installed
2.2.4. `การทำให้แก้จริง` : มีการแก้ไขโค้ดหรือไฟล์ -> ทำ /make-real ทุกครั้ง
2.2.5. `การใช้ MCP` : ต้องใช้งาน MCP -> ใช้ config ที่ c:/Users/{COMPUTER_USERNAME}/.codeium/windsurf/mcp_config.json
2.2.6. `การทำตามคำสั่งในไฟล์` : พบคอมเมนต์ @ai ในไฟล์ -> ทำตามนั้น
2.2.7. `การค้นหาเมื่อไม่แน่ใจ` : ไม่มั่นใจแนวทางหรือคำตอบ -> SEARCH ด้วย google search หรือ mcp:deepwiki หรือ mcp:context7
2.2.8. `การขอข้อมูลเพิ่ม` : ต้องให้คุณเปิดไฟล์/ให้ข้อมูลเพิ่ม -> ขอด้วย open <file>
2.2.9. `การทำงานเยอะ` : งานมีจำนวนมากหรือซ้ำๆ -> AUTOMATE ด้วย /use-scripts
2.2.10. `การทำ mockup` : ต้องใช้รูป/ข้อมูลตัวอย่าง -> ใช้ URL จริงจาก unsplash หรือแหล่งอื่น
2.2.11. `การจัดการปัญหาระหว่างทาง` : พบ ERROR หรือ WARNING -> จดไว้ และก่อนจบงานให้กลับมา FIX ให้ครบ
2.2.12. `การไม่ปิดปัญหา` : ต้องแก้ lint/test/type -> ห้ามใช้ pattern กลุ่ม *-ignore เพื่อกลบปัญหา
2.2.13. `การตั้งค่า` : ต้องใส่ค่าคงที่ที่ควรยืดหยุ่น -> ห้าม HARD_CODE
2.2.14. `ประสิทธิภาพ` : เลือก dependency/แนวทาง -> ห้ามใช้ lib ที่ไม่มีประสิทธิภาพ

---

## 3. Before Task End (ใช้ก่อนจบงาน)
3.1. `คุณภาพโค้ด` : ก่อนสรุปงาน -> ทำ /run-lint
3.2. `การปรับปรุงโครงสร้าง` : ก่อนสรุปงาน -> ทำ /refactor
3.3. `งานค้าง` : มี TODO.md -> ทำตาม TODO.md ให้ครบ และลบ TODO.md
3.4. `การตรวจแผน` : มี PLAN -> VALIDATE ว่าทำครบทุกข้อ ถ้ายังไม่ครบให้ทำจนกว่าจะครบ
3.5. `ไอเดียต่อยอด` : ปิดงานแล้ว -> ขอ /idea-features

---

## 4. ENV (ใช้เมื่อมีการใช้ {})

4.1. `การอ้างอิงค่า` : มีการใช้ {} ในข้อความหรือ path -> ใช้ค่า ENV ต่อไปนี้

```env [.env]
COMPUTER_USERNAME = "newkub"
GITHUB_USERNAME = "newkub"
```

---

## 5. Tools (ใช้ทุกงาน)
5.1. `Shell` : รันคำสั่งบนเครื่อง -> ใช้ pwsh
5.2. `CLI ตรวจสอบ` : ก่อนใช้เครื่องมือใดๆ -> ใช้ /check-cli-installed
5.3. `File operation` : ทำงานเกี่ยวกับไฟล์/โฟลเดอร์ -> ใช้ pwsh
