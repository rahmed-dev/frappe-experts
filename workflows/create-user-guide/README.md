---
last-redoc-date: 2025-11-17
---

# Create User Guide Workflow

Generates anti-fluff, action-oriented user documentation for ERPNext features.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Inputs](#inputs)
4. [Output](#output)
5. [Key Features](#key-features)

## Purpose

Create practical, user-focused quick guides that get users productive fast with zero fluff.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:quick-guide → *create-user-guide
```

## Inputs

| Input | Description |
|-------|-------------|
| Feature/module | ERPNext feature, custom feature (TSD), workflow, or integration |
| Target user | User role (e.g., Sales Team, Warehouse Staff) |

## Output

**File**: `{module_data_path}/guides/{feature}-quick-guide-{date}.md`

**Structure**:
1. What This Does (1 sentence)
2. Quick Start (Most Common Scenario) - Step-by-step with pro tips
3. Common Tasks - Daily operations table
4. Troubleshooting - Problem → Solution table
5. Advanced Tips (optional)

## Key Features

- **Anti-Fluff**: Zero verbose explanations, pure action
- **Action-Oriented**: Every heading is a verb (Open, Fill, Submit)
- **Show-Don't-Tell**: Exact clicks/types specified
- **Pro Tips**: Practical insights embedded per step
- **Troubleshooting Table**: Problem → Solution format
- **Common Tasks Table**: Task | Steps | Time
- **Token-Efficient**: Tables and numbered lists, no prose
