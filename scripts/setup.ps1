# OnDefend Claude Code Setup Script (PowerShell)
# Run this script to configure Claude Code with OnDefend plugins

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "OnDefend Claude Code Setup" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Check if claude is available
$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claudeCmd) {
    Write-Host "Error: Claude Code is not installed." -ForegroundColor Red
    Write-Host "Install it from: https://claude.ai/code"
    exit 1
}

Write-Host "Adding OnDefend marketplace..."
& claude mcp add-marketplace OnDefend/claude-code-config 2>$null

Write-Host ""
Write-Host "Installing plugins..."

# Core plugins
Write-Host "  - Installing blindspot-core..."
& claude plugin install blindspot-core@OnDefend/claude-code-config 2>$null

Write-Host "  - Installing django-tools..."
& claude plugin install django-tools@OnDefend/claude-code-config 2>$null

Write-Host "  - Installing react-tools..."
& claude plugin install react-tools@OnDefend/claude-code-config 2>$null

Write-Host "  - Installing fastapi-tools..."
& claude plugin install fastapi-tools@OnDefend/claude-code-config 2>$null

Write-Host "  - Installing e2e-testing..."
& claude plugin install e2e-testing@OnDefend/claude-code-config 2>$null

Write-Host ""
Write-Host "===================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "Available skills:"
Write-Host "  /customer-access-audit  - Audit Django views for customer isolation"
Write-Host "  /django-test-fixture    - Generate pytest fixtures"
Write-Host "  /react-component        - Scaffold React components"
Write-Host "  /fastapi-endpoint       - Generate FastAPI endpoints"
Write-Host "  /e2e-test              - Generate Playwright tests"
Write-Host ""
Write-Host "Run 'claude /plugin list' to see all installed plugins."
