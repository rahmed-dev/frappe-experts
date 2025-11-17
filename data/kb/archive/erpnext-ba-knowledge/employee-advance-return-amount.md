# ERPNext Employee Advance - return_amount Field (Standard Feature)

**DocType:** Employee Advance (Standard ERPNext)
**Field:** `return_amount`
**Field Label:** "Amount scheduled for deduction via salary" (somewhat misleading)
**Field Type:** Currency

---

## Actual Behavior (Tested 2025-11-14)

The `return_amount` field is a **running total** of all repayments made against the advance, regardless of method.

### How It Updates:

**Method 1: Return via Salary (Additional Salary)**
1. Employee Advance has "Repay unclaimed amount from salary" enabled
2. Click "Return" button → Creates draft Additional Salary (prefilled)
3. Submit Additional Salary
4. **`return_amount` increases immediately**

**Method 2: Return via Journal Entry**
1. Employee Advance has "Repay unclaimed amount from salary" disabled
2. Click "Return" button → Creates draft Journal Entry (prefilled)
3. Submit Journal Entry
4. **`return_amount` increases immediately**

---

## Business Use Cases

### Detecting Full Repayment:
- Compare: `return_amount >= advance_amount`
- If true → Advance fully repaid

### Detecting Partial Repayment:
- Calculate: `remaining = advance_amount - return_amount`
- Track repayment progress

### Detecting Overpayment:
- If `return_amount > advance_amount` → Employee overpaid

---

## ERPNext Standard Behavior Notes:

- Field updates automatically when repayment transactions are submitted
- No manual entry needed
- Works across different repayment methods (Additional Salary, Journal Entry, Payment Entry)
- Standard ERPNext field (not custom)

---

**Knowledge Source:** Testing and validation
**ERPNext Version:** v14+
**Date Validated:** 2025-11-14
