---
paths:
  - "**/app/**/*.py"
---

# FastAPI Gateway Patterns

## Endpoint Structure

All endpoints must:
1. Use Pydantic models for validation
2. Use `Depends(get_auth_token)` for auth
3. Use `make_request()` to proxy to Django
4. Forward status codes from backend

## Request Handling

```python
@router.get("")
async def list_items(
    res: Response,
    query: ItemQuery = Depends(),
    token: str = Depends(get_auth_token),
):
    response = make_request(
        "/api/v2/items",
        "GET",
        params=query.model_dump(exclude_none=True),
        api_key=token,
    )
    res.status_code = response.status_code
    return response.json()
```

## Path Parameters

Use `Annotated` with `Path` for path parameters:
```python
item_id: Annotated[int, Path(title="The ID of the item")]
```
