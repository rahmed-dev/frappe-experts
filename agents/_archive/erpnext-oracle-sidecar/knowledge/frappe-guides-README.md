# Universal Frappe Development Guidelines

This directory contains universal development guidelines for Frappe Framework applications, independent of any specific project.

## Core Development Principles

### 1. Server-Side First Philosophy

**Always prefer server-side logic over client-side processing.**

- **Data Operations:** Filter, sort, and process data in Python `execute()` methods, not in JavaScript
- **Business Logic:** Implement validation and calculations on the server
- **Security:** Server-side validation cannot be bypassed by users
- **Performance:** Database queries are faster than client-side filtering

```python
# ✅ Good: Server-side filtering
def execute(filters=None):
    task_filters = {}
    if not filters.get("show_completed"):
        task_filters["status"] = ["!=", "Completed"]
    tasks = frappe.get_all("Task", filters=task_filters)
    return columns, data

# ❌ Bad: Client-side filtering
# Don't filter data in JavaScript after receiving it
```

### 2. Use Frappe Standards

**Leverage built-in Frappe features instead of custom implementations.**

- **Filters:** Define in `.json` files, not custom JavaScript UI
- **Permissions:** Use `frappe.has_permission()`, not custom checks
- **UI Components:** Use `frappe.ui.Dialog`, `frappe.msgprint`, etc.
- **API Calls:** Use `frappe.call()` with `@frappe.whitelist()` decorators

```json
// ✅ Good: Define filters in JSON
{
  "filters": [
    {
      "fieldname": "show_completed",
      "fieldtype": "Check",
      "label": "Show Completed",
      "default": "0"
    }
  ]
}

// ❌ Bad: Build custom filter UI in JavaScript
```

### 3. Minimize Code Complexity

**Less code = fewer bugs = easier maintenance.**

- **Reduce Duplication:** Extract helper functions for repeated code
- **Keep It Simple:** Choose straightforward solutions over complex architectures
- **Single Responsibility:** Each function should do one thing well
- **Document as You Go:** Clear comments explain "why," not just "what"

```javascript
// ✅ Good: Extract helper function
function validateSelection() {
    if (selectedTaskIds.size === 0) {
        frappe.msgprint('Please select at least one task.');
        return false;
    }
    return true;
}

// ❌ Bad: Repeat validation code in every function
```

### 4. Proper Configuration Management

**JSON changes require database synchronization in Frappe.**

- **After JSON Edits:** Always run `bench --site [site] reload-doc` or `bench migrate`
- **Report Filters:** Define in JSON, processed automatically by framework
- **DocType Changes:** Use fixtures or migrations for version control
- **Don't Mix:** Keep configuration in JSON/database, not hardcoded

```bash
# After editing .json files:
bench --site [site] reload-doc [app] Report "[Report Name]"

# Or run full migration:
bench --site [site] migrate
```

### 5. Permission-First Design

**Always validate permissions before allowing actions.**

- **Check Per Action:** Validate permissions for each operation
- **Use Framework Methods:** `frappe.has_permission(doctype, ptype, doc)`
- **Fail Gracefully:** Return clear error messages for permission denials
- **Document Requirements:** Specify required permissions in comments

```python
# ✅ Good: Check permissions before action
if not frappe.has_permission("Task", "write", task):
    frappe.throw("Insufficient permissions")

task.status = new_status
task.save()
```

### 6. Error Handling Best Practices

**Provide clear feedback and log errors appropriately.**

- **User-Facing Errors:** Use `frappe.throw()` or `frappe.msgprint()` with clear messages
- **Background Logging:** Use `frappe.log_error()` for debugging
- **Partial Success:** Track and report both successes and failures in bulk operations
- **Graceful Degradation:** Continue processing even if some items fail

```python
# ✅ Good: Track successes and failures
updated = 0
failed = 0
errors = []

for task_id in task_ids:
    try:
        # Process task
        updated += 1
    except Exception as e:
        failed += 1
        errors.append(f"{task_id}: {str(e)}")
        frappe.log_error(f"Error: {str(e)}", "Task Update Error")

return {
    "success": failed == 0,
    "updated": updated,
    "failed": failed,
    "errors": errors
}
```

### 7. Performance Optimization

**Design for scalability from the start.**

- **Batch Processing:** Process large datasets in batches (e.g., 10 items at a time)
- **Efficient Queries:** Use proper filters and field selection in queries
- **Lazy Loading:** Fetch data only when needed
- **Database Indexing:** Leverage ERPNext's indexed fields

```python
# ✅ Good: Batch processing
for i in range(0, len(task_ids), 10):
    batch = task_ids[i:i+10]
    for task_id in batch:
        # Process each task
```

### 8. Documentation Standards

**Code should be self-documenting with clear comments.**

- **File-Level:** Describe module purpose and main components
- **Function-Level:** Explain what, why, and requirements
- **Inline Comments:** Clarify complex logic and business rules
- **Keep Updated:** Update docs when code changes

### 9. CSS Scoping for Custom Pages (CRITICAL)

**NEVER use `app_include_css` for page-specific styles.**

This is one of the most common and dangerous mistakes in Frappe development:

```python
# hooks.py - ❌ CRITICAL MISTAKE - DON'T DO THIS
app_include_css = "/assets/my_app/css/my_page.css"  # Affects ENTIRE ERPNext!
```

**Why this is dangerous:**
- Applies CSS to **every page** in ERPNext
- Breaks standard forms (oversized fields, wrong padding)
- Creates upgrade conflicts
- Can make the entire site unusable

**✅ CORRECT Approach:**

1. **Load CSS on page load:**
```javascript
frappe.pages['my-custom-page'].on_page_load = function(wrapper) {
    frappe.require('/assets/my_app/css/my_page.css');  // Load only when needed
    // ... rest of code
};
```

2. **Scope ALL CSS selectors:**
```css
/* ❌ BAD - affects all pages */
.container { padding: 20px; }

/* ✅ GOOD - only affects my-custom-page */
.page-my-custom-page .container { padding: 20px; }
```

**See [custom-pages/best-practices.md](./custom-pages/best-practices.md) for complete guide.**

---

## Quick Navigation

### Detailed Guides by Topic

- **[Report Development](./reports/)** - Script reports, Query reports, best practices
- **[Server Scripting](./server-scripting/)** - Python development, API endpoints, permissions
- **[Client Scripting](./client-scripting/)** - JavaScript UI, dialogs, formatters
- **[Custom Pages](./custom-pages/)** - **NEW!** Custom Frappe pages, dashboards, CSS scoping

### Common Development Tasks

1. **Creating Script Reports** → See [reports/best-practices.md](./reports/best-practices.md)
2. **Server-Side APIs** → See [server-scripting/best-practices.md](./server-scripting/best-practices.md)
3. **Client-Side Interactions** → See [client-scripting/best-practices.md](./client-scripting/best-practices.md)
4. **Building Custom Pages** → See [custom-pages/best-practices.md](./custom-pages/best-practices.md)

---

## Development Workflow

### Standard Development Cycle

1. **Plan** - Document requirements and approach
2. **Develop** - Implement following Frappe conventions
3. **Test** - Validate with realistic data and edge cases
4. **Review** - Refactor for simplicity and performance
5. **Document** - Update relevant documentation
6. **Deploy** - Migrate and monitor

### Testing Changes

```bash
# After making changes
bench --site [site-name] migrate
bench --site [site-name] clear-cache
bench restart

# Enable developer mode
bench --site [site-name] set-config developer_mode 1
bench --site [site-name] clear-cache
```

### Debugging

```bash
# Watch error logs
tail -f sites/[site-name]/logs/error.log

# Watch web requests
tail -f sites/[site-name]/logs/web.log
```

---

## Key Takeaways

1. **Server-side first** - Data operations belong in Python
2. **Use Frappe standards** - Don't reinvent the wheel
3. **Keep it simple** - Complexity is the enemy
4. **Validate permissions** - Security is not optional
5. **Handle errors gracefully** - Users need clear feedback
6. **Optimize for performance** - Design for scale
7. **Document everything** - Future you will thank you

---

## Resources

### Official Documentation

- [Frappe Framework Docs](https://frappeframework.com/docs)
- [ERPNext Developer Guide](https://frappeframework.com/docs/user/en/tutorial)
- [Frappe API Reference](https://frappeframework.com/docs/user/en/api)

### Community Resources

- [Frappe Forum](https://discuss.frappe.io/)
- [Frappe GitHub](https://github.com/frappe/frappe)
- [ERPNext GitHub](https://github.com/frappe/erpnext)
- [Frappe School](https://frappe.school/)

---

**Remember:** When in doubt, choose the simpler solution that follows Frappe conventions.
