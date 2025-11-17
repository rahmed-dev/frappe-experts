---
last-updated: 2025-11-17
---

# Functional Knowledge Base

Business and domain knowledge for ERPNext - modules, processes, and solution patterns.

## Table of Contents

1. [ERPNext BA Guide](#erpnext-ba-guide)
2. [ERPNext Modules](#erpnext-modules)
3. [Business Processes](#business-processes)
4. [Implementation Examples](#implementation-examples)
5. [Quick Reference](#quick-reference)

## ERPNext BA Guide

**File**: `erpnext-ba-guide.md` (262 lines)

**Purpose**: Complete ERPNext feature catalog - what exists, which modules handle what

**Contents**:
- ERPNext module capabilities
- Standard DocTypes by business function
- Feature mapping (requirement → ERPNext solution)
- Configure-first approach
- Industry patterns

**When to Use**:
- Before designing ANY solution (check what exists first)
- Requirements analysis
- Gap analysis (Standard vs Custom)
- Client requirement mapping

## ERPNext Modules

**Location**: `erpnext-modules/`

### Module Coverage

| Module | File | Key Topics |
|--------|------|------------|
| **HR & Payroll** | `hr-payroll.md` | Employee management, attendance, leave, payroll processing, shifts |
| **Manufacturing** | `manufacturing.md` | BOM, work orders, production planning, job cards, workstations |
| **Stock & Inventory** | `stock-inventory.md` | Warehouses, stock entries, batch/serial, stock ledger, reorder levels |
| **Quality Management** | `quality-module.md` | Quality inspection, templates, procedures, reviews |

### When to Reference

**HR & Payroll** (`hr-payroll.md`):
- Employee lifecycle (hiring, transfers, exits)
- Attendance tracking (shifts, check-in/out, biometric)
- Leave management (allocation, applications, encashment)
- Payroll (salary structure, processing, deductions, taxes)
- Loan management

**Manufacturing** (`manufacturing.md`):
- Production planning (material requirements, capacity)
- BOM management (multi-level, variants)
- Work order execution (job cards, operations)
- Workstation planning and capacity
- Subcontracting

**Stock & Inventory** (`stock-inventory.md`):
- Warehouse management (bins, locations)
- Stock movements (entries, transfers, reconciliation)
- Batch/serial number tracking
- Reorder automation
- Valuation methods (FIFO, Moving Average)

**Quality Management** (`quality-module.md`):
- Inspection planning (goals, templates)
- In-process quality checks
- Final product inspection
- Non-conformance handling

## Business Processes

**Location**: `business-processes/`

| File | Description | Coverage |
|------|-------------|----------|
| **common-patterns.md** | Standard workflow patterns | Approval flows, state transitions, role-based routing |

**Common Patterns Include**:
- Multi-level approvals
- State machines (Draft → Pending → Approved)
- Role-based workflows
- Email notifications
- Escalation handling

## Implementation Examples

**File**: `employee-advance-return-amount.md`

Real-world customization pattern showing:
- Business requirement
- ERPNext standard approach
- Configuration steps
- Custom field additions
- Workflow design

**Use Case**: Employee advance repayment tracking

## Quick Reference

### Solution Design Process

**Step 1**: Check ERPNext First
- Read `erpnext-ba-guide.md`
- Identify matching module
- Find standard DocTypes

**Step 2**: Identify Gaps
- What ERPNext has (Standard)
- What needs configuration (Custom Fields, Workflows)
- What needs custom development (Scripts, Custom App)

**Step 3**: Apply 4-Tier Framework
- Tier 1: Use standard ERPNext
- Tier 2: Configure (fields, workflows, permissions)
- Tier 3: Light customization (scripts, reports)
- Tier 4: Custom app (last resort)

### Module Selection Guide

| Business Need | ERPNext Module | Key DocTypes |
|---------------|----------------|--------------|
| Employee management | HR | Employee, Attendance, Leave Application |
| Production | Manufacturing | BOM, Work Order, Job Card |
| Inventory control | Stock | Item, Warehouse, Stock Entry |
| Quality checks | Quality | Quality Inspection, Quality Goal |
| Sales | Selling | Sales Order, Quotation, Customer |
| Purchases | Buying | Purchase Order, Supplier, RFQ |
| Accounting | Accounts | Journal Entry, Payment Entry, GL Entry |
| Projects | Projects | Project, Task, Timesheet |
| Assets | Assets | Asset, Asset Movement, Maintenance |
| CRM | CRM | Lead, Opportunity, Campaign |

### Gap Analysis Template

**For each requirement**:

1. **Standard Feature**: Does ERPNext have this?
   - Check: `erpnext-ba-guide.md`
   - Check: Relevant module file

2. **Configuration Needed**: Can we extend standard?
   - Custom Fields?
   - Workflow?
   - Print Format?
   - Permissions?

3. **Customization Required**: Do we need code?
   - Server Script?
   - Client Script?
   - Script Report?
   - Custom App?

### Essential Reading Order

**For Requirements Analysis**:
1. `erpnext-ba-guide.md` - What exists
2. Relevant `erpnext-modules/*.md` - Module deep-dive
3. `business-processes/common-patterns.md` - Workflow patterns

**For Solution Design**:
1. `erpnext-ba-guide.md` - Standard capabilities
2. `development/frappe-framework/4-tier-framework.md` - Design philosophy
3. Module-specific file for implementation details

**For Implementation Planning**:
1. Module file for standard features
2. `employee-advance-return-amount.md` for customization pattern
3. `business-processes/common-patterns.md` for workflow design
