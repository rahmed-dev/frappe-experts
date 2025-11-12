# ERPNext BA Knowledge Base

This folder contains domain-specific knowledge for the ERPNext Business Analyst agent.

## Knowledge Files to Add

### From Oracle's Sidecar (to be migrated):
- `erpnext-ba-guide.md` - ERPNext modules and features (CRITICAL!)
- `erpnext-modules/` folder - Manufacturing, HR, Stock, Quality documentation
- `business-processes/common-patterns.md` - Industry patterns

### New Knowledge to Create:
- `requirements-structuring-templates.md` - Format for Business Requirements Documents
- `question-frameworks.md` - What to ask clients in discovery
- `industry-requirements-patterns.md` - Common asks by industry

## Organization

```
knowledge/
├── README.md (this file)
├── erpnext-modules/
│   ├── manufacturing.md
│   ├── hr.md
│   ├── stock.md
│   ├── quality.md
│   ├── accounts.md
│   └── selling.md
├── business-processes/
│   └── common-patterns.md
├── requirements-templates/
│   ├── brd-template.md
│   └── requirement-item-template.md
└── discovery-frameworks/
    └── question-library.md
```

## Usage

ERPNext BA loads this knowledge base on activation and references it when:
- Mapping business needs to ERPNext modules
- Identifying standard vs custom features
- Structuring requirements documents
- Asking discovery questions
