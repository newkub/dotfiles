---
description: improve-react-components
auto_execution_mode: 1
---

React Component Improvement Guidelines

Is the component following React best practices?

- Are functional components used with hooks instead of class components?
- Are custom hooks extracted for reusable logic?
- Are effects properly cleaned up to prevent memory leaks?
- Are dependencies arrays in useEffect correct and complete?

Is the component structure well-organized?

- Does it follow the single responsibility principle?
- Are complex components broken down into smaller, focused components?
- Are props properly destructured and organized?
- Are magic numbers and strings extracted to constants?

Are there any performance optimizations needed?

- Are expensive computations memoized with useMemo?
- Are event handlers wrapped with useCallback when passed to child components?
- Are large lists handled with React.memo or virtual scrolling?
- Are unnecessary re-renders avoided?

Is the component reusable and maintainable?

- Are props properly typed with TypeScript interfaces?
- Is the component easily testable with proper separation of concerns?
- Are dependencies injected properly (props vs context vs dependency injection)?
- Are there any hardcoded values that should be configurable?

Is the JSX structure clean and maintainable?

- Are conditional rendering patterns consistent (&& vs ternary vs early returns)?
- Are list keys properly set and unique?
- Are event handlers properly bound?
- Is the JSX semantic and readable?

Are modern React patterns used effectively?

- Are concurrent features like Suspense used when appropriate?
- Are modern hooks like useTransition, useDeferredValue used for performance?
- Are proper error boundaries implemented?
- Is the component compatible with React 18+ features?

Is the styling approach consistent?

- Are UnoCSS utility classes used instead of custom CSS or CSS-in-JS?
- Are utility classes properly organized and readable?
- Are responsive breakpoints used correctly with UnoCSS?
- Are UnoCSS color utilities used from the configured theme?

Is error handling properly implemented?

- Are async operations properly handled with loading states?
- Are error states implemented with proper fallbacks?
- Are try-catch blocks used appropriately in async functions?
- Are error boundaries implemented for better error handling?

Is accessibility properly implemented?

- Do interactive elements have proper ARIA attributes?
- Are form inputs associated with labels?
- Is keyboard navigation supported?
- Are color contrasts sufficient?

Can the component scale as the project grows?

- Is the component easily composable and reusable?
- Are there opportunities to extract custom hooks?
- Is the component flexible enough for future feature additions?
- Are there any performance bottlenecks that need addressing?

👉 If you see something that should be done, just do it without asking.
