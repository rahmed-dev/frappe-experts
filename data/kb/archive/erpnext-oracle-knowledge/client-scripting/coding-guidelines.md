# Client-Side JavaScript Guidelines

## Naming
- Variables/functions: `camelCase`
- Constants: `UPPER_SNAKE_CASE`
- Private helpers: `_leadingUnderscore`

## Style
- Use consistent indentation (2 or 4 spaces, pick one)
- Use consistent quotes (single or double, pick one)
- Always use semicolons

## Comments
- Add comment at start of each function explaining its purpose
- Use `// ===== Section Name =====` to group related functions
- Explain WHY in comments, not WHAT

## Report Structure
```javascript
frappe.query_reports["Report Name"] = {
    onload: function(report) {
        // Setup event handlers, buttons, styles
    },

    formatter: function(value, row, column, data, default_formatter) {
        value = default_formatter(value, row, column, data);
        // Apply custom formatting
        return value;
    }
};
```

## Event Handlers
- Always use event delegation: `$(document).on('click', '.selector', handler)`
- Never bind directly to elements that don't exist yet
- Use `e.stopPropagation()` when needed to prevent event bubbling

## Dialogs
- Always validate input before submitting
- Hide dialog after successful action
- Provide clear error messages

## Error Handling
- Always check if data exists before accessing properties
- Handle both `callback` and `error` in frappe.call()
- Show user-friendly error messages with frappe.msgprint()

## Performance
- Build HTML string once, insert once (not in loop)
- Cache jQuery selections: `const $element = $('#id')`
- Debounce search inputs (300ms delay)

## Security
- Always escape user input: `frappe.utils.escape_html()`
- Never use `eval()` or `Function()` constructor
- Validate input before sending to server

## Translation
- Wrap all user-facing strings in `__()`
- Example: `frappe.msgprint(__('Task updated successfully'))`

## Minimalist Code
- No emojis in code or UI
- No custom CSS for colors/aesthetics (use Frappe's defaults)
- No STATUS_COLORS mappings or decorative badges
- Only add CSS if essential for functionality
- Use Frappe's built-in classes: `btn-primary`, `indicator-green`, etc.
