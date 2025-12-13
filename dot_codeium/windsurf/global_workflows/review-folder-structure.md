---
description: review-folder-structure
auto_execution_mode: 1
---

Folder Structure Review Guidelines with Code Examples

## **Recommended Folder Structures by Project Type:**

**For Vite Projects:**
- Is src/ used as the main source directory?
- Are components organized in src/components/ with feature-based grouping?
- Are utilities and helpers in src/utils/ or src/lib/?
- Are types organized in src/types/ or src/interfaces/?
- Are assets properly organized in src/assets/?
- Is public/ used only for static assets served directly?

**For Next.js Projects:**
- Is the app directory structure used (app/ router) instead of pages/?
- Are API routes properly organized in app/api/ or pages/api/?
- Are components organized by feature in components/ or by type?
- Are layouts and templates properly structured?
- Are middleware and instrumentation files in the root?

**For Nuxt.js Projects:**
- Are pages organized in pages/ directory with file-based routing?
- Are components organized in components/ with auto-imports?
- Are composables organized in composables/ directory?
- Are server API routes in server/api/?
- Are middleware functions in middleware/?
- Are plugins organized in plugins/?

**For Pure TypeScript Projects:**
- Is src/ used as the main source directory?
- Are source files organized by feature or by type?
- Are utility functions in src/utils/ or src/helpers/?
- Are types centralized in src/types/?
- Are configuration files in the root or src/config/?
- Are build outputs separated from source?

**For Monorepo Projects:**
- Are packages organized in packages/ or apps/ directory?
- Do package names follow consistent naming conventions?
- Are shared utilities in packages/shared/ or packages/common/?
- Are package.json files properly configured for each package?
- Are build and development scripts properly orchestrated?
- Are dependencies managed at the workspace level?

### **Vite Project Structure Example:**
```
vite-project/
├── public/
│   ├── favicon.ico
│   └── robots.txt
├── src/
│   ├── assets/
│   │   ├── images/
│   │   └── icons/
│   ├── components/
│   │   ├── ui/
│   │   │   ├── Button.vue
│   │   │   └── Input.vue
│   │   └── features/
│   │       ├── auth/
│   │       │   ├── LoginForm.vue
│   │       │   └── RegisterForm.vue
│   │       └── dashboard/
│   │           └── StatsCard.vue
│   ├── composables/
│   │   └── useAuth.ts
│   ├── types/
│   │   └── index.ts
│   ├── utils/
│   │   └── helpers.ts
│   ├── styles/
│   │   └── main.css
│   └── main.ts
├── index.html
├── package.json
├── tsconfig.json
├── uno.config.ts
└── vite.config.ts
```

### **Next.js Project Structure Example:**
```
nextjs-project/
├── app/
│   ├── api/
│   │   └── users/
│   │       └── route.ts
│   ├── dashboard/
│   │   ├── page.tsx
│   │   └── layout.tsx
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
├── components/
│   ├── ui/
│   │   ├── Button.tsx
│   │   └── Input.tsx
│   └── providers/
│       └── ThemeProvider.tsx
├── lib/
│   ├── utils.ts
│   └── db.ts
├── types/
│   └── index.ts
├── public/
│   └── favicon.ico
├── middleware.ts
├── next.config.js
├── package.json
├── tailwind.config.js
└── tsconfig.json
```

### **Nuxt.js Project Structure Example:**
```
nuxt-project/
├── assets/
│   └── css/
│       └── main.css
├── components/
│   ├── ui/
│   │   ├── Button.vue
│   │   └── Card.vue
│   └── TheHeader.vue
├── composables/
│   ├── useAuth.ts
│   └── useApi.ts
├── layouts/
│   └── default.vue
├── middleware/
│   └── auth.ts
├── pages/
│   ├── index.vue
│   └── dashboard.vue
├── plugins/
│   └── vuetify.ts
├── server/
│   └── api/
│       └── users.get.ts
├── types/
│   └── index.ts
├── app.vue
├── nuxt.config.ts
└── package.json
```

### **Pure TypeScript Project Structure Example:**
```
ts-project/
├── src/
│   ├── core/
│   │   ├── domain/
│   │   │   └── User.ts
│   │   └── services/
│   │       └── UserService.ts
│   ├── ui/
│   │   ├── components/
│   │   │   ├── Button.tsx
│   │   │   └── Modal.tsx
│   │   └── styles/
│   │       └── index.css
│   ├── utils/
│   │   ├── validators.ts
│   │   └── formatters.ts
│   ├── types/
│   │   ├── api.ts
│   │   └── ui.ts
│   └── index.ts
├── dist/
├── tests/
│   └── UserService.test.ts
├── package.json
├── tsconfig.json
├── eslint.config.js
└── uno.config.ts
```

### **Monorepo Project Structure Example:**
```
monorepo/
├── packages/
│   ├── shared/
│   │   ├── ui/
│   │   │   ├── src/
│   │   │   │   ├── components/
│   │   │   │   │   ├── Button.tsx
│   │   │   │   │   └── Input.tsx
│   │   │   │   └── index.ts
│   │   │   ├── package.json
│   │   │   └── tsconfig.json
│   │   └── utils/
│   │       ├── src/
│   │       │   └── index.ts
│   │       ├── package.json
│   │       └── tsconfig.json
│   ├── web/
│   │   ├── src/
│   │   │   ├── App.tsx
│   │   │   └── main.tsx
│   │   ├── index.html
│   │   ├── package.json
│   │   └── vite.config.ts
│   └── mobile/
│       ├── src/
│       │   ├── App.tsx
│       │   └── main.tsx
│       ├── package.json
│       └── vite.config.ts
├── package.json
├── turbo.json
└── tsconfig.json
```

Is the folder structure promoting good development practices?

- Does the structure follow the single responsibility principle?
- Are related files co-located (styles, tests, types with components)?
- Are build outputs and dependencies separated from source code?
- Are configuration files appropriately placed?
- Are static assets properly organized and optimized?

Is the structure scalable and maintainable?

- Can new features be added without disrupting existing structure?
- Are there clear boundaries between different parts of the application?
- Is the structure intuitive for new developers?
- Are there opportunities to extract shared code into packages?

Does the structure support modern development workflows?

- Are there separate directories for different environments (dev, staging, prod)?
- Is testing code properly organized (tests/, __tests__/, or *.test.* files)?
- Are documentation files properly placed (docs/, .github/)?
- Are deployment and CI/CD configurations properly organized?

Is UnoCSS integration properly structured?

- Are UnoCSS configuration files in the appropriate location?
- Are custom utility classes organized in a maintainable way?
- Are UnoCSS presets and themes properly configured?
- Are UnoCSS icon collections properly integrated?

Are there any structural issues that need addressing?

- Are there any deeply nested folders that should be flattened?
- Are there any files in the wrong directories?
- Are there any empty or unused directories?
- Are there opportunities to improve the overall organization?

👉 If you see something that should be done, just do it without asking.