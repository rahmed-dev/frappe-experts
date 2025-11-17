# Update Knowledge Base Workflow Instructions

<critical>Intelligent knowledge base updater - detects new learnings, better patterns, improved security/coding standards</critical>
<critical>Communicate in {communication_language} throughout</critical>

<workflow>

<step n="1" goal="Detect context and learning type">
  <ask>What triggered this knowledge base update?

Options:
a) **End of development session** - Reflect on what was learned during recent work
b) **Discovered better pattern** - Found improved way of doing something
c) **Security improvement** - Learned more secure coding practice
d) **New Frappe/ERPNext feature** - Discovered new framework capability
e) **Bug fix insight** - Learned from debugging a production issue
f) **Manual addition** - I want to add specific knowledge
  </ask>

  <action>Store trigger type as {{trigger_type}}</action>
</step>

<step n="2" goal="Intelligent diff detection and analysis">
  <check if="trigger_type is 'End of development session'">
    <ask>Let's reflect on your recent development session. What did you work on?

Examples:
- "Implemented employee advance repayment feature"
- "Fixed duplicate submission bug in dialogs"
- "Created custom report for stock analysis"
    </ask>
    <action>Store as {{session_work}}</action>

    <action>Analyze session work and identify potential learnings:
    - **New patterns discovered**: Any new Frappe patterns used?
    - **Anti-patterns avoided**: Did we encounter and fix common mistakes?
    - **Better approaches**: Did we find more efficient solutions?
    - **Security improvements**: Any permission or validation enhancements?
    - **Performance optimizations**: Better query patterns or caching?
    </action>

    <ask>Based on your session, I've identified potential knowledge additions:

{{identified_learnings}}

Do any of these represent NEW knowledge worth adding to the knowledge base? (Select all that apply or type 'None')
    </ask>

    <action>Store selected learnings as {{new_learnings}}</action>
  </check>

  <check if="trigger_type is 'Discovered better pattern'">
    <ask>What was the **old pattern** you were using?</ask>
    <action>Store as {{old_pattern}}</action>

    <ask>What is the **better pattern** you discovered?</ask>
    <action>Store as {{new_pattern}}</action>

    <ask>Why is the new pattern better? (performance, security, maintainability, readability)</ask>
    <action>Store as {{improvement_reason}}</action>

    <action>Determine if this contradicts existing knowledge:
    - Search relevant knowledge base files for old_pattern
    - Check if old_pattern is documented as "best practice"
    - Flag for replacement if found
    </action>
  </check>

  <check if="trigger_type is 'Security improvement'">
    <ask>What security vulnerability or weakness did you discover?</ask>
    <action>Store as {{security_issue}}</action>

    <ask>What is the secure way to handle this?</ask>
    <action>Store as {{secure_pattern}}</action>

    <ask>What category does this fall under?
    - Permission checking
    - Input validation
    - SQL injection prevention
    - XSS prevention
    - Authentication/Authorization
    - Data encryption
    - Other
    </ask>
    <action>Store as {{security_category}}</action>
  </check>

  <check if="trigger_type is 'New Frappe/ERPNext feature'">
    <ask>What new feature or capability did you discover?</ask>
    <action>Store as {{new_feature}}</action>

    <ask>Which Frappe/ERPNext version introduced this? (if known)</ask>
    <action>Store as {{version}}</action>

    <ask>What use case does this solve?</ask>
    <action>Store as {{use_case}}</action>
  </check>

  <check if="trigger_type is 'Bug fix insight'">
    <ask>What was the bug or production issue?</ask>
    <action>Store as {{bug_description}}</action>

    <ask>What was the root cause?</ask>
    <action>Store as {{root_cause}}</action>

    <ask>How should this be prevented in the future? (pattern to follow or anti-pattern to avoid)</ask>
    <action>Store as {{prevention_pattern}}</action>
  </check>

  <check if="trigger_type is 'Manual addition'">
    <ask>What knowledge do you want to add?</ask>
    <action>Store as {{manual_knowledge}}</action>

    <ask>Which category does this belong to?
    - Development (technical)
    - Functional (business)
    </ask>
    <action>Store as {{category}}</action>
  </check>
</step>

<step n="3" goal="Categorize and map to knowledge base files">
  <action>Analyze {{new_learnings}} or {{new_pattern}} or {{secure_pattern}} or {{new_feature}} or {{prevention_pattern}} or {{manual_knowledge}}</action>

  <action>Determine target knowledge base file(s):

**Development Knowledge** ({project-root}/.bmad/custom/modules/frappe-experts/data/development/):
- **frappe-framework/frappe-dev-critical.md** - Critical patterns, anti-patterns, tech stack
- **frappe-framework/4-tier-framework.md** - Solution design philosophy
- **server-scripting/best-practices.md** - Python backend patterns
- **server-scripting/coding-guidelines.md** - Python code standards
- **client-scripting/best-practices.md** - JavaScript patterns
- **client-scripting/coding-guidelines.md** - JavaScript standards
- **custom-pages/** - Custom UI knowledge
- **reports/** - Report development
- **debugging/** - Debug patterns

**Functional Knowledge** ({project-root}/.bmad/custom/modules/frappe-experts/data/functional/):
- **erpnext-ba-guide.md** - ERPNext features catalog
- **erpnext-modules/** - Module-specific knowledge
- **business-processes/common-patterns.md** - Workflow patterns
  </action>

  <action>Map learning to specific file(s)</action>
  <action>Store as {{target_files}}</action>

  <ask>I recommend adding this knowledge to:

{{target_files}}

Does this mapping make sense? (y/n/suggest alternative)
  </ask>

  <check if="user suggests alternative">
    <action>Update {{target_files}} with user's suggestion</action>
  </check>
</step>

<step n="4" goal="Check for conflicting knowledge">
  <action>For each {{target_files}}:
  1. Read complete file
  2. Search for existing patterns related to {{new_learnings}}
  3. Check if new knowledge contradicts existing content
  4. If contradiction found, flag for replacement vs addition
  </action>

  <check if="contradiction found">
    <ask>⚠️ Found existing knowledge that may conflict:

**Existing**: {{conflicting_content}}
**New**: {{new_learnings}}

Action:
a) **Replace** old with new (marks old as deprecated)
b) **Add** new alongside old (note: different approaches)
c) **Skip** - existing knowledge is still valid
    </ask>

    <action>Store conflict resolution as {{resolution_action}}</action>
  </check>
</step>

<step n="5" goal="Format and add knowledge">
  <action>Format new knowledge in token-efficient style:
  - **Pattern name** or **Topic**
  - **Description**: What this is (1-2 sentences)
  - **Use case**: When to use this
  - **Example** (code snippet if applicable)
  - **Anti-pattern** (what NOT to do, if applicable)
  </action>

  <action>Generate formatted knowledge entry</action>
  <template-output>formatted_entry</template-output>

  <ask>Review the formatted knowledge entry above. Approve to add to knowledge base? (y/n/edit)</ask>

  <check if="user approves">
    <action>For each file in {{target_files}}:
    1. Read complete file
    2. Identify appropriate section to insert
    3. Add formatted entry
    4. If {{resolution_action}} is 'Replace', mark old content as deprecated
    5. Save updated file
    </action>
  </check>

  <check if="user wants to edit">
    <ask>What changes would you like to make to the formatted entry?</ask>
    <action>Apply user edits</action>
    <goto step="5">Re-present formatted entry</goto>
  </check>
</step>

<step n="6" goal="Update metadata and git tracking">
  <action>Update last-updated date in affected files' frontmatter</action>

  <action>Generate git commit message suggestion:
  **Format**: `KB: [Category] Brief description`

  Examples:
  - `KB: [Dev] Add secure dialog pattern to prevent duplicates`
  - `KB: [Func] Update HR module with shift assignment pattern`
  - `KB: [Security] Add permission checking best practice`

  **Suggested commit message**:
  {{generated_commit_message}}
  </action>

  <ask>Knowledge base updated successfully!

Files modified:
{{target_files}}

Suggested git commit message:
{{generated_commit_message}}

Would you like to commit this change? (y/n)
  </ask>

  <check if="user wants to commit">
    <action>Stage files: git add {{target_files}}</action>
    <action>Commit with message: {{generated_commit_message}}</action>
    <action>Report commit hash</action>
  </check>
</step>

<step n="7" goal="Completion and reflection">
  <action>Summary of knowledge base update:
  - **Trigger**: {{trigger_type}}
  - **Files updated**: {{target_files}}
  - **Knowledge added**: {{summary_of_additions}}
  - **Conflicting knowledge resolved**: {{resolution_action}} (if any)
  - **Git committed**: Yes/No
  </action>

  <ask optional="true">Would you like to review the updated knowledge base file(s) now? (y/n)</ask>

  <check if="user wants review">
    <action>Display updated sections from each file</action>
  </check>

  <action>Workflow complete - knowledge base enhanced!</action>
</step>

</workflow>
