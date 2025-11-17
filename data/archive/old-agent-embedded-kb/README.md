---
title: "Archived Agent-Embedded Knowledge Bases"
archived-date: 2025-11-17
reason: "Migration to unified knowledge base structure"
---

# Archived Agent-Embedded Knowledge Bases

## Why These Were Archived

**Date:** 2025-11-17
**Reason:** Migration from agent-specific embedded knowledge bases to unified module-level knowledge base

### The Problem (Before)

Each agent had its own `knowledge/` folder with duplicated content:

```
agents/
├── frappe-nexus-sidecar/knowledge/     (10 files - dev guides)
├── erpnext-ba-sidecar/knowledge/       (7 files - ERPNext modules)
├── frappe-sa-sidecar/knowledge/        (2 files - 4-tier framework)
├── debug-master-sidecar/knowledge/     (embedded debugging patterns)
├── phase-master-sidecar/knowledge/     (minimal)
├── quick-guide-sidecar/knowledge/      (minimal)
└── test-gen-sidecar/knowledge/         (minimal)
```

**Issues:**
- Knowledge duplication across agents
- Inconsistent updates (one agent updated, others missed)
- Harder to maintain (7 places to update same info)
- Confusion about which KB to use (embedded vs unified)

### The Solution (After)

**Unified Knowledge Base Structure:**

```
data/kb/
├── development/                    # Technical knowledge
│   ├── standards/                 # NEW - Core coding standards
│   │   ├── coding-principles.md
│   │   ├── testing-standards.md
│   │   └── code-output-format.md
│   ├── frappe-framework/
│   ├── server-scripting/
│   ├── client-scripting/
│   ├── custom-pages/
│   └── reports/
└── functional/                     # Business knowledge
    ├── erpnext-modules/
    └── business-processes/
```

**Benefits:**
- Single source of truth
- Update once, all agents benefit
- Clear organization (dev vs functional)
- Easy to maintain and extend

---

## What's Archived Here

This directory contains the OLD embedded knowledge bases from each agent:

| Agent | Folder | Files | Notes |
|-------|--------|-------|-------|
| Frappe Nexus | `frappe-nexus-knowledge/` | 10 | Development guides (migrated to unified KB) |
| ERPNext BA | `erpnext-ba-knowledge/` | 7 | ERPNext modules (migrated to unified KB) |
| Frappe SA | `frappe-sa-knowledge/` | 2 | 4-tier framework (migrated to unified KB) |
| Debug Master | `debug-master-knowledge/` | Minimal | Debugging patterns (migrated to unified KB) |
| Phase Master | `phase-master-knowledge/` | Minimal | Implementation sequencing |
| Quick Guide | `quick-guide-knowledge/` | Minimal | Documentation patterns |
| Test Gen | `test-gen-knowledge/` | Minimal | Testing patterns |

---

## Migration Details

### What Was Added to Unified KB

**New Standards Files (2025-11-17):**
1. `development/standards/coding-principles.md` - Core coding standards from AGENTS.md
2. `development/standards/testing-standards.md` - Testing philosophy from AGENTS.md
3. `development/standards/code-output-format.md` - Code delivery standards from AGENTS.md

### Agent Updates

**All agents now reference unified KB:**

**Nexus (frappe-nexus.md):**
- Line 24: `Unified knowledge base: {project-root}/.bmad/custom/modules/frappe-experts/data/kb/development/`
- Instructions updated to load new standards files
- Memories updated to reference unified KB

**Other Agents:**
- Already referenced unified KB (no embedded KB loading)
- Frappe SA & ERPNext BA: Added proactive attitude guidelines (Section 10 from AGENTS.md)

---

## If You Need to Reference Old KB

**Archived locations:**
```
data/archive/old-agent-embedded-kb/
├── frappe-nexus-knowledge/
├── erpnext-ba-knowledge/
├── frappe-sa-knowledge/
├── debug-master-knowledge/
├── phase-master-knowledge/
├── quick-guide-knowledge/
└── test-gen-knowledge/
```

**⚠️ DO NOT use these for active development!**

These are preserved for:
- Historical reference
- Auditing what was changed during migration
- Recovery if something was accidentally lost (shouldn't happen)

**Always use the unified KB:** `data/kb/`

---

## Rollback Instructions (Emergency Only)

If you need to restore old embedded KBs (NOT recommended):

```bash
cd /path/to/frappe-bench/.bmad/custom/modules/frappe-experts

# Restore specific agent KB (example: Nexus)
cp -r data/archive/old-agent-embedded-kb/frappe-nexus-knowledge \
      agents/frappe-nexus-sidecar/knowledge

# Revert agent instructions to reference embedded KB
# (Manual edit required)
```

**Better approach:** Fix issues in unified KB rather than rolling back.

---

## Timeline

**2025-11-17:**
- Migrated all 7 agent embedded KBs to unified structure
- Added 3 new standards files from AGENTS.md integration
- Updated Nexus instructions and memories
- Added proactive attitude guidelines to Frappe SA and ERPNext BA
- Archived all old embedded KB folders

**Previous State:**
- Mixed references (some agents used unified, some had embedded)
- Nexus was last agent using embedded KB
- Inconsistent knowledge distribution

---

## Questions?

If you're unsure where knowledge lives now:

**For Development Knowledge (Nexus, Debug Master):**
- Check: `data/kb/development/`

**For Business Knowledge (ERPNext BA, Frappe SA):**
- Check: `data/kb/functional/`

**For Standards (All agents):**
- Check: `data/kb/development/standards/`

**For Agent-Specific Instructions:**
- Check: `agents/[agent-name]-sidecar/instructions.md`

---

**This migration improves maintainability and ensures all agents benefit from knowledge updates immediately.**
