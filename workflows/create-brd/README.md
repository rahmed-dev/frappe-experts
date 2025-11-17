---
last-redoc-date: 2025-11-17
---

# Create BRD Workflow

Converts messy client meeting notes into structured Business Requirements Document mapped against ERPNext capabilities.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)
5. [Key Features](#key-features)

## Purpose

Transform unstructured requirements into ERPNext-aware BRD with gap analysis (Standard/Configure/Custom).

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:erpnext-ba → *create-brd
```

## Inputs

| Input | Description |
|-------|-------------|
| Source material | Meeting notes, existing docs, or verbal description |
| Project name | Project identifier |
| Client name | Client organization |
| Industry | Business domain |
| Current system | Existing solution (Manual/Excel/Legacy) |

## Output

**File**: `{module_data_path}/requirements/{project}-requirements-{date}.md`

**Sections**:
1. Executive Summary - Purpose, current state, outcome
2. Business Context - Industry, pain points, goals
3. Requirements Analysis - Categorized by business area + ERPNext status
4. Module Coverage - ERPNext modules used + standard features
5. Gaps Summary - Standard/Config/Custom breakdown

## Key Features

- **ERPNext Classification**: ✅ Standard / ⚙️ Configure / 🔨 Custom per requirement
- **Token-Efficient**: Tables over prose, numbered sections, zero fluff
- **Module Mapping**: Identifies ERPNext modules + DocTypes per requirement
- **Gap Quantification**: Counts standard vs. config vs. custom needs
- **Handoff-Ready**: Structured for Technical Specification workflow
