---
description: review-react-tsx
auto_execution_mode: 1
---

Review Guidelines for React TSX Components

Is it type-safe?

- Are all props properly typed with TypeScript interfaces?
- Are component state and refs properly typed?
- Are event handlers correctly typed?
- Are generic types used appropriately for polymorphic components?

Does it follow React best practices?

- Are functional components used with hooks instead of class components?
- Are custom hooks extracted for reusable logic?
- Are effects properly cleaned up to prevent memory leaks?
- Are dependencies arrays in useEffect correct and complete?

Is the component structure optimized?

- Does it follow the single responsibility principle?
- Are complex components broken down into smaller, focused components?
- Are props properly destructured and organized?
- Are magic numbers and strings extracted to constants?

Are there any performance considerations?

- Are expensive computations memoized with useMemo?
- Are event handlers wrapped with useCallback when passed to child components?
- Are large lists handled with React.memo or virtual scrolling?
- Are unnecessary re-renders avoided?

Is the JSX/TSX structure clean and maintainable?

- Are conditional rendering patterns consistent (&& vs ternary vs early returns)?
- Are list keys properly set and unique?
- Are event handlers properly bound?
- Is the JSX semantic and readable?

Are there proper error boundaries and loading states?

- Are async operations properly handled with loading states?
- Are error states implemented with proper fallbacks?
- Are try-catch blocks used appropriately in async functions?

Is accessibility properly implemented?

- Do interactive elements have proper ARIA attributes?
- Are form inputs associated with labels?
- Is keyboard navigation supported?
- Are color contrasts sufficient?

Are modern React patterns used?

- Are concurrent features like Suspense used when appropriate?
- Are modern hooks like useTransition, useDeferredValue used for performance?
- Are proper error boundaries implemented?
- Is the component compatible with React 18+ features?

Is the styling approach consistent with UnoCSS best practices?

- Are UnoCSS utility classes used instead of custom CSS or CSS-in-JS?
- Are utility classes properly organized and readable?
- Are responsive breakpoints used correctly with UnoCSS?
- Are UnoCSS color utilities used from the configured theme?
- Are there any unused CSS classes that should be removed?
- Are CSS custom properties used appropriately for theming?
- Is the component responsive across different screen sizes using UnoCSS utilities?
- Are UnoCSS icons from Iconify used consistently?

Can it scale as the project grows?

- Is the component easily testable with proper separation of concerns?
- Are dependencies injected properly (props vs context vs dependency injection)?
- Is the component composable and reusable?
- Are there any hardcoded values that should be configurable?

Are TypeScript best practices followed?

- Are interfaces and types properly defined and exported?
- Are utility types used effectively?
- Is type assertion used sparingly and appropriately?
- Are generic constraints properly defined?

👉 If you see something that should be done, just do it without asking.