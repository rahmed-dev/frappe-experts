---
last-redoc-date: 2025-11-17
---

# Frappe Experts Workflows

Complete workflow collection covering Frappe/ERPNext SDLC from requirements gathering to production deployment.

## Table of Contents

1. [Workflows by Phase](#workflows-by-phase)
2. [Workflow Characteristics](#workflow-characteristics)

## Workflows by Phase

### Requirements Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **create-brd** | Messy notes → BRD with ERPNext mapping | Meeting notes, client inputs | Business Requirements Document | ERPNext BA |
| **review-requirements** | Existing docs → ERPNext categorization | Any requirements format | Interactive analysis | ERPNext BA |

### Design Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **create-tsd** | BRD → Technical Spec (4-tier + UX) | BRD document | Technical Specification Document | Frappe SA |
| **design-system** | Requirements → System architecture | Requirements | Architecture design | Frappe SA |

### Planning Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **create-implementation-plan** | TSD → Phased plan (UI vs code) | TSD document | Implementation Plan (phases + sprints) | Phase Master |

### Development Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **develop-story** | Execute user story with tests | Story + acceptance criteria | Implemented + tested code | Frappe Nexus |
| **validate-code** | Code → Best practices validation | Code files | Validation report with fixes | Frappe Nexus |

### Quality Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **generate-test-scenarios** | Feature → Comprehensive test coverage | Feature spec | Test scenarios document | Test Gen |

### Support Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **debug** | Systematic debugging process | Error context | Debug findings | Debug Master |
| **diagnose-error** | Error → Root cause analysis | Error details | Diagnostic report | Debug Master |

### Documentation Phase

| Workflow | Purpose | Input | Output | Agent |
|----------|---------|-------|--------|-------|
| **create-user-guide** | Feature → Anti-fluff user docs | Feature/TSD | Quick reference guide | Quick Guide |

## Workflow Characteristics

**All workflows are non-standalone** - Invoked via agent menus, not directly

**Token-Efficient Design**:
- Tables over prose throughout
- Numbered sections for navigation
- Zero fluff policy
- Template-based output

**Frappe-Specific Patterns**:
- **4-Tier Framework**: Standard / Configure / Scripts / Custom App
- **ERPNext Mapping**: Requirements mapped to standard features
- **UI vs Code Separation**: Implementation plans distinguish manual config from code
- **Best Practices Enforcement**: Validation against Frappe conventions

**Output Locations** (via config):
- Requirements: `{module_data_path}/requirements/`
- Technical: `{module_data_path}/technical/`
- Implementation: `{module_data_path}/implementation/`
- Testing: `{module_data_path}/testing/`
- Diagnostics: `{module_data_path}/diagnostics/`
- Guides: `{module_data_path}/guides/`
