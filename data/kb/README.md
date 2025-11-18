---
last-updated: 2025-11-18
---

# Frappe-Experts Knowledge Base

Consolidated knowledge base for Frappe/ERPNext development - organized into Development (technical) and Functional (business) categories.

## Table of Contents

1. [Overview](#overview)
2. [Structure](#structure)
3. [How to Use](#how-to-use)
4. [Quick Navigation](#quick-navigation)

## Overview

**Purpose**: Centralized, non-duplicated knowledge base for all Frappe-Experts agents

**Organization**:
- **Development** - Technical knowledge (code, patterns, framework)
- **Functional** - Business knowledge (ERPNext modules, processes, solutions)

**Size**: 21 consolidated files, 43,243 lines of essential knowledge

## Structure

```
data/kb/                  # Knowledge Base (static - READ by agents)
├── development/          # Technical knowledge for developers
│   ├── standards/        # ⭐ NEW - Core coding & testing standards (MANDATORY for Nexus)
│   ├── frappe-framework/ # Core framework patterns and principles
│   ├── server-scripting/ # Python backend development
│   ├── client-scripting/ # JavaScript frontend development
│   ├── custom-pages/     # Custom UI development
│   ├── reports/          # Report development
│   └── debugging/        # Debug patterns and tools
│
├── functional/           # Business knowledge for analysts
│   ├── erpnext-modules/  # Module-specific guides
│   ├── business-processes/ # Common workflow patterns
│   └── industry-solutions/ # Industry-specific knowledge
│
└── archive/              # Deprecated agent-specific knowledge bases

(Runtime documents from workflows saved to: ~/.bmad/frappe-experts/data/)
```

## How to Use

### For Developers (Frappe Nexus, Debug Master)
**Primary Focus**: `development/`

**⭐ MANDATORY Standards (Load FIRST every session):**
- `data/kb/development/standards/coding-principles.md` - Core coding standards, naming, error handling, security
- `data/kb/development/standards/testing-standards.md` - Test philosophy, deterministic data, assertions
- `data/kb/development/standards/code-output-format.md` - Code delivery standards, completeness, explanations

**Essential Frappe-Specific Files**:
- `data/kb/development/frappe-framework/frappe-dev-critical.md` - Critical patterns, anti-patterns, code templates
- `data/kb/development/server-scripting/` - Python backend guidelines
- `data/kb/development/client-scripting/` - JavaScript frontend guidelines

### For Business Analysts (ERPNext BA)
**Primary Focus**: `functional/`

**Essential Files**:
- `data/kb/functional/erpnext-ba-guide.md` - Complete ERPNext feature catalog
- `data/kb/functional/erpnext-modules/` - Module-specific capabilities
- `data/kb/functional/business-processes/` - Common workflow patterns

### For Solution Architects (Frappe SA)
**Cross-Category**: Both `development/` and `functional/`

**Essential Files**:
- `data/kb/development/frappe-framework/4-tier-framework.md` - Configure-first approach
- `data/kb/functional/erpnext-ba-guide.md` - ERPNext capabilities reference

### For All Agents
**Foundation**: Start with these

| File | Purpose | Lines |
|------|---------|-------|
| ⭐ `development/standards/coding-principles.md` | Core coding standards | 410 |
| ⭐ `development/standards/testing-standards.md` | Testing philosophy & standards | 430 |
| ⭐ `development/standards/code-output-format.md` | Code delivery standards | 348 |
| `development/frappe-framework/frappe-dev-critical.md` | Critical patterns & anti-patterns | 156 |
| `development/frappe-framework/4-tier-framework.md` | Solution design philosophy | 355 |
| `development/frappe-framework/script-report-filters-and-multiselect.md` | Script report filters & MultiSelectList (NEW - 2025-11-18) | 450+ |
| `functional/erpnext-ba-guide.md` | ERPNext features & modules | 262 |

## Quick Navigation

### Development Knowledge

| Category | Files | Topics Covered |
|----------|-------|----------------|
| ⭐ **Standards** | 3 files | Coding principles, testing standards, code output format |
| **Frappe Framework** | 3 files | Tech stack, critical patterns, 4-tier framework, script report filters & MultiSelectList |
| **Server Scripting** | 2 files | Python coding guidelines, best practices, hooks, background jobs |
| **Client Scripting** | 2 files | JavaScript guidelines, form interactions, UI patterns |
| **Custom Pages** | 2 files | Custom UI development, page creation patterns |
| **Reports** | 2 files | Script reports, query reports, data visualization |

**[→ Development README](development/README.md)**

### Functional Knowledge

| Category | Files | Topics Covered |
|----------|-------|----------------|
| **ERPNext Modules** | 4 files | HR/Payroll, Manufacturing, Stock/Inventory, Quality |
| **Business Processes** | 1 file | Common workflow patterns, approval flows |
| **BA Guide** | 1 file | Complete ERPNext feature catalog |
| **Examples** | 1 file | Real-world implementation patterns |

**[→ Functional README](functional/README.md)**

## Maintenance

**Update Strategy**: Knowledge base is manually updated via:
- `/bmad:frappe-experts:workflows:update-knowledge-base` workflow
- Session-end agent prompts ("Did we learn something new?")
- Periodic review (monthly/quarterly)

**Version Control**: Git-tracked - see commit history for evolution

**Archive**: Old agent-specific knowledge bases preserved in `data/archive/`
