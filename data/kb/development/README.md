---
last-updated: 2025-11-17
---

# Development Knowledge Base

Technical knowledge for Frappe/ERPNext development - patterns, best practices, coding guidelines.

## Table of Contents

1. [⭐ Core Standards](#core-standards-new) ← **START HERE**
2. [Core Framework](#core-framework)
3. [Server-Side Development](#server-side-development)
4. [Client-Side Development](#client-side-development)
5. [Custom Pages](#custom-pages)
6. [Reports](#reports)
7. [Quick Reference](#quick-reference)

## ⭐ Core Standards (NEW)

**Location**: `standards/` | **Added**: 2025-11-17 | **MANDATORY for Nexus**

| File | Description | Key Topics | Lines |
|------|-------------|------------|-------|
| **coding-principles.md** | Core coding standards for all development | Language (English), idiomatic style, naming, SRP/DRY/KISS, error handling, security, performance, dependencies | 410 |
| **testing-standards.md** | Testing philosophy & best practices | Deterministic test data, static expectations, explicit tests, comprehensive coverage, Frappe test patterns | 430 |
| **code-output-format.md** | Code delivery & documentation standards | Complete usable code, clear explanations, handling ambiguity, placeholders, installation instructions | 348 |

**When to Read**:
- **coding-principles.md** - ⭐ **LOAD AT START OF EVERY CODING SESSION** (mandatory for Nexus)
- **testing-standards.md** - Before writing ANY tests (mandatory standards)
- **code-output-format.md** - Before delivering code to users (quality checklist)

**Why These Are Critical**:
- Ensure consistent code quality across all Frappe development
- Prevent common security vulnerabilities (SQL injection, XSS, hardcoded secrets)
- Maintain deterministic, reliable tests
- Deliver production-ready code (no TODOs, no skeletons)

**Key Principles from Standards**:
- ✅ All code/comments in English
- ✅ Return early pattern (reduce nesting)
- ✅ Explicit error handling with clear messages
- ✅ No hardcoded secrets (use site_config)
- ✅ Parameterized queries (or Frappe ORM)
- ✅ Fixed test data (no random/dynamic values)
- ✅ Complete, functional code (not skeletons)

---

## Core Framework

### Frappe Framework Essentials

| File | Description | Key Topics |
|------|-------------|------------|
| **frappe-dev-critical.md** | Critical patterns & anti-patterns | Tech stack, architecture, critical patterns, common mistakes to avoid, code templates |
| **4-tier-framework.md** | Configure-first solution design | Tier 1: Standard → Tier 2: Config → Tier 3: Scripts → Tier 4: Custom App, ROI decision matrix |

**When to Read**:
- **frappe-dev-critical.md** - Before ANY development work (foundations)
- **4-tier-framework.md** - Before architectural decisions (solution design)

## Server-Side Development

**Location**: `server-scripting/`

| File | Description | Practical Examples |
|------|-------------|-------------------|
| **coding-guidelines.md** | Python code standards | Naming conventions, function structure, imports, type hints |
| **best-practices.md** | Server-side patterns | API methods, hooks, background jobs, bulk operations, error handling |

**Key Patterns Covered**:
- `@frappe.whitelist()` API decoration
- `frappe.get_doc()` / `frappe.get_all()` data access
- Hooks: `validate`, `before_save`, `on_submit`, `on_cancel`
- Background jobs with `ignore_permissions=True`
- Type conversion: `int(val) if val else 0`, `flt(val)`
- Return format: `{"success": bool, "data": any, "message": str}`

## Client-Side Development

**Location**: `client-scripting/`

| File | Description | Practical Examples |
|------|-------------|-------------------|
| **coding-guidelines.md** | JavaScript code standards | Form script structure, naming, event handlers |
| **best-practices.md** | Client-side patterns | `frappe.call()`, dialogs, field manipulation, form events |

**Key Patterns Covered**:
- `frappe.call({method, args, callback})`
- `frappe.ui.Dialog` with native field types
- `frm.set_df_property()` for dynamic field control
- Form events: `refresh`, `before_save`, `onload`
- Field events: `change`, `validate`

## Custom Pages

**Location**: `custom-pages/`

| File | Description |
|------|-------------|
| **coding-guidelines.md** | Page development standards |
| **best-practices.md** | Custom UI patterns |

**Use Cases**:
- Dashboards beyond standard
- Shop floor interfaces
- Kiosk UIs
- External-facing portals

## Reports

**Location**: `reports/`

| File | Description |
|------|-------------|
| **coding-guidelines.md** | Report development standards |
| **best-practices.md** | Query & script report patterns |

**Report Types**:
- **Script Reports** - Python/SQL with complex logic
- **Query Reports** - Simple SQL queries
- **Print Formats** - Document printing

## Quick Reference

### Critical Anti-Patterns to Avoid

| ❌ Don't | ✅ Do |
|----------|-------|
| Custom HTML/CSS fields | Use native Frappe field types (Check, Select, Date) |
| Client-side data filtering | Server-side Python methods |
| Skip `@frappe.whitelist()` | Always decorate API methods |
| String form values in Python | Convert to `int(val)` or `flt(val)` |
| Skip permission checks | Use `frappe.has_permission()` |
| Leave dialogs submit-enabled | Disable button on submit to prevent duplicates |
| `console.log()` in production | Remove or use `frappe.log_error()` |
| Skip `frappe.db.commit()` in loops | Commit after each iteration |
| `$("#id").hide()` | Use `frm.set_df_property("field", "hidden", 1)` |

### Code Templates

**Server API Method**:
```python
@frappe.whitelist()
def method_name(param1, param2=None):
    """Brief description"""
    if not frappe.has_permission("DocType", "write"):
        frappe.throw(_("No permission"), frappe.PermissionError)

    # Logic here
    return {"success": True, "data": result, "message": "Success"}
```

**Client Script**:
```javascript
frappe.ui.form.on('DocType', {
    refresh: function(frm) {
        // Form refresh logic
    },
    field_name: function(frm) {
        // Field change logic
    }
});
```

**Frappe Call**:
```javascript
frappe.call({
    method: 'app.module.method_name',
    args: {param1: value},
    callback: function(r) {
        if (r.message.success) {
            // Handle success
        }
    }
});
```

### Essential Reading Order

**For New Developers**:
1. ⭐ `standards/coding-principles.md` - **START HERE** (core standards)
2. ⭐ `standards/testing-standards.md` - Testing philosophy
3. ⭐ `standards/code-output-format.md` - Delivery standards
4. `frappe-framework/frappe-dev-critical.md` - Frappe foundations
5. `server-scripting/best-practices.md` - Backend patterns
6. `client-scripting/best-practices.md` - Frontend patterns

**For Solution Design**:
1. `frappe-framework/4-tier-framework.md` - Design philosophy
2. Review relevant category (server/client/pages/reports)

**For Code Review**:
1. ⭐ Check against `standards/coding-principles.md` (universal standards)
2. Check against `coding-guidelines.md` in relevant category (Frappe-specific)
3. Verify patterns from `frappe-dev-critical.md` anti-patterns section

**For Every Nexus Coding Session (MANDATORY)**:
1. ⭐ Load `standards/coding-principles.md`
2. ⭐ Load `standards/testing-standards.md`
3. ⭐ Load `standards/code-output-format.md`
4. Then proceed with Frappe-specific knowledge
