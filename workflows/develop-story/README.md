---
last-redoc-date: 2025-11-17
---

# Develop Story Workflow

Story-driven development workflow for Frappe Framework - implement tasks, write tests, validate against acceptance criteria.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Output](#output)

## Purpose

Execute user story implementation following test-driven development and validation.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:frappe-nexus → *develop-story
```

## Output

**File**: Uses template for story execution tracking

**Process** (inferred):
- Load story and acceptance criteria
- Implement tasks/subtasks
- Write tests (unit + integration)
- Validate against acceptance criteria
- Update story status
