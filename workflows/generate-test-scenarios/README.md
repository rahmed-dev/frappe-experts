---
last-redoc-date: 2025-11-17
---

# Generate Test Scenarios Workflow

Generate comprehensive QA test scenarios covering happy path, edge cases, integrations, and permissions.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)

## Purpose

Create complete test scenario coverage for Frappe features ensuring quality assurance.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:test-gen → *generate-test-scenarios
```

## Inputs

| Input | Description |
|-------|-------------|
| Feature name | Feature to test |
| TSD/Spec | Technical specification (optional) |

## Output

**File**: `{module_data_path}/testing/{feature}-test-scenarios-{date}.md`

**Coverage**:
- Happy path scenarios
- Edge cases
- Integration points
- Permission testing
- Data validation
- Error handling
