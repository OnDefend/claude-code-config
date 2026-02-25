---
name: e2e-test
description: Generate Playwright end-to-end tests using Page Object Model pattern
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write
---

# E2E Test Generator

Generate Playwright end-to-end tests following the Page Object Model pattern.

## Skill Invocation

```
/e2e-test <page-or-feature> [test-type]
```

**Test Types:**
- `page` - Full page test with page object (default)
- `flow` - Multi-page user flow test
- `crud` - Create/Read/Update/Delete operations

**Examples:**
- `/e2e-test SecurityTools`
- `/e2e-test CreateEndpoint crud`
- `/e2e-test CampaignExecution flow`

## Page Object Template

Create `e2e/pages/{page-name}.page.ts`:

```typescript
import { Page, Locator, expect } from "@playwright/test";
import { BasePage } from "./base.page";

export class {PageName}Page extends BasePage {
  readonly pageTitle: Locator;
  readonly addButton: Locator;
  readonly dataTable: Locator;

  constructor(page: Page, customerUUID?: string) {
    super(page, customerUUID);
    this.pageTitle = page.getByRole("heading", { name: "{Page Title}" });
    this.addButton = page.getByRole("button", { name: /add|create/i });
    this.dataTable = page.locator('[data-testid="data-table"]');
  }

  async goto(): Promise<void> {
    await super.goto("/{page-path}");
    await this.waitForPageReady();
  }
}
```

## Test Spec Template

Create `e2e/specs/{section}/{feature}.spec.ts`:

```typescript
import { test, expect } from "../../fixtures";
import { {PageName}Page } from "../../pages/{page-name}.page";

test.describe("{PageName} Page", () => {
  let page: {PageName}Page;

  test.beforeEach(async ({ page: playwrightPage, customerUUID }) => {
    page = new {PageName}Page(playwrightPage, customerUUID);
  });

  test("should load page with correct title", async () => {
    await page.goto();
    await expect(page.pageTitle).toBeVisible();
  });
});
```

## Selector Best Practices

Priority order:
1. `data-testid` - Most stable
2. Role + Name - `getByRole("button", { name: "Submit" })`
3. Label - `getByLabel("Email")`
4. Text - `getByText("Welcome")`
5. CSS Selector - Last resort

## Running Tests

```bash
npx playwright test
npx playwright test --ui
npx playwright test -g "should load page"
```
