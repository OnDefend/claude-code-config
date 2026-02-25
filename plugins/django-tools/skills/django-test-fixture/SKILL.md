---
name: django-test-fixture
description: Generate pytest fixtures for Django models with customer isolation testing
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit
---

# Django Test Fixture Generator

Generate pytest fixtures for Django models following established patterns, including customer isolation testing.

## Skill Invocation

```
/django-test-fixture <model-name> [app-name]
```

**Examples:**
- `/django-test-fixture Alert` - Generate fixtures for Alert model
- `/django-test-fixture Finding alertvalidation` - Specify app explicitly

## Required Information

Before generating, gather:

1. **Model name** (PascalCase): e.g., `Alert`, `Finding`, `Report`
2. **App location**: e.g., `apps.agents.models`, `apps.alertvalidation.models`
3. **Required fields** and their types
4. **Foreign key relationships** (especially to `Customer`)

## Generation Template

```python
# ============================================
# {ModelName} Fixtures
# ============================================

@pytest.fixture
def test_{model_name}(db, test_customer):
    """Create a test {model_name}."""
    obj = {ModelName}.objects.create(
        name="Test {ModelName}",
        customer=test_customer,
        # Add required fields
    )
    return obj


@pytest.fixture
def second_{model_name}(db, test_customer):
    """Create a second test {model_name}."""
    obj = {ModelName}.objects.create(
        name="Second Test {ModelName}",
        customer=test_customer,
    )
    return obj


@pytest.fixture
def other_customer_{model_name}(db, second_customer):
    """Create a {model_name} for the other customer (access control testing)."""
    obj = {ModelName}.objects.create(
        name="Other Customer {ModelName}",
        customer=second_customer,
    )
    return obj
```

## Naming Conventions

| Purpose | Naming Pattern | Example |
|---------|---------------|---------|
| Primary test fixture | `test_{model_name}` | `test_campaign` |
| Second instance | `second_{model_name}` | `second_campaign` |
| Other customer | `other_customer_{model_name}` | `other_customer_campaign` |

## Test File Template

Generate test file at `apps/{app}/tests/test_{model_name}_views.py`:

```python
@pytest.mark.django_db
class Test{ModelName}ListView:
    def test_list_{model_name_plural}_customer_isolation(
        self, authenticated_client, test_customer, test_{model_name}, other_customer_{model_name}
    ):
        """Test that users only see their own customer's {model_name_plural}."""
        url = reverse("{model_name}-list", kwargs={"customer_uuid": test_customer.uuid})
        response = authenticated_client.get(url)

        ids = [item["id"] for item in response.json()["{model_name_plural}"]]
        assert test_{model_name}.id in ids
        assert other_customer_{model_name}.id not in ids
```

## Verification Checklist

- [ ] Import added to conftest.py
- [ ] Primary fixture created
- [ ] Other customer fixture created for isolation tests
- [ ] All required fields populated
- [ ] Docstring explains fixture purpose
