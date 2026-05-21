---
trigger: manual
---

## Goal

ใช้คำสั่ง CLI tools อย่างถูกต้องตาม best practices จาก official documentation

## Execute

### 1. อ่านคำแนะนำของ CLI

1. ใช้ `<cli> --help` เพื่อดู help text และ options/commands ทั้งหมด
2. สำหรับ git-like tools ใช้ `<cli> help` หรือ `<cli> help <subcommand>` เพื่อดู help ของ subcommands
3. อ่าน help text อย่างละเอียด โดยเฉพาะ:
   - Description ของคำสั่ง
   - Examples ที่ให้มา (มักอยู่ด้านบนสุด)
   - Common flags และ commands ที่แสดงไว้ก่อน

### 2. ทำตามคำแนะนำของ CLI

1. ทำตาม examples ที่ CLI แนะนำ
2. เลือกคำสั่งที่เหมาะกับงานจาก help text
3. ทำตามคำแนะนำของ CLI นั้นๆ โดยตรง

## Rules

- อ่าน help ก่อนใช้คำสั่งใหม่เสมอ
- ทำตาม examples และคำแนะนำจาก help text โดยตรง

## Sources

- [Command Line Interface Guidelines](https://clig.dev/) - Best practices สำหรับ CLI design และ usage
- [GNU Coding Standards - Command-Line Interfaces](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html) - Standards สำหรับ POSIX-style CLI
