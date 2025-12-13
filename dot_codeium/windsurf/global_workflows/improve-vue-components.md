---
description: improve-vue-components
auto_execution_mode: 1
---

Vue Component Improvement Guidelines

Is the component following Vue 3 best practices?

- Is the Composition API used instead of Options API for new components?
- Are reactive references properly declared with ref() or reactive()?
- Are computed properties using the computed() function?
- Are watchers using watch() or watchEffect() appropriately?

Is the component structure well-organized?

- Does it follow the single responsibility principle?
- Are related logic grouped together in logical sections?
- Is the component broken down into smaller, focused components when appropriate?
- Are props properly validated and documented?

Are there any performance optimizations needed?

- Are expensive computations properly cached with computed()?
- Are large lists handled with virtual scrolling if needed?
- Are event listeners properly managed to prevent memory leaks?
- Are unnecessary re-renders avoided through proper reactivity?

Is the component reusable and maintainable?

- Are magic numbers and strings extracted to constants?
- Are props properly destructured and organized?
- Is the component easily testable with proper separation of concerns?
- Are dependencies injected properly through props or provide/inject?

Is the template structure optimized?

- Are v-for keys properly set for list rendering?
- Are conditional rendering directives used efficiently?
- Are event handlers properly bound and optimized?
- Is the template semantic and accessible?

Are modern Vue patterns used effectively?

- Are async components used for code splitting when appropriate?
- Are Suspense boundaries implemented for better loading states?
- Are teleport used for modal and dropdown positioning?
- Are provide/inject used for component communication when props become too complex?

Is the styling approach consistent?

- Are UnoCSS utility classes used instead of custom CSS?
- Are scoped styles used only when necessary for component-specific styling?
- Is the component responsive using UnoCSS utilities?
- Are CSS custom properties used for theming?

Is error handling properly implemented?

- Are async operations properly handled with proper error boundaries?
- Are loading and error states implemented?
- Are try-catch blocks used appropriately in component logic?

Can the component scale as the project grows?

- Is the component easily composable with other components?
- Are there any hardcoded values that should be configurable?
- Is the component flexible enough for future feature additions?
- Are there opportunities to extract reusable composables?

👉 If you see something that should be done, just do it without asking.
