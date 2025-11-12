# Phase Master Knowledge Base

This folder contains implementation planning knowledge for the Phase Master agent.

## Knowledge Files to Create

### Dependency Patterns:
- `frappe-dependency-patterns.md` - Common DocType dependency patterns in Frappe
- `doctype-relationships.md` - Link fields, child tables, table multiselect dependencies

### Sequencing Patterns:
- `implementation-sequences.md` - Proven sequencing patterns for typical Frappe projects
- `mvp-patterns.md` - Common Phase 1 scopes that deliver useful systems

### Critical Path Analysis:
- `critical-path-examples.md` - Case studies of dependency resolution
- `blocking-dependencies.md` - Common blocking dependencies in ERPNext projects

### Parallel Work:
- `parallel-work-patterns.md` - Features that can typically be built simultaneously
- `team-allocation-strategies.md` - How to split work across multiple developers

## Organization

```
knowledge/
├── README.md (this file)
├── dependencies/
│   ├── frappe-dependency-patterns.md
│   ├── doctype-relationships.md
│   └── common-blockers.md
├── sequencing/
│   ├── implementation-sequences.md
│   ├── mvp-patterns.md
│   └── phase-breakdown-examples.md
├── critical-path/
│   ├── critical-path-examples.md
│   └── dependency-resolution-strategies.md
└── parallel-work/
    ├── parallel-work-patterns.md
    └── team-strategies.md
```

## Usage

Phase Master loads this knowledge base on activation and references it when:
- Analyzing dependencies between features
- Identifying critical path (must-build-first)
- Creating phased implementation plans
- Identifying parallel work opportunities
- Suggesting optimal sequencing
- Planning for contingencies
