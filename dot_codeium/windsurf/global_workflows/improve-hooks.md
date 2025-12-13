---
description: improve-hooks
auto_execution_mode: 1
---

React Hooks Improvement Guidelines

Is the hook following React hooks best practices?

- Does the hook name start with "use" for proper ESLint detection?
- Are all React hooks called at the top level of the component?
- Are hooks used conditionally or in loops (which should be avoided)?
- Are custom hooks properly abstracted for reusability?

Is the hook logic well-structured and maintainable?

- Does it follow the single responsibility principle?
- Is complex logic broken down into smaller, focused hooks?
- Are hook dependencies properly managed?
- Is the hook easily testable in isolation?

Are there any performance optimizations needed?

- Are expensive computations memoized with useMemo?
- Are event handlers wrapped with useCallback when returned?
- Are effects properly optimized with proper dependency arrays?
- Are unnecessary re-renders prevented?

Is the hook reusable and flexible?

- Are parameters properly typed with TypeScript?
- Are default values provided for optional parameters?
- Can the hook be easily composed with other hooks?
- Are there any hardcoded values that should be configurable?

Is error handling properly implemented?

- Are async operations handled with proper loading and error states?
- Are cleanup functions implemented for effects?
- Are try-catch blocks used appropriately in async functions?
- Are errors properly propagated to consuming components?

Is the hook following TypeScript best practices?

- Are generic types used appropriately for flexible return types?
- Are proper interfaces defined for complex state or configuration?
- Is type safety maintained throughout the hook implementation?
- Are utility types used effectively?

Can the hook scale as the project grows?

- Is the hook easily discoverable and documented?
- Are there opportunities to extract shared logic into smaller hooks?
- Is the hook flexible enough for future feature additions?
- Are there any performance bottlenecks that need addressing?

Is the hook accessible and inclusive?

- Does the hook provide proper ARIA attributes when needed?
- Are keyboard navigation considerations included?
- Does the hook work well with assistive technologies?
- Are there any accessibility improvements needed?

👉 If you see something that should be done, just do it without asking.
