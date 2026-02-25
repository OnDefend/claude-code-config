#!/bin/bash

# OnDefend Claude Code Setup Script
# Run this script to configure Claude Code with OnDefend plugins

set -e

echo "==================================="
echo "OnDefend Claude Code Setup"
echo "==================================="
echo ""

# Check if claude is installed
if ! command -v claude &> /dev/null; then
    echo "Error: Claude Code is not installed."
    echo "Install it from: https://claude.ai/code"
    exit 1
fi

echo "Adding OnDefend marketplace..."
claude mcp add-marketplace OnDefend/claude-code-config 2>/dev/null || true

echo ""
echo "Installing plugins..."

# Core plugins
echo "  - Installing blindspot-core..."
claude plugin install blindspot-core@OnDefend/claude-code-config 2>/dev/null || true

echo "  - Installing django-tools..."
claude plugin install django-tools@OnDefend/claude-code-config 2>/dev/null || true

echo "  - Installing react-tools..."
claude plugin install react-tools@OnDefend/claude-code-config 2>/dev/null || true

echo "  - Installing fastapi-tools..."
claude plugin install fastapi-tools@OnDefend/claude-code-config 2>/dev/null || true

echo "  - Installing e2e-testing..."
claude plugin install e2e-testing@OnDefend/claude-code-config 2>/dev/null || true

echo ""
echo "==================================="
echo "Setup Complete!"
echo "==================================="
echo ""
echo "Available skills:"
echo "  /customer-access-audit  - Audit Django views for customer isolation"
echo "  /django-test-fixture    - Generate pytest fixtures"
echo "  /react-component        - Scaffold React components"
echo "  /fastapi-endpoint       - Generate FastAPI endpoints"
echo "  /e2e-test              - Generate Playwright tests"
echo ""
echo "Run 'claude /plugin list' to see all installed plugins."
