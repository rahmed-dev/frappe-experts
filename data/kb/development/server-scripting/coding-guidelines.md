# Server-Side Python Guidelines

> **📚 Read first (skip if already loaded):** `../standards/coding-principles.md`, `../standards/testing-standards.md`, `../standards/code-output-format.md`
> **Relationship:** Standards = WHY | This file = HOW (Frappe Python specifics)

## Naming
- Variables/functions: `snake_case`
- Constants: `UPPER_SNAKE_CASE`
- Private helpers: `_leading_underscore`
- Classes: `PascalCase`
- Use exact DocType names: `frappe.get_doc("Task", name)` not "task"

## Style
- Follow PEP 8 with line length 100 chars
- Use 4-space indentation
- Import order: standard library → third-party → frappe → local

## Comments
- Add docstring at start of each function explaining purpose
- Use Google-style docstrings with Args, Returns, Raises
- Explain WHY in comments, not WHAT

## Function Structure
```python
@frappe.whitelist()
def api_method(param1, param2):
    """Brief description of what this does

    Args:
        param1 (str): Description
        param2 (int): Description

    Returns:
        dict: {"success": bool, "message": str}
    """
    # Implementation
    pass
```

## Data Access
- Create: `doc = frappe.get_doc({...}); doc.insert()`
- Read: `frappe.get_doc("DocType", name)` or `frappe.get_all("DocType", filters={...}, fields=[...])`
- Update: `doc = frappe.get_doc(...); doc.field = value; doc.save()`
- Delete: `frappe.delete_doc("DocType", name)`
- Get single value: `frappe.db.get_value("DocType", name, "field")`
- Use `frappe.db.sql()` with parameterized queries for complex reads

## SQL Queries
- Always use parameterized queries: `frappe.db.sql("SELECT * FROM `tabTask` WHERE name = %(name)s", {"name": name})`
- Never use f-strings or string concatenation (SQL injection risk)
- Use `as_dict=True` for dict results

## Error Handling
- Use specific exceptions: `frappe.ValidationError`, `frappe.PermissionError`, `frappe.DoesNotExistError`
- Use `frappe.throw()` for user-facing errors
- Use `frappe.log_error()` for background logging
- Handle specific exceptions, not bare `except:`

## Permissions
- Always check document-level permissions: `frappe.has_permission("DocType", "write", doc)`
- Check before any write operation
- Return permission errors with `frappe.throw(..., frappe.PermissionError)`

## Performance
- Avoid N+1 queries: fetch related data upfront or use SQL joins
- Process in batches for bulk operations (batch size: 100)
- Use `frappe.cache()` for expensive lookups
- Fetch only needed fields

## Testing
- Separate validation, logic, and side effects into different functions
- Use private helpers that can be tested independently
