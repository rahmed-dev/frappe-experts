#!/bin/bash
# Deploy frappe-experts module
# This script helps deploy the module to a new environment

set -e  # Exit on error

echo "🚀 Frappe Expertise Suite - Deployment Script"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory (where this deploy script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULE_NAME="frappe-experts"

echo "📁 Module path: $SCRIPT_DIR"
echo ""

# Check if we're in the right directory
if [ ! -f "$SCRIPT_DIR/config.yaml" ]; then
    echo -e "${RED}❌ Error: config.yaml not found. Are you in the module directory?${NC}"
    exit 1
fi

# Check if bmad is available
if ! command -v bmad &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: 'bmad' command not found in PATH${NC}"
    echo "You may need to install BMAD first or ensure it's in your PATH"
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Detect project root (look for .bmad directory)
PROJECT_ROOT=""
CURRENT_DIR="$SCRIPT_DIR"

while [[ "$CURRENT_DIR" != "/" ]]; do
    if [ -d "$CURRENT_DIR/.bmad" ]; then
        PROJECT_ROOT="$CURRENT_DIR"
        break
    fi
    CURRENT_DIR="$(dirname "$CURRENT_DIR")"
done

if [ -z "$PROJECT_ROOT" ]; then
    echo -e "${YELLOW}⚠️  Could not auto-detect project root${NC}"
    echo "Please enter the project root directory (where .bmad folder exists):"
    read -r PROJECT_ROOT

    if [ ! -d "$PROJECT_ROOT/.bmad" ]; then
        echo -e "${RED}❌ Error: .bmad directory not found at $PROJECT_ROOT${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Project root: $PROJECT_ROOT${NC}"
echo ""

# Deployment options
echo "Deployment Options:"
echo "1. Install module using BMAD installer (Recommended)"
echo "2. Manual symlink setup (Advanced)"
echo "3. Copy module to .bmad/custom/modules/ (One-time setup)"
echo ""
read -p "Select option (1-3): " DEPLOY_OPTION

case $DEPLOY_OPTION in
    1)
        echo ""
        echo "📦 Installing via BMAD installer..."
        echo ""

        # Check if module is already in .bmad/custom/modules/
        TARGET_PATH="$PROJECT_ROOT/.bmad/custom/modules/$MODULE_NAME"

        if [ "$SCRIPT_DIR" != "$TARGET_PATH" ]; then
            echo "Module needs to be in: $TARGET_PATH"
            echo "Current location: $SCRIPT_DIR"
            echo ""
            read -p "Copy module to target location? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                mkdir -p "$(dirname "$TARGET_PATH")"
                cp -r "$SCRIPT_DIR" "$TARGET_PATH"
                echo -e "${GREEN}✅ Module copied to $TARGET_PATH${NC}"
            else
                echo "Please manually move module to $TARGET_PATH"
                exit 1
            fi
        fi

        echo ""
        echo "Now run:"
        echo "  cd $PROJECT_ROOT"
        echo "  bmad install $MODULE_NAME"
        echo ""
        ;;

    2)
        echo ""
        echo "🔗 Manual symlink setup..."
        echo "This will create symlinks in .claude/commands/"
        echo ""

        CLAUDE_COMMANDS="$PROJECT_ROOT/.claude/commands"

        if [ ! -d "$CLAUDE_COMMANDS" ]; then
            echo -e "${RED}❌ Error: .claude/commands not found at $PROJECT_ROOT${NC}"
            echo "Please run Claude Code initialization first"
            exit 1
        fi

        # Create module directory structure
        mkdir -p "$CLAUDE_COMMANDS/bmad/$MODULE_NAME/agents"
        mkdir -p "$CLAUDE_COMMANDS/bmad/$MODULE_NAME/workflows"

        echo "Creating agent symlinks..."

        # Symlink all agents (will be compiled .md files)
        for agent_yaml in "$SCRIPT_DIR/agents"/*.agent.yaml; do
            if [ -f "$agent_yaml" ]; then
                agent_name=$(basename "$agent_yaml" .agent.yaml)
                agent_md="$SCRIPT_DIR/agents/${agent_name}.md"

                # Check if compiled .md file exists
                if [ -f "$agent_md" ]; then
                    ln -sf "$agent_md" "$CLAUDE_COMMANDS/bmad/$MODULE_NAME/agents/${agent_name}.md"
                    echo -e "  ${GREEN}✅${NC} $agent_name"
                else
                    echo -e "  ${YELLOW}⚠️${NC}  $agent_name (not compiled yet)"
                fi
            fi
        done

        echo ""
        echo "Creating workflow symlinks..."

        # Symlink all workflows
        for workflow_dir in "$SCRIPT_DIR/workflows"/*; do
            if [ -d "$workflow_dir" ]; then
                workflow_name=$(basename "$workflow_dir")
                ln -sf "$workflow_dir" "$CLAUDE_COMMANDS/bmad/$MODULE_NAME/workflows/$workflow_name"
                echo -e "  ${GREEN}✅${NC} $workflow_name"
            fi
        done

        echo ""
        echo -e "${GREEN}✅ Symlinks created!${NC}"
        echo ""
        echo "Note: You need to compile agents first:"
        echo "  bmad compile $MODULE_NAME"
        echo ""
        ;;

    3)
        echo ""
        echo "📋 Copying module to .bmad/custom/modules/..."
        echo ""

        TARGET_PATH="$PROJECT_ROOT/.bmad/custom/modules/$MODULE_NAME"

        if [ "$SCRIPT_DIR" == "$TARGET_PATH" ]; then
            echo "Module is already in the correct location!"
        else
            mkdir -p "$(dirname "$TARGET_PATH")"

            if [ -d "$TARGET_PATH" ]; then
                echo -e "${YELLOW}⚠️  Target directory already exists${NC}"
                read -p "Overwrite? (y/n) " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    exit 1
                fi
                rm -rf "$TARGET_PATH"
            fi

            cp -r "$SCRIPT_DIR" "$TARGET_PATH"
            echo -e "${GREEN}✅ Module copied to $TARGET_PATH${NC}"
        fi

        echo ""
        echo "Next steps:"
        echo "  1. cd $PROJECT_ROOT"
        echo "  2. bmad install $MODULE_NAME"
        echo ""
        ;;

    *)
        echo -e "${RED}Invalid option${NC}"
        exit 1
        ;;
esac

echo "🎉 Deployment process complete!"
echo ""
echo "📚 For more details, see DEPLOYMENT.md"
