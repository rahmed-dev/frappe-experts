---
title: "Code Output Format & Delivery Standards"
category: "Development Standards"
applies-to: ["Nexus"]
source: "Consolidated from AGENTS.md LLM interaction guidelines"
last-updated: 2025-11-17
---

# Code Output Format & Delivery Standards

These guidelines ensure that all code generated is complete, usable, properly documented, and ready for integration. Code should be production-ready, not requiring significant refactoring or completion.

---

## 1. Complete and Usable Code

### Deliver Production-Ready Code
*   Strive to provide **complete, functional code snippets or solutions** that can be readily used or integrated.
*   Code should not require significant modifications to work.
*   All dependencies, imports, and setup should be included.

### Include Necessary Context
Every code delivery should include:

1. **Imports and Dependencies**
   ```python
   import frappe
   from frappe import _
   from frappe.utils import flt, cint, getdate
   ```

2. **Basic Setup and Configuration**
   ```python
   # If custom hooks needed
   # In hooks.py:
   doc_events = {
       "Sales Order": {
           "on_submit": "myapp.custom.validate_credit_limit"
       }
   }
   ```

3. **Complete Function/Method Implementation**
   - Not just signatures, but full implementations
   - Include error handling
   - Include validation logic
   - Include return statements

4. **Usage Examples**
   ```python
   # Example usage:
   customer = "CUST-001"
   result = check_credit_limit(customer, 50000)
   if not result["approved"]:
       frappe.msgprint(result["message"])
   ```

### No Skeleton Code
Avoid providing incomplete implementations like:
```python
# Bad
def process_payment(doc):
    # TODO: Add validation
    # TODO: Process payment
    # TODO: Update ledger
    pass
```

Instead, provide complete implementations:
```python
# Good
def process_payment(doc):
    """Process payment and update ledger"""
    # Validate
    if not doc.paid_amount or doc.paid_amount <= 0:
        frappe.throw(_("Paid amount must be greater than zero"))

    # Process payment
    doc.payment_status = "Paid"
    doc.save()

    # Update ledger
    create_ledger_entry(doc)

    return {"success": True, "message": _("Payment processed successfully")}
```

---

## 2. Clear Explanations

### When to Provide Explanations
Provide explanations:
*   After the code block (code first, explanation second)
*   When there are significant design choices
*   When dealing with complex logic
*   When trade-offs are involved
*   When the solution might not be obvious

### Focus on the "Why"
Explain the reasoning behind significant decisions:

**Example:**
```python
@frappe.whitelist()
def get_item_stock(item_code, warehouse=None):
    """
    Get current stock levels for an item.

    Why server-side:
    - Stock data is sensitive and requires permission checks
    - Multiple warehouses need to be queried efficiently
    - Calculations need to consider reserved/projected quantities

    Why cached:
    - Stock queries are expensive (multiple joins)
    - Data doesn't change frequently enough to warrant real-time queries
    - Cache is invalidated on stock transactions
    """
    # Check permissions
    if not frappe.has_permission("Stock Entry", "read"):
        frappe.throw(_("No permission"), frappe.PermissionError)

    # Implementation...
```

### Keep Explanations Concise
*   Be direct and to the point
*   Focus on essential technical information
*   Avoid unnecessary adjectives or verbose descriptions
*   Use bullet points for clarity when listing multiple points

**Good Explanation:**
```
This implementation uses server-side caching because:
- Stock queries are expensive (5+ table joins)
- Cache invalidation happens automatically on transactions
- Reduces API response time from 800ms to 50ms
```

**Avoid:**
```
This absolutely amazing and highly sophisticated implementation leverages
the incredibly powerful server-side caching mechanism to dramatically and
significantly improve performance in ways that are truly remarkable...
```

---

## 3. Handling Ambiguity

### Ask Clarifying Questions
When a request is ambiguous or lacks crucial details:

1. **If interaction is possible:**
   - Ask specific clarifying questions
   - Offer 2-3 concrete options
   - Explain implications of each choice

**Example:**
```
The spec doesn't specify how to handle partial payments. I see two approaches:

Option A: Allow partial payments, track outstanding balance
- Pros: Flexible, matches real-world scenarios
- Cons: More complex status tracking

Option B: Require full payment only
- Pros: Simpler implementation
- Cons: Less flexible for users

Which approach aligns with your requirements?
```

2. **If interaction is not possible:**
   - Explicitly state reasonable assumptions made
   - Explain why those assumptions are reasonable
   - Implement based on best practices
   - Document assumptions clearly in code comments

**Example:**
```python
def calculate_discount(order_amount, customer_type):
    """
    Calculate discount based on customer type.

    Assumptions (spec was unclear):
    - Wholesale customers: 15% discount (industry standard)
    - Retail customers: 5% discount (industry standard)
    - Discounts applied before tax (common practice)
    - Minimum order for discount: 1000 (prevents abuse)

    These can be made configurable if needed.
    """
    if order_amount < 1000:
        return 0

    discount_rates = {
        "Wholesale": 0.15,
        "Retail": 0.05
    }

    return order_amount * discount_rates.get(customer_type, 0)
```

### When Multiple Approaches Exist

If multiple valid approaches exist:
1. Choose the most appropriate based on Frappe best practices
2. Briefly mention key alternatives
3. Justify your chosen solution
4. Explain significant trade-offs

**Example:**
```
I've implemented this using a Server Script rather than a DocType hook.

Alternative approaches considered:
1. DocType hook (custom app): Better for complex logic, versioned
2. Server Script: Easier to modify, no deployment needed
3. Custom Script (client-side): Limited server access

Chose Server Script because:
- Logic is simple (single validation rule)
- You mentioned wanting to modify rules without deployments
- No need for version control yet
- Can migrate to DocType hook later if needed
```

---

## 4. Placeholders and TODOs

### Clear Placeholder Marking
When placeholders are necessary, mark them clearly:

**Good Placeholders:**
```python
# Configuration
API_KEY = "YOUR_API_KEY_HERE"  # Replace with actual API key from Settings
WEBHOOK_URL = "YOUR_WEBHOOK_URL"  # Get from external system admin

# User must implement
def validate_custom_business_rule(doc):
    """
    Implement your custom validation logic here.

    This function is called before saving.
    Raise frappe.ValidationError if validation fails.

    Example:
        if doc.custom_field < 0:
            frappe.throw("Custom field cannot be negative")
    """
    raise NotImplementedError("Implement custom validation logic")
```

### Avoid Generic TODOs
Do not include `TODO`, `FIXME`, or similar placeholder comments unless:
1. They are part of a formal, explicitly requested issue-tracking workflow, OR
2. They are clear instructions to the user on what needs customization

**Bad:**
```python
def calculate_tax(amount):
    # TODO: Implement tax calculation
    # FIXME: This is wrong
    return amount * 0.1
```

**Good:**
```python
def calculate_tax(amount, tax_rate=None):
    """
    Calculate tax based on configured rate.

    Args:
        amount: Taxable amount
        tax_rate: Optional override rate. If not provided, uses system default.

    Note: Tax calculation follows regional regulations as per Finance team.
    """
    if tax_rate is None:
        tax_rate = frappe.db.get_single_value("Tax Settings", "default_rate")

    return flt(amount) * flt(tax_rate) / 100
```

---

## 5. Installation and Setup Instructions

### Include Installation Steps
When using external libraries or requiring configuration:

**Example:**
```python
"""
Payment Gateway Integration

Installation:
1. Install required package:
   $ bench --site [sitename] pip install razorpay

2. Add to site_config.json:
   {
     "razorpay_key_id": "rzp_test_...",
     "razorpay_key_secret": "YOUR_SECRET"
   }

3. Run setup:
   $ bench --site [sitename] migrate

4. Enable in Payment Gateway Settings DocType
"""

import frappe
try:
    import razorpay
except ImportError:
    frappe.throw(_("Please install razorpay: bench pip install razorpay"))
```

### Configuration Requirements
Clearly document configuration needs:

```python
"""
Email Notification Configuration

Required Settings (System Settings DocType):
- notification_email: Email to send notifications to
- notification_frequency: daily|weekly|immediate

Optional Settings:
- notification_template: Custom email template (uses default if not set)

Setup Instructions:
1. Go to: System Settings
2. Scroll to: Email Notifications section
3. Configure required fields
4. Save
"""
```

---

## 6. Error Messages and User Feedback

### Provide Helpful Error Messages
All error messages should:
1. Be clear and specific
2. Explain what went wrong
3. Suggest how to fix it (when possible)
4. Be in English

**Bad:**
```python
if not data:
    frappe.throw("Error")
```

**Good:**
```python
if not customer:
    frappe.throw(_("Customer is required. Please select a customer before proceeding."))

if not frappe.db.exists("Customer", customer):
    frappe.throw(_("Customer '{0}' not found. Please check the customer ID.").format(customer))
```

### Success Messages
Provide clear feedback on successful operations:

```python
def process_bulk_update(items):
    """Process bulk item updates"""
    updated_count = 0
    failed_items = []

    for item in items:
        try:
            update_item(item)
            updated_count += 1
        except Exception as e:
            failed_items.append({"item": item, "error": str(e)})

    # Clear success message
    if updated_count == len(items):
        frappe.msgprint(_("Successfully updated {0} items").format(updated_count))
    else:
        frappe.msgprint(_(
            "Updated {0} items. {1} items failed. See error log for details."
        ).format(updated_count, len(failed_items)))

    return {
        "success": updated_count,
        "failed": failed_items
    }
```

---

## Summary Checklist

Before delivering code, verify:

- [ ] Code is complete and functional (not skeleton/TODO)
- [ ] All imports and dependencies included
- [ ] Setup/configuration instructions provided if needed
- [ ] Error handling implemented with clear messages
- [ ] Usage examples included for non-trivial functions
- [ ] Explanations focus on "why" (design decisions, trade-offs)
- [ ] Assumptions documented if spec was ambiguous
- [ ] Placeholders clearly marked with instructions
- [ ] No generic TODO/FIXME comments
- [ ] Installation steps provided for external libraries
- [ ] Success/error feedback messages are clear and helpful
- [ ] Code is ready for production use

---

**Deliver code that can be used immediately, not code that requires completion.**
