---
last-redoc-date: 2025-11-17
---

# Update Knowledge Base Workflow

Intelligent knowledge base updater with diff detection - captures new learnings, better patterns, and improved practices.

## Table of Contents

1. [Purpose](#purpose)
2. [Usage](#usage)
3. [Triggers](#triggers)
4. [Intelligence Features](#intelligence-features)
5. [Process](#process)

## Purpose

Maintain living knowledge base by detecting and capturing:
- New patterns discovered during development
- Better/more secure coding practices
- Bug fix insights and prevention patterns
- New Frappe/ERPNext features
- Manual knowledge additions

## Usage

**Standalone workflow** - Invoke directly:
```
/bmad:frappe-experts:workflows:update-knowledge-base
```

**When to Use**:
- End of development session (reflection mode)
- Discovered better pattern than current knowledge
- Learned more secure approach
- Found new framework capability
- Fixed production bug with lessons learned
- Want to manually add knowledge

## Triggers

| Trigger | Description | Example |
|---------|-------------|---------|
| **End of session** | Reflect on recent work, identify learnings | After implementing feature, discovered new hook pattern |
| **Better pattern** | Found improved way vs. existing knowledge | New way to handle bulk operations more efficiently |
| **Security improvement** | More secure coding practice | Better permission checking approach |
| **New feature** | Discovered Frappe/ERPNext capability | Found built-in API method that replaces custom code |
| **Bug fix insight** | Learned from production issue | Discovered anti-pattern causing race condition |
| **Manual addition** | Explicit knowledge to add | User wants to document specific pattern |

## Intelligence Features

### Diff Detection

**Conflict Analysis**:
- Reads existing knowledge base files
- Searches for related patterns
- Identifies contradictions with new knowledge
- Offers resolution: Replace / Add alongside / Skip

**Example**:
```
Existing: "Use frappe.call() for server methods"
New: "Use frappe.xcall() for async server calls (v15+)"
→ Action: Add alongside (version-specific)
```

### Auto-Categorization

Analyzes learning and maps to appropriate knowledge base file(s):

**Development** → `data/development/`:
- Critical patterns → `frappe-framework/frappe-dev-critical.md`
- Server code → `server-scripting/best-practices.md`
- Client code → `client-scripting/best-practices.md`
- Reports → `reports/`
- Debug → `debugging/`

**Functional** → `data/functional/`:
- ERPNext features → `erpnext-ba-guide.md`
- Module knowledge → `erpnext-modules/`
- Workflows → `business-processes/common-patterns.md`

### Session Reflection Mode

**For Non-Coders** (like Rizwan):

When trigger = "End of development session":
1. Workflow asks: "What did you work on?"
2. AI analyzes the work and identifies potential learnings
3. Presents discoveries: "I noticed you used X pattern - is this new?"
4. User confirms what's worth capturing (no coding knowledge needed)

**AI Detection**:
- New patterns in code written
- Anti-patterns avoided
- Better approaches found
- Security enhancements made
- Performance optimizations

## Process

**Step 1**: Trigger selection (6 options)

**Step 2**: Intelligent analysis
- Session reflection (AI-assisted)
- Pattern comparison (old vs new)
- Security analysis
- Feature discovery
- Bug insight extraction

**Step 3**: Auto-categorization
- Maps to development/ or functional/
- Selects specific file(s)
- User confirms mapping

**Step 4**: Conflict detection
- Searches existing knowledge
- Flags contradictions
- Resolves: Replace / Add / Skip

**Step 5**: Format & add
- Token-efficient formatting
- Pattern + Description + Use Case + Example
- User approval before saving

**Step 6**: Git tracking
- Updates file frontmatter (last-updated)
- Generates commit message: `KB: [Category] Description`
- Optional auto-commit

**Step 7**: Summary & review

## Example Usage

**Scenario**: Discovered better dialog pattern

**Workflow**:
```
Trigger: "Discovered better pattern"
Old pattern: "Don't disable dialog submit button"
New pattern: "Always disable submit button on dialog submit"
Reason: "Prevents duplicate submissions in production"

→ Categorized to: development/client-scripting/best-practices.md
→ Conflict found: Existing pattern unclear about this
→ Resolution: Replace with new pattern
→ Added: ✅ Disable submit button example with code
→ Commit: KB: [Dev] Add dialog submit prevention pattern
```

**Result**: Knowledge base now has concrete best practice with example

## Key Features

- **Non-coder friendly**: AI assists in identifying learnings from work
- **Diff detection**: Prevents duplicate or conflicting knowledge
- **Auto-mapping**: Suggests correct file placement
- **Git integration**: Tracks knowledge evolution
- **Token-efficient**: Formats in consistent, compact style
- **Conflict resolution**: Handles pattern updates intelligently
