---
last-redoc-date: 2025-11-17
---

# Review Requirements Workflow

Analyze existing requirements and categorize against ERPNext standard capabilities.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)

## Purpose

Evaluate requirements documents to identify ERPNext coverage (Standard/Configure/Custom).

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:erpnext-ba → *review-requirements
```

## Inputs

| Input | Description |
|-------|-------------|
| Requirements doc | Existing requirements (any format) |

## Output

Interactive analysis with categorization:
- ✅ Standard ERPNext features
- ⚙️ Configuration needed
- 🔨 Custom development required
- Module mapping
- Gap summary
