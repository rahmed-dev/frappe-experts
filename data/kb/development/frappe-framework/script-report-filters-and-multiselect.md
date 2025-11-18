# Script Report Filters and MultiSelectList

## Key Learnings from Project Overview Report Enhancement

---

## 1. Filter Definition Location

**CRITICAL**: Script report filters MUST be defined in the **JavaScript file**, NOT the JSON file.

```javascript
// project_overview.js
frappe.query_reports["Project Overview"] = {
    filters: [
        // Define filters here
    ],
    // ... rest of report config
};
```

The JSON file (`project_overview.json`) is for report metadata only (name, module, roles, etc.), not for filter definitions.

---

## 2. MultiSelectList - The Correct Multi-Select Fieldtype

### Wrong Fieldtypes (Don't Use)
- `MultiSelect` - Works for forms, not reliable in report filters
- `MultiSelectLink` - Does NOT exist, causes "Invalid Control Name" error

### Correct Fieldtype
Use **`MultiSelectList`** with `get_data` function.

---

## 3. MultiSelectList Pattern (ERPNext Standard)

### For Static Options (like Status)

```javascript
{
    fieldname: 'status',
    label: __('Status'),
    fieldtype: 'MultiSelectList',
    width: '80',
    options: ['Open', 'Working', 'Pending Review', 'Completed', 'Cancelled'],
    get_data: function(txt) {
        let statuses = ['Open', 'Working', 'Pending Review', 'Completed', 'Cancelled'];
        let options = [];
        for (let status of statuses) {
            if (!txt || status.toLowerCase().includes(txt.toLowerCase())) {
                options.push({
                    value: status,
                    label: __(status),
                    description: ''
                });
            }
        }
        return options;
    }
}
```

### For Link-Based Options (like User)

```javascript
{
    fieldname: 'assigned_to',
    label: __('Assigned To'),
    fieldtype: 'MultiSelectList',
    width: '80',
    options: 'User',
    get_data: function(txt) {
        return frappe.db.get_link_options('User', txt);
    }
}
```

### Key Requirements

1. **Both `options` AND `get_data`** - Define both for proper behavior
2. **`get_data` returns objects** - Must return `{value, label, description}` format
3. **`width: '80'`** - Add width property for consistent sizing
4. **`frappe.db.get_link_options()`** - Use for DocType-based options

---

## 4. Python Handler for Multi-Select Filters

### Helper Function

```python
def parse_multi_select(value):
    """Parse multi-select filter value to list

    Handles both list and comma-separated string formats
    that Frappe may send depending on version/context.
    """
    if not value:
        return []
    if isinstance(value, list):
        return [v.strip() for v in value if v and str(v).strip()]
    if isinstance(value, str):
        return [v.strip() for v in value.split(',') if v.strip()]
    return []
```

### Usage in execute()

```python
def execute(filters=None):
    # Parse multi-select values
    status_values = parse_multi_select(filters.get("status"))
    assigned_to_values = parse_multi_select(filters.get("assigned_to"))

    # Apply to query
    if status_values:
        task_filters["status"] = ["in", status_values]

    if assigned_to_values:
        tasks = frappe.get_all("ToDo",
            filters={
                "reference_type": "Task",
                "allocated_to": ["in", assigned_to_values],
                "status": "Open"
            },
            pluck="reference_name"
        )
```

---

## 5. Assignment Handling via ToDo

Frappe uses the **ToDo** doctype for task assignments, not a direct field on Task.

### Fetching Assignments

```python
# Get all assignments for tasks
assignments = frappe.get_all(
    "ToDo",
    filters={
        "reference_type": "Task",
        "reference_name": ["in", task_names],
        "status": "Open"
    },
    fields=["reference_name", "allocated_to"]
)
```

### With User Full Names

```python
# Get full names for assigned users
assigned_users = list(set([a.allocated_to for a in assignments]))
user_names = {}
if assigned_users:
    users = frappe.get_all(
        "User",
        filters={"name": ["in", assigned_users]},
        fields=["name", "full_name"]
    )
    user_names = {u.name: u.full_name or u.name for u in users}

# Store as "email:full_name" format for client parsing
for assignment in assignments:
    email = assignment.allocated_to
    full_name = user_names.get(email, email)
    task_assignments[task_name].append(f"{email}:{full_name}")
```

### Assign/Unassign API

```python
# Assign
from frappe.desk.form.assign_to import add
add({
    "assign_to": [user],
    "doctype": "Task",
    "name": task_id,
    "description": "Assigned from Report"
})

# Unassign
from frappe.desk.form.assign_to import remove
remove("Task", task_id, user)
```

---

## 6. Client-Side Formatters

### Circular Avatar with Initials

```javascript
if (column.fieldname === "assigned_to" && data && data.assigned_to) {
    const userEntries = data.assigned_to.split(',').filter(u => u.trim());
    if (userEntries.length > 0) {
        const maxDisplay = 3;
        const displayEntries = userEntries.slice(0, maxDisplay);
        const overflow = userEntries.length - maxDisplay;

        let avatarsHtml = displayEntries.map(entry => {
            const [email, fullName] = entry.split(':');
            const displayName = fullName || email.split('@')[0];
            const initial = displayName.trim()[0].toUpperCase();
            return `<span style="display:inline-flex;align-items:center;justify-content:center;
                width:24px;height:24px;border-radius:50%;background:#d1d5db;color:#374151;
                font-size:11px;font-weight:500;margin-right:4px"
                title="${frappe.utils.escape_html(fullName || email)}">${initial}</span>`;
        }).join('');

        if (overflow > 0) {
            avatarsHtml += `<span style="...">+${overflow}</span>`;
        }

        value = `<div style="display:flex;align-items:center">${avatarsHtml}</div>`;
    }
}
```

### Color-Coded Pills (Priority/Status)

```javascript
if (column.fieldname === "priority" && data && data.priority) {
    const priority = data.priority.toLowerCase();
    let indicator_color = "gray";

    if (priority === "low") indicator_color = "blue";
    else if (priority === "medium") indicator_color = "orange";
    else if (priority === "high") indicator_color = "red";
    else if (priority === "urgent") indicator_color = "red";

    value = `<span class="indicator-pill ${indicator_color}">${data.priority}</span>`;
}
```

### CSS Progress Bar

```javascript
if (column.fieldname === "project_progress" && data && data.indent === 0) {
    const percent = data.project_progress;
    const color = percent < 50 ? '#ff5858' : percent < 80 ? '#ffb65c' : '#36d399';

    value = `
        <div style="display:flex;align-items:center;gap:8px">
            <div style="width:60px;height:8px;background:#e5e7eb;border-radius:4px;overflow:hidden">
                <div style="width:${percent}%;height:100%;background:${color}"></div>
            </div>
            <span style="font-size:12px;color:#6b7280">${percent}%</span>
        </div>
    `;
}
```

---

## 7. Project Progress from Doctype Field

Use Project's built-in `percent_complete` field instead of calculating from tasks:

```python
# Fetch projects with percent_complete
projects = frappe.get_all(
    "Project",
    fields=["name", "project_name", "percent_complete"],
    filters=project_filters
)

# Use directly
project_progress = round(p.percent_complete or 0)
```

---

## 8. Toolbar Button Visibility

Show/hide buttons based on selection:

```javascript
// Add buttons in onload
report.page.add_inner_button(__('Assign'), function() {
    showAssignDialog(report);
}, __('Assignment'));  // Group name

// Update visibility
function updateButtonVisibility() {
    const hasSelection = selectedTaskIds.size > 0;

    // Show/hide grouped dropdown
    report.page.inner_toolbar
        .find('.dropdown:has(.dropdown-menu .dropdown-item:contains("Assign"))')
        .toggle(hasSelection);
}
```

---

## 9. Batch Operations Best Practices

### Efficient Data Fetching

```python
# Collect all IDs first
all_task_names = []
for p in projects:
    tasks = frappe.get_all("Task", ...)
    all_task_names.extend([t.name for t in tasks])

# Single batch query for all assignments
if all_task_names:
    assignments = frappe.get_all("ToDo",
        filters={"reference_name": ["in", all_task_names]},
        fields=["reference_name", "allocated_to"]
    )
```

### Process in Batches

```python
# Process in batches of 10
for i in range(0, len(task_ids), 10):
    batch = task_ids[i:i+10]
    for task_id in batch:
        # Process each task
```

---

## 10. Common Pitfalls

| Issue | Solution |
|-------|----------|
| Filters not showing | Define in JS file, not JSON |
| "Invalid Control Name" error | Use `MultiSelectList`, not `MultiSelectLink` |
| Multi-select returns no data | Use `parse_multi_select()` and `["in", values]` |
| Progress not showing | Use Project's `percent_complete` field |
| Assignments not efficient | Batch fetch from ToDo, not per-task |

---

## References

- ERPNext Financial Statements: `/apps/erpnext/erpnext/public/js/financial_statements.js`
- ERPNext Purchase Order Analysis: `/apps/erpnext/erpnext/buying/report/purchase_order_analysis/purchase_order_analysis.js`
- Frappe Assign To API: `frappe.desk.form.assign_to`

---

*Document created: 2025-11-18*
*Source: Project Overview Report Enhancement Session*
