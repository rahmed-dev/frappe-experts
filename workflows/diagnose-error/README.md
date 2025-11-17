---
last-redoc-date: 2025-11-17
---

# Diagnose Error Workflow

Root cause analysis and diagnosis for ERPNext/Frappe errors with plain language explanations.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)

## Purpose

Perform systematic error diagnosis with root cause identification and remediation recommendations.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:debug-master → *diagnose-error
```

## Inputs

| Input | Description |
|-------|-------------|
| Error details | Error message, stacktrace, context |
| Error ID | Unique identifier for tracking |

## Output

**File**: `{module_data_path}/diagnostics/{error_id}-diagnosis-{date}.md`

**Content** (inferred):
- Error summary
- Root cause analysis
- Impact assessment
- Remediation steps
- Prevention recommendations
