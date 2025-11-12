# Generate Test Scenarios Workflow Instructions

<critical>Think like user, developer, AND hacker to generate comprehensive test scenarios</critical>

<workflow>

<step n="1" goal="Load feature context">
  <ask>What feature/module needs test scenarios?

Options:
a) Specific feature from Technical Spec (provide TSD and feature name)
b) Complete implementation phase (provide Implementation Plan and phase number)
c) Custom DocType (provide DocType name)
d) Integration (provide integration details)
  </ask>

  <action>Load complete context (TSD, Implementation Plan, DocType schema)</action>
  <action>Store as {{feature_name}}</action>

  <action>Understand:
    - What the feature does
    - Business rules and validations
    - Integration touch-points
    - Permission requirements
    - Data dependencies
  </action>
</step>

<step n="2" goal="Generate test scenarios">
  <action>Think in 3 modes:
    - 👤 **USER mode:** How will end-users interact? What mistakes will they make?
    - 💻 **DEVELOPER mode:** What edge cases exist? What can break?
    - 🔒 **HACKER mode:** How could this be exploited? What security holes exist?
  </action>

  <action>Generate scenarios across dimensions:
    1. Happy Path (basic functionality works)
    2. Edge Cases (boundary conditions, empty states, max limits)
    3. Error Conditions (validation failures, missing data)
    4. Integration Points (how this affects other DocTypes)
    5. Permission Testing (role-based access)
    6. Data Validation (field types, formats, constraints)
    7. Workflow States (if workflow attached)
    8. Performance (large data volumes, concurrent users)
    9. Security (injection, unauthorized access)
  </action>
</step>

<step n="3" goal="Generate Test Scenario Document">
  <template-output>test_scenarios</template-output>

  <action>Generate complete test scenarios document:

# Test Scenarios: [Feature Name]

**Feature:** {{feature_name}}
**Based on:** Technical Specification v{{tsd_version}}
**Date:** {{date}}
**Prepared by:** Test Gen

---

## Test Environment Setup

**Prerequisites:**
- [System setup requirements]
- [Test data needed]
- [User roles to create]

**Test Users:**
- **Admin User:** Full permissions
- **[Role] User:** [Specific permissions]
- **[Role] User:** [Limited permissions]

---

## 1. Happy Path Scenarios

### HP-01: [Scenario Name - e.g., "Create Sales Order Successfully"]

**Objective:** Verify user can complete primary workflow

**Test Steps:**
1. Login as: [Role]
2. Navigate to: [Path]
3. Fill fields:
   - Field 1: [Test value]
   - Field 2: [Test value]
4. Click [Button]

**Expected Result:**
- ✅ [What should happen]
- ✅ [System state after]
- ✅ [Related records updated]

**Test Data:**
- Customer: TEST-CUST-001
- Item: TEST-ITEM-001

---

### HP-02: [Next Happy Path Scenario]
[Same structure]

---

## 2. Edge Case Scenarios

### EC-01: [Scenario - e.g., "Empty Item Table Validation"]

**Objective:** System prevents submission with empty required child table

**Test Steps:**
1. Create new [DocType]
2. Fill all fields EXCEPT Items table
3. Attempt to submit

**Expected Result:**
- ❌ Submission blocked
- ⚠️ Error message: "Cannot submit with empty Items table"

---

### EC-02: [Maximum Quantity Limit]
**Objective:** System handles large quantities

**Test Steps:**
1. Enter quantity: 999,999,999
2. Submit

**Expected Result:**
- ✅ Accepts large number OR
- ⚠️ Shows validation error if exceeds business rule

---

### EC-03: [Duplicate Prevention]
[Continue with edge cases]

---

## 3. Error Condition Scenarios

### ER-01: [Validation Error - e.g., "Delivery Date Before Order Date"]

**Objective:** System validates date logic

**Test Steps:**
1. Set Order Date: 2025-01-15
2. Set Delivery Date: 2025-01-10
3. Attempt to save

**Expected Result:**
- ❌ Save blocked
- ⚠️ Error: "Delivery Date cannot be before Order Date"

---

### ER-02: [Missing Mandatory Field]
[Continue with error scenarios]

---

## 4. Integration Point Scenarios

### INT-01: [Integration - e.g., "Stock Update on Submit"]

**Objective:** Verify Sales Order updates Stock Ledger

**Test Steps:**
1. Check stock before: Item XYZ = 100 units
2. Create Sales Order for 10 units of Item XYZ
3. Submit Sales Order
4. Check Stock Ledger Entry

**Expected Result:**
- ✅ Stock Ledger Entry created
- ✅ Reserved Qty = 10
- ✅ Available Qty = 90

**Integration Points Tested:**
- Sales Order → Stock Ledger Entry
- Sales Order → Bin (Reserved Qty)

---

### INT-02: [Accounting Integration]
[Continue with integration scenarios]

---

## 5. Permission Testing Scenarios

### PERM-01: [Role-based Access - e.g., "Sales User Cannot Cancel"]

**Objective:** Verify role restrictions work

**Test Steps:**
1. Login as: Sales User (not Sales Manager)
2. Open submitted Sales Order
3. Attempt to click Cancel

**Expected Result:**
- ❌ Cancel button not visible OR disabled
- ⚠️ Error if API called directly: "Insufficient Permission"

---

### PERM-02: [User Permissions - Own Documents]
**Objective:** User can only see own documents

**Test Steps:**
1. Login as: Sales User A
2. Create Sales Order
3. Logout
4. Login as: Sales User B
5. Try to open Sales User A's order

**Expected Result:**
- ❌ Document not visible in list
- ❌ Direct access blocked if URL guessed

---

## 6. Data Validation Scenarios

### VAL-01: [Field Type Validation - e.g., "Email Format"]

**Test Steps:**
1. Enter invalid email: "notanemail"
2. Attempt to save

**Expected Result:**
- ⚠️ Validation error: "Invalid email format"

---

### VAL-02: [Numeric Range Validation]
[Continue with validation scenarios]

---

## 7. Workflow State Scenarios

(If workflow attached)

### WF-01: [State Transition - e.g., "Draft → Pending Approval"]

**Test Steps:**
1. Create document
2. Fill required fields
3. Click "Submit for Approval"

**Expected Result:**
- ✅ Status changes to "Pending Approval"
- ✅ Notification sent to approver
- ❌ Creator cannot edit anymore

---

## 8. Performance Scenarios

### PERF-01: [Large Data Volume]

**Objective:** System handles 100+ line items

**Test Steps:**
1. Create Sales Order with 150 line items
2. Save and Submit

**Expected Result:**
- ✅ Saves within 3 seconds
- ✅ No timeout errors

---

### PERF-02: [Concurrent Users]
**Objective:** Multiple users editing same document

[Continue with performance scenarios]

---

## 9. Security Scenarios

### SEC-01: [SQL Injection Prevention]

**Objective:** System sanitizes inputs

**Test Steps:**
1. In Customer Name field, enter: `'; DROP TABLE tabCustomer;--`
2. Attempt to save

**Expected Result:**
- ✅ Input sanitized/escaped
- ❌ No database modification occurs

---

### SEC-02: [XSS Prevention]
**Objective:** System blocks script injection

**Test Steps:**
1. In description field, enter: `<script>alert('XSS')</script>`
2. Save and view document

**Expected Result:**
- ✅ Script not executed when viewing
- ✅ HTML tags escaped or stripped

---

## 10. Regression Test Scenarios

(Tests to ensure existing functionality still works)

### REG-01: [Existing Feature Not Broken]

**Objective:** Verify [related feature] still works after new feature added

[Continue with regression tests]

---

## Test Coverage Summary

| Category | Scenarios | Priority |
|----------|-----------|----------|
| Happy Path | [count] | 🔴 Critical |
| Edge Cases | [count] | 🟡 High |
| Error Conditions | [count] | 🟡 High |
| Integration Points | [count] | 🔴 Critical |
| Permissions | [count] | 🔴 Critical |
| Data Validation | [count] | 🟢 Medium |
| Workflow States | [count] | 🟡 High |
| Performance | [count] | 🟢 Medium |
| Security | [count] | 🔴 Critical |
| Regression | [count] | 🟡 High |

---

## Recommended Test Execution Order

1. **Phase 1:** Happy Path (HP-01 to HP-XX) - Must all pass
2. **Phase 2:** Critical Security & Permissions (SEC-* and PERM-*)
3. **Phase 3:** Integration Points (INT-*)
4. **Phase 4:** Error Conditions & Edge Cases (ER-*, EC-*)
5. **Phase 5:** Performance & Regression (PERF-*, REG-*)

---

## Known Limitations / Out of Scope

- [What this feature explicitly does NOT handle]
- [Documented constraints]

  </action>

  <action>Save to {{default_output_file}}</action>
</step>

<step n="4" goal="Review and expand">
  <ask>Review the test scenarios. Any specific edge cases or integrations I should add?</ask>

  <check if="user identifies gaps">
    <action>Generate additional scenarios for gaps</action>
    <action>Save updated version</action>
  </check>
</step>

<step n="5" goal="Completion">
  <action>Confirm test scenarios complete and saved</action>
  <action>Provide test coverage statistics (total scenarios, by category)</action>
  <action>Suggest: These scenarios can be used for manual testing or automated test script development</action>
</step>

</workflow>
