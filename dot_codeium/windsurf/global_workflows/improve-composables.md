---
description: improve-composables
auto_execution_mode: 1
---

Vue Composables Improvement Guidelines

Is the composable following Vue 3 Composition API best practices?

- Is the composable properly structured for reusability?
- Are reactive references properly declared with ref() or reactive()?
- Are computed properties using the computed() function?
- Are watchers using watch() or watchEffect() appropriately?

Is the composable logic well-structured and maintainable?

- Does it follow the single responsibility principle?
- Is complex logic broken down into smaller, focused composables?
- Are composable dependencies properly managed?
- Is the composable easily testable in isolation?

Are there any performance optimizations needed?

- Are expensive computations properly cached with computed()?
- Are reactive effects properly optimized?
- Are unnecessary re-renders prevented through proper reactivity?
- Are cleanup functions implemented when needed?

Is the composable reusable and flexible?

- Are parameters properly typed with TypeScript interfaces?
- Are default values provided for optional parameters?
- Can the composable be easily composed with other composables?
- Are there any hardcoded values that should be configurable?

Is error handling properly implemented?

- Are async operations handled with proper loading and error states?
- Are cleanup functions implemented for watchers and effects?
- Are try-catch blocks used appropriately in async functions?
- Are errors properly propagated to consuming components?

Is the composable following TypeScript best practices?

- Are generic types used appropriately for flexible return types?
- Are proper interfaces defined for complex state or configuration?
- Is type safety maintained throughout the composable implementation?
- Are utility types used effectively?

Can the composable scale as the project grows?

- Is the composable easily discoverable and documented?
- Are there opportunities to extract shared logic into smaller composables?
- Is the composable flexible enough for future feature additions?
- Are there any performance bottlenecks that need addressing?

Is the composable accessible and inclusive?

- Does the composable provide proper ARIA attributes when needed?
- Are keyboard navigation considerations included?
- Does the composable work well with assistive technologies?
- Are there any accessibility improvements needed?

Are modern Vue patterns used effectively?

- Are async composables used for better code splitting?
- Are Suspense boundaries considered for async operations?
- Are provide/inject used appropriately for composable communication?
- Is the composable compatible with Vue 3's reactivity system?

👉 If you see something that should be done, just do it without asking.
