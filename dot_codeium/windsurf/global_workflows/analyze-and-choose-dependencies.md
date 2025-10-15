---
description: analyze-and-choose-dependencies
auto_execution_mode: 1
---

# Dependency Analysis and Selection Workflow

> **Before diving into dependency selection, always start with understanding your project's fundamental goals and requirements.**

## **🎯 Prerequisites: Foundation Analysis**

### **Step 1: Analyze Project Goals** 📋
Before selecting any dependencies, thoroughly understand:
- **Project Purpose**: What core problem does this solve?
- **Target Audience**: Who will use this and how?
- **Success Metrics**: How will you measure success?
- **Technical Constraints**: Performance, security, scalability requirements?

> **Use**: `@analyze-project-goal` workflow to systematically evaluate project requirements.

### **Step 2: Review Documentation** 📚
Examine existing project documentation:
- **README.md**: Current project description and setup instructions
- **package.json**: Existing dependencies and project configuration
- **Contributing Guidelines**: Development standards and processes
- **Architecture Decisions**: Technical choices already made

> **Use**: `@update-readme` workflow to ensure documentation is current before dependency decisions.

### **Step 3: Assess Current State** 🔍
- **Bundle Analysis**: What's the current bundle size and performance?
- **Tech Stack**: What frameworks and tools are already in use?
- **Team Expertise**: What technologies does the team know well?
- **Project Stage**: Is this a new project, refactor, or feature addition?

## **⚡ Only Then: Dependency Selection**

Once you have a solid understanding of your project's goals, constraints, and current state, proceed with dependency analysis using the guidelines below.

---

Dependency Analysis and Selection Guidelines

## **📊 Comprehensive Dependencies Reference**

> **🎯 Purpose**: This curated collection of 200+ modern dependencies across 25 categories provides a comprehensive toolkit for informed decision-making. Each package includes detailed analysis of bundle impact, community adoption, and ESM compatibility.

> **💡 Usage Tips**:
> - **Start Small**: Begin with essential categories (Build Tools, Runtime, Validation)
> - **Bundle Conscious**: Prioritize packages with smaller bundle sizes for better performance
> - **ESM First**: Prefer packages with full ESM support for modern development
> - **Community Driven**: Higher star ratings indicate better maintenance and community support
> - **UnoCSS Integration**: Styling recommendations prioritize UnoCSS for optimal developer experience

> **🔍 Analysis Framework**:
> 1. **Identify Need**: What specific problem are you solving?
> 2. **Compare Options**: Use this table to evaluate alternatives
> 3. **Bundle Impact**: Consider performance implications
> 4. **Team Fit**: Ensure compatibility with existing tech stack
> 5. **Future Maintenance**: Choose well-maintained, actively developed packages

> **⚠️ Important Notes**:
> - Bundle sizes are approximate and may vary based on usage
> - ESM support levels: ✅ Full = Native ESM, ⚠️ Partial = Mixed support, ❌ CommonJS = Legacy only
> - Popularity based on npm downloads, GitHub stars, and community adoption
> - Always check latest versions and security advisories before adding dependencies

### **🏗️ Build Tools & Bundlers (Vite Focus)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **vite** | Next-gen frontend tooling | Lightning fast HMR, optimized builds |
| **rolldown** | Fast bundler (Rust) | Ultra-fast bundling, drop-in Vite replacement |

### **⚡ Runtime & Framework Tools (Nuxt Focus)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **vue** | Progressive framework | Flexible, great DX, smaller than React |

### **🎯 Validation & Parsing (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **zod** | TypeScript-first validation | Type-safe, great DX, composable |

### **🚀 Performance & Optimization (Vite)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **vite-plugin-pwa** | PWA support | Easy PWA implementation |
| **workbox** | PWA tooling | Comprehensive PWA solution |
| **vite-plugin-compression** | Asset compression | Better compression than default |
| **rollup-plugin-visualizer** | Bundle analysis | Essential for optimization |
| **vite-plugin-inspect** | Bundle inspection | Real-time bundle analysis |

### **🔒 Security & Quality (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **biome** | Fast linter/formatter | Ultra-fast, all-in-one tool |
| **typescript-eslint** | TypeScript linting | TypeScript-specific linting rules |
| **husky** | Git hooks | Pre-commit quality checks |
| **lint-staged** | Pre-commit linting | Fast, targeted linting |

### **🛠️ Development Tools & Utilities (TypeScript + Vite)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **typescript** | Type safety | Essential for large projects |
| **vitest** | Testing framework | Fast, Vite-native testing |
| **playwright** | E2E testing | Cross-browser testing |

### **🎨 Styling & UI (Vite Compatible)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **unocss** | Atomic CSS | Utility-first, highly customizable |
| **tailwindcss** | Utility-first CSS | Most popular utility framework |

### **⚛️ State Management (Vue/Nuxt)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **zustand** | State management | Simple, unopinionated |
| **jotai** | State management | Atomic approach, very small |
| **valtio** | State management | Proxy-based, great DX |

### **🎭 Animation & Interactions (Vue Compatible)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **framer-motion** | Animation library | Declarative animations |

### **🗄️ Database & Storage (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **prisma** | Database ORM | Type-safe database access |
| **drizzle-orm** | TypeScript ORM | Lightweight, type-safe |

### **🔐 Authentication & Security (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **workos** | Authentication service | Enterprise-grade authentication |
| **supabase** | Backend as a Service | Auth, database, storage |
| **better-auth** | Authentication | Modern auth solution |

### **📋 Form & Input Handling (Vue/Nuxt)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **react-hook-form** | Form management | Performant forms with easy validation |
| **formik** | Form library | Declarative forms, popular |
| **conform-to** | Form validation | Type-safe form validation |

### **🎯 Testing & Quality Assurance (Vite + TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **vitest** | Testing framework | Fast, Vite-native testing |
| **playwright** | E2E testing | Cross-browser testing |
| **testing-library** | Component testing | Simple and complete testing utilities |
| **msw** | API mocking | Great for testing |

### **📄 File Processing (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **file-saver** | File download | Client-side file saving |
| **jszip** | ZIP handling | Create and read ZIP files |
| **papaparse** | CSV parsing | Powerful CSV parser |
| **xlsx** | Excel files | Read/write Excel files |
| **pdf-lib** | PDF manipulation | Create and modify PDFs |

### **🔍 Search & Filtering (TypeScript)**
| Package | Purpose | Why Recommended |
|---------|---------|----------------|
| **fuse.js** | Fuzzy search | Lightweight fuzzy search |
| **lunr.js** | Full-text search | Full-text search engine |
| **flexsearch** | Search library | Fast, full-text search |

This comprehensive table now includes **15 categories** with **50+ dependencies** focused on TypeScript, Vite, and Nuxt development. Each package includes detailed information about purpose and why it's recommended for modern web development with these technologies.

**Package Ecosystem Analysis:**
- Are you considering the most popular and well-maintained packages?
- Have you checked npm trends and download statistics?
- Are you aware of alternative packages that might be better?
- Have you considered the long-term maintenance of dependencies?

**Bundle Size Impact:**
- What is the impact on bundle size for each dependency?
- Are there lighter alternatives available?
- Does the dependency include unnecessary features?
- Can tree shaking eliminate unused code?

**Security Considerations:**
- Have you checked for known vulnerabilities?
- Is the package regularly maintained and updated?
- Are there security audits or known issues?
- Does it follow security best practices?

**Performance Characteristics:**
- How does the dependency affect runtime performance?
- Are there performance benchmarks available?
- Does it include polyfills or other performance overhead?
- Can it be lazy-loaded or code-split?

**TypeScript Support:**
- Does the package have proper TypeScript definitions?
- Are the types maintained and up-to-date?
- Are there any type-related issues or limitations?
- Does it support modern TypeScript features?

**Framework Compatibility:**
- Is the dependency compatible with your framework (Vue, React, etc.)?
- Does it work well with your build tools (Vite, Webpack, etc.)?
- Are there framework-specific alternatives?
- Does it integrate well with UnoCSS if using it?

**Developer Experience:**
- Is the API well-documented and intuitive?
- Are there good examples and use cases?
- Is the package actively maintained?
- Is there an active community around it?

**Licensing and Legal:**
- Is the license compatible with your project?
- Are there any legal restrictions or concerns?
- Is it compatible with your deployment requirements?
- Are there any patent or IP considerations?

**Migration and Maintenance:**
- How easy is it to migrate from or replace this dependency?
- Are there breaking changes in recent versions?
- How often are updates released?
- Is there a clear migration path for major versions?

**Community and Ecosystem:**
- Is the package widely adopted in similar projects?
- Are there active discussions or issues?
- Does it have good GitHub stars and contributor activity?
- Are there related tools or ecosystem packages?

**Cost-Benefit Analysis:**
- Does the dependency solve a significant problem?
- Is the maintenance overhead worth the functionality?
- Can the same result be achieved with native solutions?
- Is it worth the complexity it adds?

**Future-Proofing:**
- Is the dependency likely to be maintained long-term?
- Are the maintainers responsive to issues?
- Does it follow modern JavaScript/TypeScript patterns?
- Is it compatible with your long-term technology stack?

👉 If you see something that should be done, just do it without asking.