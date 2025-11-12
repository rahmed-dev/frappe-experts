# Frappe-Experts Module

**Complete Frappe Framework and ERPNext development ecosystem with 7 focused expert agents**

Build Frappe/ERPNext solutions faster with specialized agents handling requirements analysis, solution design, implementation planning, development execution, testing, documentation, and debugging.

---

## Quick Start

### Installation

```bash
# Clone the module
cd /path/to/frappe-bench
git clone https://github.com/rahmed-dev/frappe-experts.git .bmad/custom/modules/frappe-experts

# Install to BMAD
bmad install frappe-experts
```

**Zero configuration needed!** All agents have embedded knowledge bases and work out-of-the-box.

### Load Your First Agent

```bash
# Load ERPNext Business Analyst for requirements analysis
/bmad:frappe-experts:agents:erpnext-ba

# Load Frappe Developer for building features
/bmad:frappe-experts:agents:frappe-nexus

# Load Solution Architect for technical design
/bmad:frappe-experts:agents:frappe-sa
```

Each agent has a `*help` command showing all available capabilities.

---

## The 7 Focused Agents

### Tier 1: Foundation (Strategic Planning)

#### 1. ERPNext BA (Business Analyst)
**Icon:** 📊 | **File:** `erpnext-ba.agent.yaml` | **Lines:** 71

Business requirements analyst specializing in ERPNext feature mapping and gap analysis.

**Use When:**
- Analyzing business requirements
- Checking what ERPNext already has
- Identifying Standard vs Custom needs
- Creating Business Requirements Document (BRD)

**Key Commands:**
- `*review-requirements` - Analyze requirements against ERPNext
- `*gap-analysis` - Standard vs Custom feature breakdown
- `*create-brd` - Generate Business Requirements Document

**Knowledge Base:** 7 files
- ERPNext module capabilities (Manufacturing, HR, Stock, Quality)
- Business process patterns
- Industry-specific solutions

---

#### 2. Frappe SA (Solution Architect)
**Icon:** 🏗️ | **File:** `frappe-sa.agent.yaml` | **Lines:** 93

Technical solution architect with 4-tier framework (Standard → Configure → Scripts → Custom).

**Use When:**
- Designing technical solutions
- Creating Technical Specification Document (TSD)
- Choosing the right customization tier
- UX/UI design with Frappe components

**Key Commands:**
- `*create-tsd` - Generate Technical Specification
- `*design-solution` - Architect the solution approach
- `*feasibility-check` - Validate technical feasibility

**Knowledge Base:** 2 files
- Configure-first approach (CRITICAL philosophy)
- 4-tier solution framework

---

#### 3. Phase Master (Implementation Planner)
**Icon:** 📋 | **File:** `phase-master.agent.yaml` | **Lines:** 81

Implementation sequencing specialist handling dependency management and phased delivery.

**Use When:**
- Planning implementation phases
- Sequencing features by dependencies
- Breaking down complex projects
- Solving "what to build first" problems

**Key Commands:**
- `*create-implementation-plan` - Generate phased delivery plan
- `*sequence-features` - Order features by dependencies
- `*validate-plan` - Check for missing dependencies

**Knowledge Base:** Workflow-driven (no static knowledge needed)

---

#### 4. Nexus (Frappe Developer - Execution Specialist)
**Icon:** 🎯 | **File:** `frappe-nexus.agent.yaml` | **Lines:** 139 | **Version:** 2.0.0 (REFOCUSED)

Senior Frappe full-stack developer who EXECUTES specifications with precision.

**Use When:**
- Building features from Technical Specification
- Executing Implementation Plans phase-by-phase
- Scaffolding apps, DocTypes, APIs
- Testing and validating code
- Debugging Frappe issues

**Key Commands:**
- `*build` - Execute Phased Implementation Plan
- `*implement` - Build feature from Technical Specification
- `*scaffold-app` / `*scaffold-doctype` / `*scaffold-api` - Create structures
- `*test` - Run tests and validate
- `*debug` - Systematic debugging workflow
- `*migrate` / `*build-assets` - Frappe operations

**Knowledge Base:** 12 files
- Complete Frappe development guides
- Client scripting patterns
- Server scripting best practices
- Reports and custom pages

**What Changed in v2.0:** See [NEXUS-CHANGELOG.md](./agents/NEXUS-CHANGELOG.md)
- 258 → 139 lines (46% reduction)
- Removed all design commands (moved to Frappe SA)
- Removed requirements analysis (moved to ERPNext BA)
- Focused purely on execution

---

### Tier 2: Pain Relievers (Productivity Boosters)

#### 5. Quick Guide (Documentation Generator)
**Icon:** 📝 | **File:** `quick-guide.agent.yaml` | **Lines:** 81

Anti-fluff documentation generator for action-oriented user guides.

**Use When:**
- Creating end-user documentation
- Need quick, actionable guides (not 50-page manuals)
- Onboarding users to new features

**Key Commands:**
- `*create-user-guide` - Generate focused user documentation
- `*document-feature` - Document specific feature

---

#### 6. Test Gen (QA Scenario Generator)
**Icon:** 🧪 | **File:** `test-gen.agent.yaml` | **Lines:** 82

Comprehensive test scenario generator (happy path + edge cases + security).

**Use When:**
- Generating test scenarios
- Need comprehensive test coverage
- Not good at thinking of edge cases

**Key Commands:**
- `*generate-test-scenarios` - Create complete test matrix
- `*security-tests` - Generate security test cases

---

#### 7. Debug Master (Diagnostics Expert)
**Icon:** 🔧 | **File:** `debug-master.agent.yaml` | **Lines:** 82

Root cause diagnostics specialist for production issues.

**Use When:**
- 3 AM production errors
- Systematic debugging needed
- Need plain language error explanations

**Key Commands:**
- `*diagnose-error` - Root cause analysis workflow
- `*explain-error` - Plain language error explanation

---

## The 7 Workflows

Each workflow is a step-by-step guided process:

1. **create-brd** - Convert meeting notes to Business Requirements Document
2. **review-requirements** - Analyze requirements (Standard vs Custom)
3. **create-tsd** - Generate Technical Specification Document
4. **create-implementation-plan** - Sequence features into phases
5. **create-user-guide** - Generate end-user documentation
6. **generate-test-scenarios** - Create comprehensive test matrix
7. **diagnose-error** - Systematic root cause diagnosis

Workflows are loaded automatically when you use agent commands (e.g., `*create-brd` loads the workflow).

---

## Typical Workflow

### Scenario: Build a new ERPNext customization

**Phase 1: Requirements (ERPNext BA)**
```bash
/bmad:frappe-experts:agents:erpnext-ba
*review-requirements
# Provide: Meeting notes or requirements doc
# Output: BRD with Standard vs Custom breakdown
```

**Phase 2: Solution Design (Frappe SA)**
```bash
/bmad:frappe-experts:agents:frappe-sa
*create-tsd
# Provide: BRD from previous step
# Output: Technical Specification with 4-tier approach
```

**Phase 3: Implementation Planning (Phase Master)**
```bash
/bmad:frappe-experts:agents:phase-master
*create-implementation-plan
# Provide: TSD from previous step
# Output: Phased delivery plan with dependencies
```

**Phase 4: Development (Nexus)**
```bash
/bmad:frappe-experts:agents:frappe-nexus
*build
# Provide: Implementation Plan from previous step
# Output: Working, tested, production-ready code
```

**Phase 5: Documentation (Quick Guide)**
```bash
/bmad:frappe-experts:agents:quick-guide
*create-user-guide
# Provide: Implemented feature
# Output: Action-oriented user guide
```

**Phase 6: Testing (Test Gen)**
```bash
/bmad:frappe-experts:agents:test-gen
*generate-test-scenarios
# Provide: Feature details
# Output: Comprehensive test matrix
```

**Phase 7: Debugging (Debug Master)** *(if needed)*
```bash
/bmad:frappe-experts:agents:debug-master
*diagnose-error
# Provide: Error logs or issue description
# Output: Root cause + plain language explanation
```

---

## Knowledge Base Distribution

**Total:** 21 knowledge files distributed across agents

### ERPNext BA (7 files)
```
agents/erpnext-ba-sidecar/knowledge/
├── README.md
├── erpnext-ba-guide.md (11KB - ERPNext module capabilities)
├── business-processes/
│   └── common-patterns.md
└── erpnext-modules/
    ├── manufacturing.md
    ├── hr-payroll.md
    ├── stock-inventory.md
    └── quality-module.md
```

### Frappe SA (2 files)
```
agents/frappe-sa-sidecar/knowledge/
├── README.md
└── frappe-framework/
    └── configure-first-approach.md (CRITICAL philosophy)
```

### Nexus (12 files)
```
agents/frappe-nexus-sidecar/knowledge/
├── README.md
├── Frappe-dev-critical.md
├── frappe-guides-README.md
├── UPDATES-2025-11-09.md
├── client-scripting/ (2 files)
├── server-scripting/ (2 files)
├── reports/ (2 files)
└── custom-pages/ (2 files)
```

**Zero external dependencies!** All knowledge embedded in agent sidecars.

---

## Module Structure

```
frappe-experts/
├── README.md                              # This file
├── REFOCUS-SUMMARY.md                     # Refocus documentation
├── DEPLOYMENT.md                          # Deployment guide
├── PORTABILITY.md                         # Portability guide
├── MIGRATION-QUICK-START.md               # Migration instructions
├── WHAT-GETS-TRACKED.md                   # Git tracking reference
├── config.yaml                            # Module configuration
├── agents/
│   ├── erpnext-ba.agent.yaml              # ERPNext Business Analyst
│   ├── erpnext-ba-sidecar/                # (instructions, memories, knowledge)
│   ├── frappe-sa.agent.yaml               # Solution Architect
│   ├── frappe-sa-sidecar/
│   ├── phase-master.agent.yaml            # Implementation Planner
│   ├── phase-master-sidecar/
│   ├── frappe-nexus.agent.yaml            # Frappe Developer (v2.0 - REFOCUSED)
│   ├── frappe-nexus-sidecar/
│   ├── quick-guide.agent.yaml             # Documentation Generator
│   ├── quick-guide-sidecar/
│   ├── test-gen.agent.yaml                # QA Scenario Generator
│   ├── test-gen-sidecar/
│   ├── debug-master.agent.yaml            # Diagnostics Expert
│   ├── debug-master-sidecar/
│   ├── NEXUS-CHANGELOG.md                 # Nexus v1.0 → v2.0 changes
│   └── _archive/                          # Archived agents
│       ├── README.md                      # Archive documentation
│       └── erpnext-oracle.agent.yaml      # Deprecated Oracle agent
├── workflows/
│   ├── create-brd/                        # BRD workflow
│   ├── review-requirements/               # Requirements analysis
│   ├── create-tsd/                        # Technical Specification
│   ├── create-implementation-plan/        # Implementation sequencing
│   ├── create-user-guide/                 # User documentation
│   ├── generate-test-scenarios/           # Test scenario generation
│   └── diagnose-error/                    # Error diagnostics
└── data/                                  # Module data storage (gitignored)
```

**Total:** 130 tracked files, 629 lines of agent code (35% reduction from pre-refocus)

---

## Documentation

### Core Documentation
- **[README.md](./README.md)** - This file (main entry point)
- **[REFOCUS-SUMMARY.md](./REFOCUS-SUMMARY.md)** - Complete refactoring documentation
- **[NEXUS-CHANGELOG.md](./agents/NEXUS-CHANGELOG.md)** - Nexus v1.0 → v2.0 migration guide

### Deployment & Migration
- **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Complete deployment strategies
- **[PORTABILITY.md](./PORTABILITY.md)** - Portability verification
- **[MIGRATION-QUICK-START.md](./MIGRATION-QUICK-START.md)** - Quick migration guide
- **[WHAT-GETS-TRACKED.md](./WHAT-GETS-TRACKED.md)** - Git tracking reference

### Archive
- **[agents/_archive/README.md](./agents/_archive/README.md)** - Why Oracle was archived and migration map

---

## Agent Evolution

### What Changed (2025-11-12 Refocus)

**Before:**
- 8 agents (bloated Nexus + obsolete Oracle)
- 971 lines of agent code
- Mixed responsibilities (Oracle: business + technical)
- Mental mode switching overhead

**After:**
- 7 focused agents
- 629 lines of agent code (35% reduction)
- Single responsibility per agent
- Clear boundaries (business vs technical vs sequencing vs execution)

**Key Changes:**
1. **Nexus refocused** - Strategic → Execution Specialist (258 → 139 lines)
2. **Oracle deprecated** - Split into ERPNext BA + Frappe SA + Phase Master
3. **Knowledge migrated** - Distributed to appropriate agents
4. **Archive created** - Preserved Oracle for reference

See [REFOCUS-SUMMARY.md](./REFOCUS-SUMMARY.md) for complete details.

---

## Configuration

Module configuration in `config.yaml`:

```yaml
module_name: frappe-experts
module_version: '1.0.0'
module_data_path: '{project-root}/.bmad/custom/modules/frappe-experts/data'
user_name: '{config}:user_name'
communication_language: '{config}:communication_language'
```

**Dynamic tokens:**
- `{project-root}` - Auto-resolves to frappe-bench root
- `{config}:user_name` - Inherits from core config
- `{config}:communication_language` - Inherits from core config

**Zero configuration needed!** All paths are dynamic and portable.

---

## Portability

**100% Portable** - Works on any machine with zero dependencies.

**What's tracked in git:**
- All 7 agent YAML source files
- All agent sidecars (instructions, memories, knowledge)
- All workflows (YAML + instructions.md)
- All documentation
- Archive (deprecated agents for reference)

**What's excluded:**
- Compiled .md files (regenerated by `bmad install`)
- Runtime session data
- Project-specific data folder

See [PORTABILITY.md](./PORTABILITY.md) for verification details.

---

## Advanced Usage

### Create Custom Agents

Use BMAD Builder workflows to extend this module:

```bash
/bmad:bmb:workflows:create-agent
# Follow prompts to add new agent to frappe-experts
```

### Create Custom Workflows

```bash
/bmad:bmb:workflows:create-workflow
# Add new workflows to existing agents
```

### Update Knowledge Bases

Knowledge bases are handwritten markdown files in each agent's sidecar:

```bash
# Edit ERPNext BA knowledge
vim agents/erpnext-ba-sidecar/knowledge/erpnext-modules/manufacturing.md

# Edit Frappe SA knowledge
vim agents/frappe-sa-sidecar/knowledge/frappe-framework/configure-first-approach.md

# Edit Nexus knowledge
vim agents/frappe-nexus-sidecar/knowledge/Frappe-dev-critical.md
```

After editing, commit changes:

```bash
git add agents/*/knowledge/
git commit -m "Update knowledge bases"
git push
```

---

## Troubleshooting

### Agent not loading?

```bash
# Reinstall the module
bmad install frappe-experts

# Verify agents compiled
ls -la .bmad/custom/modules/frappe-experts/agents/*.md
```

### Knowledge base not found?

```bash
# Check knowledge files exist
ls -la agents/*/knowledge/

# Verify paths in agent YAML
grep -r "knowledge/" agents/*.agent.yaml
```

### Workflow not working?

```bash
# Check workflow exists
ls -la workflows/*/workflow.yaml

# Verify workflow referenced in agent menu
grep -A 5 "workflows:" agents/*.agent.yaml
```

---

## Contributing

To contribute to this module:

1. **Fork the repository**
   ```bash
   git clone https://github.com/rahmed-dev/frappe-experts.git
   ```

2. **Make changes**
   - Edit agent YAML files (not compiled .md files)
   - Update knowledge bases in sidecars
   - Add workflows if needed

3. **Test thoroughly**
   ```bash
   bmad install frappe-experts
   # Test all agents and workflows
   ```

4. **Submit pull request**
   - Describe changes clearly
   - Reference any issues fixed
   - Include examples if adding features

---

## Technical Details

**BMAD Version:** 6.0.0-alpha.8+
**Module Type:** Custom Expert Module
**Agent Count:** 7 (all Expert-type with sidecars)
**Workflow Count:** 7
**Knowledge Files:** 21 (distributed across agents)
**Total Lines:** 629 (agent code only)
**Dependencies:** ZERO
**Portability:** 100%

**Tested With:**
- Frappe Framework v15+
- ERPNext v15+
- BMAD v6.0.0-alpha.8+

---

## Changelog

### v1.0.0 (2025-11-12) - Major Refocus
- Refocused Nexus to execution-only specialist (v2.0.0)
- Deprecated Oracle, split into ERPNext BA + Frappe SA + Phase Master
- Migrated knowledge bases appropriately
- Created archive for deprecated agents
- 35% reduction in agent code (971 → 629 lines)
- Added comprehensive documentation

### v0.1.0 (2024-XX-XX) - Initial Release
- Original Nexus (strategic developer)
- Original Oracle (business analyst + solution architect)
- 4 workflows (design-system, debug, develop-story, validate-code)

---

## License

MIT License - See repository for full license text.

---

## Author

**Created by:** Rizwan Ahmed
**Date:** 2025-11-12
**Repository:** https://github.com/rahmed-dev/frappe-experts
**Contact:** [Your contact info]

---

## Support

- **Issues:** https://github.com/rahmed-dev/frappe-experts/issues
- **Documentation:** See this README and linked guides
- **BMAD Help:** `/help` in Claude Code
- **Community:** [Link to community if available]

---

**Ready to revolutionize your Frappe/ERPNext development workflow!**

Install now: `bmad install frappe-experts`
