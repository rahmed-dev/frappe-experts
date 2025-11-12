# ERPNext HR & Payroll Module - Business Analyst Reference

## Overview

Comprehensive Human Resource Management covering employee lifecycle, attendance, leave, payroll, recruitment, training, and performance.

## Core DocTypes

### Employee Management

**Employee** - Central employee master
- Personal details, employment details, attendance device ID
- Department, Designation, Grade
- Standard Feature: ✅

**Employment Type** - Full-time, Part-time, Contract, etc.
**Branch** - Office locations
**Department** - Organizational units
**Designation** - Job titles

### Attendance & Shift Management

**Attendance** - Daily attendance records
- Employee, Attendance Date, Status (Present/Absent/Half Day/Work From Home)
- In/Out Time, Shift
- Standard Feature: ✅

**Shift Type** - Define working hours
- Start/End Time, Break times
- Holiday List
- Auto Attendance (biometric integration)
- Standard Feature: ✅

**Shift Assignment** - Assign shifts to employees
- Rotating shifts supported
- Standard Feature: ✅

### Leave Management

**Leave Type** - Annual Leave, Sick Leave, etc.
- Max days allowed
- Encashable, Carry Forward settings
- Standard Feature: ✅

**Leave Application** - Employee leave requests
- Approval workflow
- Leave balance calculation
- Standard Feature: ✅

**Leave Allocation** - Assign leave quota
- Standard Feature: ✅

**Compensatory Leave Request** - Extra leaves for overtime
- Standard Feature: ✅

### Payroll

**Salary Structure** - Define pay components
- Earnings (Basic, HRA, Allowances)
- Deductions (Tax, PF, etc.)
- Condition-based components
- Standard Feature: ✅

**Salary Structure Assignment** - Link employee to salary structure
- From Date, Base amount
- Standard Feature: ✅

**Salary Slip** - Monthly pay slip
- Earnings, Deductions, Net Pay
- Payment Days calculation
- Leave without pay impact
- Standard Feature: ✅

**Payroll Entry** - Bulk salary slip generation
- Month-wise processing
- Bank entry creation
- Standard Feature: ✅

**Additional Salary** - One-time payments/deductions
- Bonus, Incentive, Penalty
- Standard Feature: ✅

### Recruitment

**Job Opening** - Open positions
**Job Applicant** - Candidate applications
**Job Offer** - Offer letters
**Appointment Letter** - Joining documents
- Standard Feature: ✅ All recruitment doctypes

### Training & Appraisal

**Training Program** - Training courses
**Training Event** - Scheduled training sessions
**Training Result** - Attendance and scores
**Appraisal** - Performance reviews
- Standard Feature: ✅

### Claims & Expenses

**Expense Claim** - Employee expense reimbursement
- Receipt attachment
- Approval workflow
- Standard Feature: ✅

**Employee Advance** - Advance payments
- Recovery from salary
- Standard Feature: ✅

## Business Processes

### Process 1: Employee Onboarding
1. Job Opening → Job Applicant → Job Offer
2. Employee Offer Letter (optional)
3. Employee creation
4. Salary Structure Assignment
5. Leave Allocation
6. Shift Assignment (if applicable)

**Configuration**: Mostly standard, may add custom onboarding checklist

### Process 2: Attendance Processing
1. Attendance marked (manual/biometric/mobile)
2. Shift validation
3. Late entry/Early exit marking
4. Overtime calculation (via Additional Salary or custom)
5. Leave without pay calculation

**Configuration**: Standard with Shift Type configuration

### Process 3: Payroll Processing
1. Payroll Entry created for month
2. Salary Slips generated
3. Leave without pay auto-calculated
4. Additional Salaries included
5. Employee Advance recovery
6. Bank entries created
7. Payment processed

**Configuration**: Standard ERPNext flow

### Process 4: Leave Request Flow
1. Employee submits Leave Application
2. Approval workflow (Reporting Manager → HR)
3. Leave balance checked
4. Approved/Rejected
5. Attendance auto-marked if approved

**Configuration**: Workflow + Email Alerts

## Configuration Options

### HR Settings
- Retirement Age
- Standard Working Hours
- Encrypt Salary Slips (privacy)
- Email Salary Slip to Employee
- Leave Approval Notification
- Expense Approver

### Payroll Settings
- Include holidays in total working days
- Payroll based on Attendance
- Consider Unmarked Attendance As (Present/Absent)
- Fraction of Daily Salary for Half Day
- Max benefits amount
- Tax calculation method

## Common Customization Needs

### Tier 1: Standard (Use As-Is)
- ✅ Basic employee management
- ✅ Attendance tracking
- ✅ Leave management
- ✅ Simple payroll (fixed salary)
- ✅ Expense claims

### Tier 2: Configuration
- ⚙️ Custom salary components (allowances/deductions)
- ⚙️ Approval workflows (leave, expense, advance)
- ⚙️ Custom fields (employee ID format, additional personal data)
- ⚙️ Shift patterns (rotating shifts, split shifts)

### Tier 3: Light Customization
- 🔨 Attendance from biometric devices (Server Script/Integration)
- 🔨 Complex overtime calculation (Server Script)
- 🔨 Custom tax calculation (Server Script)
- 🔨 Payroll reports (Script Reports)
- 🔨 Employee self-service portal (Custom Page)

### Tier 4: Custom App
- 🔨 Advanced biometric integration
- 🔨 Mobile attendance app (if ERPNext mobile insufficient)
- 🔨 Complex incentive schemes
- 🔨 Advanced rostering/scheduling
- 🔨 Performance management system (if standard appraisal insufficient)

## Integration Points

- **Accounting**: Salary journal entries, expense claims
- **Projects**: Timesheet → Project costing
- **Manufacturing**: Shift → Job Card (employee assignment)

## Key Reports

1. **Monthly Attendance Sheet**: Employee-wise attendance
2. **Salary Register**: Payroll summary
3. **Bank Remittance Report**: Salary payment list
4. **Employee Leave Balance**: Leave balances
5. **Employee Information**: Master data report
6. **Recruitment Analytics**: Hiring funnel

## Best Practices

1. **Shift Management**: Use Shift Type + Shift Assignment, not custom
2. **Payroll**: Start simple, add complexity gradually
3. **Leave**: Configure Leave Types properly (encashment, carry forward)
4. **Attendance**: Prefer auto-attendance via biometric integration
5. **Approval Workflows**: Use ERPNext Workflow, not custom scripts
6. **Tax**: Use Additional Salary for variable components
7. **Reporting**: Standard reports cover 80% of needs

## Solution Design Questions

1. Fixed or variable salary structures?
2. Shift work involved? Rotating shifts?
3. Biometric integration needed?
4. Overtime calculation method?
5. Tax calculation (standard or complex)?
6. Leave encashment required?
7. Loan/Advance management needed?
8. Performance appraisal frequency?
9. Training management needed?
10. Employee self-service portal requirements?

---

**Remember**: ERPNext HR covers most standard HR needs. Configure shift types, salary structures, and workflows before building custom.
