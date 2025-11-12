# Frappe SA Knowledge Base

This folder contains technical knowledge for the Frappe Solution Architect agent.

## Knowledge Files to Add

### From Oracle's Sidecar (to be migrated):
- `frappe-framework/configure-first-approach.md` - **CRITICAL!** 4-tier framework
- Technical Frappe guides (DocType design, hooks, scripts)
- Server/client scripting best practices
- Custom pages best practices
- Reports best practices
- ERPNext technical architecture patterns

### New Knowledge to Create:
- `technical-design-templates.md` - Format for Technical Specification Documents
- `migration-patterns.md` - Common legacy → ERPNext data mapping strategies
- `performance-patterns.md` - Indexing strategies, query optimization, background jobs
- `api-design-patterns.md` - REST endpoint structures, authentication, rate limiting
- `ux-ui-component-library.md` - Frappe UI components reference and usage patterns

## Organization

```
knowledge/
├── README.md (this file)
├── frappe-framework/
│   ├── configure-first-approach.md (CRITICAL!)
│   ├── doctype-design.md
│   ├── hooks-guide.md
│   └── server-scripts.md
├── best-practices/
│   ├── server-scripting.md
│   ├── client-scripting.md
│   ├── custom-pages.md
│   └── reports.md
├── ux-ui/
│   ├── component-library.md
│   ├── form-layout-patterns.md
│   └── dashboard-patterns.md
├── architecture/
│   ├── migration-patterns.md
│   ├── performance-patterns.md
│   └── api-design-patterns.md
└── templates/
    └── technical-spec-template.md
```

## Usage

Frappe SA loads this knowledge base on activation and references it when:
- Applying 4-tier framework
- Designing DocTypes and workflows
- Designing UX/UI with Frappe components
- Planning migrations
- Optimizing performance
- Designing APIs
