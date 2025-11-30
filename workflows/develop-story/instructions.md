# Develop Story Workflow Instructions

<critical>Load COMPLETE file {agent-folder}/frappe-nexus-sidecar/knowledge/Frappe-dev-critical.md for core Frappe patterns and anti-patterns</critical>
<critical>Follow template standards from: {project-root}/{bmad_folder}/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>
<critical>Communicate in {communication_language} throughout</critical>

<workflow>

<step n="1" goal="Load story and context">
  <ask>Which story are you implementing? Provide:
a) Story file path
b) Story ID/name
  </ask>

  <action>Read complete story file</action>
  <action>Store as {{story_name}}, {{story_file}}</action>
  <action>Extract:
    - Story goals and acceptance criteria
    - Task list
    - Technical notes
    - Dependencies
  </action>
</step>

<step n="2" goal="Execute development cycle">
  <action>FOR EACH TASK IN STORY:

    1. READ TASK
       - Understand requirements
       - Review acceptance criteria
       - Check technical notes

    2. IMPLEMENT TASK
       - Follow Frappe best practices from knowledge base
       - Server-side first: ALL queries in Python, not JavaScript
       - Use Frappe native components (frappe.ui.Dialog, field types)
       - Register customizations in hooks.py
       - Apply proper permissions (@frappe.whitelist(), frappe.has_permission())
       - Convert form values to proper types (int, flt)
       - Date format: Store YYYY-MM-DD, Display DD-MM-YYYY

    3. WRITE TESTS
       - Unit tests for functions
       - Integration tests for workflows
       - Validation tests for business rules

    4. EXECUTE VALIDATIONS
       - Run tests
       - Check code against anti-patterns
       - Verify Frappe standards compliance
       - Test manually if needed

    5. FRAPPE WORKFLOW COMMANDS
       - After hooks.py changes: bench --site [site] migrate && bench restart
       - After JS changes: bench build --app [app] && bench --site [site] clear-cache
       - Manual test: bench --site [site] execute "path.to.function"

    6. MARK COMPLETE
       - ONLY if ALL validations pass
       - Mark task checkbox with [x]
       - Update story File List section

    7. REPEAT until all tasks complete
  </action>

  <action>BLOCKING CONDITIONS (HALT AND ASK USER):
    - Unapproved dependencies needed
    - Ambiguous requirements after checking story
    - 3 failures attempting same fix repeatedly
    - Missing configuration
    - Failing regression tests
    - Unclear Frappe/ERPNext integration approach
  </action>

  <action>AUTHORIZED STORY FILE UPDATES:
    ✓ Tasks/Subtasks checkboxes
    ✓ Dev Agent Record section
    ✓ Agent Model Used
    ✓ Debug Log References
    ✓ Completion Notes List
    ✓ File List
    ✓ Change Log
    ✓ Status

    ❌ DO NOT modify:
    - Story description
    - Acceptance Criteria
    - Dev Notes
    - Testing sections (unless adding test results)
  </action>
</step>

<step n="3" goal="Generate session notes">
  <template-output name="session_notes" file="{{default_output_file}}">
    <variable name="story_name">{{story_name}}</variable>
    <variable name="story_file">{{story_file}}</variable>
    <variable name="date">{{date}}</variable>
    <variable name="story_status">{{story_status}}</variable>
    <variable name="tasks_completed">{{tasks_completed}}</variable>
    <variable name="total_tasks">{{total_tasks}}</variable>
    <variable name="tests_passing">{{tests_passing}}</variable>
    <variable name="total_tests">{{total_tests}}</variable>
    <variable name="validation_status">{{validation_status}}</variable>
    <variable name="session_duration">{{session_duration}}</variable>
    <variable name="completed_tasks">{{completed_tasks}}</variable>
    <variable name="remaining_tasks">{{remaining_tasks}}</variable>
    <variable name="files_modified">{{files_modified}}</variable>
    <variable name="implementation_notes">{{implementation_notes}}</variable>
    <variable name="frappe_commands">{{frappe_commands}}</variable>
    <variable name="tests_executed">{{tests_executed}}</variable>
    <variable name="validation_checks">{{validation_checks}}</variable>
    <variable name="resolved_issues">{{resolved_issues}}</variable>
    <variable name="pending_issues">{{pending_issues}}</variable>
    <variable name="next_session_actions">{{next_session_actions}}</variable>
    <variable name="developer_name">{{developer_name}}</variable>
  </template-output>

  <action>Generate development session notes following template</action>
  <action>Use tables for files modified, tests executed, validation checks</action>
  <action>Document all Frappe commands run</action>
  <action>List resolved and pending issues</action>
</step>

<step n="4" goal="Quality validation and user approval">
  <action>Review development session against quality standards:
    ✓ Non-fluffy, to-the-point, practical
    ✓ No wordiness or verbose explanations
    ✓ Tables used over prose where appropriate
    ✓ All sections numbered
    ✓ All template variables filled (no placeholders)
    ✓ Token-efficient structure maintained
  </action>

  <action>Present summary of session:
    - Tasks completed
    - Tests passing
    - Files modified
    - Issues encountered and resolved
  </action>

  <ask>Review the session notes. Any sections need refinement? Any deviations from expected output?</ask>

  <check if="user requests changes">
    <action>Note requested changes</action>
    <action>Apply changes with user approval</action>
    <action>Re-validate quality standards</action>
    <action>Update template outputs as needed</action>
  </check>

  <action>Confirm session notes approved</action>
</step>

<step n="5" goal="Ready for review check">
  <action>Verify READY FOR REVIEW criteria:
    ✓ Code matches requirements
    ✓ All validations pass
    ✓ Follows Frappe standards
    ✓ File List complete in story
    ✓ bench migrate runs successfully
    ✓ All tests passing
  </action>

  <check if="all criteria met">
    <action>Update story status: 'Ready for Review'</action>
    <action>HALT and await user</action>
  </check>

  <check if="criteria not met">
    <action>List missing criteria</action>
    <ask>Continue development or pause here?</ask>
  </check>
</step>

<step n="6" goal="Completion">
  <action>Confirm development session complete</action>
  <action>Present final summary:
    - Story status
    - Tasks completed vs total
    - Tests passing vs total
    - Files modified count
    - Next actions (if story incomplete)
  </action>
  <action>Remind: Session notes saved to {{default_output_file}}</action>
</step>

</workflow>
