# ERPNext Stock & Inventory Module - Business Analyst Reference

## Overview

Comprehensive inventory management with warehouses, batch/serial tracking, valuation, and stock movements.

## Core DocTypes

### Item Master

**Item** - Product/material master
- Item Code, Item Name, Item Group
- Stock UOM, Maintain Stock checkbox
- Has Batch No, Has Serial No
- Valuation Method (FIFO/Moving Average)
- Default Warehouse, Reorder Level
- Standard Feature: ✅

**Item Group** - Product categories (Raw Material, Finished Goods, etc.)
**Item Variant** - Product variants (Size, Color, etc.)
**Item Price** - Price lists

### Warehouse Management

**Warehouse** - Storage locations
- Warehouse hierarchy supported
- Parent Warehouse for grouping
- Standard Feature: ✅

**Warehouse Type** - Transit, Manufacturing, Stores, etc.

### Stock Transactions

**Stock Entry** - Material movements
- Purpose: Material Issue, Material Receipt, Material Transfer, Manufacture, Repack, etc.
- Auto-created from Work Order, Purchase Receipt, Delivery Note
- Standard Feature: ✅

**Stock Reconciliation** - Physical stock adjustment
- Update actual quantities
- Valuation adjustment
- Standard Feature: ✅

**Material Request** - Purchase/transfer request
- Type: Purchase, Material Transfer, Material Issue, Manufacture
- Approval workflow
- Standard Feature: ✅

**Stock Reservation Entry** - Reserve stock for orders
- Work Order reservation
- Sales Order reservation
- Standard Feature: ✅ (Recent addition)

### Batch & Serial Tracking

**Batch** - Lot/batch number tracking
- Batch ID, Manufacturing Date, Expiry Date
- Batch-wise inventory
- Standard Feature: ✅

**Serial No** - Individual item tracking
- Warranty tracking
- AMC tracking
- Standard Feature: ✅

### Valuation & Ledger

**Stock Ledger Entry** - Immutable stock transaction log
- Auto-generated, read-only
- Qty, Valuation Rate, Stock Value
- Standard Feature: ✅

**Landed Cost Voucher** - Allocate additional costs to items
- Freight, Customs, Insurance
- Standard Feature: ✅

## Business Processes

### Process 1: Stock Receipt (Purchase)
1. Purchase Receipt created
2. Stock Ledger Entry auto-created
3. Item valuation updated (FIFO/Moving Avg)
4. Warehouse balance updated
5. General Ledger entry (Stock-in-Hand Dr, Stock Received Cr)

### Process 2: Stock Issue (Sales/Manufacturing)
1. Delivery Note or Stock Entry (Material Issue)
2. Stock Ledger Entry auto-created
3. Warehouse balance reduced
4. Valuation calculated (FIFO/Moving Avg)

### Process 3: Stock Transfer
1. Stock Entry (Material Transfer)
2. From Warehouse reduced
3. To Warehouse increased
4. In-transit warehouse (optional)

### Process 4: Physical Stock Count
1. Stock Reconciliation created
2. Enter actual quantities
3. System compares with current stock
4. Difference auto-adjusted
5. Valuation adjusted if needed

## Configuration Options

### Stock Settings
- Item Naming By (Item Code/Naming Series)
- Default Valuation Method (FIFO/Moving Average)
- Allow Negative Stock (Yes/No)
- Auto Insert Price List Rate (Yes/No)
- Automatically Set Serial Nos Based On FIFO
- Sample Retention Warehouse (for Quality)

### Reorder Settings
- Auto Material Request creation
- Reorder level per warehouse
- Lead time consideration

## Common Customization Needs

### Tier 1: Standard (Use As-Is)
- ✅ Multi-warehouse management
- ✅ Batch tracking
- ✅ Serial number tracking
- ✅ FIFO/Moving Average valuation
- ✅ Stock transfers
- ✅ Reorder level alerts
- ✅ Stock reconciliation

### Tier 2: Configuration
- ⚙️ Custom Item fields (e.g., Dimensions, Specifications)
- ⚙️ Approval workflows for Stock Entry
- ⚙️ Custom warehouse hierarchy
- ⚙️ Item-wise reorder levels

### Tier 3: Light Customization
- 🔨 Barcode scanning integration (Client Script)
- 🔨 Custom valuation logic (Server Script - rare)
- 🔨 Stock aging reports (Script Report)
- 🔨 Custom stock movement reports

### Tier 4: Custom App
- 🔨 WMS (Warehouse Management System) with bin locations
- 🔨 Advanced barcode/RFID integration
- 🔨 Pick/Pack/Ship workflow (if standard insufficient)

## Integration Points

- **Buying**: Purchase Receipt → Stock Entry
- **Selling**: Delivery Note → Stock Entry
- **Manufacturing**: Work Order → Stock Entry (material consumption)
- **Quality**: Quality Inspection → Stock acceptance/rejection
- **Accounting**: Stock Ledger → General Ledger (stock valuation)

## Key Reports

1. **Stock Balance**: Current stock levels
2. **Stock Ledger**: Transaction-wise movements
3. **Stock Ageing**: Inventory age analysis
4. **Item-wise Stock History**: Item movement history
5. **Batch-wise Balance History**: Batch tracking
6. **Serial No History**: Serial number tracking
7. **Stock Analytics**: ABC analysis, fast/slow moving

## Best Practices

1. **Valuation Method**: Choose wisely (FIFO for expiry, Moving Avg for commodities)
2. **Batch/Serial**: Enable only if needed (adds complexity)
3. **Warehouse Structure**: Keep simple, use hierarchy for grouping
4. **Negative Stock**: Avoid in production (use Material Request)
5. **Stock Reconciliation**: Regular physical counts
6. **Reorder Levels**: Set per warehouse, not globally
7. **Landed Costs**: Allocate freight/customs properly for accurate costing

## Solution Design Questions

1. Batch tracking required? (Pharma, Food)
2. Serial number tracking? (Electronics, Assets)
3. Valuation method preference?
4. Multiple warehouses? Warehouse hierarchy?
5. Reorder level management needed?
6. Consignment stock management?
7. Subcontracting inventory?
8. Landed cost allocation?
9. Stock reservation for orders?
10. Barcode/RFID integration?

---

**Remember**: ERPNext Stock is comprehensive. Standard features cover 90% of inventory needs. Batch/Serial are native - don't build custom tracking.
