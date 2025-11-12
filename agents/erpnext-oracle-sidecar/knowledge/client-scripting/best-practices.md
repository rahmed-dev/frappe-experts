# Client-Side JavaScript Best Practices

## Core Rules

1. Client-side for UI ONLY - never filter/process data
2. Minimalist - no emojis, no decorative CSS
3. Always add error handler to frappe.call()
4. Disable submit buttons to prevent duplicates

---

## frappe.call() Pattern

```javascript
frappe.call({
    method: 'app.api.method',
    args: {param: value},
    freeze: true,
    freeze_message: __('Processing...'),
    callback: function(r) {
        console.log('Response:', r);
        if (r.message && r.message.success) {
            frappe.msgprint(__('Success'));
            frm.reload_doc();
        }
    },
    error: function(r) {
        console.error('Error:', r);
        frappe.msgprint({
            title: __('Error'),
            message: r.message || __('Failed'),
            indicator: 'red'
        });
    }
});
```

---

## Dialog with Duplicate Prevention

```javascript
let d = new frappe.ui.Dialog({
    title: __('Title'),
    fields: [{
        fieldname: 'field',
        fieldtype: 'Data',
        reqd: 1
    }],
    primary_action_label: __('Submit'),
    primary_action(values) {
        // Disable button immediately
        d.get_primary_btn().prop('disabled', true);

        frappe.call({
            method: 'app.method',
            args: values,
            callback: function(r) {
                if (r.message.success) {
                    d.hide();
                    frm.reload_doc();
                }
            },
            error: function(r) {
                // Re-enable on error for retry
                d.get_primary_btn().prop('disabled', false);
                frappe.msgprint(__('Error'));
            }
        });
    }
});
d.show();
```

---

## Dialog with Dynamic Fields (Show/Hide Based on Conditions)

**CRITICAL: Always use Frappe native field components, NOT custom HTML/CSS**

```javascript
let d = new frappe.ui.Dialog({
    title: __('Create Schedule'),
    size: 'large',
    fields: [
        {
            fieldname: 'section_break_1',
            fieldtype: 'Section Break',
            label: __('Settings')
        },
        {
            fieldname: 'apply_to_all',
            fieldtype: 'Check',
            label: __('Apply to all'),
            default: 1
        },
        {
            fieldname: 'column_break_1',
            fieldtype: 'Column Break'
        },
        {
            fieldname: 'calculation_method',
            fieldtype: 'Select',
            label: __('Calculation Method'),
            options: 'By Number of Installments\nBy Monthly Amount',
            default: 'By Number of Installments',
            onchange: function() {
                // Show/hide fields based on selection
                let method = d.get_value('calculation_method');
                if (method === 'By Number of Installments') {
                    d.set_df_property('number_of_installments', 'hidden', 0);
                    d.set_df_property('monthly_amount', 'hidden', 1);
                } else {
                    d.set_df_property('number_of_installments', 'hidden', 1);
                    d.set_df_property('monthly_amount', 'hidden', 0);
                }
            }
        },
        {
            fieldname: 'column_break_2',
            fieldtype: 'Column Break'
        },
        {
            fieldname: 'number_of_installments',
            fieldtype: 'Int',
            label: __('Number of Installments'),
            default: 12
        },
        {
            fieldname: 'monthly_amount',
            fieldtype: 'Currency',
            label: __('Monthly Amount'),
            hidden: 1  // Hidden by default
        },
        {
            fieldname: 'section_break_2',
            fieldtype: 'Section Break',
            label: __('Details')
        },
        {
            fieldname: 'html_area',
            fieldtype: 'HTML',
            options: '<div id="custom_table">...</div>'
        }
    ],
    primary_action_label: __('Submit'),
    primary_action(values) {
        console.log('Form values:', values);
        // Process submission
    }
});

d.show();

// Setup field change handlers after dialog shows
d.fields_dict.apply_to_all.$input.on('change', function() {
    console.log('Checkbox changed:', this.checked);
});

d.fields_dict.calculation_method.$input.on('change', function() {
    let method = d.get_value('calculation_method');
    console.log('Method changed:', method);
});
```

### Dialog Field Manipulation Methods

```javascript
// Get field value
let value = d.get_value('fieldname');

// Set field value
d.set_value('fieldname', 'new_value');

// Show/hide field
d.set_df_property('fieldname', 'hidden', 1);  // Hide
d.set_df_property('fieldname', 'hidden', 0);  // Show

// Enable/disable field
d.set_df_property('fieldname', 'read_only', 1);  // Disable
d.set_df_property('fieldname', 'read_only', 0);  // Enable

// Make field required/optional
d.set_df_property('fieldname', 'reqd', 1);  // Required
d.set_df_property('fieldname', 'reqd', 0);  // Optional

// Access field input element directly
d.fields_dict.fieldname.$input.on('change', function() {
    // Handle change
});

// Get all form values
let all_values = d.get_values();
```

### Layout with Section Break and Column Break

```javascript
fields: [
    {
        fieldname: 'section_1',
        fieldtype: 'Section Break',
        label: __('Section Title')
    },
    {
        fieldname: 'field_1',
        fieldtype: 'Data',
        label: __('Field 1')
    },
    {
        fieldname: 'column_break_1',
        fieldtype: 'Column Break'  // Start new column
    },
    {
        fieldname: 'field_2',
        fieldtype: 'Data',
        label: __('Field 2')
    },
    {
        fieldname: 'section_2',
        fieldtype: 'Section Break',  // Start new section
        label: __('Another Section')
    }
]
```

### Common Frappe Field Types

| Field Type | Use Case | Example |
|------------|----------|---------|
| `Data` | Short text input | Name, Code |
| `Text` | Multi-line text | Description |
| `Int` | Integer number | Quantity |
| `Float` | Decimal number | Rate |
| `Currency` | Money amount | Price, Amount |
| `Date` | Date picker | Start Date |
| `Datetime` | Date + time picker | Created At |
| `Select` | Dropdown (options with `\n`) | Status, Method |
| `Check` | Checkbox | Enabled, Apply All |
| `Link` | Link to DocType | Customer, Item |
| `Table` | Child table | Items, Schedules |
| `HTML` | Custom HTML area | Tables, Charts |
| `Section Break` | Start new section | - |
| `Column Break` | Start new column | - |

---

## Utilities

```javascript
// Currency formatting
let formatted = format_currency(amount);

// Get single field from Single DocType
frappe.db.get_single_value('Settings DocType', 'field_name')
    .then(value => {
        console.log(value);
    });

// Event delegation (for dynamic elements)
$(document).on('click', '.btn-action', function() {
    const id = $(this).data('id');
    performAction(id);
});
```

---

## What NOT to Do

❌ **No custom HTML/CSS for UI controls - Use Frappe components:**
```javascript
// BAD - Custom HTML checkbox with custom styling
let html = `
    <style>
        .my-checkbox { background: blue; padding: 10px; }
    </style>
    <div class="my-checkbox">
        <input type="checkbox" id="my_check"> Apply to all
    </div>
`;

// GOOD - Use Frappe Check field
fields: [{
    fieldname: 'apply_to_all',
    fieldtype: 'Check',
    label: __('Apply to all')
}]
```

❌ **No custom CSS for aesthetics:**
```javascript
// BAD
const STATUS_COLORS = {completed: "green", pending: "orange"};
```

❌ **No client-side filtering:**
```javascript
// BAD - Do on server instead
report.data = report.data.filter(d => d.status === "Open");
```

❌ **No decorative styling:**
```css
/* BAD */
.status-badge {
    border-radius: 9999px;
    letter-spacing: 0.2px;
}
```

❌ **Don't manipulate fields with jQuery when Frappe has methods:**
```javascript
// BAD
$('#fieldname').hide();

// GOOD
d.set_df_property('fieldname', 'hidden', 1);
```

✅ **Use Frappe defaults:**
```javascript
// GOOD
value = data.status;  // Frappe handles formatting
```

---

## CSS Scoping for Custom Pages (CRITICAL)

### ❌ CRITICAL MISTAKE: Global CSS Pollution

**NEVER do this in hooks.py:**
```python
# hooks.py
app_include_css = "/assets/my_app/css/my_page.css"  # ❌ BAD - affects entire ERPNext!
```

**Why this is dangerous:**
- Applies CSS to **every page** in ERPNext
- Breaks standard forms (oversized fields, wrong padding)
- Creates upgrade conflicts
- Violates Frappe isolation principles

---

### ✅ CORRECT: Page-Specific CSS Loading

**Method 1: Load CSS on Page Load (Recommended)**

```javascript
// my_page.js
frappe.pages['my-custom-page'].on_page_load = function(wrapper) {
    // Load page-specific CSS
    frappe.require('/assets/my_app/css/my_page.css');

    var page = frappe.ui.make_app_page({
        parent: wrapper,
        title: __('My Custom Page'),
        single_column: true
    });

    new MyCustomPage(page);
};
```

**Method 2: Scope ALL CSS Selectors**

```css
/* my_page.css */

/* ❌ BAD - affects all pages */
.container { padding: 20px; }
.card { background: white; }
.btn { min-height: 48px; }

/* ✅ GOOD - only affects my-custom-page */
.page-my-custom-page .container { padding: 20px; }
.page-my-custom-page .card { background: white; }
.page-my-custom-page .btn { min-height: 48px; }
```

**Method 3: Both (Defense in Depth)**

Combine page-level loading + scoped selectors for maximum safety:

```javascript
// my_page.js
frappe.require('/assets/my_app/css/my_page.css');  // Load only when needed
```

```css
/* my_page.css - all selectors scoped */
.page-my-custom-page .shop-floor-container { ... }
.page-my-custom-page .summary-cards { ... }
.page-my-custom-page .tree-wrapper { ... }

/* Even media queries should be scoped */
@media (max-width: 768px) {
    .page-my-custom-page .container { padding: 15px; }
}
```

---

### Page Class Names in Frappe

Frappe automatically adds class names to page wrappers:

| Page Route | Page Class |
|------------|------------|
| `/app/shop-floor-dashboard` | `.page-shop-floor-dashboard` |
| `/app/my-custom-page` | `.page-my-custom-page` |
| `/app/inventory-report` | `.page-inventory-report` |

**Use these for scoping!**

---

### Real-World Example: Shop Floor Dashboard

**File Structure:**
```
plant_floor_management/
├── hooks.py                          # ✅ NO app_include_css
└── plant_floor_management/
    ├── page/
    │   └── shop_floor_dashboard/
    │       ├── shop_floor_dashboard.js    # Loads CSS
    │       └── shop_floor_dashboard.py
    └── public/
        └── css/
            └── shop_floor.css             # All selectors scoped
```

**shop_floor_dashboard.js:**
```javascript
frappe.pages['shop-floor-dashboard'].on_page_load = function(wrapper) {
    // Load page-specific CSS
    frappe.require('/assets/plant_floor_management/css/shop_floor.css');

    var page = frappe.ui.make_app_page({
        parent: wrapper,
        title: __('Shop Floor Dashboard'),
        single_column: true
    });

    new ShopFloorDashboard(page);
};
```

**shop_floor.css:**
```css
/**
 * IMPORTANT: All styles scoped to .page-shop-floor-dashboard
 */

.page-shop-floor-dashboard .shop-floor-container {
    padding: 20px;
    max-width: 1400px;
}

.page-shop-floor-dashboard .summary-card {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
}

.page-shop-floor-dashboard .tree-wrapper {
    min-height: 400px;
}

/* Mobile styles also scoped */
@media (max-width: 768px) {
    .page-shop-floor-dashboard .shop-floor-container {
        padding: 15px;
    }
}
```

**hooks.py:**
```python
# ✅ CORRECT - No global CSS
# app_include_css is commented out or removed

# Only include if truly global (rare!)
# app_include_css = "/assets/plant_floor_management/css/global.css"
```

---

### Testing CSS Scoping

**Before deploying:**

1. **Test other pages:**
   - Open Job Card form
   - Open Work Order list
   - Check field sizes are normal
   - Verify buttons look standard

2. **Test your custom page:**
   - Navigate to your custom page
   - Verify custom styles apply
   - Check responsive breakpoints

3. **Hard refresh:**
   - `Ctrl+F5` (Windows/Linux)
   - `Cmd+Shift+R` (Mac)
   - Clear browser cache

4. **Rebuild after changes:**
```bash
bench build --app my_app
bench --site site-name clear-cache
bench restart
```

---

### When is Global CSS OK?

**Rarely! Only for:**
- Brand colors used everywhere
- Global typography adjustments
- Company logo positioning

**Example of acceptable global CSS:**
```css
/* global.css - OK because it's truly global */
:root {
    --primary-color: #1976d2;
    --company-logo-height: 40px;
}

.navbar-brand img {
    height: var(--company-logo-height);
}
```

**But even then, use Frappe's theming system instead!**

---

## Key Rules

- **CRITICAL: NEVER use `app_include_css` for page-specific styles**
- **ALWAYS scope CSS to page class** (`.page-my-custom-page`)
- **ALWAYS load page CSS with `frappe.require()`** in page JS
- **ALWAYS use Frappe native UI components** - Never create custom HTML/CSS for controls
- Use Frappe field types: Check, Select, Date, Int, Currency, etc.
- Use `d.set_df_property()` to show/hide/enable/disable fields
- Use `d.get_value()` and `d.set_value()` to read/write field values
- Use `console.log()` for debugging
- Wrap strings in `__()` for translation
- Always add error handler to `frappe.call()`
- Disable buttons during submission to prevent duplicates
- Never process/filter data client-side - do it on server
- No emojis, no decorative CSS
- Use Section Break and Column Break for layout
