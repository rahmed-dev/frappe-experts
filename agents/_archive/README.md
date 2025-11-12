# Agent Archive

This folder contains legacy/deprecated agents that have been replaced or split into multiple focused agents.

---

## Archived Agents

### erpnext-oracle (Archived: 2025-11-12)

**Original Role:** ERPNext Business Analyst & Solution Architect
**Icon:** 🔮
**Status:** **DEPRECATED** - Split into 3 focused agents

**Reason for Archiving:**
Oracle tried to do too much in one agent, operating in incompatible mental modes (business vs technical). This caused context switching overhead and decision paralysis.

**Replaced By:**

1. **ERPNext BA** (`erpnext-ba`)
   - **Role:** Business Requirements Analyst
   - **Focus:** Requirements gathering, ERPNext feature mapping, gap analysis
   - **Migrated:** ERPNext-specific knowledge (erpnext-ba-guide.md, erpnext-modules/, business-processes/)

2. **Frappe SA** (`frappe-sa`)
   - **Role:** Solution Architect
   - **Focus:** Technical design, 4-tier framework, UX design
   - **Migrated:** Configure-first approach knowledge (frappe-framework/)

3. **Phase Master** (`phase-master`)
   - **Role:** Implementation Planner
   - **Focus:** Dependency sequencing, phased delivery planning
   - **New:** Addresses "FREEZE" moments on what to build first

**Knowledge Migration:**
- ✅ `business-processes/` → ERPNext BA
- ✅ `erpnext-ba-guide.md` → ERPNext BA
- ✅ `erpnext-modules/` → ERPNext BA
- ✅ `frappe-framework/configure-first-approach.md` → Frappe SA
- ✅ Technical guides (client-scripting, server-scripting, etc.) → Already in Nexus

**Why Keep in Archive:**
- Reference for migration history
- Preserve original agent structure
- Documentation of evolution

**Do Not Use:** This agent is obsolete. Use the 3 replacement agents instead.

---

## Archive Policy

**What Gets Archived:**
- Agents that have been superseded by better-focused agents
- Agents split into multiple specialized agents
- Legacy implementations kept for reference

**What Stays Archived:**
- Complete agent files (YAML + .md + sidecar)
- Migration documentation
- Knowledge bases (even if migrated - for comparison)

**Archive is Version Controlled:**
- Yes, archive folder is tracked in git
- Provides history and evolution of agent ecosystem
- Allows rollback if needed (though unlikely)

---

**Last Updated:** 2025-11-12
