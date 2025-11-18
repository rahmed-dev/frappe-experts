#!/bin/bash
# =============================================================================
# BMAD Module Command Registration Script
# =============================================================================
# Registers a custom BMAD module's agents and workflows as Claude Code slash commands
#
# Usage: ./register-commands.sh [module-path] [project-root]
#   module-path:  Path to the module (default: parent of _module-installer)
#   project-root: Path to project root (default: auto-detect from module path)
#
# Example:
#   ./register-commands.sh
#   ./register-commands.sh /path/to/module
#   ./register-commands.sh /path/to/module /path/to/project
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory and default module path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULE_PATH="${1:-$(dirname "$SCRIPT_DIR")}"
MODULE_PATH="$(cd "$MODULE_PATH" && pwd)"

# Auto-detect project root (look for .claude directory)
if [ -n "$2" ]; then
    PROJECT_ROOT="$2"
else
    # Walk up from module path to find .claude directory
    SEARCH_PATH="$MODULE_PATH"
    while [ "$SEARCH_PATH" != "/" ]; do
        if [ -d "$SEARCH_PATH/.claude" ]; then
            PROJECT_ROOT="$SEARCH_PATH"
            break
        fi
        SEARCH_PATH="$(dirname "$SEARCH_PATH")"
    done
fi

if [ -z "$PROJECT_ROOT" ] || [ ! -d "$PROJECT_ROOT/.claude" ]; then
    echo -e "${RED}Error: Could not find project root with .claude directory${NC}"
    echo "Please specify project root as second argument"
    exit 1
fi

# Get module code/name from config
MODULE_CONFIG="$MODULE_PATH/config.yaml"
if [ ! -f "$MODULE_CONFIG" ]; then
    # Try install-config.yaml
    MODULE_CONFIG="$MODULE_PATH/_module-installer/install-config.yaml"
fi

if [ ! -f "$MODULE_CONFIG" ]; then
    echo -e "${RED}Error: Could not find module config.yaml or install-config.yaml${NC}"
    exit 1
fi

# Extract module code (try 'code:' first, then 'module_name:')
MODULE_CODE=$(grep -E "^code:|^module_name:" "$MODULE_CONFIG" | head -1 | sed "s/.*: *['\"]*//" | sed "s/['\"].*//")

if [ -z "$MODULE_CODE" ]; then
    echo -e "${RED}Error: Could not determine module code from config${NC}"
    exit 1
fi

# Calculate relative path from project root to module
RELATIVE_MODULE_PATH="${MODULE_PATH#$PROJECT_ROOT/}"

echo -e "${BLUE}=============================================${NC}"
echo -e "${BLUE}  BMAD Module Command Registration${NC}"
echo -e "${BLUE}=============================================${NC}"
echo ""
echo -e "Module:       ${GREEN}$MODULE_CODE${NC}"
echo -e "Module Path:  $MODULE_PATH"
echo -e "Project Root: $PROJECT_ROOT"
echo -e "Relative:     $RELATIVE_MODULE_PATH"
echo ""

# Create command directories
COMMANDS_DIR="$PROJECT_ROOT/.claude/commands/bmad/$MODULE_CODE"
AGENTS_CMD_DIR="$COMMANDS_DIR/agents"
WORKFLOWS_CMD_DIR="$COMMANDS_DIR/workflows"

mkdir -p "$AGENTS_CMD_DIR"
mkdir -p "$WORKFLOWS_CMD_DIR"

# =============================================================================
# Register Agents
# =============================================================================
echo -e "${YELLOW}Registering Agents...${NC}"

AGENT_COUNT=0
for agent_yaml in "$MODULE_PATH/agents"/*.agent.yaml; do
    [ -f "$agent_yaml" ] || continue

    # Get agent name from filename
    agent_name=$(basename "$agent_yaml" .agent.yaml)

    # Skip if in _archive
    if [[ "$agent_yaml" == *"_archive"* ]]; then
        continue
    fi

    # Check if .md file exists
    agent_md="$MODULE_PATH/agents/$agent_name.md"
    if [ ! -f "$agent_md" ]; then
        echo -e "  ${YELLOW}⚠ Skipping $agent_name (no .md file)${NC}"
        continue
    fi

    # Create command file
    cmd_file="$AGENTS_CMD_DIR/$agent_name.md"

    cat > "$cmd_file" << EOF
---
name: '$agent_name'
description: '$agent_name agent'
---

You must fully embody this agent's persona and follow all activation instructions exactly as specified. NEVER break character until given an exit command.

<agent-activation CRITICAL="TRUE">
1. LOAD the FULL agent file from @$RELATIVE_MODULE_PATH/agents/$agent_name.md
2. READ its entire contents - this contains the complete agent persona, menu, and instructions
3. Execute ALL activation steps exactly as written in the agent file
4. Follow the agent's persona and menu system precisely
5. Stay in character throughout the session
</agent-activation>
EOF

    echo -e "  ${GREEN}✓${NC} $agent_name"
    ((AGENT_COUNT++))
done

# Also check for .md files without .agent.yaml (some modules use this pattern)
for agent_md in "$MODULE_PATH/agents"/*.md; do
    [ -f "$agent_md" ] || continue

    agent_name=$(basename "$agent_md" .md)

    # Skip READMEs and already processed
    if [[ "$agent_name" == "README" ]] || [[ "$agent_name" == *"sidecar"* ]]; then
        continue
    fi

    # Skip if in _archive
    if [[ "$agent_md" == *"_archive"* ]]; then
        continue
    fi

    # Skip if command already created
    if [ -f "$AGENTS_CMD_DIR/$agent_name.md" ]; then
        continue
    fi

    # Create command file
    cmd_file="$AGENTS_CMD_DIR/$agent_name.md"

    cat > "$cmd_file" << EOF
---
name: '$agent_name'
description: '$agent_name agent'
---

You must fully embody this agent's persona and follow all activation instructions exactly as specified. NEVER break character until given an exit command.

<agent-activation CRITICAL="TRUE">
1. LOAD the FULL agent file from @$RELATIVE_MODULE_PATH/agents/$agent_name.md
2. READ its entire contents - this contains the complete agent persona, menu, and instructions
3. Execute ALL activation steps exactly as written in the agent file
4. Follow the agent's persona and menu system precisely
5. Stay in character throughout the session
</agent-activation>
EOF

    echo -e "  ${GREEN}✓${NC} $agent_name"
    ((AGENT_COUNT++))
done

echo ""

# =============================================================================
# Register Workflows
# =============================================================================
echo -e "${YELLOW}Registering Workflows...${NC}"

WORKFLOW_COUNT=0
for workflow_yaml in "$MODULE_PATH/workflows"/*/workflow.yaml; do
    [ -f "$workflow_yaml" ] || continue

    # Get workflow name from directory
    workflow_dir=$(dirname "$workflow_yaml")
    workflow_name=$(basename "$workflow_dir")

    # Extract description from workflow.yaml
    description=$(grep -E "^description:" "$workflow_yaml" | head -1 | sed 's/^description: *//' | sed 's/^"//' | sed 's/"$//' | sed "s/^'//" | sed "s/'$//")

    if [ -z "$description" ]; then
        description="$workflow_name workflow"
    fi

    # Truncate long descriptions
    if [ ${#description} -gt 100 ]; then
        description="${description:0:97}..."
    fi

    # Create command file
    cmd_file="$WORKFLOWS_CMD_DIR/$workflow_name.md"

    cat > "$cmd_file" << EOF
---
description: '$description'
---

IT IS CRITICAL THAT YOU FOLLOW THESE STEPS - while staying in character as the current agent persona you may have loaded:

<steps CRITICAL="TRUE">
1. Always LOAD the FULL @.bmad/core/tasks/workflow.xml
2. READ its entire contents - this is the CORE OS for EXECUTING the specific workflow-config @$RELATIVE_MODULE_PATH/workflows/$workflow_name/workflow.yaml
3. Pass the yaml path $RELATIVE_MODULE_PATH/workflows/$workflow_name/workflow.yaml as 'workflow-config' parameter to the workflow.xml instructions
4. Follow workflow.xml instructions EXACTLY as written to process and follow the specific workflow config and its instructions
5. Save outputs after EACH section when generating any documents from templates
</steps>
EOF

    echo -e "  ${GREEN}✓${NC} $workflow_name"
    ((WORKFLOW_COUNT++))
done

echo ""
echo -e "${BLUE}=============================================${NC}"
echo -e "${GREEN}Registration Complete!${NC}"
echo -e "${BLUE}=============================================${NC}"
echo ""
echo -e "  Agents:    ${GREEN}$AGENT_COUNT${NC} registered"
echo -e "  Workflows: ${GREEN}$WORKFLOW_COUNT${NC} registered"
echo ""
echo -e "Commands created in:"
echo -e "  $COMMANDS_DIR"
echo ""
echo -e "${YELLOW}Start a NEW Claude Code session to use the commands:${NC}"
echo -e "  /bmad:$MODULE_CODE:agents:<agent-name>"
echo -e "  /bmad:$MODULE_CODE:workflows:<workflow-name>"
echo ""
