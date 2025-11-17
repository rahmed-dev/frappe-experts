# ERPNext Quality Module - Business Analyst Reference

## Overview

Quality management for inspections, goals, procedures, reviews, and feedback.

## Core DocTypes

### Quality Inspection

**Quality Inspection** - Inspection records
- Reference DocType (Purchase Receipt, Stock Entry, Delivery Note, Job Card)
- Reference Name
- Item Code
- Sample Size
- Inspected By
- Inspection Type (Incoming/Outgoing/In Process)
- Status (Accepted/Rejected)
- Readings table (parameters, target values, actual values)
- Standard Feature: ✅

**Quality Inspection Template** - Inspection parameters
- Reading parameters with acceptance criteria
- Linked to Item
- Standard Feature: ✅

**Quality Inspection Parameter** - Master list of parameters
- Parameter Name (e.g., Weight, Dimension, Color)
- Standard Feature: ✅

### Quality Management System

**Quality Goal** - Objectives and KPIs
- Goal title, Target, Monitoring
- Standard Feature: ✅

**Quality Procedure** - SOPs and processes
- Procedure documentation
- Processes
- Standard Feature: ✅

**Quality Review** - Periodic reviews
- Reviews against goals
- Standard Feature: ✅

**Quality Feedback** - Customer/supplier feedback
- Feedback template
- Rating
- Standard Feature: ✅

**Quality Action** - Corrective/Preventive actions
- Action type (Corrective/Preventive)
- Resolution details
- Standard Feature: ✅

## Business Processes

### Process 1: Incoming Quality Inspection (Purchase)
1. Purchase Receipt created (not submitted)
2. Quality Inspection created (linked to Purchase Receipt)
3. Inspector fills readings
4. Status: Accepted or Rejected
5. If Accepted: Purchase Receipt submitted
6. If Rejected: Stock not received, Return created

**Configuration**: Inspection Required Before Purchase (Item master)

### Process 2: In-Process Quality Inspection (Manufacturing)
1. Job Card created
2. Quality Inspection created (linked to Job Card)
3. Inspector fills readings
4. Status determines Job Card continuation
5. If Rejected: Rework or Scrap

**Configuration**: Inspection Required Before Delivery (Item master)

### Process 3: Outgoing Quality Inspection (Sales)
1. Delivery Note created (not submitted)
2. Quality Inspection created
3. Inspector fills readings
4. Status: Accepted or Rejected
5. If Accepted: Delivery Note submitted
6. If Rejected: Delivery stopped

**Configuration**: Inspection Required Before Delivery (Item master)

### Process 4: Quality Goal Monitoring
1. Quality Goal defined (e.g., Defect Rate < 2%)
2. Periodic measurement
3. Quality Review conducted
4. Quality Actions for deviations

## Configuration Options

### Quality Settings
- Default Inspection Type
- Link Quality Inspection to Work Order
- Inspection Required checkboxes (Item master level)

### Item Configuration
- Inspection Required Before Purchase
- Inspection Required Before Delivery
- Quality Inspection Template (link)

## Common Customization Needs

### Tier 1: Standard (Use As-Is)
- ✅ Quality Inspection for Purchase/Sales/Manufacturing
- ✅ Inspection templates
- ✅ Acceptance/Rejection workflow
- ✅ Quality goals and reviews

### Tier 2: Configuration
- ⚙️ Custom inspection parameters
- ⚙️ Approval workflow for Quality Inspection
- ⚙️ Custom fields for additional quality data
- ⚙️ Auto-create Quality Inspection on Purchase Receipt

### Tier 3: Light Customization
- 🔨 Statistical Process Control (SPC) reports
- 🔨 Auto-calculation of inspection results (Server Script)
- 🔨 Integration with measuring devices (Client/Server Script)
- 🔨 Custom quality dashboards

### Tier 4: Custom App
- 🔨 Advanced SPC analysis
- 🔨 IoT integration for auto-inspection
- 🔨 Image-based quality inspection (AI/ML)
- 🔨 Full QMS with ISO compliance

## Integration Points

- **Stock**: Quality Inspection → Stock Entry (acceptance/rejection)
- **Buying**: Purchase Receipt → Quality Inspection
- **Selling**: Delivery Note → Quality Inspection
- **Manufacturing**: Job Card → Quality Inspection
- **Projects**: Quality Action → Project Task

## Key Reports

1. **Quality Inspection Summary**: Inspection status overview
2. **Item Quality Inspection Summary**: Item-wise quality metrics
3. **Supplier-wise Quality Inspection**: Supplier quality tracking

## Best Practices

1. **Templates**: Create Quality Inspection Templates for each item category
2. **Mandatory Inspection**: Enable at Item level, not globally
3. **Parameters**: Use Quality Inspection Parameter master for consistency
4. **Acceptance Criteria**: Set min/max values in template
5. **Sample Size**: Define appropriate sample size in template
6. **Workflow**: Add approval workflow if multiple stakeholders
7. **Integration**: Link to Purchase/Sales/Manufacturing for automated flow
8. **Goals**: Set measurable Quality Goals with periodic reviews

## Solution Design Questions

1. Incoming inspection required?
2. In-process inspection required?
3. Outgoing inspection required?
4. Inspection parameters (dimensional, visual, functional)?
5. Sampling method (100%, statistical)?
6. Acceptance criteria definition?
7. Rejection handling (scrap, rework, return)?
8. Quality documentation (SOPs, Work Instructions)?
9. Supplier quality monitoring?
10. Quality metrics and KPIs?

---

**Remember**: ERPNext Quality covers standard inspection needs. Templates and parameters are configurable. Add custom SPC/AI only if standard inspection insufficient.
