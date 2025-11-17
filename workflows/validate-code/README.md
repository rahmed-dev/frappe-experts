---
last-redoc-date: 2025-11-17
---

# Validate Code Workflow

Validate Frappe code against best practices and anti-patterns with specific feedback.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Validation Checks](#validation-checks)

## Purpose

Code quality validation against Frappe framework standards and conventions.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:frappe-nexus → *validate-code
```

## Validation Checks

**Anti-Patterns Detected**:
- ❌ Custom HTML/CSS instead of native field types
- ❌ Client-side data filtering (should be Python)
- ❌ Missing @frappe.whitelist() decorator
- ❌ String-to-int/float conversion issues
- ❌ Missing permission checks
- ❌ Disabled submit button omissions (causes duplicates)
- ❌ console.log() in production
- ❌ Missing ignore_permissions in background jobs
- ❌ Missing frappe.db.commit() in scheduler
- ❌ Incorrect date formats
- ❌ jQuery DOM manipulation vs. set_df_property()

**Best Practices Enforced**:
- ✅ Server-side first (data in Python)
- ✅ Frappe standards (frappe.call, frappe.ui.Dialog)
- ✅ Minimal complexity (helper extraction)
- ✅ Permission-first design
- ✅ Native components only
- ✅ Proper error handling (frappe.throw, frappe.log_error)
- ✅ Standard return format: {"success": bool, "data": any, "message": str}

**Output**: Line-by-line feedback with corrections
