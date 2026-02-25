---
name: customer-access-audit
description: Audit Django views for proper customer data isolation to prevent data leakage between customers
user-invocable: true
allowed-tools: Read, Grep, Glob
---

# Customer Access Auditor

Audit Django views and API endpoints for proper customer isolation/scoping to prevent data leakage between customers.

## Skill Invocation

```
/customer-access-audit [path-or-app]
```

**Examples:**
- `/customer-access-audit` - Audit all Django apps
- `/customer-access-audit apps/react/views/` - Audit specific directory
- `/customer-access-audit campaigns` - Audit specific app

## What This Auditor Checks

### Critical Patterns (Must Have)

Every Django view that accesses customer-specific data MUST:

1. **Get customer from request context**:
```python
customer = get_customer(request, customer_uuid)
```

2. **Filter querysets by customer**:
```python
# CORRECT
Model.objects.filter(customer=customer)

# WRONG - Data leak vulnerability!
Model.objects.all()
Model.objects.filter(id=some_id)  # Missing customer filter
```

3. **Use proper decorators**:
```python
@api_view(["GET", "POST"])
@flexible_api_authentication(check_agreements=True)
@exception_handler_decorator
def my_view(request, customer_uuid):
    customer = get_customer(request, customer_uuid)
    # ...
```

### Models That MUST Be Customer-Scoped

| Model | Location | Filter Pattern |
|-------|----------|----------------|
| `Endpoint` | `apps.agents.models` | `.filter(customer=customer)` |
| `CampaignV2` | `apps.agents.models` | `.filter(customer=customer)` |
| `SecurityTool` | `apps.agents.models` | `.filter(customer=customer)` |
| `ProxyConfigs` | `apps.agents.models` | `.filter(customer=customer)` |
| `AgentInstall` | `apps.agents.models` | `.filter(customer=customer)` |
| `ReportV2` | `apps.reporting.models` | `.filter(customer=customer)` |
| `KnowledgeBase` | `apps.agents.models` | `.filter(customer=customer)` |

### Global/Shared Models (No Customer Filter Needed)

- `Simulation` (library simulations)
- `AttackTechnique` (MITRE ATT&CK reference)
- `SimulationAction` (global actions)
- `ServerConfig` (system-wide config)

## Audit Process

### Step 1: Scan for views

Search the target path for:
```python
@api_view
class *View(APIView):
class *ViewSet(ViewSet):
@flexible_api_authentication
```

### Step 2: For each view, check:

1. Does it accept `customer_uuid` parameter?
2. Does it query customer-scoped models?
3. Are there any unfiltered queries?

### Step 3: Generate report

```markdown
## Customer Access Audit Report

### Summary
- Files scanned: X
- Views analyzed: X
- Issues found: X (Critical: X, Warning: X)

### Critical Issues (Data Leak Risk)

#### 1. [CRITICAL] apps/react/views/example.py:45 - get_items()
**Issue**: Endpoint model queried without customer filter
**Code**: `Endpoint.objects.filter(id=endpoint_id)`
**Fix**: `Endpoint.objects.filter(id=endpoint_id, customer=customer)`
```

## Common Vulnerability Patterns

### Pattern 1: Direct ID lookup without customer
```python
# VULNERABLE
endpoint = Endpoint.objects.get(id=endpoint_id)

# FIXED
customer = get_customer(request, customer_uuid)
endpoint = Endpoint.objects.get(id=endpoint_id, customer=customer)
```

### Pattern 2: UUID lookup without customer
```python
# VULNERABLE
report = ReportV2.objects.get(uuid=report_uuid)

# FIXED
report = ReportV2.objects.get(uuid=report_uuid, customer=customer)
```

## Verification Commands

After fixes, verify with grep:
```bash
grep -n "objects.get\|objects.filter\|objects.all" <file> | grep -v "customer="
```
