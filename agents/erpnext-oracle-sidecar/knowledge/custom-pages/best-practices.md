# Custom Frappe Pages - Best Practices

## What is a Custom Frappe Page?

A **Custom Frappe Page** is a full-page UI component in Frappe that allows you to build completely custom interfaces while leveraging ERPNext's backend.

**Use Cases:**
- Custom dashboards (e.g., Shop Floor Dashboard)
- Specialized workflows (e.g., Quick entry interfaces)
- Data visualization pages
- Kiosk mode displays
- Mobile-first experiences

**NOT for:**
- Standard DocType forms (use Customize Form instead)
- Simple reports (use Script Report instead)
- Modifying existing pages (use Client Scripts instead)

---

## File Structure

```
my_app/
├── hooks.py                          # App configuration
└── my_app/
    └── page/
        └── my_custom_page/
            ├── my_custom_page.json   # Page definition
            ├── my_custom_page.js     # Client-side logic
            ├── my_custom_page.py     # Server-side controller (optional)
            └── my_custom_page.html   # Template (optional)
```

---

## Creating a Custom Page

### Method 1: Using bench CLI (Recommended)

```bash
bench new-page "My Custom Page"
```

This creates:
- `my_app/my_app/page/my_custom_page/`
- All necessary files with boilerplate code

### Method 2: Manual Creation

**Step 1: Create directory**
```bash
mkdir -p my_app/my_app/page/my_custom_page
```

**Step 2: Create JSON file (`my_custom_page.json`)**
```json
{
 "content": null,
 "creation": "2025-11-09 14:00:00",
 "docstatus": 0,
 "doctype": "Page",
 "idx": 0,
 "modified": "2025-11-09 14:00:00",
 "modified_by": "Administrator",
 "module": "My App",
 "name": "my-custom-page",
 "owner": "Administrator",
 "page_name": "My Custom Page",
 "roles": [
  {
   "role": "System Manager"
  }
 ],
 "standard": "Yes",
 "system_page": 0,
 "title": "My Custom Page"
}
```

**Step 3: Create JS file (`my_custom_page.js`)**
```javascript
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

class MyCustomPage {
    constructor(page) {
        this.page = page;
        this.setup();
    }

    setup() {
        this.setup_toolbar();
        this.setup_ui();
        this.load_data();
    }

    setup_toolbar() {
        // Add buttons to page toolbar
        this.page.add_inner_button(__('Refresh'), () => {
            this.load_data();
        });
    }

    setup_ui() {
        // Create main container
        this.$container = $('<div class="custom-page-container">').appendTo(this.page.main);
    }

    load_data() {
        // Fetch data from server
        frappe.call({
            method: 'my_app.my_app.page.my_custom_page.get_data',
            callback: (r) => {
                if (r.message) {
                    this.render(r.message);
                }
            }
        });
    }

    render(data) {
        // Render UI with data
        this.$container.html(`<div>${data}</div>`);
    }
}
```

**Step 4: Create Python file (`my_custom_page.py` - optional)**
```python
import frappe


@frappe.whitelist()
def get_data():
    """Get data for custom page"""
    if not frappe.has_permission('DocType', 'read'):
        frappe.throw('No permission')

    data = frappe.get_all('DocType', fields=['name', 'field'])
    return data


def get_context(context):
    """Page context - runs when page loads"""
    context.no_cache = 1

    # Check permissions
    if not frappe.has_permission('DocType', 'read'):
        frappe.throw('You need required role to access this page')

    return context
```

**Step 5: Create CSS file (`public/css/my_page.css`)**
```css
/**
 * My Custom Page Styles
 * IMPORTANT: All styles scoped to .page-my-custom-page
 */

.page-my-custom-page .custom-page-container {
    padding: 20px;
    max-width: 1400px;
    margin: 0 auto;
}

.page-my-custom-page .card {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
}
```

**Step 6: Run migrations**
```bash
bench --site site-name migrate
bench build --app my_app
bench --site site-name clear-cache
bench restart
```

---

## Page Configuration (JSON)

### Essential Fields

```json
{
 "name": "my-custom-page",           // URL slug (/app/my-custom-page)
 "page_name": "My Custom Page",      // Internal identifier
 "title": "My Custom Page",          // Display name
 "module": "My App",                 // Module assignment
 "standard": "Yes",                  // Standard page (yes for custom apps)
 "system_page": 0,                   // Not a system page
 "roles": [                          // Access control
  {"role": "System Manager"},
  {"role": "Manufacturing User"}
 ]
}
```

### Access Control

**Add roles to restrict access:**
```json
"roles": [
  {"role": "Manufacturing User"},
  {"role": "Quality Manager"},
  {"role": "Production Manager"}
]
```

**Check in Python:**
```python
def get_context(context):
    if not frappe.has_permission('Job Card', 'read'):
        frappe.throw('Access denied')
```

---

## Common Page Patterns

### Pattern 1: Dashboard with Summary Cards

```javascript
class DashboardPage {
    setup_ui() {
        this.$summary = $('<div class="summary-cards">').appendTo(this.page.main);
        this.$content = $('<div class="content-area">').appendTo(this.page.main);

        this.load_summary();
        this.load_content();
    }

    load_summary() {
        frappe.call({
            method: 'my_app.api.get_summary',
            callback: (r) => {
                this.render_summary(r.message);
            }
        });
    }

    render_summary(data) {
        this.$summary.html('');
        data.forEach(item => {
            const card = $(`
                <div class="summary-card">
                    <h4>${item.title}</h4>
                    <div class="value">${item.count}</div>
                </div>
            `);
            this.$summary.append(card);
        });
    }
}
```

### Pattern 2: Tree View with Actions

```javascript
class TreePage {
    setup_tree() {
        this.tree = new frappe.ui.Tree({
            parent: $(this.page.main),
            label: __('Items'),
            method: 'my_app.api.get_tree_nodes',
            on_click: (node) => {
                if (!node.expandable) {
                    this.show_action_dialog(node.data.value);
                }
            }
        });
    }

    show_action_dialog(item_name) {
        let d = new frappe.ui.Dialog({
            title: __('Action: {0}', [item_name]),
            fields: [
                {fieldname: 'action', fieldtype: 'Select', options: 'Action 1\nAction 2'}
            ],
            primary_action: (values) => {
                this.perform_action(item_name, values.action);
                d.hide();
            }
        });
        d.show();
    }
}
```

### Pattern 3: List View with Filters

```javascript
class ListPage {
    setup_filters() {
        this.page.add_field({
            fieldname: 'status',
            label: __('Status'),
            fieldtype: 'Select',
            options: ['All', 'Open', 'Closed'],
            default: 'All',
            change: () => {
                this.load_data();
            }
        });

        this.page.add_field({
            fieldname: 'from_date',
            label: __('From Date'),
            fieldtype: 'Date',
            change: () => {
                this.load_data();
            }
        });
    }

    load_data() {
        const filters = {
            status: this.page.fields_dict.status.get_value(),
            from_date: this.page.fields_dict.from_date.get_value()
        };

        frappe.call({
            method: 'my_app.api.get_filtered_data',
            args: { filters: filters },
            callback: (r) => {
                this.render_list(r.message);
            }
        });
    }
}
```

---

## Page Toolbar (Action Buttons)

### Primary Actions

```javascript
// Single button
this.page.set_primary_action(__('Create New'), () => {
    this.create_new();
});

// Button with icon
this.page.set_primary_action(__('Create New'), () => {
    this.create_new();
}, 'add');
```

### Inner Buttons (Grouped)

```javascript
// Add to default group
this.page.add_inner_button(__('Refresh'), () => {
    this.load_data();
});

// Add to custom group
this.page.add_inner_button(__('Export CSV'), () => {
    this.export_csv();
}, __('Actions'));

this.page.add_inner_button(__('Export PDF'), () => {
    this.export_pdf();
}, __('Actions'));
```

### Menu Items

```javascript
this.page.add_menu_item(__('Settings'), () => {
    this.open_settings();
});

this.page.add_menu_item(__('Help'), () => {
    frappe.help.show_video('my-page-help');
});
```

---

## Frappe UI Components

### 1. frappe.ui.Tree

```javascript
this.tree = new frappe.ui.Tree({
    parent: $(this.page.main),
    label: __('Work Orders'),
    method: 'my_app.api.get_tree_nodes',  // Server method
    args: {filters: {}},                   // Optional args
    toolbar: [
        {
            label: __('Expand All'),
            click: () => {
                this.tree.load_children(this.tree.root_node, true);
            }
        }
    ],
    on_click: (node) => {
        console.log('Clicked:', node.data);
    },
    on_render: (node) => {
        // Customize node rendering
        $(node.$tree_link).css('color', node.data.color);
    }
});
```

### 2. frappe.ui.Dialog

```javascript
let d = new frappe.ui.Dialog({
    title: __('Enter Details'),
    size: 'large',  // small, large, extra-large
    fields: [
        {fieldname: 'name', fieldtype: 'Data', reqd: 1},
        {fieldname: 'qty', fieldtype: 'Int', default: 1}
    ],
    primary_action_label: __('Submit'),
    primary_action: (values) => {
        // Prevent duplicates
        d.get_primary_btn().prop('disabled', true);

        frappe.call({
            method: 'my_app.api.process',
            args: values,
            callback: (r) => {
                if (r.message.success) {
                    d.hide();
                    this.refresh();
                }
            },
            error: () => {
                d.get_primary_btn().prop('disabled', false);
            }
        });
    }
});
d.show();
```

### 3. frappe.ui.Toolbar

```javascript
this.toolbar = new frappe.ui.Toolbar({
    parent: this.$toolbar_wrapper,
    items: [
        {
            label: __('Export'),
            action: () => { this.export_data(); }
        },
        {
            label: __('Import'),
            action: () => { this.import_data(); }
        }
    ]
});
```

### 4. frappe.ui.FieldGroup

```javascript
this.form = new frappe.ui.FieldGroup({
    parent: this.$form_wrapper,
    fields: [
        {fieldname: 'item', fieldtype: 'Link', options: 'Item'},
        {fieldname: 'qty', fieldtype: 'Int'}
    ]
});

this.form.make();

// Get values
let values = this.form.get_values();

// Set values
this.form.set_value('qty', 10);
```

---

## CSS Best Practices

### 1. Always Scope CSS

**❌ BAD:**
```css
.container { padding: 20px; }
.card { background: white; }
```

**✅ GOOD:**
```css
.page-my-custom-page .container { padding: 20px; }
.page-my-custom-page .card { background: white; }
```

### 2. Load CSS on Page Load

```javascript
frappe.pages['my-custom-page'].on_page_load = function(wrapper) {
    frappe.require('/assets/my_app/css/my_page.css');
    // ... rest of code
};
```

### 3. Mobile-First Responsive

```css
/* Base styles (mobile) */
.page-my-custom-page .container {
    padding: 15px;
}

/* Tablet and above */
@media (min-width: 768px) {
    .page-my-custom-page .container {
        padding: 20px;
    }
}

/* Desktop */
@media (min-width: 1200px) {
    .page-my-custom-page .container {
        padding: 30px;
        max-width: 1400px;
    }
}
```

---

## Server-Side Integration

### Whitelist Methods

```python
# my_custom_page.py

import frappe
from frappe import _


@frappe.whitelist()
def get_data(filters=None):
    """Get data for page"""
    # Permission check
    if not frappe.has_permission('DocType', 'read'):
        frappe.throw(_('No permission'), frappe.PermissionError)

    # Parse JSON if string
    if isinstance(filters, str):
        filters = frappe.parse_json(filters)

    # Query data
    data = frappe.get_all(
        'DocType',
        filters=filters,
        fields=['name', 'field1', 'field2']
    )

    return data


@frappe.whitelist()
def perform_action(name, action):
    """Perform action on document"""
    doc = frappe.get_doc('DocType', name)

    # Check permissions
    if not frappe.has_permission('DocType', 'write', doc):
        frappe.throw(_('No permission'))

    # Perform action
    if action == 'approve':
        doc.status = 'Approved'
        doc.save()

    return {'success': True, 'message': _('Action completed')}
```

---

## Performance Optimization

### 1. Lazy Loading

```javascript
load_data() {
    // Show loading indicator
    this.page.set_indicator(__('Loading...'), 'orange');

    frappe.call({
        method: 'my_app.api.get_data',
        callback: (r) => {
            this.render(r.message);
            this.page.clear_indicator();
        }
    });
}
```

### 2. Debounced Search

```javascript
setup_search() {
    let timeout;
    this.page.add_field({
        fieldname: 'search',
        fieldtype: 'Data',
        placeholder: __('Search...'),
        change: () => {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                this.load_data();
            }, 300);  // 300ms debounce
        }
    });
}
```

### 3. Pagination

```javascript
load_data(page_num = 1, page_size = 20) {
    frappe.call({
        method: 'my_app.api.get_paginated_data',
        args: {
            page_num: page_num,
            page_size: page_size
        },
        callback: (r) => {
            this.render(r.message.data);
            this.render_pagination(r.message.total, page_num, page_size);
        }
    });
}
```

---

## Testing Custom Pages

### 1. Manual Testing Checklist

- [ ] Page loads without errors
- [ ] Toolbar buttons work
- [ ] Data loads correctly
- [ ] Filters apply properly
- [ ] Actions complete successfully
- [ ] Error messages display
- [ ] Responsive on mobile/tablet
- [ ] CSS doesn't affect other pages
- [ ] Permissions work correctly

### 2. Browser Console Testing

```javascript
// Test in browser console
frappe.pages['my-custom-page'].on_page_show(frappe.container.page);
```

### 3. Check Permissions

```python
# Test in bench console
bench --site site-name console

>>> import frappe
>>> frappe.set_user('user@example.com')
>>> frappe.has_permission('DocType', 'read')
```

---

## Common Mistakes

### ❌ 1. Using app_include_css

```python
# hooks.py - DON'T DO THIS
app_include_css = "/assets/my_app/css/page.css"  # Affects ALL pages!
```

### ❌ 2. Not Scoping CSS

```css
/* Affects all buttons everywhere */
.btn { min-height: 48px; }
```

### ❌ 3. Not Checking Permissions

```python
@frappe.whitelist()
def delete_all():
    frappe.db.delete('DocType')  # No permission check!
```

### ❌ 4. Client-Side Data Processing

```javascript
// BAD - Filter on client
data = data.filter(d => d.status === 'Open');

// GOOD - Filter on server
frappe.call({
    method: 'my_app.api.get_data',
    args: { status: 'Open' }
});
```

### ❌ 5. Not Disabling Submit Buttons

```javascript
// Allows duplicate submissions
primary_action: (values) => {
    frappe.call({ method: 'my_app.api.save', args: values });
}

// GOOD
primary_action: (values) => {
    d.get_primary_btn().prop('disabled', true);
    frappe.call({
        method: 'my_app.api.save',
        args: values,
        error: () => { d.get_primary_btn().prop('disabled', false); }
    });
}
```

---

## Key Rules

- ✅ ALWAYS scope CSS to `.page-{name}`
- ✅ ALWAYS load CSS with `frappe.require()` on page load
- ✅ NEVER use `app_include_css` for page-specific styles
- ✅ ALWAYS check permissions before data operations
- ✅ ALWAYS use Frappe UI components (Tree, Dialog, FieldGroup)
- ✅ ALWAYS disable submit buttons to prevent duplicates
- ✅ ALWAYS add error handlers to `frappe.call()`
- ✅ ALWAYS do data filtering/processing on server
- ✅ Test on mobile/tablet devices
- ✅ Use responsive CSS breakpoints

---

**See also:**
- [Client Scripting Best Practices](../client-scripting/best-practices.md)
- [Server Scripting Best Practices](../server-scripting/best-practices.md)
