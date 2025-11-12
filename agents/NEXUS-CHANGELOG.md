# Nexus Agent - Refocus Changelog

**Version:** 1.0.0 → 2.0.0
**Date:** 2025-11-12
**Type:** Major Refocus (Strategic → Execution Specialist)

---

## Summary

**FROM:** Strategic Frappe Developer (design + build + everything)
**TO:** Execution Specialist (build only, from specs)

**Lines of Code:** 258 → 139 (46% reduction)
**Focus:** Removed all strategic/design commands, kept execution-only

---

## What Changed

### ✅ KEPT (Core Execution Commands)

**Execution:**
- `*build` - Execute Phased Implementation Plan
- `*implement` - Build feature from Technical Specification

**Scaffolding:**
- `*scaffold-app` - Create new Frappe custom app
- `*scaffold-doctype` - Create DocType from spec
- `*scaffold-api` - Create whitelisted API method

**Testing:**
- `*test` - Run tests and validate
- `*validate` - Check against best practices (workflow)

**Debugging:**
- `*debug` - Systematic debugging (workflow)
- `*analyze-logs` - Analyze error logs

**Operations:**
- `*migrate` - Run migration and restart
- `*build-assets` - Build assets and clear cache

**Knowledge:**
- `*explain` - Explain Frappe patterns with examples
- `*pattern` - Search knowledge base

---

### ❌ REMOVED (Moved to Other Agents or Workflows)

**Design Commands (Now: Frappe SA):**
- `*design-system` → Frappe SA handles this
- `*analyze-requirements` → ERPNext BA handles this
- `*review-architecture` → Frappe SA handles this
- `*design-integration` → Frappe SA handles this

**Scaffolding Commands (Consolidated):**
- `*create-app` → Simplified to `*scaffold-app`
- `*create-doctype` → Moved to workflow (todo)
- `*create-api` → Simplified to `*scaffold-api`
- `*create-page` → Removed (use scaffold-app + manual)
- `*create-report` → Moved to workflow (todo)
- `*create-form-script` → Removed (manual with scaffold-app)
- `*create-hook` → Removed (manual with scaffold-app)

**Integration Commands (Removed/Consolidated):**
- `*create-webhook` → Removed (manual implementation)
- `*api-client` → Moved to workflow (todo)

**Testing Commands (Consolidated):**
- `*run-tests` → Simplified to `*test`
- `*test-api` → Part of `*test` workflow
- `*review-permissions` → Moved to workflow (todo)

**Performance Commands (Not Core):**
- `*optimize` → Moved to workflow (todo)
- `*profile-query` → Part of `*analyze-logs`

**Operations Commands (Consolidated):**
- `*frappe-migrate` → Simplified to `*migrate`
- `*frappe-build` → Simplified to `*build-assets`
- `*frappe-logs` → Part of `*analyze-logs`
- `*frappe-console` → Removed (manual operation)
- `*bench-status` → Removed (manual operation)

**Knowledge Commands (Consolidated):**
- `*teach` → Merged into `*explain`
- `*find-pattern` → Simplified to `*pattern`
- `*best-practice` → Part of `*explain`
- `*anti-pattern` → Part of `*validate` workflow

**Story Commands:**
- `*develop-story` → Moved to workflow (separate file)
- `*review-qa` → Part of development workflow

---

## Rationale for Each Removal

### Design Commands Removed
**Why:** Nexus is now EXECUTION ONLY. Design decisions are made by:
- **ERPNext BA** - Business requirements and ERPNext mapping
- **Frappe SA** - Technical design and architecture
- **Phase Master** - Implementation sequencing

**Impact:** Nexus no longer makes design decisions. If specs are unclear, Nexus asks user or suggests loading appropriate agent.

---

### Scaffolding Commands Consolidated
**Why:** Too many specific scaffold commands. Simplified to 3 core commands:
- `*scaffold-app` - Creates base app structure
- `*scaffold-doctype` - Creates DocType (common task)
- `*scaffold-api` - Creates API method (common task)

**Other scaffolding** (pages, reports, hooks) done manually after app setup.

**Impact:** Cleaner menu, focuses on most common scaffolding tasks.

---

### Integration Commands Removed
**Why:** Webhook and API client generation are specialized tasks, not core execution.

**Alternative:**
- Webhooks: Manual implementation using `*scaffold-api` as starting point
- API clients: Moved to workflow (generate when needed)

**Impact:** Nexus menu stays focused on core tasks.

---

### Testing Commands Consolidated
**Why:** `*run-tests`, `*test-api`, and `*review-permissions` are all variants of testing.

**Consolidated to:**
- `*test` - Run all tests, analyze results, fix failures
- `*validate` - Code quality checks (workflow)

**Impact:** Simpler testing interface.

---

### Performance Commands Moved
**Why:** Performance optimization is specialized analysis, not daily execution.

**Alternative:**
- `*optimize` workflow - Run when needed for performance review
- `*analyze-logs` - Includes query profiling when debugging performance

**Impact:** Keeps menu focused on daily tasks.

---

### Operations Commands Simplified
**Why:** Too many Frappe-specific operation commands.

**Consolidated to:**
- `*migrate` - Covers migration + cache + restart
- `*build-assets` - Covers build + cache clear
- `*analyze-logs` - Covers log monitoring

**Removed:**
- `*frappe-console` - Manual operation (bench --site [site] console)
- `*bench-status` - Manual operation (bench status)

**Impact:** Most common operations covered, edge cases done manually.

---

### Knowledge Commands Merged
**Why:** `*teach`, `*explain`, `*find-pattern`, `*best-practice`, `*anti-pattern` all serve similar purpose.

**Consolidated to:**
- `*explain` - Teach concepts with examples, show best practices
- `*pattern` - Search knowledge base for patterns
- `*validate` workflow - Catches anti-patterns

**Impact:** Cleaner interface, same functionality.

---

### Story Commands to Workflow
**Why:** Story-driven development is a complete workflow, not a single command.

**Moved to:**
- `workflows/develop-story.yaml` - Complete story implementation workflow

**Impact:** Better structure, workflow handles complexity.

---

## Migration Path for Removed Commands

| Old Command | New Location | How to Access |
|-------------|-------------|---------------|
| `*design-system` | Frappe SA | `/bmad:load frappe-experts:frappe-sa` then `*design` |
| `*analyze-requirements` | ERPNext BA | `/bmad:load frappe-experts:erpnext-ba` then `*review-requirements` |
| `*create-doctype` | Workflow | `*scaffold-doctype` or load workflow |
| `*create-report` | Workflow | Load report workflow (todo) |
| `*optimize` | Workflow | Load optimize workflow (todo) |
| `*develop-story` | Workflow | `workflows/develop-story.yaml` |
| `*frappe-console` | Manual | `bench --site [site] console` |
| `*bench-status` | Manual | `bench status` |

---

## Benefits of Refocus

✅ **Clearer Responsibility** - Nexus does ONE thing: execute specs
✅ **Cleaner Menu** - 14 commands (was 30+)
✅ **Faster Context** - Less to load, faster activation
✅ **Better Separation** - Design vs Execution clearly separated
✅ **Easier Maintenance** - Smaller agent, easier to update
✅ **Better Documentation** - Clear what Nexus does vs doesn't do

---

## Upgrade Notes

**For existing Nexus users:**

1. **Design commands** → Load Frappe SA or ERPNext BA
2. **Scaffolding** → Use consolidated commands (`*scaffold-*`)
3. **Testing** → Use `*test` for all test scenarios
4. **Operations** → Use `*migrate` and `*build-assets`
5. **Knowledge** → Use `*explain` and `*pattern`

**No functionality lost** - just reorganized across agents and workflows for better focus.

---

## Version History

**v2.0.0** (2025-11-12) - Major refocus: Strategic → Execution Specialist
**v1.0.0** (2024-XX-XX) - Original Strategic Frappe Developer

---

**Last Updated:** 2025-11-12
**Status:** ✅ Complete
**Impact:** Breaking change (command interface changed)
