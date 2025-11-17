---
last-redoc-date: 2025-11-17
---

# Create TSD Workflow

Generates Technical Specification Document from Business Requirements using 4-tier framework with UX-focused design.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)
5. [Key Features](#key-features)

## Purpose

Transform BRD into actionable Technical Specification with tier classification, UX design, and pseudo-code logic (no actual code).

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:frappe-sa → *create-tsd
```

## Inputs

| Input | Description |
|-------|-------------|
| Business Requirements | Complete BRD document (file path) |
| BRD version | Version number |
| Project name | Project identifier |

## Output

**File**: `{module_data_path}/technical/{project}-technical-spec-{date}.md`

**Sections**:
1. Executive Summary - Approach, complexity, tier, upgrade safety
2. Solution Architecture - Tier classification, modules, performance
3. Technical Design (per feature):
   - UX/UI Design (form layout, actions, components)
   - DocType Design (fields table)
   - Business Logic (hooks, scripts, pseudo-code)
   - Workflows (if applicable)
   - API Design (if integrations)
   - Performance (indexing, caching)
   - Migration (if legacy data)
4. Security & Permissions
5. Testing Requirements
6. Deployment Strategy
7. Maintenance & Monitoring

## Key Features

- **4-Tier Framework**: Tier 1 (Standard) / Tier 2 (Config) / Tier 3 (Scripts) / Tier 4 (Custom App)
- **Upgrade Safety Assessment**: ✅ Safe / ⚠️ Monitor / ❌ Risk
- **UX-Focused Design**: Frappe components, form layouts, user actions specified
- **Field-Level DocType Specs**: Type, mandatory, options, defaults, purpose
- **Pseudo-Code Only**: Logic explained, no actual code written
- **Token-Efficient**: Tables over prose, numbered sections
- **Handoff-Ready**: Structured for Implementation Plan workflow
