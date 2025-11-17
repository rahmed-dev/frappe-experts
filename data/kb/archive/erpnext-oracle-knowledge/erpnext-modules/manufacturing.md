# ERPNext Manufacturing Module - Business Analyst Reference

## Overview

The Manufacturing module in ERPNext provides integrated tools for optimizing production processes. It is designed to streamline and optimize the production process with capabilities spanning planning through execution and quality assurance.

## Core DocTypes

### 1. Bill of Materials (BOM)
**Purpose**: Defines the recipe for manufacturing a finished good

**Key Fields**:
- Item (finished good)
- Quantity
- Raw Materials/Items table (child table)
- Operations table (routing)
- With Operations checkbox
- Is Active, Is Default checkboxes

**Business Use Cases**:
- Single-level BOMs (simple assembly)
- Multi-level BOMs (sub-assemblies)
- Template BOMs (variants)
- Costing calculation
- Material planning

**Standard Feature**: ✅ ERPNext has comprehensive BOM management

### 2. Work Order
**Purpose**: Production order for manufacturing items

**Key Fields**:
- Production Item
- BOM No
- Qty to Manufacture
- Planned Start Date
- Expected Delivery Date
- Source Warehouse
- Target Warehouse
- Required Items table
- Operations table (if using routing)

**Status Flow**: Draft → Not Started → In Process → Completed → Stopped

**Business Use Cases**:
- Make-to-Order production
- Make-to-Stock production
- Material consumption tracking
- Progress tracking
- Backflush material consumption

**Standard Feature**: ✅ ERPNext has complete work order management

### 3. Job Card
**Purpose**: Tracks time and progress for individual operations

**Key Fields**:
- Work Order reference
- Operation
- Workstation
- Time Logs table (start/end time tracking)
- Completed Qty
- Employee assignment

**Business Use Cases**:
- Shop floor time tracking
- Operation-wise progress
- Employee productivity
- Workstation utilization
- Quality inspection trigger

**Standard Feature**: ✅ ERPNext has job card functionality

### 4. Production Plan
**Purpose**: Master production scheduling document

**Key Fields**:
- Company
- From/To Date
- Get Sales Orders button
- Material Requests table
- Production Plan Items table
- Download Materials Required button

**Business Use Cases**:
- MRP (Material Requirements Planning)
- Batch production planning
- Material forecasting
- Purchase requisition generation
- Automatic Work Order creation

**Standard Feature**: ✅ ERPNext has production planning

### 5. Workstation
**Purpose**: Defines production resources/locations

**Key Fields**:
- Workstation Name
- Production Capacity (units per hour)
- Hour Rate (costing)
- Working Hours table
- Holiday List

**Business Use Cases**:
- Capacity planning
- Operation costing
- Scheduling
- Resource allocation

**Standard Feature**: ✅ ERPNext has workstation management

### 6. Operation
**Purpose**: Defines production steps/processes

**Key Fields**:
- Operation name
- Default Workstation
- Description

**Business Use Cases**:
- Routing definition
- Standard operations library
- Costing calculation

**Standard Feature**: ✅ ERPNext has operation management

### 7. Downtime Entry
**Purpose**: Records production downtime

**Key Fields**:
- Workstation
- Machine
- From/To Time
- Downtime Reason
- Remarks

**Business Use Cases**:
- Downtime tracking
- Efficiency analysis
- Maintenance planning

**Standard Feature**: ✅ ERPNext has downtime tracking

## Workflows & Business Processes

### Process 1: Make-to-Order Flow
1. Sales Order created
2. Production Plan created from Sales Order
3. Work Orders generated from Production Plan
4. Material Request created for shortages
5. Purchase Orders created
6. Materials received
7. Work Order started
8. Job Cards completed
9. Finished goods transferred to warehouse
10. Delivery Note created against Sales Order

**Configuration**: Standard ERPNext flow

### Process 2: Make-to-Stock Flow
1. Forecast/Reorder levels trigger Production Plan
2. Work Orders created
3. Materials issued
4. Production completed
5. Stock updated

**Configuration**: Standard ERPNext flow

### Process 3: Subcontracting Flow
1. BOM created with "Is Sub Contracted" items
2. Purchase Order created for subcontracting
3. Stock Entry transfers materials to subcontractor
4. Subcontractor processes
5. Purchase Receipt receives finished goods
6. Materials are backflushed

**Standard Feature**: ✅ ERPNext has subcontracting

## Configuration Options (No Custom Code)

### Manufacturing Settings
- **Capacity Planning**: Enable/disable
- **Default Warehouses**: Source, Target, WIP
- **Material Transfer for Manufacture**: Auto vs Manual
- **Backflush Raw Materials**: Based on BOM vs Based on Material Transfer
- **Over Production Allowance**: Percentage
- **Time Between Operations**: Minutes
- **Update BOM Cost Automatically**: Yes/No

### Module Activation
Settings → Module Settings → Manufacturing (checked)

## Integration Points

### Stock Module
- Material Request creation
- Stock Entries for material transfer
- Warehouse management
- Batch/Serial number tracking

### Buying Module
- Purchase Request from Production Plan
- Subcontracting Purchase Orders

### Selling Module
- Sales Order → Production Plan link
- Delivery Note after production

### Quality Module
- Quality Inspection for raw materials
- Quality Inspection for finished goods
- Job Card → Quality Inspection trigger

### Project Module
- Project-based manufacturing
- Work Order → Project link

## Common Customization Needs

### Tier 1: Standard ERPNext (Use As-Is)
- ✅ BOM management
- ✅ Work Order processing
- ✅ Job Card tracking
- ✅ Production Planning
- ✅ Material consumption
- ✅ Subcontracting

### Tier 2: Configuration (Custom Fields/Workflow)
- ⚙️ Additional BOM fields (e.g., Revision Number, Engineering Drawing)
- ⚙️ Custom Work Order fields (e.g., Priority, Shift)
- ⚙️ Approval workflows for Production Plans
- ⚙️ Custom Job Card fields (e.g., Defect Tracking)

### Tier 3: Light Customization (Scripts/Reports)
- 🔨 Custom production reports (e.g., OEE, Shop Floor Control Board)
- 🔨 Client scripts for auto-calculation
- 🔨 Server scripts for validation logic

### Tier 4: Custom App (Only if Needed)
- 🔨 Advanced scheduling algorithms (APS)
- 🔨 Custom shop floor UI
- 🔨 IoT/Machine integration
- 🔨 Advanced MES functionality

## Key Reports (Standard)

1. **Production Plan Summary**: Production plan status
2. **Work Order Summary**: Work order progress
3. **Job Card Summary**: Operation-wise tracking
4. **BOM Stock Report**: Material availability
5. **Production Analytics**: Efficiency metrics
6. **Downtime Analysis**: Downtime by reason
7. **Cost of Poor Quality Report**: Quality costs

## Best Practices for Business Analysts

1. **Check ERPNext First**: 90% of manufacturing needs are standard
2. **Configure Before Customize**: Use Custom Fields and Workflows
3. **Understand the Flow**: Sales Order → Production Plan → Work Order → Job Card
4. **Integration is Key**: Manufacturing touches Stock, Buying, Selling, Quality
5. **Capacity Planning**: Set up Workstations and Operations properly
6. **Costing**: Ensure BOMs are accurate for proper costing
7. **Subcontracting**: Use native subcontracting, don't build custom
8. **Reporting**: Standard reports cover most needs, use Query Reports for custom

## Technical Feasibility Notes

- **DocTypes**: All core doctypes are standard (no custom doctypes needed)
- **Workflows**: ERPNext has native workflow engine
- **Permissions**: Role-based permissions are configurable
- **API**: Full API access for external integrations
- **Mobile**: ERPNext is mobile-responsive
- **Offline**: Requires custom app for offline shop floor

## Solution Design Questions

When designing manufacturing solutions, ask:

1. **Make-to-Order or Make-to-Stock?**
2. **Multi-level BOMs needed?**
3. **Operation routing required?** (impacts job cards)
4. **Subcontracting involved?**
5. **Batch/Serial tracking for raw materials or finished goods?**
6. **Quality inspections at which stages?**
7. **Capacity planning needed?**
8. **Integration with external systems?** (MES, IoT, etc.)
9. **Custom reporting requirements?**
10. **Approval workflows needed?**

## Upgrade Safety

All standard manufacturing features are upgrade-safe. Custom Fields, Workflows, and Server Scripts are upgrade-safe. Avoid:
- ❌ Modifying core manufacturing doctypes
- ❌ Changing standard manufacturing workflows
- ❌ Overriding core manufacturing methods

---

**Remember**: ERPNext Manufacturing is comprehensive. Almost always configure first, customize second, build custom last.
