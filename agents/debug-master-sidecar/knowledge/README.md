# Debug Master Knowledge Base

This folder contains debugging knowledge for the Debug Master agent.

## Knowledge Files to Create

### Error Patterns:
- `frappe-error-patterns.md` - Common Frappe errors and solutions
- `python-exception-types.md` - Python exception types and meanings
- `common-bugs.md` - Known Frappe/ERPNext bugs and workarounds

### Traceback Analysis:
- `python-traceback-guide.md` - How to read Python stack traces
- `traceback-interpretation.md` - Interpreting Frappe-specific tracebacks

### Database Errors:
- `database-errors.md` - MySQL/MariaDB/PostgreSQL error codes
- `deadlock-patterns.md` - Database deadlock scenarios
- `query-errors.md` - Common SQL query errors

### Server Errors:
- `permission-errors.md` - Frappe permission system issues
- `api-errors.md` - REST API errors and authentication issues
- `javascript-errors.md` - Client-side error patterns
- `workflow-errors.md` - Workflow state transition issues

### Debugging Tools:
- `log-file-locations.md` - Where to find logs in Frappe
- `debugging-techniques.md` - Systematic debugging approaches

### Templates:
- `diagnostic-report-template.md` - Standard diagnostic report format
- `quick-analysis-template.md` - Quick error analysis format
- `production-incident-template.md` - Production incident report format

## Organization

```
knowledge/
├── README.md (this file)
├── error-patterns/
│   ├── frappe-error-patterns.md
│   ├── python-exception-types.md
│   └── common-bugs.md
├── traceback-analysis/
│   ├── python-traceback-guide.md
│   └── traceback-interpretation.md
├── database-errors/
│   ├── database-errors.md
│   ├── deadlock-patterns.md
│   └── query-errors.md
├── server-errors/
│   ├── permission-errors.md
│   ├── api-errors.md
│   ├── javascript-errors.md
│   └── workflow-errors.md
├── debugging-tools/
│   ├── log-file-locations.md
│   └── debugging-techniques.md
└── templates/
    ├── diagnostic-report-template.md
    ├── quick-analysis-template.md
    └── production-incident-template.md
```

## Usage

Debug Master loads this knowledge base on activation and references it when:
- Analyzing error logs
- Interpreting Python tracebacks
- Identifying common error patterns
- Diagnosing root causes
- Suggesting fixes based on known issues
- Providing preventive measures
