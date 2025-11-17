# Custom Frappe Pages - Coding Guidelines

## Naming Conventions

### File Names
- Page directory: `snake_case` matching page name
- JavaScript: `my_custom_page.js`
- Python: `my_custom_page.py`
- CSS: `my_custom_page.css` or descriptive name
- JSON: `my_custom_page.json`

### JavaScript
- Classes: `PascalCase` (e.g., `ShopFloorDashboard`)
- Variables/Functions: `camelCase` (e.g., `loadData`, `setupToolbar`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `MAX_PAGE_SIZE`)
- Private methods: `_leadingUnderscore` (e.g., `_processData`)
- jQuery objects: `$prefixed` (e.g., `this.$container`)

### Python
- Functions: `snake_case` (e.g., `get_tree_nodes`)
- Constants: `UPPER_SNAKE_CASE` (e.g., `DEFAULT_PAGE_SIZE`)
- Private helpers: `_leading_underscore`

### CSS
- Classes: `kebab-case` (e.g., `.summary-card`, `.tree-wrapper`)
- ALWAYS prefix with page scope: `.page-my-custom-page .class-name`

---

## File Organization

### JavaScript Class Structure

```javascript
/**
 * MyCustomPage class
 * Description of what this page does
 */
class MyCustomPage {
    constructor(page) {
        this.page = page;
        this.data = null;
        this.$container = null;

        this.setup();
    }

    // ==================== SETUP ====================

    setup() {
        this.setup_toolbar();
        this.setup_filters();
        this.setup_ui();
        this.load_data();
    }

    setup_toolbar() {
        // Toolbar buttons
    }

    setup_filters() {
        // Page filters
    }

    setup_ui() {
        // UI components
    }

    // ==================== DATA LOADING ====================

    load_data() {
        // Fetch data from server
    }

    refresh() {
        // Refresh page data
    }

    // ==================== RENDERING ====================

    render(data) {
        // Render UI with data
    }

    render_summary(summary) {
        // Render summary section
    }

    // ==================== USER ACTIONS ====================

    show_dialog(item) {
        // Show dialog for user action
    }

    perform_action(name, action) {
        // Perform action on item
    }

    // ==================== HELPER FUNCTIONS ====================

    _validate_input(values) {
        // Private validation helper
    }

    _format_data(data) {
        // Private formatting helper
    }
}
```

### Python Module Structure

```python
"""
my_custom_page.py
Description of what this module does
"""

import frappe
from frappe import _


# ==================== PAGE CONTEXT ====================

def get_context(context):
    """Page context - runs when page loads"""
    context.no_cache = 1

    if not frappe.has_permission('DocType', 'read'):
        frappe.throw(_('Access denied'))

    return context


# ==================== API METHODS ====================

@frappe.whitelist()
def get_data(filters=None):
    """
    Get data for page

    Args:
        filters (dict): Filter criteria

    Returns:
        list: Filtered data
    """
    if not frappe.has_permission('DocType', 'read'):
        frappe.throw(_('No permission'), frappe.PermissionError)

    filters = _parse_filters(filters)
    data = _fetch_data(filters)

    return data


@frappe.whitelist()
def perform_action(name, action):
    """
    Perform action on document

    Args:
        name (str): Document name
        action (str): Action to perform

    Returns:
        dict: {"success": bool, "message": str}
    """
    try:
        doc = frappe.get_doc('DocType', name)

        if not frappe.has_permission('DocType', 'write', doc):
            frappe.throw(_('No permission'))

        result = _process_action(doc, action)

        return {
            'success': True,
            'message': _('Action completed'),
            'data': result
        }

    except Exception as e:
        frappe.log_error(title='Action Error', message=str(e))
        return {
            'success': False,
            'message': str(e),
            'data': None
        }


# ==================== HELPER FUNCTIONS ====================

def _parse_filters(filters):
    """Parse and validate filters"""
    if isinstance(filters, str):
        filters = frappe.parse_json(filters)
    return filters or {}


def _fetch_data(filters):
    """Fetch data from database"""
    return frappe.get_all(
        'DocType',
        filters=filters,
        fields=['name', 'field1', 'field2']
    )


def _process_action(doc, action):
    """Process action on document"""
    if action == 'approve':
        doc.status = 'Approved'
    elif action == 'reject':
        doc.status = 'Rejected'

    doc.save()
    return doc.as_dict()
```

---

## Code Style

### JavaScript

#### Indentation
- Use **tabs** (Frappe standard)
- Consistent tab width (4 spaces equivalent)

#### Semicolons
- Always use semicolons at end of statements

#### Quotes
- Use **single quotes** for strings
- Use **double quotes** only for HTML attributes

```javascript
// GOOD
let name = 'John';
let html = `<div class="card">${name}</div>`;

// BAD
let name = "John";  // Use single quotes
```

#### Braces
- Always use braces, even for single-line blocks

```javascript
// GOOD
if (condition) {
    doSomething();
}

// BAD
if (condition) doSomething();
```

#### Comments
- Use `//` for single-line comments
- Use `/** ... */` for multi-line documentation
- Use `// ==================== SECTION ====================` for section headers

```javascript
/**
 * Load data from server
 *
 * @param {Object} filters - Filter criteria
 * @returns {Promise} - Promise resolving to data
 */
load_data(filters) {
    // Show loading indicator
    this.page.set_indicator(__('Loading...'), 'orange');

    return frappe.call({
        method: 'my_app.api.get_data',
        args: { filters: filters }
    });
}
```

### Python

#### Indentation
- Use **4 spaces** (never tabs)

#### Line Length
- Maximum **100 characters**
- Break long lines appropriately

```python
# GOOD
data = frappe.get_all(
    'DocType',
    filters={'status': 'Open'},
    fields=['name', 'field1', 'field2']
)

# BAD - too long
data = frappe.get_all('DocType', filters={'status': 'Open'}, fields=['name', 'field1', 'field2', 'field3', 'field4'])
```

#### Imports
- Standard library first
- Third-party libraries second
- Frappe imports third
- Local imports last
- Alphabetical within groups

```python
import json
from datetime import datetime

import requests

import frappe
from frappe import _

from my_app.utils import helper_function
```

#### Docstrings
- Use Google-style docstrings
- Include Args, Returns, Raises

```python
def get_filtered_data(filters, page_size=20):
    """
    Get filtered data with pagination

    Args:
        filters (dict): Filter criteria
        page_size (int): Number of records per page

    Returns:
        dict: {
            "data": list of records,
            "total": total count
        }

    Raises:
        PermissionError: If user lacks read permission
    """
    pass
```

---

## Error Handling

### JavaScript

```javascript
// ALWAYS add error handler to frappe.call()
frappe.call({
    method: 'my_app.api.method',
    args: { param: value },
    callback: function(r) {
        if (r.message && r.message.success) {
            frappe.show_alert(__('Success'));
        } else {
            frappe.msgprint({
                title: __('Warning'),
                message: r.message?.message || __('Operation failed'),
                indicator: 'orange'
            });
        }
    },
    error: function(r) {
        console.error('API Error:', r);
        frappe.msgprint({
            title: __('Error'),
            message: __('An error occurred'),
            indicator: 'red'
        });
    }
});
```

### Python

```python
@frappe.whitelist()
def process_data(name):
    """Process data with proper error handling"""
    try:
        # Validate input
        if not name:
            frappe.throw(_('Name is required'))

        # Check permissions
        doc = frappe.get_doc('DocType', name)
        if not frappe.has_permission('DocType', 'write', doc):
            frappe.throw(_('No permission'), frappe.PermissionError)

        # Process
        result = _process(doc)

        return {
            'success': True,
            'data': result
        }

    except frappe.DoesNotExistError:
        frappe.log_error(title='Not Found', message=f'Document {name} not found')
        return {
            'success': False,
            'message': _('Document not found')
        }

    except Exception as e:
        frappe.log_error(title='Processing Error', message=frappe.get_traceback())
        return {
            'success': False,
            'message': str(e)
        }
```

---

## Performance Best Practices

### 1. Minimize DOM Manipulation

```javascript
// BAD - Multiple DOM operations
data.forEach(item => {
    this.$container.append(`<div>${item.name}</div>`);
});

// GOOD - Build HTML, then insert once
let html = '';
data.forEach(item => {
    html += `<div>${item.name}</div>`;
});
this.$container.html(html);

// BETTER - Use DocumentFragment for large lists
let fragment = document.createDocumentFragment();
data.forEach(item => {
    let div = document.createElement('div');
    div.textContent = item.name;
    fragment.appendChild(div);
});
this.$container[0].innerHTML = '';
this.$container[0].appendChild(fragment);
```

### 2. Debounce User Input

```javascript
setup_search() {
    let timeout;
    this.$search.on('input', () => {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            this.load_data();
        }, 300);  // 300ms debounce
    });
}
```

### 3. Use Efficient Queries

```python
# BAD - N+1 query problem
items = frappe.get_all('Item', fields=['name'])
for item in items:
    supplier = frappe.db.get_value('Item', item.name, 'default_supplier')

# GOOD - Fetch all at once
items = frappe.get_all(
    'Item',
    fields=['name', 'default_supplier']
)
```

### 4. Pagination for Large Datasets

```python
@frappe.whitelist()
def get_paginated_data(page_num=1, page_size=20):
    """Get paginated data"""
    page_num = int(page_num)
    page_size = int(page_size)

    # Get total count
    total = frappe.db.count('DocType', filters={})

    # Get page data
    data = frappe.get_all(
        'DocType',
        filters={},
        fields=['name', 'field'],
        start=(page_num - 1) * page_size,
        page_length=page_size
    )

    return {
        'data': data,
        'total': total,
        'page_num': page_num,
        'page_size': page_size
    }
```

---

## Testing Guidelines

### Manual Testing Checklist

```javascript
// Add to page for testing
this.page.add_menu_item(__('Run Tests'), () => {
    this.run_tests();
});

run_tests() {
    console.log('=== Running Page Tests ===');

    // Test 1: Data loading
    console.log('Test 1: Load data');
    this.load_data();

    // Test 2: Filters
    console.log('Test 2: Apply filters');
    // ... test code

    // Test 3: Actions
    console.log('Test 3: Perform action');
    // ... test code

    console.log('=== Tests Complete ===');
}
```

### Console Testing

```javascript
// Test in browser console
let page = new MyCustomPage(cur_page);
page.load_data();
```

---

## Security Guidelines

### 1. Always Validate Permissions

```python
@frappe.whitelist()
def delete_item(name):
    # ❌ BAD - No permission check
    frappe.delete_doc('Item', name)

    # ✅ GOOD
    doc = frappe.get_doc('Item', name)
    if not frappe.has_permission('Item', 'delete', doc):
        frappe.throw(_('No permission'), frappe.PermissionError)
    frappe.delete_doc('Item', name)
```

### 2. Escape User Input

```javascript
// ❌ BAD - XSS vulnerability
this.$container.html(`<div>${user_input}</div>`);

// ✅ GOOD - Escape HTML
this.$container.html(`<div>${frappe.utils.escape_html(user_input)}</div>`);

// ✅ BETTER - Use textContent
let div = document.createElement('div');
div.textContent = user_input;
this.$container.html(div);
```

### 3. Validate Input

```python
@frappe.whitelist()
def process(qty, price):
    # ✅ GOOD - Type validation
    qty = int(qty) if qty else 0
    price = flt(price)

    # ✅ GOOD - Range validation
    if qty <= 0 or qty > 10000:
        frappe.throw(_('Invalid quantity'))

    if price < 0:
        frappe.throw(_('Invalid price'))
```

---

## Documentation Standards

### File Header Comments

```javascript
/**
 * shop_floor_dashboard.js
 *
 * Custom page for shop floor management
 * Provides simplified interface for job card completion
 *
 * Features:
 * - Tree view of Work Orders and Job Cards
 * - Quick entry dialog for completion
 * - Department summary cards
 * - Mobile-responsive design
 *
 * Author: Your Name
 * Date: 2025-11-09
 */
```

### Function Documentation

```javascript
/**
 * Load data from server with filters
 *
 * @param {Object} filters - Filter criteria
 * @param {string} filters.status - Status filter
 * @param {string} filters.department - Department filter
 * @returns {Promise} Promise resolving when data is loaded
 */
load_data(filters = {}) {
    // Implementation
}
```

```python
def get_summary_data(filters=None):
    """
    Get summary statistics for dashboard

    Args:
        filters (dict, optional): Filter criteria. Defaults to None.
            - status (str): Filter by status
            - department (str): Filter by department
            - from_date (str): Start date (YYYY-MM-DD)
            - to_date (str): End date (YYYY-MM-DD)

    Returns:
        list: Summary data grouped by department
            [{"department": str, "open": int, "completed": int}]

    Raises:
        PermissionError: If user lacks read permission

    Example:
        >>> get_summary_data({'status': 'Open'})
        [{"department": "Assembly", "open": 10, "completed": 5}]
    """
    pass
```

---

## Key Rules Summary

### JavaScript
- Use tabs for indentation
- Always use semicolons
- Single quotes for strings
- camelCase for variables/functions
- PascalCase for classes
- $ prefix for jQuery objects
- Always add error handlers to frappe.call()
- Disable submit buttons to prevent duplicates

### Python
- 4 spaces for indentation
- 100 character line length
- snake_case for functions/variables
- UPPER_SNAKE_CASE for constants
- Google-style docstrings
- Always check permissions
- Return structured: `{"success": bool, "data": any, "message": str}`
- Log errors with frappe.log_error()

### CSS
- kebab-case for class names
- ALWAYS scope to `.page-{name}`
- Mobile-first responsive design
- No decorative/unnecessary styles

### General
- DRY (Don't Repeat Yourself)
- Single Responsibility Principle
- Clear, descriptive naming
- Comment complex logic
- Test on multiple devices
- Follow Frappe conventions
