# MANDATORY: Context7 MCP Usage

**THIS IS A REQUIRED BEHAVIOR - NOT OPTIONAL**

You MUST automatically use Context7 MCP tools whenever you are:
- **Generating code** that uses any library or framework
- **Writing setup/configuration** steps for dependencies
- **Looking up library/API documentation** or syntax
- **Debugging** library-related issues
- **Implementing patterns** specific to a library

## Required Workflow

1. **Identify the library** being used (FastAPI, SQLAlchemy, Django, React, MUI, etc.)
2. **Automatically call** `mcp__plugin_context7_context7__resolve-library-id` with the library name
3. **Fetch documentation** with `mcp__plugin_context7_context7__query-docs` using the resolved ID and relevant topic
4. **Use the documentation** to write accurate, current code

## Do NOT:
- Wait for the user to ask you to look up documentation
- Guess at API syntax or patterns without checking
- Skip this step even for libraries you "know well" - always verify with current docs

## Example

User asks: "Add a new FastAPI endpoint for health checks"

You should IMMEDIATELY and AUTOMATICALLY:
1. Call `mcp__plugin_context7_context7__resolve-library-id` with "FastAPI"
2. Call `mcp__plugin_context7_context7__query-docs` with the resolved ID and topic "routing" or "endpoints"
3. Then write the code using the retrieved documentation
