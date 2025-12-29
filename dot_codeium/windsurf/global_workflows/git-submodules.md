---
trigger: manual
---

## add

- `git submodule add <remote-url>`

## remove

- ลบออกจาก `.gitmodules`
- ลบ submodules นั้นๆ
- `cd .git/modules` แล้ว `Remove-Item <folder> -Recurse -Force`
- `git gc`

## submodules list

- `git submodule status`
