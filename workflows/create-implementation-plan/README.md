---
last-redoc-date: 2025-11-17
---

# Create Implementation Plan Workflow

Transforms Technical Specification into phased, dependency-sequenced implementation plan separating UI configuration from code development.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)
5. [Key Features](#key-features)

## Purpose

Generate dependency-aware implementation plan with clear separation between UI-based configuration (manual setup) and code-based implementation (Nexus execution).

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:phase-master → *create-implementation-plan
```

## Inputs

| Input | Description |
|-------|-------------|
| Technical Specification | Complete TSD document (file path) |
| Project name | Project identifier |
| TSD version | Version number (e.g., 1.0) |

## Output

**File**: `{module_data_path}/implementation/{project}-implementation-plan-{date}.md`

**Sections**:
1. Executive Summary - Phased approach, architecture decisions, timeline
2. Phase 1/2/3 Structure:
   - **UI-Based Configuration**: Custom DocTypes, Customizations, Workflows, Reports
   - **Code-Based Implementation**: Server logic, Client logic, APIs, Background jobs
   - Acceptance Criteria
3. Sprint Breakdown - 1-2 week sprint organization
4. Testing Strategy - UI testing, Code testing, UAT
5. Rollout Strategy - Deployment, training, data migration
6. Risk Mitigation - Technical/dependency/adoption risks
7. Success Metrics - Per-phase measurement criteria
8. Next Steps - Hand-off to Nexus

## Key Features

- **Two-Layer Separation**: UI configuration vs. Code implementation clearly distinguished
- **Dependency Sequencing**: UI-first when code depends on configured DocTypes/fields
- **Critical Path Analysis**: Longest dependency chain identification
- **Quick Wins Identification**: High-value, low-dependency features surfaced
- **DocType Specifications**: Field-level detail (type, properties, permissions, naming)
- **Sprint-Ready**: 1-2 week sprint organization with goals
- **Frappe-Specific**: Hooks, Controllers, Client Scripts, Background Jobs explicitly called out
