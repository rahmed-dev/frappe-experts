# Common Business Process Patterns in ERPNext

## Overview

This guide covers common business processes across industries and how ERPNext handles them. Use this to quickly map business requirements to ERPNext capabilities.

## Manufacturing Patterns

### Pattern 1: Make-to-Order (MTO)
**Business Flow**: Customer Order → Production → Delivery

**ERPNext Solution**:
1. Sales Order (confirmed customer demand)
2. Production Plan (from Sales Order)
3. Work Order (generated from Production Plan)
4. Job Cards (operation tracking)
5. Finished goods Stock Entry
6. Delivery Note (against Sales Order)

**Standard Feature**: ✅ Complete MTO flow

---

### Pattern 2: Make-to-Stock (MTS)
**Business Flow**: Forecast → Production → Stock → Customer Order → Delivery

**ERPNext Solution**:
1. Production Plan (based on reorder levels/forecast)
2. Work Order
3. Manufacture to target warehouse
4. Sales Order (from available stock)
5. Delivery Note

**Standard Feature**: ✅ Complete MTS flow

---

### Pattern 3: Subcontracting
**Business Flow**: Send raw materials → Subcontractor processes → Receive finished goods

**ERPNext Solution**:
1. BOM with "Is Sub Contracted" items
2. Purchase Order (subcontracting type)
3. Stock Entry - Material Transfer to Subcontractor
4. Subcontractor processes
5. Purchase Receipt (finished goods + backflush raw materials)

**Standard Feature**: ✅ Native subcontracting

---

## Procurement Patterns

### Pattern 1: Standard Purchase
**Business Flow**: Request → Approval → PO → Receipt → Payment

**ERPNext Solution**:
1. Material Request (initiated by user/auto-generated)
2. Request for Quotation (optional)
3. Supplier Quotation (optional)
4. Purchase Order
5. Purchase Receipt
6. Purchase Invoice
7. Payment Entry

**Standard Feature**: ✅ Complete purchase-to-pay

---

### Pattern 2: Drop Shipping
**Business Flow**: Customer Order → Supplier ships directly to customer

**ERPNext Solution**:
1. Sales Order (with "Drop Ship" checked on item)
2. Purchase Order (auto-created, with customer delivery address)
3. Purchase Receipt (receives against PO)
4. Delivery Note (against Sales Order, stock auto-updated)

**Standard Feature**: ✅ Drop ship supported

---

## Sales & Distribution Patterns

### Pattern 1: Standard Sales Order Flow
**Business Flow**: Quotation → Order → Delivery → Invoice → Payment

**ERPNext Solution**:
1. Quotation (optional)
2. Sales Order
3. Delivery Note (against Sales Order)
4. Sales Invoice (against Delivery Note or Sales Order)
5. Payment Entry

**Standard Feature**: ✅ Complete order-to-cash

---

### Pattern 2: POS (Point of Sale)
**Business Flow**: Direct sales with immediate payment

**ERPNext Solution**:
1. POS Invoice (combines delivery + invoice + payment)
2. Stock automatically reduced
3. Payment recorded

**Standard Feature**: ✅ POS module

---

## Project Management Patterns

### Pattern 1: Project-based Manufacturing
**Business Flow**: Project → Tasks → Material → Production → Delivery

**ERPNext Solution**:
1. Project (with Tasks)
2. Material Request (linked to Project)
3. Purchase Order (project-linked)
4. Work Order (project-linked)
5. Delivery Note (project-linked)
6. Project costing & profitability

**Standard Feature**: ✅ Project integration across modules

---

### Pattern 2: Service Projects with Timesheets
**Business Flow**: Project → Tasks → Timesheet → Billing

**ERPNext Solution**:
1. Project with Tasks
2. Timesheet (log hours against tasks)
3. Sales Invoice (from Timesheet)
4. Project profitability (Cost vs Revenue)

**Standard Feature**: ✅ Timesheet billing

---

## HR & Payroll Patterns

### Pattern 1: Shift-based Attendance
**Business Flow**: Shift Assignment → Attendance → Payroll

**ERPNext Solution**:
1. Shift Type (define shifts)
2. Shift Assignment (assign to employees)
3. Attendance (auto-marked via biometric or manual)
4. Salary Slip (attendance-based payment calculation)

**Standard Feature**: ✅ Shift management

---

### Pattern 2: Leave Management
**Business Flow**: Leave Allocation → Application → Approval → Payroll Impact

**ERPNext Solution**:
1. Leave Type (Annual, Sick, etc.)
2. Leave Allocation (annual quota)
3. Leave Application (employee requests)
4. Approval Workflow
5. Salary Slip (Leave Without Pay auto-calculated)

**Standard Feature**: ✅ Complete leave management

---

## Quality Management Patterns

### Pattern 1: Incoming Inspection
**Business Flow**: Purchase Receipt → Inspection → Accept/Reject → Stock/Return

**ERPNext Solution**:
1. Purchase Receipt (not submitted)
2. Quality Inspection (against Purchase Receipt)
3. If Accepted: Submit Purchase Receipt → Stock updated
4. If Rejected: Create Purchase Return

**Standard Feature**: ✅ Quality Inspection

---

### Pattern 2: In-Process Inspection
**Business Flow**: Production → Operation Complete → Inspection → Continue/Rework

**ERPNext Solution**:
1. Job Card (operation)
2. Quality Inspection (against Job Card)
3. If Accepted: Complete Job Card
4. If Rejected: Rework or Scrap

**Standard Feature**: ✅ Quality Inspection in manufacturing

---

## Stock Management Patterns

### Pattern 1: Batch-wise Inventory (FEFO/FIFO)
**Business Flow**: Batch receipt → Batch tracking → FEFO dispatch

**ERPNext Solution**:
1. Item with "Has Batch No" enabled
2. Purchase Receipt (batch auto-created or manual)
3. Batch expiry date tracked
4. Stock Entry / Delivery Note (FEFO: First Expiry First Out)

**Standard Feature**: ✅ Batch management

---

### Pattern 2: Serial Number Tracking
**Business Flow**: Serial receipt → Individual tracking → Serial dispatch

**ERPNext Solution**:
1. Item with "Has Serial No" enabled
2. Purchase Receipt (serial numbers assigned)
3. Warranty/AMC tracking per serial
4. Delivery Note (specific serials)

**Standard Feature**: ✅ Serial number tracking

---

### Pattern 3: Stock Reservation
**Business Flow**: Sales Order → Reserve Stock → Manufacture/Deliver

**ERPNext Solution**:
1. Sales Order created
2. Stock Reservation Entry (reserve from warehouse)
3. Delivery Note (reserved stock used)

**Standard Feature**: ✅ Stock reservation (recent addition)

---

## Integration Patterns

### Pattern 1: Accounting Integration
**Business Flow**: Transaction → Auto GL Entry

**ERPNext Solution**:
- Purchase Receipt → Stock-in-Hand Dr, Stock Received But Not Billed Cr
- Delivery Note → COGS Dr, Stock-in-Hand Cr
- Sales Invoice → Debtors Dr, Sales Cr
- Payment Entry → Bank Dr, Debtors Cr

**Standard Feature**: ✅ Full accounting integration

---

### Pattern 2: Project Costing
**Business Flow**: Project expenses → Timesheet → Material → Costing

**ERPNext Solution**:
1. All expenses tagged to Project
2. Timesheet costs
3. Material costs from Purchase Orders/Stock Entries
4. Project Profitability Report (Cost vs Revenue)

**Standard Feature**: ✅ Project costing

---

## Configuration vs Customization Decision Tree

```
                  [Business Requirement]
                          |
         Does ERPNext have this feature? (Check erpnext-ba-guide.md)
                    /           \
                  YES            NO
                   |              |
            [Use Standard]   Need to extend?
                                  |
                     Can Custom Fields solve it?
                          /              \
                        YES               NO
                         |                 |
                   [Tier 2:          Need business logic?
                   Custom Fields]          |
                                    Can Server Script handle?
                                      /            \
                                    YES             NO
                                     |               |
                                [Tier 3:        Need custom UI
                                Scripts]        or complex module?
                                                     |
                                                [Tier 4:
                                                Custom App]
```

---

## Common Business Scenarios & Solutions

### Scenario 1: "We need approval workflows"
**Solution**: Tier 2 - Use ERPNext Workflow (no code)

### Scenario 2: "We need to track additional item information"
**Solution**: Tier 2 - Add Custom Fields to Item doctype

### Scenario 3: "We need custom invoice format with logo and terms"
**Solution**: Tier 2 - Create Custom Print Format

### Scenario 4: "We need auto-calculation of delivery date"
**Solution**: Tier 3 - Server Script (Before Save event)

### Scenario 5: "We need real-time dashboard"
**Solution**: Tier 2 - Use ERPNext Dashboard (configurable)

### Scenario 6: "We need barcode scanning for stock entry"
**Solution**: Tier 3 - Client Script for barcode input

### Scenario 7: "We need production scheduling algorithm"
**Solution**: Tier 4 - Custom App (if ERPNext Production Plan insufficient)

### Scenario 8: "We need IoT integration for machines"
**Solution**: Tier 4 - Custom App (bidirectional IoT communication)

---

## Industry-Specific Patterns

### Pharma/Food (Batch & Expiry)
- ✅ Use Batch tracking with expiry
- ✅ FEFO dispatch
- ✅ Quality Inspection mandatory
- ⚙️ Add Custom Fields for regulatory data
- 🔨 Regulatory reports via Script Reports

### Electronics (Serial Tracking)
- ✅ Use Serial Number tracking
- ✅ Warranty/AMC management
- ⚙️ Custom Fields for component details
- 🔨 RMA process (configure via Workflow or light custom)

### Job Shop Manufacturing
- ✅ Project-based manufacturing
- ✅ Job Work/Subcontracting
- ⚙️ Custom Fields for customer specifications
- 🔨 Advanced scheduling if needed (Tier 4)

### Process Manufacturing
- ✅ BOM with co-products/by-products
- ✅ Batch production
- ⚙️ Formula management via BOM
- 🔨 Recipe optimization (custom if needed)

---

## Quick Reference: Standard Feature Checklist

Before suggesting customization, check if ERPNext has:

**Manufacturing**:
- ✅ BOM (multilevel)
- ✅ Work Order
- ✅ Job Card
- ✅ Production Plan
- ✅ Subcontracting
- ✅ Workstation & Operations

**Inventory**:
- ✅ Multi-warehouse
- ✅ Batch tracking
- ✅ Serial number
- ✅ FIFO/Moving Average
- ✅ Stock Reconciliation
- ✅ Reorder levels

**Quality**:
- ✅ Quality Inspection
- ✅ Inspection templates
- ✅ Accept/Reject workflow

**HR**:
- ✅ Shift management
- ✅ Leave management
- ✅ Attendance
- ✅ Payroll
- ✅ Expense claims

**Projects**:
- ✅ Task management
- ✅ Timesheet
- ✅ Project costing
- ✅ Gantt charts

**Approvals**:
- ✅ Workflow engine
- ✅ Email alerts
- ✅ Role-based approvals

---

**Remember**: 80% of business processes map to standard ERPNext. Configure before you customize. Check patterns first, then climb the tiers only if needed.
