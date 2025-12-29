---
trigger: always_on
---
 
 
 
 
## rust + turborepo

- ถ้าจะ rust ต้องใช้คู่กับ /follow-turborepo เสมอ
- ถ้า rust project อยู่ใน apps/ ให้ใช้ scripts แบบ general และถ้าอยู่ใน packages/ ให้ใช้ scripts แบบ advanced และกำหนดให้เหมาะสม
 
### ถ้า project อยู่ใน apps/
 
 
``` json [package.json]
{
	"name": "tui",
	"private": true,
	"scripts": {
        // ====== General / Dev ======
        "postinstall": "cargo update",
        "lint": "cargo check && cargo clippy --all-targets --all-features -- -D warnings",
        "test": "cargo test --all-features && cargo nextest run --all-features",
        "build" : "cargo build",
        "build:windows": "cargo build --release --target x86_64-pc-windows-msvc",
        "build:wasm": "wasm-pack build --out-dir ./pkg",
        "build:node": "napi build --platform --release",
        "release": "cargo build --release",
        "verify": "cargo fmt --all -- --check && cargo clippy --all-targets --all-features -- -D warnings && cargo nextest run && cargo audit && cargo build",
    }
}
```
 
### ถ้า project อยู่ใน packages/
 
ให้เหมือน ถ้า project อยู่ใน apps/ แต่เพิ่ม scripts ตามความเหมาะสม
 
``` json [package.json]
{
	"name": "tui",
	"private": true,
	"scripts": {
        // ====== Full / Profiling / Debug ======
        "check:memory": "cargo build --release && valgrind --leak-check=full ./target/release/tui",
        "check:memory:heap": "cargo build --release && heaptrack ./target/release/tui",
        "check:memory:miri": "cargo +nightly miri test",
        "check:memory:asan": "RUSTFLAGS='-Z sanitizer=address' cargo +nightly test",
        "check:cpu": "cargo flamegraph --release",
        "check:cpu:stat": "cargo build --release && perf stat ./target/release/tui",
        "check:cpu:perf": "cargo build --release && perf record ./target/release/tui",
        "check:gpu:intel": "intel_gpu_top",
        "check:gpu:nvidia": "nvidia-smi dmon",
        "check:gpu:amd": "radeontop",
        "bench": "cargo bench"
	}
}
 
 
 
 
2. /follow-rust-best-practics
