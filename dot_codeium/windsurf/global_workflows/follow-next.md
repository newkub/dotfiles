---
description: แนวทางการจัดโครงสร้างโปรเจกต์ Next.js
---

# แนวทางการจัดโครงสร้างโปรเจกต์ Next.js

## Next.js Project Structure

```
nextjs-project/
├── app/  # App Router
│   ├── layout.tsx
│   ├── page.tsx
│   ├── globals.css
│   ├── error.tsx
│   ├── loading.tsx
│   ├── not-found.tsx
│   └── api/
├── components/
├── hooks/
├── lib/
├── public/
├── styles/
├── types/
├── utils/
├── middleware.ts
├── next.config.js
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── .gitignore
└── README.md
```

| File | Follow Docs |
|------|-------------|
| app/ | [Next.js App Router](https://nextjs.org/docs/app) |
| components/ | Custom React components |
| hooks/ | [React Hooks](https://react.dev/learn) |
| lib/ | Custom utilities |
| public/ | [Next.js Public Folder](https://nextjs.org/docs/basic-features/static-file-serving) |
| styles/ | [Next.js Styling](https://nextjs.org/docs/basic-features/built-in-css-support) |
| types/ | [TypeScript Docs](https://www.typescriptlang.org/docs/) |
| utils/ | Custom utilities |
| middleware.ts | [Next.js Middleware](https://nextjs.org/docs/advanced-features/middleware) |
| next.config.js | [Next.js Config](https://nextjs.org/docs/api-reference/next.config.js/introduction) |
| package.json | [npm Docs](https://docs.npmjs.com/cli/v10/configuring-npm/package-json) |
| tsconfig.json | [TypeScript Config](https://www.typescriptlang.org/tsconfig/) |
| tailwind.config.js | [Tailwind Config](https://tailwindcss.com/docs/configuration) |
| .gitignore | [Git Ignore](https://git-scm.com/docs/gitignore) |
| README.md | [Markdown Guide](https://www.markdownguide.org/) |
