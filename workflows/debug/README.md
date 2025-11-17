---
last-redoc-date: 2025-11-17
---

# Debug Workflow

Systematic Frappe debugging workflow with logs analysis, common issue patterns, and debugging tools.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Process](#process)
4. [Key Tools](#key-tools)

## Purpose

Guide systematic debugging of Frappe/ERPNext issues through structured investigation.

## Usage

**Non-standalone** - Invoke via agent:
```
/bmad:frappe-experts:agents:debug-master → *debug
```

## Process

| Step | Action |
|------|--------|
| 1. Gather Info | Error message, expected outcome, reproducibility |
| 2. Check Logs | error.log, web.log, Python tracebacks, JS console |
| 3. Common Issues | Migration, cache, permissions, type conversion |
| 4. Debug Tools | Console, execute, mariadb, frappe.log_error() |
| 5. Systematic | Isolate layer (DB/Python/JS/UI), test incrementally |

## Key Tools

**Commands**:
- `tail -f sites/[site]/logs/error.log` - Monitor errors
- `bench --site [site] console` - Python REPL
- `bench --site [site] execute "path.to.function"` - Run function
- `bench --site [site] migrate` - Apply migrations
- `bench build --app [app] && bench --site [site] clear-cache` - Rebuild JS
- `bench --site [site] mariadb` - Database shell
- `frappe.log_error(title="Debug", message=data)` - Debug logging

**Common Patterns**:
- Not migrated → migrate
- JS stale → build + clear-cache
- Cache issues → clear-cache + restart
- Permission errors → Check frappe.has_permission()
- Type errors → int/flt conversion from forms
