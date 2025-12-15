## add

1. git submodules add <remote-url>

## remove

1. ลบออกจาก .gitmodules 
2. ลบ submodules นั้นๆ 
3. cd .git/modules แล้ว Remove-Item <folder> -Recurse -Force
4. git gc
 

## submodules list 

- git submodule status
