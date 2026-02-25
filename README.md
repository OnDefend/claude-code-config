# OnDefend Claude Code Configuration

Shared Claude Code plugins, skills, and configurations for the OnDefend team.

## Quick Start

### 1. Add the Marketplace

```bash
/plugin marketplace add OnDefend/claude-code-config
```

### 2. Install Plugins

```bash
# Install all recommended plugins
/plugin install blindspot-core@OnDefend/claude-code-config
/plugin install django-tools@OnDefend/claude-code-config
/plugin install react-tools@OnDefend/claude-code-config
/plugin install fastapi-tools@OnDefend/claude-code-config

# Or install individually
/plugin install customer-access-audit@OnDefend/claude-code-config
```

### 3. Verify Installation

```bash
/plugin list
```

## Available Plugins

| Plugin | Description | Skills Included |
|--------|-------------|-----------------|
| `blindspot-core` | Core Blindspot conventions and rules | Context7 workflow, git rules |
| `django-tools` | Django/DRF development tools | `/django-test-fixture`, `/customer-access-audit` |
| `react-tools` | React/MUI development tools | `/react-component` |
| `fastapi-tools` | FastAPI gateway tools | `/fastapi-endpoint` |
| `e2e-testing` | Playwright E2E testing tools | `/e2e-test` |

## For New Team Members

1. Install Claude Code: https://claude.ai/code
2. Clone your project repository
3. Run the commands above to add marketplace and install plugins
4. Start coding!

## Updating Plugins

```bash
# Update marketplace index
/plugin marketplace update OnDefend/claude-code-config

# Update specific plugin
/plugin update blindspot-core@OnDefend/claude-code-config

# Update all plugins
/plugin update --all
```

## Repository Structure

```
claude-code-config/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace definition
├── plugins/
│   ├── blindspot-core/           # Core conventions
│   ├── django-tools/             # Django skills
│   ├── react-tools/              # React skills
│   ├── fastapi-tools/            # FastAPI skills
│   └── e2e-testing/              # E2E testing skills
├── templates/
│   ├── CLAUDE.md.template        # CLAUDE.md starter
│   └── settings.json.template    # Settings starter
└── README.md
```

## Contributing

1. Create a branch for your changes
2. Add/modify plugins in `plugins/` directory
3. Update `marketplace.json` if adding new plugins
4. Submit a PR for review

## License

Internal use only - OnDefend
