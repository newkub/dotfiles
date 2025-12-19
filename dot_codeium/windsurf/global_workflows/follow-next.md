---
auto_execution_mode: 3
---


follow ทำตามกฏเหล่านี้อย่างเคร่งครัด (Next.js 15 App Router)

## Next.js 15 Project Structure

```
my-next-app/
├── app/                    # App Router
│   ├── (auth)/             # Route groups (no URL)
│   ├── api/                # API Routes
│   ├── layout.tsx          # Root layout
│   ├── page.tsx            # Home page
│   ├── loading.tsx         # Loading UI
│   ├── error.tsx           # Error UI
│   └── not-found.tsx       # 404 page
├── components/             # React components
├── lib/                    # Utilities & helpers
├── hooks/                  # Custom React hooks
├── types/                  # TypeScript types
├── actions/                # Server Actions
├── middleware.ts           # Middleware
├── public/                 # Static files
├── next.config.js
├── tsconfig.json
└── package.json
```

## Core Concepts

### Architecture Overview
```
                    ┌─────────────────────────────────────────────┐
                    │   Next.js 15 App Router Architecture (RSC)  │
                    └─────────────────────────────────────────────┘

                                  ┌──────────┐
                                  │  types/  │
                                  └─────┬────┘
                                        │ TypeScript interfaces & types
                                        │
                          ┌─────────────┼─────────────┐
                          │             │             │
                          ▼             ▼             ▼
                    ┌──────────┐  ┌──────────┐  ┌──────────┐
                    │   lib/   │  │ config/  │  │ actions/ │
                    └─────┬────┘  └──────────┘  └─────┬────┘
                          │        • env vars         │
                          │        • constants        │ • 'use server'
                          │ • cn() helper             │ • Mutations
                          │ • db (Drizzle)            │ • revalidate
                          │ • Zod schemas             │
                          │                           │
                          └───────────┬───────────────┘
                                      │
                                      ▼
                              ┌───────────────┐
                              │  components/  │
                              └───────┬───────┘
                                      │ • Server (default)
                                      │ • Client ('use client')
                                      │ • UI Library
                                      │
                      ┌───────────────┼───────────────┐
                      │               │               │
                      ▼               ▼               ▼
                ┌─────────┐     ┌─────────┐     ┌─────────┐
                │ pages/  │     │ hooks/  │     │  api/   │
                └────┬────┘     └─────────┘     └─────────┘
                     │           • useUser        • REST
                     │           • useAuth        • Webhooks
                     │ • page.tsx (Route)
                     │ • layout.tsx (Nested)
                     │ • loading.tsx (Suspense)
                     │ • error.tsx (Boundary)
                     │
                ┌────┴────┐
                │         │
                ▼         ▼
          ┌──────────┐ ┌──────────────┐
          │middleware│ │ Route Groups │
          └────┬─────┘ └──────────────┘
               │        • (auth)/ Private
               │ • Auth • (marketing)/ Public
               │ • i18n • @modal Parallel
               │
               └───────┬──────────┘
                       │
                       ▼
            ┌──────────────────────────┐
            │  Data & State Management │
            └──────────┬───────────────┘
                       │
              ┌────────┼────────┐
              │        │        │
              ▼        ▼        ▼
         ┌────────┐ ┌────────┐ ┌────────┐
         │Database│ │External│ │ Cache  │
         └────────┘ └────────┘ └────────┘
          • Drizzle  • fetch    • Next Cache
          • Pool     • axios    • ISR/SSG
```

### Core Principles
- **App Router**: Use `app/` directory (not `pages/`)
- **Server Components**: Default - async/await, zero JS to client
- **Client Components**: Opt-in with `'use client'` for interactivity
- **Server Actions**: Use `'use server'` for mutations (replace API routes for forms)
- **File-based Routing**: `page.tsx` = routes, `layout.tsx` = layouts
- **Streaming & Suspense**: Progressive rendering with React Suspense

### Data Flow
```
types → lib/utils → components
  ↓              ↓
actions ←———  app/pages (Server Components)
  ↓
api/routes (webhooks, external)
```

### Key Technologies
- **Styling**: UnoCSS (utility-first, no runtime)
- **Icons**: UnoCSS + Iconify (@iconify-json/mdi)
- **Database**: Drizzle ORM (type-safe SQL ORM)
- **Validation**: Zod (runtime schema validation)
- **Utils**: clsx (conditional classes)

## Folder Rules

### app/
- <Purpose> => App Router - file-based routing, Server Components
- <Do> => Server Components default (async/await), `'use client'` สำหรับ interactivity, route groups `(folder)`, dynamic `[id]/[...slug]`, export `metadata`
- <Don't> => `useState/useEffect/useContext` ใน Server, export Client จาก Server ตรง, browser APIs ใน Server, non-serializable props
- <Naming> => Special `page/layout/loading/error.tsx`, groups `(name)`, dynamic `[param]`
- <Type Safety> => `Metadata`, `{ params: { id: string } }`, `{ searchParams: { q?: string } }`
- <Routing> => Static `page.tsx`→`/`, Dynamic `[slug]/page.tsx`→`/:slug`, Catch-all `[...slug]`, Group `(folder)`→no URL

- <Example> =>
```tsx
export default async function Page() {
  const users = await db.select().from(usersTable)
  return <div>{users.map(u => <div key={u.id}>{u.name}</div>)}</div>
}
```


### lib/
- <Purpose> => Utilities, DB clients, API configs
- <Do> => export named, pure functions, singleton (DB/API), จัดกลุ่ม `db/api/utils.ts`
- <Don't> => export default, side effects, business logic, hooks
- <Libraries> => **clsx** (cn helper), **Drizzle** (ORM), **Zod** (validation)
- <Example> => `export const cn = (...inputs: ClassValue[]) => clsx(inputs)`


### actions/ (Server Actions)
<Purpose> => Server mutations
<Do> => `'use server'` บรรทัดแรก, return serializable, `revalidatePath/Tag()`, Zod validate, try-catch
<Don't> => return non-serializable, expose sensitive
<Naming> => `*.actions.ts`, `camelCase` กริยา
<Type Safety> => Type FormData, Zod schemas
<Error Handling> => Return `{success,error?,data?}`
<Example>
```typescript
'use server'
const s=z.object({name:z.string().min(2),email:z.string().email()})
export async function createUser(fd:FormData){
  try{
    const d=s.parse({name:fd.get('name'),email:fd.get('email')})
    await db.insert(usersTable).values(d)
    revalidatePath('/users')
    return {success:true}
  }catch{return {success:false,error:'Failed'}}
}
```


### middleware.ts
<Purpose> => Edge middleware (auth, redirects)
<Do> => export `middleware`, `config` with `matcher`, Edge Runtime
<Don't> => heavy computations, Node.js APIs, DB ตรง
<Type Safety> => `NextRequest`, `NextResponse`
<Example>
```typescript
export function middleware(req){
  const token=req.cookies.get('token')
  if(req.nextUrl.pathname.startsWith('/dashboard')&&!token){
    return NextResponse.redirect(new URL('/login',req.url))
  }
  return NextResponse.next()
}
export const config={matcher:['/dashboard/:path*']}
```



