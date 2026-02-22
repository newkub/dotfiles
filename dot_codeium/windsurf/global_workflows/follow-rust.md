---
description: ตั้งค่าและพัฒนา Rust packages ตาม strict best practices ด้วย monorepo structure
title: agents-md
auto_execution_mode: 3
---

## 1. Pre-Execution

1. **Prepare**
   - ตรวจสอบว่า Rust toolchain ติดตั้งและอัพเดทเป็นเวอร์ชันล่าสุด
   - ยืนยันว่ามี cargo, rustfmt, clippy, nextest พร้อมใช้งาน
   - เตรียม workspace configuration สำหรับ monorepo และ turborepo
   - ตรวจสอบสิทธิ์การสร้างไฟล์ใน packages/ และ apps/ directories

2. **Analyze**
   - ศึกษาสถานะปัจจุบันของ workspace และ packages ที่มีอยู่
   - ระบุปัญหาหลักที่ต้องแก้ไขคือการจัดโครงสร้างโค้ดให้เป็นไปตาม best practices
   - เข้าใจ constraints ของการแบ่งไฟล์ไม่เกิน 200 บรรทัดและ security requirements
   - วิเคราะห์ dependencies ที่ใช้ร่วมกันระหว่าง packages

3. **Planning**
   - เรียงลำดับความสำคัญของการพัฒนา packages ตาม dependencies graph
   - แบ่งงานออกเป็น 4 หมวดหลัก: Rules, Structure, Workflow, Quality Assurance
   - ประเมินเวลาที่ต้องใช้สำหรับการ refactor และ setup monorepo structure
   - วางแผนการทดสอบและ validation สำหรับแต่ละขั้นตอน



## 2. Main Operations

1. **Define Code Quality Standards**
   - กำหนด Breakdown Strategy ให้แบ่งโค้ดเป็นไฟล์เล็กๆ ที่สุด (ไม่เกิน 200 บรรทัด)
   - ตั้งค่า Type Safety requirements ให้ใช้ strong typing และ generics
   - สร้าง Side Effect Reduction guidelines สำหรับ pure functions และ immutable state
   - กำหนด Performance Optimization standards สำหรับ memory efficiency และ async patterns
   - ตั้งค่า Developer Experience requirements สำหรับ documentation และ testing

2. **Setup Security & Production Rules**
   - ห้าม hardcode sensitive data หรือ configuration values ใน source code
   - กำหนดว่าห้ามสร้าง mockup data สำหรับ production environments
   - ตั้งค่า production ready requirements สำหรับ code quality และ error handling
   - สร้าง security audit checklist สำหรับ dependencies และ vulnerabilities

3. **Configure Monorepo Structure**
   - สร้าง workspace configuration สำหรับ Rust monorepo และ turborepo
   - ตั้งค่า `packages/monorepo/` structure พร้อม apps/ และ packages/ directories
   - กำหนด directory layout สำหรับ tests/, benches/, scripts/, tools/, config/, crates/, examples/, docs/
   - สร้าง summary table สำหรับแต่ละ folder พร้อมวัตถุประสงค์และ tools

4. **Implement Development Workflow**
   - กำหนด phases สำหรับ Development, Formatting, Testing, Benchmarks, Release
   - สร้าง table แสดง commands, output และ duration สำหรับแต่ละ phase
   - ตั้งค่า Quality Assurance schedule สำหรับ Unit Tests, Integration Tests, E2E Tests, Benchmarks
   - กำหนด tools และ coverage requirements สำหรับแต่ละประเภทการทดสอบ

```
monorepo/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── release.yml
├── .cargo/
│   └── config.toml
├── apps/
│   ├── cli/
│   │   ├── src/
│   │   │   ├── main.rs
│   │   │   ├── lib/
│   │   │   │   ├── mod.rs
│   │   │   │   ├── commands/
│   │   │   │   │   ├── mod.rs
│   │   │   │   │   ├── build.rs
│   │   │   │   │   ├── test.rs
│   │   │   │   │   └── deploy.rs
│   │   │   │   ├── services/
│   │   │   │   │   ├── mod.rs
│   │   │   │   │   ├── config.rs
│   │   │   │   │   ├── logger.rs
│   │   │   │   │   └── workspace.rs
│   │   │   │   └── utils/
│   │   │   │       ├── mod.rs
│   │   │   │       ├── output.rs
│   │   │   │       └── validation.rs
│   │   │   └── tests/
│   │   │       ├── integration/
│   │   │       └── unit/
│   │   ├── Cargo.toml
│   │   └── README.md
│   └── web/
│       ├── app/                    # Nuxt 4 app directory
│       │   ├── components/         # Vue components
│       │   │   ├── ui/
│       │   │   │   ├── Button.vue
│       │   │   │   ├── Modal.vue
│       │   │   │   └── Form.vue
│       │   │   ├── layout/
│       │   │   │   ├── AppHeader.vue
│       │   │   │   ├── AppFooter.vue
│       │   │   │   └── Sidebar.vue
│       │   │   └── features/
│       │   │       ├── auth/
│       │   │       └── dashboard/
│       │   ├── composables/        # Vue composables
│       │   │   ├── useAuth.ts
│       │   │   ├── useApi.ts
│       │   │   └── index.ts
│       │   ├── layouts/            # Layout templates
│       │   │   ├── default.vue
│       │   │   ├── auth.vue
│       │   │   └── dashboard.vue
│       │   ├── middleware/         # Route middleware
│       │   │   ├── auth.ts
│       │   │   └── admin.ts
│       │   ├── pages/              # File-based routing
│       │   │   ├── index.vue
│       │   │   ├── login.vue
│       │   │   ├── dashboard.vue
│       │   │   └── users/
│       │   │       ├── index.vue
│       │   │       └── [id].vue
│       │   ├── plugins/            # Vue plugins
│       │   │   ├── api.client.ts
│       │   │   └── database.server.ts
│       │   ├── utils/              # Utility functions
│       │   │   ├── api.ts
│       │   │   ├── validation.ts
│       │   │   └── formatting.ts
│       │   ├── assets/             # Build assets
│       │   │   ├── css/
│       │   │   │   └── main.css
│       │   │   └── images/
│       │   ├── app.vue             # Main app component
│       │   └── error.vue           # Error page
│       ├── server/                 # Nitro server
│       │   ├── api/
│       │   │   ├── auth/
│       │   │   │   ├── login.post.ts
│       │   │   │   └── logout.post.ts
│       │   │   ├── users/
│       │   │   │   ├── index.get.ts
│       │   │   │   └── [id].get.ts
│       │   │   └── health.get.ts
│       │   ├── routes/
│       │   └── plugins/
│       │       └── database.ts
│       ├── shared/                 # Shared code (Nuxt 4)
│       │   ├── types/
│       │   │   ├── api.ts
│       │   │   ├── auth.ts
│       │   │   └── user.ts
│       │   └── utils/
│       │       └── index.ts
│       ├── content/                # Content module
│       ├── public/                 # Static assets
│       │   ├── favicon.ico
│       │   └── images/
│       ├── nuxt.config.ts          # Nuxt config
│       ├── package.json
│       ├── tsconfig.json
│       ├── .env.example
│       ├── .nuxtignore
│       ├── README.md
│       └── .gitignore
├── packages/
│   ├── core/
│   │   ├── .github/
│   │   │   └── workflows/
│   │   │       ├── ci.yml
│   │   │       └── release.yml
│   │   ├── src/
│   │   │   ├── lib.rs                    # re-export only if needed
│   │   │   ├── mod.rs                    # module declarations
│   │   │   ├── prelude.rs                # common imports
│   │   │   ├── types.rs                  # shared type aliases
│   │   │   ├── macros/
│   │   │   │   ├── mod.rs                # re-export macros
│   │   │   │   └── derive.rs             # derive macro implementations
│   │   │   ├── services/
│   │   │   │   ├── mod.rs                # re-export public services
│   │   │   │   ├── registry.rs           # service registration
│   │   │   │   └── discovery.rs          # service discovery logic
│   │   │   ├── utils/
│   │   │   │   ├── mod.rs                # re-export public utilities
│   │   │   │   ├── helpers.rs            # general helper functions
│   │   │   │   └── validation.rs         # input validation utilities
│   │   │   ├── error/
│   │   │   │   ├── mod.rs                # re-export error types
│   │   │   │   ├── core.rs               # CoreError, ErrorKind
│   │   │   │   ├── result.rs             # Result<T, E> type aliases
│   │   │   │   └── context.rs            # ErrorContext for rich errors
│   │   │   ├── config/
│   │   │   │   ├── mod.rs                # re-export config types
│   │   │   │   └── settings.rs           # Config struct, Default impl
│   │   │   ├── constant/
│   │   │   │   ├── mod.rs                # re-export constants
│   │   │   │   ├── defaults.rs           # default const values
│   │   │   │   └── limits.rs             # MAX_SIZE, TIMEOUT_MS, etc.
│   │   │   ├── data/
│   │   │   │   ├── mod.rs                # re-export data types
│   │   │   │   ├── model.rs              # domain models, Serialize/Deserialize
│   │   │   │   └── repository.rs         # data access patterns
│   │   │   ├── adapter/
│   │   │   │   ├── mod.rs                # re-export adapters
│   │   │   │   ├── external.rs           # external service clients
│   │   │   │   └── internal.rs           # internal service clients
│   │   │   └── traits/
│   │   │       ├── mod.rs                # re-export traits
│   │   │       ├── base.rs               # core trait definitions
│   │   │       └── extension.rs          # trait implementations
│   └── utils/
│       └── ... (โครงสร้างเดียวกับ core/)
├── tests/
│   ├── unit/
│   │   ├── processor_test.rs
│   │   └── handlers_test.rs
│   ├── integration/
│   │   ├── full_workflow_test.rs
│   │   └── api_test.rs
│   ├── e2e/
│   │   ├── full_system_test.rs
│   │   └── user_scenario_test.rs
│   ├── property/
│   │   ├── property_test.rs
│   │   └── invariant_test.rs
│   ├── stress/
│   │   ├── load_test.rs
│   │   └── memory_stress_test.rs
│   ├── fixtures/
│   │   ├── test_data.rs
│   │   └── mock_data.rs
│   └── common/
│       ├── mod.rs
│       ├── test_utils.rs
│       └── helpers.rs
├── benches/
│   ├── performance/
│   │   ├── processor_bench.rs
│   │   └── load_test.rs
│   ├── memory/
│   │   ├── memory_usage_bench.rs
│   │   └── allocation_bench.rs
│   ├── io/
│   │   ├── file_io_bench.rs
│   │   └── network_io_bench.rs
│   ├── regression/
│   │   ├── performance_regression.rs
│   │   └── memory_regression.rs
│   └── comparison/
│       └── algorithm_comparison.rs
├── scripts/
│   ├── build.sh
│   ├── test.sh
│   ├── format.sh
│   ├── lint.sh
│   └── release.sh
├── tools/
│   ├── codegen/
│   │   └── generate_types.rs
│   ├── migration/
│   │   └── migrate.rs
│   └── benchmark/
│       └── custom_bench.rs
├── crates/
│   ├── internal/
│   │   ├── utils/
│   │   └── macros/
│   └── external/
│       ├── integrations/
│       └── adapters/
├── examples/
│   ├── basic/
│   │   ├── simple_usage.rs
│   │   └── getting_started.rs
│   ├── advanced/
│   │   ├── complex_usage.rs
│   │   └── custom_config.rs
│   └── README.md
└── docs/
    ├── architecture/
    │   ├── design.md
    │   └── decisions.md
    ├── api/
    │   ├── reference.md
    │   └── examples.md
    └── guides/
        ├── quick_start.md
        └── advanced_usage.md
├── Cargo.toml
├── package.json
├── README.md
├── CHANGELOG.md
├── LICENSE
└── .gitignore
```

### Request Flow Example (Nuxt 4)

```
GET /api/users/123
    ↓
[Server Route] server/api/users/[id].get.ts → Extract user_id from params
    ↓
[Composable] useApi() → Make API call to backend
    ↓
[Middleware] auth.ts → Check authentication with useAuth()
    ↓
[Store] userStore → Update user state in Pinia store
    ↓
[Component] pages/users/[id].vue → Display user data
    ↓
Response Flow:
API Route → Composable → Store → Component → Vue Template → HTML Response
```

### Nuxt 4 Auto-imports

- **Components**: `components/` directory auto-imports all Vue components
- **Composables**: `composables/` directory auto-imports all composables
- **Utils**: `utils/` directory auto-imports all utility functions
- **Stores**: `stores/` directory auto-imports all Pinia stores
- **Types**: `types/` directory provides type definitions

### File-based Routing

- `pages/index.vue` → `/` (Home page)
- `pages/login.vue` → `/login` (Login page)
- `pages/users/index.vue` → `/users` (Users list)
- `pages/users/[id].vue` → `/users/:id` (Dynamic user page)

### Server-side API Routes

- `server/api/users/[id].get.ts` → GET /api/users/:id
- `server/api/auth/login.post.ts` → POST /api/auth/login
- `server/health.get.ts` → GET /health

## Core Applications

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `apps/` | Applications | CLI และ Web apps พร้อมโครงสร้างที่เป็นระเบียบ | Cargo, npm | package-core | cli, web, full | ✅ E2E + Integration | OOP, Functional | ✅ GitHub Actions |
| `apps/cli/` | CLI Application | Command-line interface พร้อม modules แยกตามฟังก์ชัน | Cargo | package-core | cli, full | ✅ E2E + Integration | Functional | ✅ GitHub Actions |
| `apps/cli/src/lib/` | CLI Library | Core functionality แบ่งเป็น commands, services, utils | Rust | package-core | lib, full | ✅ Unit + Integration | Functional | ✅ GitHub Actions |
| `apps/cli/src/lib/commands/` | CLI Commands | Command implementations (build, test, deploy) | Rust | package-core | commands | ✅ Unit tests | Functional | ✅ GitHub Actions |
| `apps/cli/src/lib/services/` | CLI Services | Service layer (config, logger, workspace) | Rust | package-core | services | ✅ Unit tests | Functional | ✅ GitHub Actions |
| `apps/cli/src/lib/utils/` | CLI Utils | Utility functions (output, validation) | Rust | package-core | utils | ✅ Unit tests | Functional | ✅ GitHub Actions |
| `apps/web/` | Web Application | Nuxt 4 full-stack application พร้อม Vue 3 และ TypeScript | Node.js, npm, pnpm | Nuxt 4, Vue 3, TypeScript | web, full | ✅ E2E + Integration | Vue 3, Composition API | ✅ GitHub Actions |
| `apps/web/components/` | Vue Components | Auto-imported Vue components แบ่งตามฟังก์ชัน (ui, layout, features) | Vue 3, TypeScript | Nuxt 4 | components | ✅ Unit + Component tests | Vue 3, Composition API | ✅ GitHub Actions |
| `apps/web/composables/` | Vue Composables | Auto-imported composables สำหรับ shared logic (auth, api, database) | Vue 3, TypeScript | Nuxt 4 | composables | ✅ Unit tests | Vue 3, Composition API | ✅ GitHub Actions |
| `apps/web/pages/` | File-based Routing | Pages ที่สร้าง routes อัตโนมัติ (index, login, dashboard, users) | Vue 3, TypeScript | Nuxt 4 | pages | ✅ E2E + Integration | Vue 3, File-based routing | ✅ GitHub Actions |
| `apps/web/layouts/` | Layout Templates | Layout templates สำหรับ page structure (default, auth, dashboard) | Vue 3, TypeScript | Nuxt 4 | layouts | ✅ Unit tests | Vue 3, Layout system | ✅ GitHub Actions |
| `apps/web/middleware/` | Route Middleware | Route middleware สำหรับ auth, admin checks | Vue 3, TypeScript | Nuxt 4 | middleware | ✅ Unit tests | Vue 3, Middleware pattern | ✅ GitHub Actions |
| `apps/web/server/` | Server-side Code | Nitro server code สำหรับ API routes และ server plugins | Node.js, TypeScript | Nuxt 4, Nitro | server | ✅ Unit + Integration tests | Server-side, API routes | ✅ GitHub Actions |
| `apps/web/stores/` | State Management | Pinia stores สำหรับ global state management | Vue 3, TypeScript | Nuxt 4, Pinia | stores | ✅ Unit tests | Vue 3, Pinia pattern | ✅ GitHub Actions |
| `apps/web/types/` | TypeScript Types | Type definitions สำหรับ API, auth, user data | TypeScript | Nuxt 4 | types | ✅ Type checking | TypeScript, Type safety | ✅ GitHub Actions |
| `apps/web/utils/` | Utility Functions | Auto-imported utilities สำหรับ API, validation, formatting | TypeScript | Nuxt 4 | utils | ✅ Unit tests | TypeScript, Pure functions | ✅ GitHub Actions |

## Core Libraries

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `packages/` | Core Libraries | core, package-utils พร้อมโครงสร้างที่เป็นระเบียบ | Cargo | tokio, serde | std, async, full | ✅ Unit + Integration | Functional, OOP | ✅ Automated testing |
| `packages/core/` | Core Package | Core functionality และ abstractions พร้อม modules แยกตามฟังก์ชัน | Cargo | None | std, full | ✅ Unit + Integration | Functional | ✅ Automated testing |
| `packages/core/src/services/` | Core Services | Service layer (registry, discovery) | Rust | None | services | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/core/src/utils/` | Core Utils | Utility functions (helpers, validation) | Rust | None | utils | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/` | Utils Package | Utility functions และ helpers พร้อม modules แยกตามประเภท | Cargo | core | utils, full | ✅ Unit + Integration | Functional | ✅ Automated testing |
| `packages/utils/src/lib/` | Utils Library | Core utilities แบ่งตามประเภท (crypto, io, collections, time) | Rust | core | lib, full | ✅ Unit + Integration | Functional | ✅ Automated testing |
| `packages/utils/src/lib/crypto/` | Crypto Utils | Cryptographic utilities (hash, encryption) | Rust | core | crypto | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/src/lib/io/` | IO Utils | I/O utilities (file, stream) | Rust | core | io | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/src/lib/collections/` | Collection Utils | Collection utilities (map, vector) | Rust | core | collections | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/src/lib/time/` | Time Utils | Time utilities (duration, timestamp) | Rust | core | time | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/src/services/` | Utils Services | Service utilities (cache, pool, queue) | Rust | core | services | ✅ Unit tests | Functional | ✅ Automated testing |
| `packages/utils/src/macros/` | Utils Macros | Procedural macros (derive, helpers) | Rust | core | macros | ✅ Unit tests | Functional | ✅ Automated testing |

## Testing Infrastructure

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `tests/` | Testing | Unit, Integration, E2E, Property, Stress | Cargo test, proptest | All packages | test-all, stress | ✅ All test types | Functional | ✅ Test reporting |
| `tests/unit/` | Unit Tests | Unit testing สำหรับ individual components | Cargo test | All packages | unit | ✅ Unit tests | Functional | ✅ Test reporting |
| `tests/integration/` | Integration Tests | Integration testing สำหรับ component interactions | Cargo test | All packages | integration | ✅ Integration tests | Functional | ✅ Test reporting |
| `tests/e2e/` | E2E Tests | End-to-end testing สำหรับ full workflows | Cargo test | All packages | e2e | ✅ E2E tests | Functional | ✅ Test reporting |
| `tests/property/` | Property Tests | Property-based testing สำหรับ invariants | Cargo test, proptest | All packages | property | ✅ Property tests | Functional | ✅ Test reporting |
| `tests/stress/` | Stress Tests | Stress testing สำหรับ performance limits | Cargo test | All packages | stress | ✅ Stress tests | Functional | ✅ Test reporting |
| `tests/fixtures/` | Test Fixtures | Test data และ mock objects | Cargo | All packages | fixtures | ✅ Fixture validation | Functional | ✅ Test reporting |
| `tests/common/` | Common Test Utils | Shared testing utilities | Cargo | All packages | test-utils | ✅ Utility tests | Functional | ✅ Test reporting |

## Performance & Benchmarking

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `benches/` | Benchmarking | Performance, Memory, I/O, Regression | Criterion | All packages | bench-all, perf | ✅ Benchmark suites | Functional | ✅ Regression detection |
| `benches/performance/` | Performance | Core performance benchmarks | Criterion | All packages | performance | ✅ Performance tests | Functional | ✅ Regression detection |
| `benches/memory/` | Memory | Memory usage และ allocation benchmarks | Criterion | All packages | memory | ✅ Memory tests | Functional | ✅ Regression detection |
| `benches/io/` | I/O | File I/O และ network I/O benchmarks | Criterion | All packages | io | ✅ I/O tests | Functional | ✅ Regression detection |
| `benches/regression/` | Regression | Performance regression detection | Criterion | All packages | regression | ✅ Regression tests | Functional | ✅ Regression detection |
| `benches/comparison/` | Comparison | Algorithm comparison benchmarks | Criterion | All packages | comparison | ✅ Comparison tests | Functional | ✅ Regression detection |

## Documentation & Examples

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `examples/` | Examples | Basic และ Advanced usage | Cargo run | All packages | examples, demo | ✅ Example tests | Mixed | ✅ Doc testing |
| `examples/basic/` | Basic Examples | Simple usage examples | Cargo run | All packages | basic | ✅ Basic tests | Mixed | ✅ Doc testing |
| `examples/advanced/` | Advanced Examples | Complex usage examples | Cargo run | All packages | advanced | ✅ Advanced tests | Mixed | ✅ Doc testing |
| `docs/` | Documentation | Architecture, API, Guides | Markdown, mdBook | None | docs, guides | ✅ Doc testing | N/A | ✅ Docs deployment |
| `docs/architecture/` | Architecture | System architecture documentation | Markdown | None | architecture | ✅ Doc validation | N/A | ✅ Docs deployment |
| `docs/api/` | API Documentation | API reference และ examples | Markdown | None | api | ✅ Doc validation | N/A | ✅ Docs deployment |
| `docs/guides/` | Guides | User guides และ tutorials | Markdown | None | guides | ✅ Doc validation | N/A | ✅ Docs deployment |

## Development & Automation

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `scripts/` | Automation | Build, Test, Format, Lint, Release | Bash, PowerShell | System tools | automation | ✅ Script tests | Procedural | ✅ Pipeline integration |
| `tools/` | Development Tools | Codegen, Migration, Custom Bench | Rust, Python | All packages | tools, dev | ✅ Tool tests | Mixed | ✅ Tool CI |
| `tools/codegen/` | Code Generation | Source code generation tools | Rust | All packages | codegen | ✅ Codegen tests | Mixed | ✅ Tool CI |
| `tools/migration/` | Migration | Data migration tools | Rust | All packages | migration | ✅ Migration tests | Mixed | ✅ Tool CI |
| `tools/benchmark/` | Benchmark Tools | Custom benchmarking tools | Rust | All packages | benchmark | ✅ Benchmark tests | Mixed | ✅ Tool CI |

## Configuration & Internal

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `config/` | Configuration | CI/CD, Docker, Development | YAML, TOML, Docker | System | config, env | ✅ Config validation | Declarative | ✅ Environment setup |
| `config/ci/` | CI Configuration | Continuous integration configuration | YAML | System | ci | ✅ CI validation | Declarative | ✅ Environment setup |
| `config/docker/` | Docker Configuration | Docker container configuration | Docker, YAML | System | docker | ✅ Docker validation | Declarative | ✅ Environment setup |
| `config/development/` | Development Config | Development environment configuration | TOML | System | development | ✅ Dev config validation | Declarative | ✅ Environment setup |
| `crates/` | Internal Crates | Utils, Macros, Integrations | Cargo | Core packages | internal, macros | ✅ Crate tests | Functional, OOP | ✅ Crate publishing |
| `crates/internal/` | Internal Crates | Internal utilities และ macros | Cargo | Core packages | internal | ✅ Internal tests | Functional, OOP | ✅ Crate publishing |
| `crates/external/` | External Crates | External integrations และ adapters | Cargo | Core packages | external | ✅ External tests | Functional, OOP | ✅ Crate publishing |

## 3. Validation
| `benches/` | Benchmarking | Performance, Memory, I/O, Regression | Criterion | All packages | bench-all, perf | ✅ Benchmark suites | Functional | ✅ Regression detection |

## Documentation & Examples

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `examples/` | Examples | Basic และ Advanced usage | Cargo run | All packages | examples, demo | ✅ Example tests | Mixed | ✅ Doc testing |
| `docs/` | Documentation | Architecture, API, Guides | Markdown, mdBook | None | docs, guides | ✅ Doc testing | N/A | ✅ Docs deployment |

## Development & Automation

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `scripts/` | Automation | Build, Test, Format, Lint, Release | Bash, PowerShell | System tools | automation | ✅ Script tests | Procedural | ✅ Pipeline integration |
| `tools/` | Development Tools | Codegen, Migration, Custom Bench | Rust, Python | All packages | tools, dev | ✅ Tool tests | Mixed | ✅ Tool CI |

## Configuration & Internal

| Folder | วัตถุประสงค์ | คำอธิบาย | Tools | Dependencies | Feature Flags | Testing | Programming Styles | CI/CD |
|--------|-------------|------------|-------|-------------|--------------|---------|-------------------|-------|
| `config/` | Configuration | CI/CD, Docker, Development | YAML, TOML, Docker | System | config, env | ✅ Config validation | Declarative | ✅ Environment setup |
| `crates/` | Internal Crates | Utils, Macros, Integrations | Cargo | Core packages | internal, macros | ✅ Crate tests | Functional, OOP | ✅ Crate publishing |



## 3. Validation

1. **Validate Code Quality Standards**
   - ตรวจสอบว่าทุกไฟล์ไม่เกิน 200 บรรทัดตาม Breakdown Strategy
   - ยืนยันว่าโค้ดใช้ strong typing และ generics ตาม Type Safety requirements
   - ตรวจสอบว่าใช้ pure functions และ immutable state ตาม Side Effect Reduction
   - ตรวจสอบว่ามี memory efficiency และ async patterns ตาม Performance Optimization
   - ยืนยันว่ามี documentation และ testing ตาม Developer Experience requirements

2. **Validate Security & Production Compliance**
   - รัน security audit เพื่อตรวจหา hardcoded sensitive data หรือ configuration values
   - ตรวจสอบว่าไม่มี mockup data สำหรับ production environments
   - ยืนยันว่าโค้ดเป็น production ready พร้อม error handling ที่เหมาะสม
   - ตรวจสอบว่าไม่มี security vulnerabilities ใน dependencies

3. **Validate Monorepo Structure**
   - ตรวจสอบว่า workspace configuration ถูกต้องสำหรับ Rust monorepo และ turborepo
   - ยืนยันว่า directory layout ตรงตามที่กำหนดใน `packages/monorepo/` structure
   - ตรวจสอบว่าทุก folder มี README.md, Cargo.toml และ src/ directory ที่ถูกต้อง
   - ยืนยันว่า summary table อธิบายวัตถุประสงค์และ tools ของแต่ละ folder ได้ครบถ้วน

4. **Validate Development Workflow**
   - รันทดสอบแต่ละ phase (Development, Formatting, Testing, Benchmarks, Release)
   - ตรวจสอบว่า commands ใน table ทำงานได้ตามที่กำหนด
   - ยืนยันว่า Quality Assurance schedule ถูกตั้งค่าอย่างถูกต้อง
   - ตรวจสอบว่า tools และ coverage requirements ตรงตามที่ระบุไว้

## 4. Verification

1. **Verify Code Quality Implementation**
   - รัน `cargo fmt --all` เพื่อตรวจสอบ formatting ทั่ว workspace
   - รัน `cargo clippy --all-targets --all-features` เพื่อตรวจสอบ code quality
   - ตรวจสอบขนาดไฟล์ทั้งหมดว่าไม่เกิน 200 บรรทัดด้วย script ตรวจสอบ
   - ยืนยันว่าทุก package มี unit tests ครอบคลุมอย่างน้อย 80%

2. **Verify Security & Production Readiness**
   - รัน `cargo audit` เพื่อตรวจสอบ security vulnerabilities ใน dependencies
   - สแกน source code หา hardcoded secrets ด้วย tools เช่น `git-secrets`
   - ตรวจสอบว่า production builds ไม่มี debug symbols หรือ test code
   - ยืนยันว่า error handling ครอบคลุมทุก code paths

3. **Verify Monorepo Functionality**
   - รัน `cargo build --workspace` เพื่อตรวจสอบว่าทุก package build ได้
   - ทดสอบ turborepo commands ว่าทำงานได้ตามที่กำหนด
   - ตรวจสอบว่า workspace dependencies ถูกต้องและไม่ซ้ำซ้อน
   - ยืนยันว่าทุก directory มีโครงสร้างตาม monorepo pattern

4. **Verify Development Workflow Execution**
   - รันทดสอบทุก phase ใน Development Workflow table
   - ตรวจสอบว่า duration ใน table ใกล้เคียงกับความเป็นจริง
   - ยืนยันว่า Quality Assurance schedule ทำงานได้จริง
   - ตรวจสอบว่า tools และ coverage ตรงตาม requirements ที่ระบุไว้

## Architecture Flow Pattern

