---
title: "Core Coding Principles & Standards"
category: "Development Standards"
applies-to: ["Nexus", "Debug Master"]
source: "Consolidated from AGENTS.md coding guidelines"
last-updated: 2025-11-17
---

# Core Coding Principles & Standards

This document defines the core coding standards for all Frappe development work. These principles ensure consistent, maintainable, secure, and high-quality code across all implementations.

---

## 1. Core Coding Principles

### Language
*   **Language:** All code, comments, variable names, function names, class names, and commit messages must be **strictly in English**.

### Idiomatic Style
*   Write code that adheres to the idiomatic style, conventions, and official style guides of the target language. This includes formatting, naming, and general structure.
*   Assume a linter or formatter will eventually run; aim to produce code that is already close to passing common linting rules.
*   **For Frappe/Python:** Follow PEP 8 style guide
*   **For JavaScript:** Follow Frappe's JavaScript conventions

### Clarity and Readability
*   Prioritize clarity, readability, and maintainability over unnecessary "cleverness" or extreme brevity if it sacrifices understanding.
*   Write self-documenting code.
*   Follow the **Principle of Least Surprise**: code should behave in a way that users and other developers would naturally expect.

### Conciseness
*   Avoid superfluous adjectives, adverbs, or phrases in code, comments, or explanations that do not add essential technical information. Be direct.

### Return Early Pattern
*   Always prefer the "return early" pattern to reduce nesting and improve code flow legibility.
*   **Example:** Instead of:
    ```python
    if condition:
        # long block of code
    else:
        return
    ```
    Use:
    ```python
    if not condition:
        return
    # long block of code
    ```

---

## 2. Naming and Structure

### Naming Conventions
*   Use descriptive, clear, and unambiguous names for variables, functions, classes, constants, and methods. Prefer explicit names over abbreviated ones.
*   Follow standard naming patterns of the target language.
*   Use verbs or verb phrases for functions/methods that perform an action.
*   Use nouns or noun phrases for variables, classes, and constants.

**Python/Frappe Examples:**
```python
# Good
def calculate_total_amount(items):
    pass

def validate_payment_entry(doc):
    pass

# Bad
def calc_amt(i):
    pass

def validate(d):
    pass
```

### Modularity and Responsibility (SRP)
*   Keep functions, methods, and classes small and focused on a **single, well-defined responsibility (Single Responsibility Principle)**.
*   Decompose complex tasks into smaller, cohesive units.
*   Group related functionality logically (e.g., within the same file or module).

### DRY (Don't Repeat Yourself)
*   Avoid code duplication. Re-use code through functions, classes, helper utilities, or modules.
*   **Frappe Context:** Use `frappe.utils` for common operations instead of reimplementing.

### KISS (Keep It Simple, Stupid)
*   Favor simpler solutions over complex ones, as long as they meet requirements.
*   **Frappe Context:** Use framework features (hooks, events) rather than custom workarounds.

---

## 3. Error Handling and Validation

### Explicit Error Handling
*   Implement robust and explicit error handling. Avoid silent failures.
*   Use language-appropriate mechanisms like `try-except` blocks, error return values, or Result types.
*   **Frappe Context:** Use `frappe.throw()` for user-facing errors, raise exceptions for programming errors.

**Frappe Example:**
```python
@frappe.whitelist()
def process_payment(payment_entry):
    try:
        # Validate
        if not payment_entry:
            frappe.throw(_("Payment Entry is required"))

        # Process
        doc = frappe.get_doc("Payment Entry", payment_entry)
        doc.submit()

        return {"success": True, "message": _("Payment processed successfully")}

    except frappe.ValidationError as e:
        frappe.throw(_("Validation failed: {0}").format(str(e)))
    except Exception as e:
        frappe.log_error(message=str(e), title="Payment Processing Error")
        frappe.throw(_("Payment processing failed. Please contact support."))
```

### Fail Fast
*   Validate inputs and preconditions early in a function or method.
*   Return or throw errors at the earliest point of failure rather than deep inside nested blocks.

**Frappe Example:**
```python
def calculate_discount(item_code, qty, customer):
    # Validate early - fail fast
    if not item_code:
        frappe.throw(_("Item Code is required"))

    if not qty or qty <= 0:
        frappe.throw(_("Quantity must be greater than zero"))

    if not customer:
        frappe.throw(_("Customer is required"))

    # Now proceed with business logic
    # ...
```

### Meaningful Errors
*   Provide clear, specific, and useful error messages (in English) that aid in debugging.
*   Use specific error types/classes when appropriate, rather than generic ones.
*   **Frappe Context:** Use appropriate Frappe exceptions:
    - `frappe.ValidationError` for validation failures
    - `frappe.PermissionError` for permission issues
    - `frappe.DoesNotExistError` for missing documents
    - `frappe.DuplicateEntryError` for uniqueness violations

### Logging
*   Log errors with sufficient context for troubleshooting when appropriate for the application type.
*   **Frappe Context:** Use `frappe.log_error()` for production errors with full context.

---

## 4. Comments and Documentation

### Purposeful Comments
*   Write comments to explain the "why" (intent, design decisions, non-obvious logic) rather than the "what" (which the code itself should make clear).
*   Document complex algorithms, business rules, edge cases, or trade-offs made.

**Good vs Bad:**
```python
# Bad - explains "what" (obvious from code)
# Loop through items and calculate total
for item in items:
    total += item.amount

# Good - explains "why" (business context)
# Tax calculation must happen after discount to comply with
# regional tax regulations (as per Finance team requirement)
tax_amount = calculate_tax(amount_after_discount)
```

### API Documentation
*   For public functions, methods, and classes, use docstrings to describe purpose, parameters, return values, and any exceptions thrown.

**Frappe Example:**
```python
def calculate_payment_schedule(doc, payment_terms_template):
    """
    Calculate payment schedule based on payment terms template.

    Args:
        doc (Document): Sales Invoice or Purchase Invoice document
        payment_terms_template (str): Name of Payment Terms Template

    Returns:
        list: List of payment schedule entries with due_date and payment_amount

    Raises:
        frappe.ValidationError: If template not found or invalid
    """
    pass
```

### Conciseness
*   Keep comments concise and to the point.

### Maintenance
*   Keep comments up-to-date with code changes. Remove outdated comments.

### No Dead Code
*   Do not include commented-out code blocks. Use version control for history.

---

## 5. Security Best Practices

### Input Validation and Sanitization
*   Validate and sanitize ALL external inputs (user input, API responses, file contents) to prevent injection attacks (XSS, SQL Injection, etc.) and other vulnerabilities.
*   Check boundaries and expected formats.

**Frappe Example:**
```python
@frappe.whitelist()
def update_item_price(item_code, new_price):
    # Validate inputs
    if not item_code or not isinstance(item_code, str):
        frappe.throw(_("Invalid Item Code"))

    # Sanitize and validate price
    try:
        new_price = float(new_price)
    except (ValueError, TypeError):
        frappe.throw(_("Invalid price format"))

    if new_price < 0:
        frappe.throw(_("Price cannot be negative"))

    # Proceed with update
    # ...
```

### No Hardcoded Secrets
*   **Never** hardcode sensitive information (API keys, passwords, tokens, connection strings).
*   Use environment variables, configuration files, or secret management services.
*   Clearly mark placeholders (e.g., `YOUR_API_KEY_HERE`) and instruct where to replace them.

**Frappe Context:**
```python
# Good - use Site Config or System Settings
api_key = frappe.conf.get("external_api_key")
if not api_key:
    api_key = frappe.db.get_single_value("System Settings", "external_api_key")

# Bad - hardcoded secret
api_key = "sk_live_abc123xyz"  # NEVER DO THIS
```

### Parameterized Queries
*   Always use parameterized queries or prepared statements for database interactions to prevent SQL injection.
*   **Frappe Context:** Frappe ORM handles this automatically. When using raw SQL, always use parameters:

```python
# Good - parameterized
frappe.db.sql("""
    SELECT name, item_name
    FROM `tabItem`
    WHERE item_group = %s
""", (item_group,))

# Bad - string concatenation (SQL injection risk!)
frappe.db.sql(f"SELECT name FROM `tabItem` WHERE item_group = '{item_group}'")
```

### Least Privilege
*   Follow the principle of least privilege for file access, database permissions, and API scopes.
*   **Frappe Context:** Always check permissions before operations:

```python
@frappe.whitelist()
def delete_item(item_code):
    if not frappe.has_permission("Item", "delete"):
        frappe.throw(_("No permission to delete items"), frappe.PermissionError)

    frappe.delete_doc("Item", item_code)
```

### Dependency Management
*   Keep dependencies updated to patch known vulnerabilities.
*   Be mindful of adding new dependencies and their security implications.

### Secure Defaults
*   Favor secure defaults (e.g., HTTPS over HTTP, strong encryption algorithms).
*   Avoid disabling security features (e.g., SSL/TLS certificate validation) without strong justification.

---

## 6. Performance and Optimization

### Clarity First
*   Write readable and maintainable code first.

### Optimize When Necessary
*   Avoid premature optimization.
*   Profile and measure performance to identify bottlenecks before attempting optimizations.
*   **Frappe Context:** Use `frappe.debug_log()` and database query profiling.

### Algorithmic Efficiency
*   Be mindful of time and space complexity for critical code paths.
*   If a simple solution is inherently inefficient (e.g., O(n²) when O(n log n) is readily available and not significantly more complex), consider or propose the more efficient alternative.

**Frappe Example:**
```python
# Bad - O(n²) - queries in loop
for item in items:
    price = frappe.db.get_value("Item Price",
        {"item_code": item.item_code}, "price_list_rate")

# Good - O(n) - single query with IN clause
item_codes = [item.item_code for item in items]
prices = frappe.db.get_all("Item Price",
    filters={"item_code": ["in", item_codes]},
    fields=["item_code", "price_list_rate"],
    as_list=False)
price_map = {p.item_code: p.price_list_rate for p in prices}
```

### Resource Management
*   Ensure proper handling and release of resources (e.g., file handles, network connections, database connections).
*   **Frappe Context:** Use context managers when appropriate.

---

## 7. Dependencies, Imports, and Configuration

### Minimal Dependencies
*   Only import or require libraries/modules that are strictly necessary for the task.
*   Prefer solutions using the language's standard library whenever possible and efficient.
*   **Frappe Context:** Prefer Frappe's built-in utilities over external libraries.

**Frappe Example:**
```python
# Good - use Frappe utilities
from frappe.utils import flt, cint, getdate, now_datetime, add_days

# Avoid if Frappe has equivalent
# import pandas  # Only if truly needed for complex data manipulation
```

### External Libraries
*   If using external libraries, choose popular, well-maintained, and reputable ones appropriate for the task.
*   Mention the library and, if necessary, how to install it.
*   Justify the use of an external library if the functionality is complex to replicate with standard tools.

### Configuration
*   Use environment variables or dedicated configuration files for application settings rather than hardcoding them.
*   **Frappe Context:** Use Site Config (`site_config.json`) or System Settings DocType.

---

## Summary Checklist

Before committing code, verify:

- [ ] All code, comments, and names are in English
- [ ] Follows idiomatic Python/JavaScript style for Frappe
- [ ] Uses return early pattern to reduce nesting
- [ ] Function/variable names are descriptive and clear
- [ ] Single Responsibility Principle followed
- [ ] No code duplication (DRY)
- [ ] Explicit error handling with meaningful messages
- [ ] Input validation at function entry (fail fast)
- [ ] Comments explain "why" not "what"
- [ ] No hardcoded secrets or sensitive data
- [ ] Parameterized queries (or Frappe ORM)
- [ ] Permission checks before sensitive operations
- [ ] No premature optimization
- [ ] Minimal dependencies, prefer Frappe utilities
- [ ] No commented-out code

---

**These principles are non-negotiable for production code quality.**
