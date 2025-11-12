# Frappe Expertise Suite

Complete Frappe Framework and ERPNext solution development toolkit featuring expert agents for strategic development, business analysis, and solution architecture. Includes comprehensive workflows for system design, debugging, story-driven development, and code validation.

## Overview

This module provides a complete development ecosystem for Frappe Framework and ERPNext projects:

**Expert Agents:**
- **Nexus 🎯** - Strategic Frappe Developer & Framework Architect
- **Oracle 🔮** - ERPNext Business Analyst & Solution Architect

**Advanced Workflows:**
- **design-system** - Systematic solution architecture
- **debug** - Frappe debugging workflow
- **develop-story** - Story-driven development
- **validate-code** - Code quality validation

## Installation

```bash
bmad install frappe-experts
```

**No configuration needed!** The module is completely self-contained with embedded frappe-guides knowledge base.

## Components

### Agents (2 Expert-Type Agents)

#### 1. Nexus 🎯 - Strategic Frappe Developer

**Role:** Senior Frappe Framework Architect & Full-Stack Developer

**Capabilities:**
- System architecture and design
- Full-stack Frappe development (Python, JavaScript/VueJS, MariaDB)
- API design and scaffolding
- Story-driven development execution
- Systematic debugging
- Code validation against best practices
- Framework-native solutions
- **EMBEDDED frappe-guides knowledge base** - Complete Frappe patterns and best practices built-in!

**Command Examples:**
- `*design-system` - Architect Frappe solution from requirements
- `*develop-story` - Execute story tasks with tests
- `*debug` - Systematic debugging workflow
- `*validate-code` - Check against anti-patterns
- `*create-api` - Scaffold whitelisted API method
- `*teach` - Deep-dive Frappe concepts explanation

**Philosophy:** Server-side first, framework-native solutions, strategic thinking before coding

#### 2. Oracle 🔮 - ERPNext Business Analyst

**Role:** ERPNext Business Analyst & Solution Architect

**Capabilities:**
- Requirements analysis (ERPNext feature mapping)
- Solution design (configure-first approach with 4-tier framework)
- Gap analysis (Standard vs Custom)
- Technical feasibility validation
- User story generation
- ROI analysis and prioritization
- Migration strategy planning
- **EMBEDDED ERPNext + Frappe knowledge base** - Complete functional/business documentation built-in!
  - Manufacturing, HR, Stock, Quality modules
  - Configure-First Approach (4-tier framework)
  - Business process patterns (MTO, MTS, and more)
  - Industry-specific solutions

**Command Examples:**
- `*review-requirements` - Analyze what ERPNext has vs needs building
- `*gap-analysis` - Compare requirements vs ERPNext capabilities
- `*design-solution` - Create configuration + customization approach
- `*feasibility-check` - Validate technical feasibility
- `*create-user-stories` - Generate implementable stories
- `*module-check` - Identify which ERPNext module handles a process

**Philosophy:** Check ERPNext first, configure before customize, upgrade-safe solutions, configurable not hard-coded

### Workflows (4)

#### 1. design-system
**Type:** Interactive
**Purpose:** Architect Frappe solutions systematically

**Stages:**
1. Requirements Analysis
2. Data Model Design
3. API Architecture
4. Integration Points
5. Implementation Strategy

**Usage:**
```
Load Nexus agent, then: *design-system
```

#### 2. debug
**Type:** Interactive
**Purpose:** Systematic Frappe debugging

**Process:**
1. Gather Information
2. Check Logs (error.log, web.log)
3. Common Frappe Issues
4. Debugging Tools (console, execute, mariadb)
5. Systematic Approach

**Usage:**
```
Load Nexus agent, then: *debug
```

#### 3. develop-story
**Type:** Action
**Purpose:** Story-driven development execution

**Features:**
- Task-by-task implementation
- Frappe best practices enforcement
- Test-driven approach
- Story file updates (authorized sections)
- Blocking condition handling
- Ready for Review criteria

**Usage:**
```
Load Nexus agent, then: *develop-story
Provide story file path
```

#### 4. validate-code
**Type:** Action
**Purpose:** Code quality validation

**Checks:**
- Anti-patterns detection (custom UI, client-side logic, missing decorators)
- Best practices verification (server-side first, permissions, error handling)
- Line-by-line feedback

**Usage:**
```
Load Nexus agent, then: *validate-code
Provide code file path
```

## Quick Start

### 1. Load Nexus (Strategic Developer)

```
/bmad:frappe-experts:agents:nexus
```

**View commands:**
```
*help
```

**Common workflows:**
```
*design-system    # Architecture & design
*develop-story    # Implement story tasks
*debug            # Debug issues
*validate-code    # Code review
*create-api       # Scaffold API method
```

### 2. Load Oracle (Business Analyst)

```
/bmad:frappe-experts:agents:oracle
```

**View commands:**
```
*help
```

**Common workflows:**
```
*review-requirements  # Analyze requirements
*gap-analysis        # ERPNext capability check
*design-solution     # Solution architecture
*create-user-stories # Generate stories
*feasibility-check   # Technical validation
```

## Module Structure

```
frappe-experts/
├── agents/
│   ├── frappe-nexus.md                    # Nexus agent definition
│   ├── frappe-nexus-sidecar/
│   │   ├── instructions.md                # Private directives
│   │   ├── memories.md                    # Memory bank
│   │   └── knowledge/                     # EMBEDDED frappe-guides knowledge base
│   │       ├── Frappe-dev-critical.md     # Core patterns & anti-patterns
│   │       ├── client-scripting/          # Client-side best practices
│   │       ├── server-scripting/          # Server-side best practices
│   │       ├── custom-pages/              # Custom page guidelines
│   │       ├── reports/                   # Report patterns
│   │       ├── frappe-guides-README.md    # Knowledge base overview
│   │       └── UPDATES-2025-11-09.md      # Latest updates
│   ├── erpnext-oracle.md                  # Oracle agent definition
│   └── erpnext-oracle-sidecar/
│       ├── instructions.md                # Private directives
│       ├── memories.md                    # Memory bank
│       └── knowledge/                     # Knowledge base
├── workflows/
│   ├── design-system/
│   │   └── workflow.yaml
│   ├── debug/
│   │   └── workflow.yaml
│   ├── develop-story/
│   │   └── workflow.yaml
│   └── validate-code/
│       └── workflow.yaml
├── data/                                  # Module data storage
├── _module-installer/
│   └── install-config.yaml                # Installation config
└── README.md                              # This file
```

## Configuration

The module can be configured in `.bmad/frappe-experts/config.yaml`

**Key settings:**
- `module_data_path` - Module data storage location
- `workflows_enabled` - Enable/disable workflows

**Inherited from core:**
- `user_name` - Your name (used in greetings)
- `communication_language` - Agent communication language
- `output_folder` - Where workflows save outputs

**Note:** No external knowledge base configuration needed - Both Nexus and Oracle have everything embedded!

## Examples

### Example 1: Design a New Frappe Feature

```
1. Load Nexus: /bmad:frappe-experts:agents:nexus
2. Run: *design-system
3. Provide business requirements
4. Review architecture design
5. Get implementation plan
```

### Example 2: Analyze ERPNext Requirements

```
1. Load Oracle: /bmad:frappe-experts:agents:oracle
2. Run: *review-requirements
3. Provide requirements document
4. Get categorized analysis (Standard/Configurable/Custom)
5. Review integration points
```

### Example 3: Implement Story Tasks

```
1. Load Nexus: /bmad:frappe-experts:agents:nexus
2. Run: *develop-story
3. Provide story file path
4. Nexus implements tasks, writes tests, validates
5. Story marked "Ready for Review"
```

### Example 4: Validate Code Quality

```
1. Load Nexus: /bmad:frappe-experts:agents:nexus
2. Run: *validate-code
3. Provide code file path
4. Get anti-pattern detection and best practice feedback
```

## Knowledge Base Integration

### Nexus - Embedded Frappe Development Knowledge

**Nexus has the complete frappe-guides knowledge base EMBEDDED**:
- **Frappe-dev-critical.md** - Core patterns and anti-patterns
- **client-scripting/** - Client-side best practices and examples
- **server-scripting/** - Server-side best practices and patterns
- **custom-pages/** - Custom page development guidelines
- **reports/** - Report creation patterns
- **frappe-guides-README.md** - Overview of all patterns
- **UPDATES-2025-11-09.md** - Latest updates and changes

### Oracle - Embedded ERPNext Business Knowledge

**Oracle has complete frappe-guides PLUS extensive functional/business documentation EMBEDDED**:

**Frappe Technical Guides:**
- Complete frappe-guides (same as Nexus)
- erpnext-ba-guide.md - ERPNext modules and features

**ERPNext Module Documentation:**
- **manufacturing.md** - BOM, Work Order, Job Card, Production Planning, Subcontracting
- **hr-payroll.md** - Employee management, Attendance, Shifts, Leave, Payroll
- **stock-inventory.md** - Warehouse, Batch/Serial tracking, Stock transactions
- **quality-module.md** - Quality Inspection, Goals, Procedures

**Frappe Framework Functional Guides:**
- **configure-first-approach.md** - 4-Tier Solution Framework (CRITICAL for Oracle)
  - Tier 1: ERPNext Built-in Features
  - Tier 2: Configuration (Custom Fields, Workflows)
  - Tier 3: Light Customization (Scripts, Reports)
  - Tier 4: Custom App (Last resort)
  - ROI decision matrix

**Business Process Patterns:**
- **common-patterns.md** - Industry patterns and flows
  - Manufacturing (MTO, MTS, Subcontracting)
  - Procurement, Sales & Distribution
  - Project Management, HR & Payroll
  - Quality Management, Stock Management
  - Configuration vs Customization decision tree
  - Industry-specific patterns (Pharma, Electronics, etc.)

**ZERO external dependencies!** Both agents have everything embedded.

## Development Roadmap

### Phase 1: Core Components ✅
- [x] Nexus agent with sidecar system
- [x] Oracle agent with sidecar system
- [x] design-system workflow
- [x] debug workflow
- [x] develop-story workflow
- [x] validate-code workflow

### Phase 2: Enhanced Features
- [ ] Add create-doctype workflow for Nexus
- [ ] Add create-report workflow for Nexus
- [ ] Add integration design workflows
- [ ] Add migration planning workflows for Oracle
- [ ] Enhanced memory systems for both agents

### Phase 3: Polish and Integration
- [ ] Shared templates library
- [ ] Cross-agent collaboration workflows
- [ ] Performance optimization guides
- [ ] Extended ERPNext module coverage

## Quick Commands

**Create new agent:**
```
/bmad:bmb:workflows:create-agent
```

**Create new workflow:**
```
/bmad:bmb:workflows:create-workflow
```

## Contributing

To extend this module:

1. Add new agents using `create-agent` workflow
2. Add new workflows using `create-workflow` workflow
3. Update agent menus to reference new workflows
4. Test thoroughly with Frappe/ERPNext projects
5. Submit improvements via pull request

## Technical Notes

- **Agent Types:** Both agents are Expert-type with sidecar systems
- **Workflow Types:** Mix of Interactive (design-system, debug) and Action (develop-story, validate-code) workflows
- **Dependencies:** NONE - Both agents have comprehensive embedded knowledge
- **Platform:** Works with any Frappe Framework or ERPNext project
- **Knowledge Base Size:**
  - Nexus: 12 files (complete frappe-guides)
  - Oracle: 20+ files (frappe-guides + ERPNext modules + business patterns)

## Author

Created by Rizwan Ahmed on 2025-11-10

**Migrated from legacy agents:** frappe-nexus and erpnext-oracle
**BMAD Version:** 6.0.0-alpha.8
**Module Type:** Standard Module (2 Expert Agents, 4 Workflows)

---

**⚡ Ready to revolutionize your Frappe development workflow! ⚡**
