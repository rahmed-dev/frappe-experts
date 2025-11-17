---
title: "Testing Standards & Philosophy"
category: "Development Standards"
applies-to: ["Nexus", "Test-Gen", "Debug Master"]
source: "Consolidated from AGENTS.md testing guidelines"
last-updated: 2025-11-17
---

# Testing Standards & Philosophy

When generating automated tests (including unit, integration, and end-to-end tests), the primary goals are **clarity, determinism, and maintainability**. Tests are a form of living documentation and should be easily understood by any developer.

---

## 1. Core Philosophy: Simplicity and Readability

### Tests Should Be Boringly Explicit
*   A test should read as a straightforward script of "setup, execute, verify."
*   No surprises, no clever abstractions that hide intent.

### Minimize Logic in Tests
*   **Whenever possible, prefer explicit, linear test steps over loops, complex conditionals, or intricate helper functions.**
*   Excessive logic obscures the test's intent and makes debugging failures more difficult.
*   Each test should be independently understandable.

**Example:**
```python
# Bad - Hidden logic
def test_payment_processing():
    for scenario in get_test_scenarios():  # What scenarios? Where defined?
        result = process_payment(scenario['input'])
        assert result == scenario['expected']  # What's expected?

# Good - Explicit and clear
def test_payment_processing_with_valid_card():
    payment_data = {
        "card_number": "4111111111111111",
        "amount": 100.00,
        "currency": "USD"
    }
    result = process_payment(payment_data)

    assert result["success"] == True
    assert result["transaction_id"] == "TXN_001"
    assert result["amount"] == 100.00
```

### Prefer Duplication Over Complex Abstraction
*   It is often better to have a few duplicated lines of setup code if it makes each test case self-contained and clear.
*   Rather than hiding the setup in a complex, multi-purpose helper function that serves 10 different tests.

**Guideline:** If a helper function makes tests harder to understand, don't use it.

### Explain the "Why," Not the "What"
*   Avoid obvious comments that simply restate what the code does.
*   Comments in tests are valuable when they explain:
    - The business reason for the test
    - Why a specific, non-obvious assertion is being made
    - Edge cases being tested and why they matter

```python
# Bad comment
# Check if result is True
assert result == True

# Good comment
# Payment must be marked successful even if receipt email fails
# (as per Finance team decision 2024-11-15)
assert payment.status == "Success"
assert receipt_sent == False
```

---

## 2. Standard Library and Dependencies

### Favor the Standard Library
*   Whenever feasible and efficient, prefer using the language's standard library for testing over introducing large, third-party testing frameworks.
*   This minimizes dependencies and keeps the test setup lean.

**Frappe Context:**
*   Use Frappe's built-in test framework (`frappe.tests.utils.FrappeTestCase`)
*   Use standard Python `unittest` assertions
*   Avoid adding pytest, nose, or other frameworks unless there's a compelling reason

```python
import frappe
from frappe.tests.utils import FrappeTestCase

class TestPaymentEntry(FrappeTestCase):
    def test_payment_amount_validation(self):
        payment = frappe.get_doc({
            "doctype": "Payment Entry",
            "payment_type": "Receive",
            "paid_amount": -100  # Invalid negative amount
        })

        with self.assertRaises(frappe.ValidationError):
            payment.insert()
```

---

## 3. Test Data Management: Deterministic and Explicit

### Use Fixed, Hardcoded Data
*   **Never use dynamically generated data** (e.g., random identifiers, `time.Now()`, random strings) for key entities or timestamps in the test setup.
*   Tests must be 100% deterministic and repeatable.

**Bad Example:**
```python
import uuid
from datetime import datetime

def test_create_order():
    order_id = str(uuid.uuid4())  # Different every run!
    order_date = datetime.now()   # Different every run!

    order = create_order(order_id, order_date)
    # Assertions become complicated because values change
```

**Good Example:**
```python
def test_create_order():
    order_id = "ORD-2024-001"
    order_date = "2024-11-17"

    order = create_order(order_id, order_date)

    # Assertions are simple and clear
    assert order.name == "ORD-2024-001"
    assert order.order_date == "2024-11-17"
```

### Utilize Fixed Identifiers
*   Always use hardcoded, fixed identifiers.
*   For UUIDs, use a library function to parse a fixed UUID string:
    ```python
    import uuid
    test_uuid = uuid.UUID("11111111-1111-1111-1111-111111111111")
    ```

**Frappe Context:**
```python
class TestSalesOrder(FrappeTestCase):
    def setUp(self):
        # Create test customer with fixed name
        if not frappe.db.exists("Customer", "TEST-CUST-001"):
            frappe.get_doc({
                "doctype": "Customer",
                "customer_name": "Test Customer 001",
                "customer_type": "Company",
                "customer_group": "Commercial",
                "territory": "All Territories"
            }).insert()

    def test_sales_order_creation(self):
        # Use fixed customer
        so = frappe.get_doc({
            "doctype": "Sales Order",
            "customer": "TEST-CUST-001",
            "delivery_date": "2024-12-01",
            "items": [{
                "item_code": "TEST-ITEM-001",
                "qty": 10,
                "rate": 100
            }]
        })
        so.insert()

        # Deterministic assertions
        self.assertEqual(so.customer, "TEST-CUST-001")
        self.assertEqual(so.items[0].amount, 1000)
```

### Rationale
*   Ensures the test is 100% deterministic and repeatable.
*   Makes the assertion phase much easier to write and debug.
*   Expected results are known in advance.

---

## 4. Assertions and Validations: Static and Unambiguous

### Prefer Static Expected Results
*   The expected outcome of a test should, whenever possible, be a static, hardcoded value.
*   For API tests, this is often a raw string representing the expected JSON or XML response.

### Avoid Constructing `expected` Values Dynamically
*   Do not build the `expected` result string programmatically within the test (e.g., using string formatting).
*   A static string is unambiguous, serves as clear documentation of the expected output.
*   Makes identifying differences during a failure trivial.

**Good Practice Example:**
```python
def test_get_customer_api():
    response = requests.get("/api/customer/TEST-CUST-001")

    # Expected result is a clear, static string
    expected_json = {
        "data": {
            "customer_name": "Test Customer 001",
            "customer_type": "Company",
            "territory": "All Territories"
        }
    }

    self.assertEqual(response.json(), expected_json)
```

**Practice to Be Avoided:**
```python
def test_get_customer_api():
    customer_id = "TEST-CUST-001"
    response = requests.get(f"/api/customer/{customer_id}")

    # Avoid this - hides the final expected value from the reader
    expected_json = {
        "data": {
            "customer_name": f"Test Customer {customer_id.split('-')[-1]}",
            "customer_type": "Company"
        }
    }
    # Reader can't easily see what the expected output is
```

**Frappe Context:**
```python
def test_payment_entry_submission():
    pe = frappe.get_doc({
        "doctype": "Payment Entry",
        "payment_type": "Receive",
        "party_type": "Customer",
        "party": "TEST-CUST-001",
        "paid_amount": 1000,
        "received_amount": 1000
    })
    pe.insert()
    pe.submit()

    # Static expected values
    self.assertEqual(pe.docstatus, 1)  # Submitted
    self.assertEqual(pe.paid_amount, 1000)
    self.assertEqual(pe.status, "Submitted")
```

---

## 5. Scenario Coverage and Naming

### Test More Than the "Happy Path"
Ensure comprehensive coverage by testing a range of scenarios:

1. **Basic Retrieval & Pagination**
   - Does the endpoint return data correctly?
   - Does it respect page size/offset?

2. **Filtering Logic**
   - Test various combinations of filters
   - Ensure they correctly include and exclude data

3. **Ordering Logic**
   - If applicable, explicitly test both ascending and descending order

4. **Edge Cases**
   - What happens with filters that yield zero results?
   - What about invalid input or non-existent IDs?
   - Boundary conditions (zero, negative, very large numbers)

5. **Error Cases**
   - Missing required fields
   - Invalid data types
   - Permission violations
   - Duplicate entries

**Frappe Example Structure:**
```python
class TestPaymentEntry(FrappeTestCase):
    # Happy path
    def test_payment_entry_creation_with_valid_data(self):
        pass

    # Validation tests
    def test_payment_entry_requires_party(self):
        pass

    def test_payment_entry_requires_positive_amount(self):
        pass

    def test_payment_entry_rejects_negative_amount(self):
        pass

    # Edge cases
    def test_payment_entry_with_zero_amount(self):
        pass

    def test_payment_entry_with_non_existent_customer(self):
        pass

    # Permission tests
    def test_payment_entry_submission_requires_permission(self):
        pass

    # Business logic
    def test_payment_entry_updates_outstanding_amount(self):
        pass
```

### Use Descriptive Naming
*   Test functions should have clear names that describe the specific scenario being tested.
*   The name should reflect the intent of the test.

**Naming Pattern:** `test_<what>_<scenario>_<expected_outcome>`

**Examples:**
```python
# Good
def test_sales_order_submission_with_valid_items_succeeds(self):
    pass

def test_sales_order_submission_without_items_raises_validation_error(self):
    pass

def test_payment_entry_with_negative_amount_raises_validation_error(self):
    pass

# Bad (too vague)
def test_sales_order(self):
    pass

def test_payment(self):
    pass
```

---

## 6. Validate the Business Outcome, Not Implementation Details

### Focus on What Matters
*   Assertions should validate the result of the business logic.
*   Don't assert internal implementation details that may change.

**Example:**
```python
# Good - validates business outcome
def test_discount_calculation():
    order = create_order_with_discount(base_amount=1000, discount_percent=10)

    # Assert business result
    self.assertEqual(order.discount_amount, 100)
    self.assertEqual(order.total_amount, 900)

# Bad - tests implementation details
def test_discount_calculation():
    order = create_order_with_discount(base_amount=1000, discount_percent=10)

    # Asserting internal variable names or private methods
    self.assertTrue(order._discount_calculated)
    self.assertEqual(len(order._calculation_steps), 3)
```

**When testing a filter based on user attributes:**
*   More valuable to assert that the returned records belong to the correct user (e.g., checking a `user_id` field)
*   Rather than asserting the specific, auto-generated primary key of a sub-record
*   This confirms that the relationships and filters worked as intended to produce the correct business outcome

---

## 7. Frappe-Specific Testing Patterns

### Test Case Structure
```python
import frappe
from frappe.tests.utils import FrappeTestCase

class TestMyDocType(FrappeTestCase):
    def setUp(self):
        """Run before each test - create test data"""
        # Create test records with fixed IDs
        pass

    def tearDown(self):
        """Run after each test - cleanup"""
        # Delete test records
        pass

    def test_specific_scenario(self):
        """Test description"""
        # Setup
        # Execute
        # Assert
        pass
```

### Testing Validation Logic
```python
def test_item_price_must_be_positive(self):
    item = frappe.get_doc({
        "doctype": "Item",
        "item_code": "TEST-ITEM-001",
        "item_name": "Test Item",
        "standard_rate": -100  # Invalid
    })

    with self.assertRaises(frappe.ValidationError) as context:
        item.insert()

    self.assertIn("Price cannot be negative", str(context.exception))
```

### Testing Permissions
```python
def test_payment_entry_submission_requires_permission(self):
    # Create user without submit permission
    frappe.set_user("test_user@example.com")

    pe = frappe.get_doc("Payment Entry", "PE-001")

    with self.assertRaises(frappe.PermissionError):
        pe.submit()

    # Restore admin user
    frappe.set_user("Administrator")
```

### Testing Background Jobs
```python
def test_scheduled_task_execution(self):
    from myapp.tasks import daily_report_generation

    # Execute the task
    daily_report_generation()

    # Assert side effects
    reports = frappe.get_all("Report Log",
        filters={"report_type": "Daily Summary"},
        fields=["name", "status"])

    self.assertEqual(len(reports), 1)
    self.assertEqual(reports[0].status, "Completed")
```

---

## Summary Checklist

Before committing tests, verify:

- [ ] Tests are explicit and linear (minimal logic)
- [ ] Test names clearly describe the scenario
- [ ] No random or dynamic test data (use fixed values)
- [ ] Expected results are static and hardcoded
- [ ] Tests cover happy path, validation, edge cases, and errors
- [ ] Comments explain "why" not "what"
- [ ] Tests are self-contained (can run independently)
- [ ] Assertions validate business outcomes, not implementation details
- [ ] Uses Frappe test framework appropriately
- [ ] Cleanup performed in tearDown() if needed
- [ ] Permission scenarios tested where relevant
- [ ] Tests are deterministic (same result every run)

---

**Tests are living documentation. Make them clear, deterministic, and maintainable.**
