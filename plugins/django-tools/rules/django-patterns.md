---
paths:
  - "**/apps/**/*.py"
  - "**/tests/**/*.py"
---

# Django Development Patterns

## Customer Data Isolation

**CRITICAL**: All views accessing customer-specific data MUST:

1. Call `get_customer(request, customer_uuid)` at the start
2. Filter ALL querysets by `customer=customer`
3. Never use `.objects.all()` or `.objects.get(id=...)` without customer filter

## View Decorators

Always use this pattern:

```python
@api_view(["GET", "POST"])
@flexible_api_authentication(check_agreements=True)
@exception_handler_decorator
def my_view(request, customer_uuid):
    customer = get_customer(request, customer_uuid)
    # ...
```

## Testing

- Add fixtures to `conftest.py`
- Always create `other_customer_*` fixtures for isolation tests
- Use `@pytest.mark.django_db` decorator

## Serializers

- Use `customer` field as read-only or exclude from input
- Validate that related objects belong to the same customer
