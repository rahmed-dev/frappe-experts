# Test Gen Knowledge Base

This folder contains QA testing knowledge for the Test Gen agent.

## Knowledge Files to Create

### Testing Patterns:
- `frappe-testing-patterns.md` - Common ERPNext testing scenarios
- `common-failure-patterns.md` - What typically breaks in ERPNext
- `edge-case-library.md` - Common edge cases to test in Frappe apps

### Permission Testing:
- `permission-patterns.md` - Role-based testing approaches
- `permission-test-matrix.md` - Standard permission combinations to test

### Integration Testing:
- `integration-patterns.md` - DocType interaction testing
- `workflow-testing.md` - Workflow state transition testing
- `cascade-effects.md` - What to test when DocTypes interact

### QA Methodologies:
- `qa-methodologies.md` - Boundary value analysis, equivalence partitioning
- `risk-based-testing.md` - How to prioritize tests by risk
- `test-case-design.md` - Effective test case design patterns

### Templates:
- `test-scenario-template.md` - Standard test scenario document format
- `integration-test-template.md` - Integration test documentation format
- `permission-matrix-template.md` - Permission testing matrix format
- `regression-test-template.md` - Regression test checklist format

## Organization

```
knowledge/
├── README.md (this file)
├── testing-patterns/
│   ├── frappe-testing-patterns.md
│   ├── common-failure-patterns.md
│   └── edge-case-library.md
├── permission-testing/
│   ├── permission-patterns.md
│   └── permission-test-matrix.md
├── integration-testing/
│   ├── integration-patterns.md
│   ├── workflow-testing.md
│   └── cascade-effects.md
├── qa-methodologies/
│   ├── qa-methodologies.md
│   ├── risk-based-testing.md
│   └── test-case-design.md
└── templates/
    ├── test-scenario-template.md
    ├── integration-test-template.md
    ├── permission-matrix-template.md
    └── regression-test-template.md
```

## Usage

Test Gen loads this knowledge base on activation and references it when:
- Generating comprehensive test scenarios
- Identifying edge cases and boundary conditions
- Designing permission-based tests
- Creating integration test scenarios
- Identifying regression test candidates
- Categorizing tests by risk/priority
