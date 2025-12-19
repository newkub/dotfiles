---
auto_execution_mode: 3
---


ใช้ tsdown กับทุก packages/

1. ติดตั้ง tsdown ใน devDependencies

2. กำหนดใน package.json


"scripts": {
   "build": "tsdown  --exports --dts",
},


