---
title: Follow Bun
description: แนวทางการใช้งาน Bun native APIs ให้เต็มประสิทธิภาพ โดยใช้ทั้ง Bun-specific APIs และ Web-standard APIs ที่ Bun รองรับ
auto_execution_mode: 3
---

## Prompt

ใช้สำหรับพัฒนาโปรเจกต์ด้วย Bun native APIs ให้เต็มประสิทธิภาพ โดยใช้ทั้ง Bun-specific APIs และ Web-standard APIs ที่ Bun รองรับ

## Execute

1. วิเคราะห์ความต้องการและเลือก APIs ที่เหมาะสม

- ตรวจสอบว่าต้องการ Bun native APIs หรือ Web APIs
- ประเมิน performance requirements และ use case
- เลือก APIs ที่เหมาะสมกับงาน (HTTP server, file I/O, networking, database, etc.)

2. ดำเนินการพัฒนาตาม Bun APIs best practices

- ใช้ `Bun.serve()` สำหรับ HTTP server แทน Node.js http module
- ใช้ `$` shell template literal สำหรับ shell commands
- ใช้ `Bun.file()` และ `Bun.write()` สำหรับ file operations
- ใช้ `Bun.spawn()` หรือ `Bun.spawnSync()` สำหรับ child processes
- ใช้ Web-standard APIs เมื่อเป็นไปได้ (fetch, ReadableStream, etc.)

3. ตรวจสอบและ optimize การใช้งาน Bun APIs

- ยืนยันว่าใช้ Bun APIs อย่างถูกต้องตาม documentation
- ตรวจสอบ error handling และ edge cases
- เปรียบเทียบ performance กับ alternative approaches

## Rules

1. HTTP Server APIs

- `Bun.serve()` - HTTP server สำหรับสร้าง web server พร้อม routing และ WebSocket support
- `Bun.websocket()` - WebSocket server สำหรับ real-time communication
- รองรับ TLS, cookies, error handling, และ metrics

2. Shell & Process APIs

- `$` - Shell template literal สำหรับรัน shell commands แบบ cross-platform
- `Bun.spawn()` - Spawn child process (async) คืน `Subprocess` object
- `Bun.spawnSync()` - Spawn child process (sync) คืน `SpawnSyncResult`
- รองรับ stdin/stdout/stderr redirection, environment variables

3. File I/O APIs

- `Bun.file()` - สร้าง `BunFile` object สำหรับอ่านไฟล์ (lazy loading)
- `Bun.write()` - เขียนไฟล์ รองรับ string, Blob, ArrayBuffer, Response
- `Bun.stdin` / `Bun.stdout` / `Bun.stderr` - Standard streams

4. Networking APIs

- `Bun.listen()` - TCP server สำหรับสร้าง TCP listener
- `Bun.connect()` - TCP client สำหรับเชื่อมต่อ TCP server
- `Bun.udpSocket()` - UDP socket สำหรับ UDP communication
- `Bun.dns.lookup()` - DNS resolution พร้อม prefetch และ cache

5. Bundler & Build APIs

- `Bun.build()` - Bundle JavaScript/TypeScript/CSS/HTML ด้วย esbuild-compatible API
- `Bun.plugin()` - Register build plugin สำหรับ custom loaders
- `Bun.Transpiler()` - Transpile code (TypeScript, JSX, TSX) เป็น JavaScript
- `Bun.FileSystemRouter()` - File-based routing สำหรับ building frameworks

6. Database APIs

- `bun:sqlite` - Built-in SQLite driver สำหรับ high-performance queries
- `Bun.SQL` / `Bun.sql` - SQL client สำหรับ PostgreSQL/MySQL ด้วย prepared statements
- `Bun.RedisClient` / `Bun.redis` - Built-in Redis client สำหรับ Redis operations

7. Hashing & Crypto APIs

- `Bun.password` - Password hashing (bcrypt, argon2, scrypt) พร้อม verification
- `Bun.hash()` - Fast hash function สำหรับ general purpose hashing
- `Bun.CryptoHasher()` - Streaming crypto hasher (SHA-1, SHA-256, SHA-512, MD5)
- `Bun.sha` - SHA hash utilities (sha-256, sha-384, sha-512, sha-512-256)

8. Utilities APIs

- `Bun.sleep()` / `Bun.sleepSync()` - Sleep for milliseconds
- `Bun.nanoseconds()` - High-resolution timer (monotonic)
- `Bun.randomUUIDv7()` - Generate UUID v7 (time-ordered)
- `Bun.which()` - Find executable path (cross-platform `which`)
- `Bun.peek()` - Peek value from Promise (non-blocking)
- `Bun.deepEquals()` - Deep equality comparison
- `Bun.inspect()` - Object inspection (Node.js util.inspect compatible)
- `Bun.escapeHTML()` - HTML escape special characters
- `Bun.stringWidth()` - Calculate display width (handles Unicode, ANSI)

9. Compression APIs

- `Bun.gzipSync()` / `Bun.gunzipSync()` - Gzip compression/decompression
- `Bun.deflateSync()` / `Bun.inflateSync()` - Deflate compression/decompression
- `Bun.zstdCompressSync()` / `Bun.zstdDecompressSync()` - Zstd compression
- `Bun.zstdCompress()` / `Bun.zstdDecompress()` - Async Zstd compression

10. Streams & Buffer APIs

- `Bun.readableStreamTo*()` - Convert ReadableStream (toBlob, toArrayBuffer, toJSON, etc.)
- `Bun.ArrayBufferSink` - Accumulate data into ArrayBuffer
- `Bun.allocUnsafe()` - Allocate ArrayBuffer without zeroing (faster)
- `Bun.concatArrayBuffers()` - Concatenate multiple ArrayBuffers

11. Data Parsing APIs

- `Bun.TOML.parse()` - Parse TOML files
- `Bun.markdown()` - Parse and manipulate Markdown
- `Bun.color()` - Color parsing and manipulation (RGB, HSL, HEX, CSS names)
- `Bun.semver` - Semantic version parsing and comparison
- `Bun.Glob` - Glob pattern matching (fast file matching)
- `Bun.Cookie` / `Bun.CookieMap` - HTTP Cookie parsing and serialization

12. Security APIs

- `Bun.CSRF.generate()` / `Bun.CSRF.verify()` - CSRF token generation and verification
- `Bun.CSRF.unsafe` - Low-level CSRF operations
- `HTMLRewriter` - HTML streaming transformation (Cloudflare Workers compatible)

13. FFI & Low-level APIs

- `bun:ffi` - Foreign Function Interface สำหรับ calling C functions
- `bun:jsc` - JavaScriptCore engine utilities
- `Bun.mmap` - Memory-mapped files
- `Bun.gc` - Garbage collection control
- `Bun.generateHeapSnapshot()` - Generate heap snapshot for debugging

14. Other Bun APIs

- `bun:test` - Built-in test runner (Jest-compatible)
- `Bun.env` - Environment variables (faster than `process.env`)
- `Bun.version` / `Bun.revision` - Bun version information
- `Bun.main` - Main entry point file path
- `Bun.resolveSync()` - Module resolution (sync)

15. Web-standard APIs (ที่ Bun รองรับ)

- `fetch`, `Request`, `Response`, `Headers` - HTTP client APIs
- `AbortController`, `AbortSignal` - Request cancellation
- `URL`, `URLSearchParams` - URL manipulation
- `Worker`, `self.postMessage` - Web Workers
- `structuredClone`, `MessagePort`, `MessageChannel`, `BroadcastChannel` - Structured cloning
- `ReadableStream`, `WritableStream`, `TransformStream` - Web Streams
- `Blob`, `WebSocket` - Binary data และ WebSocket
- `atob`, `btoa`, `TextEncoder`, `TextDecoder` - Encoding utilities
- `setTimeout`, `setInterval`, `clearTimeout`, `clearInterval` - Timers
- `crypto`, `SubtleCrypto`, `CryptoKey` - Web Crypto API
- `console`, `performance`, `queueMicrotask`, `reportError` - Global utilities
- `EventTarget`, `Event`, `ErrorEvent`, `CloseEvent`, `MessageEvent` - Event system
- `ShadowRealm` - Isolated JavaScript execution environment

## Reference

- [Bun APIs Documentation](https://bun.com/docs/runtime/bun-apis)
- [Web APIs Documentation](https://bun.com/docs/runtime/web-apis)
- [Bun HTTP Server](https://bun.com/docs/runtime/http/server)
- [Bun File I/O](https://bun.com/docs/runtime/file-io)

