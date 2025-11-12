# Migration Quick Start Guide

**Goal:** Deploy frappe-experts module to a new laptop in 5 minutes.

---

## 🚀 Current Laptop (One-Time Setup)

### Step 1: Create Git Repository

```bash
cd /home/riz/frappe-bench/.bmad/custom/modules/frappe-experts

# Repository is already initialized!
# Check status
git status

# Add remote repository
git remote add origin <your-github-repo-url>

# Push to remote
git push -u origin master
```

**Create GitHub repo:**
1. Go to https://github.com/new
2. Create repository: `frappe-experts-module`
3. Copy the repository URL
4. Use that URL in the `git remote add origin` command above

---

## 💻 New Laptop (Deploy Module)

### Prerequisites

- [ ] BMAD framework installed
- [ ] Frappe/ERPNext project set up
- [ ] Git installed

### Step 1: Clone Module

```bash
# Navigate to your Frappe project
cd /path/to/your/frappe-bench

# Create custom modules directory if it doesn't exist
mkdir -p .bmad/custom/modules/

# Clone the module
cd .bmad/custom/modules/
git clone <your-github-repo-url> frappe-experts
```

### Step 2: Install Module

```bash
# Go back to project root
cd /path/to/your/frappe-bench

# Install module
bmad install frappe-experts
```

### Step 3: Verify Installation

```bash
# List installed modules
bmad list-modules

# Should see:
# - frappe-experts (v1.0.0)

# List agents
bmad list-agents

# Should see all 7 agents:
# - frappe-experts:erpnext-ba
# - frappe-experts:frappe-sa
# - frappe-experts:phase-master
# - frappe-experts:frappe-nexus
# - frappe-experts:quick-guide
# - frappe-experts:test-gen
# - frappe-experts:debug-master
```

### Step 4: Test an Agent

In Claude Code interface:

```
/bmad:load frappe-experts:erpnext-ba
```

Then try:
```
*create-brd
```

---

## ✅ Done!

Your frappe-experts module is now deployed on the new laptop.

---

## 🔄 Keeping Module Updated

### On Current Laptop (After Making Changes)

```bash
cd .bmad/custom/modules/frappe-experts

# Stage changes
git add .

# Commit
git commit -m "Description of changes"

# Push
git push
```

### On New Laptop (Pull Updates)

```bash
cd .bmad/custom/modules/frappe-experts

# Pull latest changes
git pull

# Recompile module
cd /path/to/your/frappe-bench
bmad install frappe-experts --force
```

---

## 🆘 Troubleshooting

### "bmad: command not found"

Install BMAD framework first:
```bash
# Follow BMAD installation instructions
```

### "Module not compiling"

Force reinstall:
```bash
bmad install frappe-experts --force
```

### "Agent not loading"

Check compilation:
```bash
ls .bmad/custom/modules/frappe-experts/agents/*.md

# Should see compiled .md files
# If not, run:
bmad compile frappe-experts
```

---

## 📚 Full Documentation

For complete details, see:
- `DEPLOYMENT.md` - Comprehensive deployment guide
- `README.md` - Module documentation

---

**Total Time:** ~5 minutes
**Complexity:** Easy ⭐
