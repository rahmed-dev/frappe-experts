---
last-redoc-date: 2025-11-17
---

# Frappe Experts Agents

Expert agents for Frappe/ERPNext development covering full SDLC from requirements to production support.

## Table of Contents

1. [Agent Roster](#agent-roster)
2. [Invocation](#invocation)
3. [Agent Workflow](#agent-workflow)

## Agent Roster

| Agent | Role | Primary Focus | Key Workflows |
|-------|------|---------------|---------------|
| **ERPNext BA** 🔮 | Business Analyst | Requirements → BRD | create-brd, review-requirements |
| **Frappe SA** 📐 | Solution Architect | BRD → Technical Spec (4-tier + UX) | create-tsd, design-system |
| **Phase Master** 📊 | Implementation Planner | TSD → Phased Plan (dependency sequencing) | create-implementation-plan |
| **Frappe Nexus** 🎯 | Developer | Specs → Code (execution specialist) | develop-story, validate-code |
| **Debug Master** 🔍 | Debugger | Error diagnosis & root cause | diagnose-error, debug |
| **Test Gen** 🧪 | QA Specialist | Test scenario generation | generate-test-scenarios |
| **Quick Guide** 📘 | Doc Writer | Anti-fluff end-user guides | create-user-guide |

## Invocation

**Via BMAD Command**:
```
/bmad:frappe-experts:agents:{agent-name}
```

**Examples**:
- `/bmad:frappe-experts:agents:erpnext-ba`
- `/bmad:frappe-experts:agents:frappe-nexus`

## Agent Workflow

**Requirements Phase**:
1. **ERPNext BA** - Convert messy notes → BRD with ERPNext mapping

**Design Phase**:
2. **Frappe SA** - BRD → Technical Spec (4-tier framework, UX design)
3. **Phase Master** - TSD → Implementation Plan (UI config vs code separation)

**Development Phase**:
4. **Frappe Nexus** - Execute implementation plan with tests

**Quality Phase**:
5. **Test Gen** - Generate test scenarios (happy/edge/integration)
6. **Frappe Nexus** - Validate code against best practices

**Support Phase**:
7. **Debug Master** - Diagnose errors, root cause analysis
8. **Quick Guide** - Create end-user documentation

## Agent Characteristics

**All agents are Expert-type** with sidecar resources:
- `{agent-name}-sidecar/instructions.md` - Operational directives
- `{agent-name}-sidecar/memories.md` - Persistent context
- `{agent-name}-sidecar/knowledge/` - Domain knowledge base

**Communication**:
- All agents use `{communication_language}` from config
- Menu-driven interaction (numbered + asterisk commands)
- Non-standalone workflows (invoked via agent menus)
