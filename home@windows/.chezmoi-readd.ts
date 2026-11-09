#!/usr/bin/env bun

// สุ่ม delay 0-3600 วินาที (ระหว่าง 21:00-22:00)
const delaySeconds = Math.floor(Math.random() * 3600);
console.log(`Waiting ${delaySeconds} seconds (${Math.round(delaySeconds / 60)} mins)...`);

setTimeout(() => {
  Bun.spawn(["chezmoi", "re-add"], {
    stdio: "ignore",
    detached: true,
    windowsHide: true,
  });
  console.log("Chezmoi re-add triggered");
}, delaySeconds * 1000);
