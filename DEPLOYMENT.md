# Frappe Expertise Suite - Deployment Guide

Complete guide for deploying and migrating the frappe-experts module across different environments.

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Module Structure](#module-structure)
3. [Deployment Scenarios](#deployment-scenarios)
4. [Migration to New Laptop](#migration-to-new-laptop)
5. [Development Workflow](#development-workflow)
6. [Troubleshooting](#troubleshooting)

---

## Overview

The **frappe-experts** module is designed to be **portable and self-contained**. All agents and workflows are defined as YAML source files that compile to XML .md format.

**Key Principles:**
- ✅ **Source files (YAML)** are version controlled
- ❌ **Compiled files (.md)** are NOT version controlled (generated on deployment)
- ✅ **Module is project-agnostic** (uses `{project-root}` tokens)
- ✅ **Zero hardcoded paths** (all paths are relative)

---

## Module Structure

```
frappe-experts/
├── .gitignore                    # Excludes compiled files and data
├── config.yaml                   # Module configuration
├── README.md                     # Module documentation
├── DEPLOYMENT.md                 # This file
├── deploy.sh                     # Deployment script
│
├── _module-installer/
│   └── install-config.yaml       # BMAD installer configuration
│
├── agents/                       # Agent definitions
│   ├── erpnext-ba.agent.yaml    # ✅ Source (version controlled)
│   ├── frappe-sa.agent.yaml     # ✅ Source
│   ├── phase-master.agent.yaml  # ✅ Source
│   ├── frappe-nexus.md          # ❌ Compiled (not in git)
│   ├── quick-guide.agent.yaml   # ✅ Source
│   ├── test-gen.agent.yaml      # ✅ Source
│   ├── debug-master.agent.yaml  # ✅ Source
│   │
│   └── *-sidecar/               # ❌ Compiled sidecars (not in git)
│       ├── memories.md
│       ├── instructions.md
│       └── knowledge/
│
├── workflows/                    # Workflow definitions
│   ├── create-brd/
│   │   ├── workflow.yaml        # ✅ Source (version controlled)
│   │   └── instructions.md      # ✅ Source
│   ├── review-requirements/
│   ├── create-tsd/
│   ├── create-implementation-plan/
│   ├── create-user-guide/
│   ├── generate-test-scenarios/
│   └── diagnose-error/
│
└── data/                         # ❌ NOT version controlled
    ├── requirements/             # Generated BRD documents
    ├── technical/                # Generated TSD documents
    ├── implementation/           # Generated Implementation Plans
    ├── guides/                   # Generated User Guides
    ├── testing/                  # Generated Test Scenarios
    └── diagnostics/              # Generated Error Diagnoses
```

---

## Deployment Scenarios

### Scenario 1: First-Time Installation

**On your current laptop:**

1. Ensure module is in `.bmad/custom/modules/`:
   ```bash
   cd /path/to/your/project
   ls .bmad/custom/modules/frappe-experts/
   ```

2. Run BMAD installer:
   ```bash
   bmad install frappe-experts
   ```

3. Verify installation:
   ```bash
   bmad list-modules
   ```

**What happens:**
- BMAD compiles YAML → XML .md files
- Creates module configuration
- Sets up command shortcuts
- Ready to use!

---

### Scenario 2: Migration to New Laptop (Git Repository)

**RECOMMENDED APPROACH** ⭐

#### Step 1: Setup Git Repository (First Time Only)

On your **current laptop**:

```bash
cd .bmad/custom/modules/frappe-experts/

# Initialize git repository
git init

# Add all source files (compiled files are excluded by .gitignore)
git add .

# Create initial commit
git commit -m "Initial commit: Frappe Expertise Suite v1.0"

# Add remote (GitHub, GitLab, Bitbucket, etc.)
git remote add origin <your-repo-url>

# Push to remote
git push -u origin main
```

#### Step 2: Deploy to New Laptop

On your **new laptop**:

```bash
# Navigate to your project
cd /path/to/your/frappe-project

# Create custom modules directory if it doesn't exist
mkdir -p .bmad/custom/modules/

# Clone the module
cd .bmad/custom/modules/
git clone <your-repo-url> frappe-experts

# Navigate to module
cd frappe-experts

# Run deployment script
./deploy.sh
# OR manually:
# cd /path/to/your/frappe-project
# bmad install frappe-experts
```

#### Step 3: Verify Installation

```bash
# Check agents are available
bmad list-agents

# Load an agent to test
# (In Claude Code interface)
/bmad:load frappe-experts:erpnext-ba
```

**Advantages:**
- ✅ Version control for all agents and workflows
- ✅ Easy updates (`git pull`)
- ✅ Team collaboration ready
- ✅ Track changes over time
- ✅ Rollback to previous versions if needed

---

### Scenario 3: Manual Copy (Without Git)

**Quick and simple, but less maintainable**

#### On Current Laptop:

```bash
cd .bmad/custom/modules/

# Create a portable package
tar -czf frappe-experts-v1.0.tar.gz \
  --exclude='agents/*.md' \
  --exclude='agents/*-sidecar' \
  --exclude='data' \
  frappe-experts/

# Copy to USB drive or cloud storage
```

#### On New Laptop:

```bash
# Navigate to target project
cd /path/to/your/frappe-project/.bmad/custom/modules/

# Extract module
tar -xzf frappe-experts-v1.0.tar.gz

# Run deployment
cd frappe-experts
./deploy.sh
```

---

### Scenario 4: Development Mode (Symlink)

**For active development of the module itself**

If you're developing the module and want changes to reflect immediately:

```bash
# Keep module in a separate development directory
cd ~/dev/bmad-modules/frappe-experts/

# Symlink to project
ln -s ~/dev/bmad-modules/frappe-experts \
  /path/to/project/.bmad/custom/modules/frappe-experts

# Install/compile
cd /path/to/project
bmad install frappe-experts
```

**Advantages:**
- ✅ Edit once, use in multiple projects
- ✅ Centralized module development
- ✅ Easy testing across projects

---

## Migration to New Laptop

### Complete Migration Checklist

**Before migration (Current Laptop):**

- [ ] Commit all changes to git
- [ ] Push to remote repository
- [ ] Note your BMAD configuration settings
- [ ] Backup any custom data in `data/` folder (if needed)

**On new laptop:**

- [ ] Install BMAD framework
- [ ] Clone your project repository
- [ ] Clone frappe-experts module to `.bmad/custom/modules/`
- [ ] Run `bmad install frappe-experts`
- [ ] Test agent loading

**Estimated time:** 5-10 minutes

---

## Development Workflow

### Making Changes to the Module

1. **Edit source files** (YAML):
   ```bash
   cd .bmad/custom/modules/frappe-experts/
   vim agents/erpnext-ba.agent.yaml
   ```

2. **Recompile**:
   ```bash
   cd /path/to/project
   bmad install frappe-experts --force
   # OR
   bmad compile frappe-experts
   ```

3. **Test changes**:
   ```
   /bmad:load frappe-experts:erpnext-ba
   ```

4. **Commit changes**:
   ```bash
   cd .bmad/custom/modules/frappe-experts/
   git add agents/erpnext-ba.agent.yaml
   git commit -m "Update ERPNext BA persona"
   git push
   ```

---

### Creating a New Agent

1. Create YAML source file:
   ```bash
   cd agents/
   cp erpnext-ba.agent.yaml new-agent.agent.yaml
   vim new-agent.agent.yaml
   ```

2. Update config if needed:
   ```bash
   vim config.yaml
   ```

3. Recompile:
   ```bash
   bmad install frappe-experts --force
   ```

4. Commit:
   ```bash
   git add agents/new-agent.agent.yaml
   git commit -m "Add new agent: [name]"
   git push
   ```

---

### Creating a New Workflow

1. Create workflow directory:
   ```bash
   cd workflows/
   mkdir my-new-workflow
   ```

2. Create workflow files:
   ```bash
   cd my-new-workflow/
   vim workflow.yaml
   vim instructions.md
   ```

3. Recompile:
   ```bash
   bmad install frappe-experts --force
   ```

4. Commit:
   ```bash
   git add workflows/my-new-workflow/
   git commit -m "Add workflow: my-new-workflow"
   git push
   ```

---

## Troubleshooting

### Issue: "Module not found"

**Cause:** Module not in `.bmad/custom/modules/`

**Fix:**
```bash
cd /path/to/project
ls .bmad/custom/modules/frappe-experts/
# If not found, deploy the module first
```

---

### Issue: "Agent not loading"

**Cause:** Module not compiled yet

**Fix:**
```bash
bmad install frappe-experts --force
# OR
bmad compile frappe-experts
```

---

### Issue: "Config values not resolving"

**Cause:** BMAD core config not set up

**Fix:**
```bash
bmad config set user_name "Your Name"
bmad config set communication_language "English"
```

---

### Issue: "Workflows not showing up"

**Cause:** Workflows not installed properly

**Fix:**
```bash
# Reinstall module
bmad install frappe-experts --force

# Verify workflows exist
ls .bmad/custom/modules/frappe-experts/workflows/
```

---

### Issue: "Git says 'compiled files changed'"

**Cause:** `.gitignore` not set up correctly

**Fix:**
```bash
cd .bmad/custom/modules/frappe-experts/
git checkout .gitignore
git status
# Should NOT show compiled .md files
```

---

## Version Management

### Semantic Versioning

The module follows semantic versioning (vX.Y.Z):
- **X (Major)**: Breaking changes to agent APIs or workflows
- **Y (Minor)**: New agents, new workflows, new features
- **Z (Patch)**: Bug fixes, documentation updates

### Tagging Releases

```bash
cd .bmad/custom/modules/frappe-experts/

# Tag a release
git tag -a v1.0.0 -m "Release v1.0.0: Initial release"
git push origin v1.0.0

# Update config.yaml version
vim config.yaml  # Update module_version: '1.0.0'
git commit -am "Bump version to 1.0.0"
git push
```

---

## Advanced: Multi-Project Setup

If you use frappe-experts across multiple projects:

### Option 1: Global Module Location

```bash
# Create a shared modules directory
mkdir -p ~/.bmad/shared-modules/

# Clone module there
cd ~/.bmad/shared-modules/
git clone <repo-url> frappe-experts

# Symlink to each project
ln -s ~/.bmad/shared-modules/frappe-experts \
  ~/project1/.bmad/custom/modules/frappe-experts

ln -s ~/.bmad/shared-modules/frappe-experts \
  ~/project2/.bmad/custom/modules/frappe-experts
```

### Option 2: Per-Project with Git Submodules

```bash
cd /path/to/project/.bmad/custom/modules/

# Add as git submodule
git submodule add <repo-url> frappe-experts

# Update submodule in future
git submodule update --remote frappe-experts
```

---

## Support

For issues with the module:
1. Check this deployment guide
2. Check module README.md
3. Review BMAD documentation
4. Open issue in module repository

---

**Last Updated:** 2025-11-12
**Module Version:** 1.0.0
**BMAD Version:** 6.x
