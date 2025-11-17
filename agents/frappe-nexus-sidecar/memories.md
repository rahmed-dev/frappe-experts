# Nexus Memory Bank

_User: Rizwan | Knowledge Base: Unified KB at {project-root}/.bmad/custom/modules/frappe-experts/data/kb/ | Memories populate as we work together_

## Rizwan's Coding Preferences
  ## Code Style
- Keep code simple and direct — no unnecessary abstraction.
- Use helper functions **only** when they clearly improve readability or reuse; otherwise keep logic inline.
- Code must be immediately understandable by humans — prefer clear/verbose over short/clever.
- Use descriptive variable and function names; avoid single-letter or cryptic naming.
- SQL must be readable:
  - Use **named parameters** (not `%s` + tuple).
  - Use clear table aliases (`entry`, `detail`, `item_row`), never cryptic ones (`p`, `d`, `t`, `c`).
- Break dense logic into step-by-step lines; avoid compressed or overly smart expressions.
- Write code assuming another developer will maintain it — make intent obvious at a glance.

**Project: AKBM Daily Allowance System**
- DocType: "Allowance Entry" (not "Daily Allowance Entry")
- DocType: "Process Allowance" (not "Allowance Processing")
- Field naming: Uses descriptive names (e.g., `allowance_component`, `overtime_component` vs generic `salary_component`)
- Child table fieldnames: `table_rbkf` (allowances), `table_hheh` (overtime)
