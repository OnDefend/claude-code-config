---
paths:
  - "**/e2e/**/*.ts"
  - "**/e2e/**/*.spec.ts"
---

# Playwright E2E Testing Patterns

## Page Object Model

All pages must extend `BasePage` and implement:
- `goto()` - Navigate to the page
- `waitForPageReady()` - Wait for page to be interactive

## Selectors

Use in this priority order:
1. `data-testid` attributes
2. `getByRole()` with name
3. `getByLabel()` for form inputs
4. `getByText()` for static content
5. CSS selectors (last resort)

## Test Structure

```typescript
test.describe("Feature", () => {
  test.beforeEach(async ({ page }) => {
    // Setup
  });

  test("should do something", async () => {
    // Arrange, Act, Assert
  });
});
```

## Waiting

- Use `waitFor()` instead of arbitrary timeouts
- Wait for specific elements or API responses
- Use `expect().toBeVisible()` for visibility checks
