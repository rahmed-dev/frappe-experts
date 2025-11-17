# Script Report Best Practices

## Core Rules
1. **ALWAYS filter and process data in Python (.py file), NEVER in JavaScript (.js file)**
2. **Minimalist Code: Only include code essential for functionality. No decorative styling, emojis, or unnecessary CSS.**

## Why Server-Side Filtering?
- No timing/race conditions
- Respects database permissions
- Better performance (database does the filtering)
- Cleaner code (5 lines Python vs 120 lines JavaScript)
- No need to reload entire report to change filters

## Filter Definition
Define filters in JSON, not in JavaScript:
```json
{
  "filters": [
    {
      "fieldname": "show_completed",
      "fieldtype": "Check",
      "label": "Show Completed",
      "default": "0"
    }
  ]
}
```

Then use in Python:
```python
def execute(filters=None):
    task_filters = {}
    if not filters.get("show_completed"):
        task_filters["status"] = ["!=", "Completed"]

    data = frappe.get_all("Task", filters=task_filters)
    return columns, data
```

## Data Fetching Efficiency
```python
# Fetch only needed fields
tasks = frappe.get_all(
    "Task",
    filters=filters,
    fields=["name", "subject", "status"],  # Don't fetch all fields
    order_by="exp_start_date asc"
)

# Use SQL for complex queries with joins
data = frappe.db.sql("""
    SELECT t.name, t.subject, p.project_name
    FROM `tabTask` t
    LEFT JOIN `tabProject` p ON t.project = p.name
    WHERE t.status = %(status)s
""", {"status": status}, as_dict=True)
```

## Column Definitions
```python
def get_columns():
    return [
        {
            "label": "Task",
            "fieldname": "task",
            "fieldtype": "Link",      # Creates clickable link
            "options": "Task",
            "width": 200
        },
        {
            "label": "Progress",
            "fieldname": "progress",
            "fieldtype": "Percent",    # Auto-formats as percentage
            "width": 100
        }
    ]
```

## JavaScript Usage (UI Only - Minimal)

**Do NOT include:**
- ❌ Custom CSS for colors/styling (use Frappe defaults)
- ❌ STATUS_COLORS mappings or color schemes
- ❌ Emojis in comments or UI
- ❌ Decorative badges with custom classes
- ❌ Large CSS blocks for "beautiful" styling

**DO include (only if needed):**
- ✅ Action buttons that call server methods
- ✅ Event handlers for interactions
- ✅ Dialogs for user input
- ✅ Minimal CSS only if essential for functionality

```javascript
frappe.query_reports["Report Name"] = {
    formatter: function(value, row, column, data, default_formatter) {
        value = default_formatter(value, row, column, data);

        // Add action buttons (minimal, no decorative styling)
        if (column.fieldname === "actions") {
            value = `<button class="btn btn-xs btn-primary"
                     data-task="${data.name}">Update</button>`;
        }

        return value;
    },

    onload: function(report) {
        // Event delegation for dynamic buttons
        $(document).on('click', '.btn-primary', function() {
            const taskId = $(this).data('task');
            showDialog(taskId, report);
        });
    }
};
```

## Common Patterns

### Interactive Buttons with Server Actions
```python
# In .py file
@frappe.whitelist()
def update_status(task_name, new_status):
    task = frappe.get_doc("Task", task_name)
    if not frappe.has_permission("Task", "write", task):
        frappe.throw("No permission")

    task.status = new_status
    task.save()
    return {"success": True}
```

```javascript
// In .js file
function showDialog(taskId, report) {
    let d = new frappe.ui.Dialog({
        title: 'Update Status',
        fields: [{
            fieldname: 'status',
            fieldtype: 'Select',
            options: ['Open', 'Working', 'Completed']
        }],
        primary_action(values) {
            frappe.call({
                method: 'app.report.report_name.update_status',
                args: {task_name: taskId, new_status: values.status},
                callback: (r) => {
                    if (r.message.success) {
                        report.refresh();
                    }
                }
            });
            d.hide();
        }
    });
    d.show();
}
```

## Common Mistakes to Avoid
1. ❌ Filtering data in JavaScript: `report.data = report.data.filter(...)`
2. ❌ Forgetting to reload JSON: Run `bench --site [site] reload-doc` after editing JSON
3. ❌ N+1 query problem: Fetch related data with joins, not in loop
4. ❌ Fetching all fields: Specify only needed fields
5. ❌ Not checking permissions before server actions

## Performance Tips
- Batch process large datasets (100 items per batch)
- Cache static data with `frappe.cache()`
- Require filters for reports with large data
- Use `pluck` for single field: `frappe.get_all(..., pluck="name")`

## Key Takeaways
- Server-side = data processing, filtering, business logic
- Client-side = formatting, buttons, dialogs, styling
- Define filters in JSON
- Check permissions before any write operation
- Use parameterized SQL queries (prevent SQL injection)
- Test with large datasets (500+ rows)
