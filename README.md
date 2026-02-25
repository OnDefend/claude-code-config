# OnDefend Claude Code Configuration

Shared Claude Code plugins, skills, and configurations for the OnDefend team. This repository serves as a plugin marketplace that provides standardized development workflows, code patterns, and automation.

## Quick Start

### Installation

```bash
# Add the marketplace
/plugin marketplace add OnDefend/claude-code-config

# Install all plugins
/plugin install blindspot-core@OnDefend/claude-code-config
/plugin install django-tools@OnDefend/claude-code-config
/plugin install react-tools@OnDefend/claude-code-config
/plugin install fastapi-tools@OnDefend/claude-code-config
/plugin install e2e-testing@OnDefend/claude-code-config
```

### Verify Installation

```bash
/plugin list
```

---

## Available Plugins

### blindspot-core

Core conventions and mandatory behaviors for all Blindspot projects.

| Component | Description |
|-----------|-------------|
| **Git Rules** | No AI attribution in commits, conventional commit format |
| **Context7 Mandatory** | Auto-lookup documentation for all library code generation |
| **Code Style** | Python PEP 8, ES modules, type hints |

---

### django-tools

Django/DRF development tools for BlindspotAPI.

#### Skills

| Skill | Description | Example |
|-------|-------------|---------|
| `/customer-access-audit` | Audit views for customer data isolation vulnerabilities | `/customer-access-audit apps/react/views/` |
| `/django-test-fixture` | Generate pytest fixtures with customer isolation | `/django-test-fixture Alert alertvalidation` |

#### Rules
- All views must call `get_customer(request, customer_uuid)`
- Filter all querysets by `customer=customer`
- Use `@flexible_api_authentication` decorator

---

### react-tools

React/MUI development tools for BlindspotWeb.

#### Skills

| Skill | Description | Example |
|-------|-------------|---------|
| `/react-component` | Scaffold React components | `/react-component list-page Alerts` |

**Component Types:** `page`, `list-page`, `form-page`, `detail-page`, `modal`, `card`

#### Rules
- Use `useAppSelector` for Redux state
- Use `useContext(DataContext)` for auth tokens
- API paths must include `${current_customer.uuid}`

---

### fastapi-tools

FastAPI gateway development tools for BlindspotFastAPI.

#### Skills

| Skill | Description | Example |
|-------|-------------|---------|
| `/fastapi-endpoint` | Generate gateway endpoint modules | `/fastapi-endpoint findings` |

#### Rules
- Use Pydantic models for all request/response validation
- Use `Depends(get_auth_token)` for authentication
- Use `make_request()` to proxy to Django backend

---

### e2e-testing

Playwright E2E testing tools for BlindspotWeb.

#### Skills

| Skill | Description | Example |
|-------|-------------|---------|
| `/e2e-test` | Generate Playwright tests with Page Object Model | `/e2e-test SecurityTools crud` |

**Test Types:** `page`, `flow`, `crud`

#### Rules
- Extend `BasePage` for all page objects
- Use `data-testid` or `getByRole()` selectors
- No arbitrary timeouts - use `waitFor()`

---

## Repository Structure

```
claude-code-config/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace definition
├── plugins/
│   ├── blindspot-core/           # Core conventions
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   └── rules/
│   │       ├── git-rules.md
│   │       ├── context7-mandatory.md
│   │       └── code-style.md
│   ├── django-tools/             # Django development
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── rules/
│   │   │   └── django-patterns.md
│   │   └── skills/
│   │       ├── customer-access-audit/
│   │       │   └── SKILL.md
│   │       └── django-test-fixture/
│   │           └── SKILL.md
│   ├── react-tools/              # React development
│   ├── fastapi-tools/            # FastAPI development
│   └── e2e-testing/              # E2E testing
├── templates/
│   ├── CLAUDE.md.template        # Starter CLAUDE.md for projects
│   └── settings.json.template    # Starter settings with marketplace
└── scripts/
    ├── setup.sh                  # Linux/Mac setup script
    └── setup.ps1                 # Windows PowerShell setup script
```

---

## Updating Plugins

```bash
# Update marketplace index
/plugin marketplace update OnDefend/claude-code-config

# Update specific plugin
/plugin update django-tools@OnDefend/claude-code-config

# Update all plugins
/plugin update --all
```

---

## Templates

Starter templates are available in `templates/`:

| Template | Description |
|----------|-------------|
| `CLAUDE.md.template` | Base CLAUDE.md with standard sections |
| `settings.json.template` | Settings with marketplace and permissions pre-configured |

---

## Contributing

### Adding a New Skill

1. Create skill directory:
   ```
   plugins/<plugin>/skills/<skill-name>/SKILL.md
   ```

2. Add YAML frontmatter:
   ```yaml
   ---
   name: skill-name
   description: When to use this skill
   user-invocable: true
   allowed-tools: Read, Grep, Glob
   ---
   ```

3. Document with examples and verification checklist

4. Update `plugin.json` to include the skill

5. Submit a PR

### Adding a New Plugin

1. Create plugin structure:
   ```
   plugins/<plugin-name>/
   ├── .claude-plugin/
   │   └── plugin.json
   ├── rules/
   └── skills/
   ```

2. Add to `marketplace.json`

3. Update this README

4. Submit a PR

---

## Local Development

Test changes locally before pushing:

```bash
# Add as local marketplace
/plugin marketplace add ./path/to/claude-code-config

# Install from local
/plugin install blindspot-core@./path/to/claude-code-config
```

---

## Support

- **Issues**: [GitHub Issues](https://github.com/OnDefend/claude-code-config/issues)
- **Claude Code Docs**: https://code.claude.com/docs/

---

## License

Internal use only - OnDefend
