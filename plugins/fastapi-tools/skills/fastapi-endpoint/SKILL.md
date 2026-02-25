---
name: fastapi-endpoint
description: Generate new FastAPI endpoint modules for the gateway service
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write
---

# FastAPI Endpoint Generator

Generate new FastAPI endpoint modules following established patterns.

## Skill Invocation

```
/fastapi-endpoint <resource-name> [description]
```

**Examples:**
- `/fastapi-endpoint findings`
- `/fastapi-endpoint alerts "Alert management endpoints"`

## Required Information

1. **Resource name** (singular, lowercase): e.g., `finding`, `alert`
2. **HTTP methods needed**: GET (list), GET (single), POST, PATCH, DELETE
3. **Query/filter parameters** for GET list endpoint
4. **Request body fields** for POST/PATCH endpoints

## Generation Steps

### Step 1: Create endpoint module

Create `app/api/api_v1/paths/{resource_plural}.py`:

```python
from fastapi import APIRouter, status, Query, Path, Depends, Response
from pydantic import BaseModel, Field
from typing import List, Optional, Annotated
from ...api_v1.settings import make_request, get_auth_token

router = APIRouter(prefix="/{resource_plural}", tags=["{ResourcePlural}"])


class {Resource}Query(BaseModel):
    id: Optional[int] = Query(None)
    name: Optional[str] = Query(None)


class {Resource}Create(BaseModel):
    name: str = Field(..., description="Name for the {resource}")


@router.get("")
async def list_{resource_plural}(
    res: Response,
    query: {Resource}Query = Depends(),
    token: str = Depends(get_auth_token),
):
    response = make_request(
        "/api/v2/{resource_plural}",
        "GET",
        params=query.model_dump(exclude_none=True),
        api_key=token,
    )
    res.status_code = response.status_code
    return response.json()
```

### Step 2: Register the router

Add to `app/api/api_v1/api.py`:

```python
from .paths import {resource_plural}
router.include_router({resource_plural}.router)
```

## Key Patterns

1. Always use Pydantic models for query params and request bodies
2. Always use `Depends(get_auth_token)` for authentication
3. Always use `make_request()` to proxy to Django backend
4. Always forward status codes via `res.status_code`

## Verification Checklist

- [ ] File created in `app/api/api_v1/paths/`
- [ ] Import added to `api.py`
- [ ] Router registered in `api.py`
- [ ] Pydantic models have Field descriptions
- [ ] All endpoints have docstrings
