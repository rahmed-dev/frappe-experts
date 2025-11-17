# Review Requirements Workflow Instructions

<critical>Analyze existing requirements and categorize against ERPNext capabilities</critical>

<critical>Follow template standards from: {project-root}/.bmad/custom/modules/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>

<workflow>

<step n="1" goal="Load existing requirements">
  <ask>Provide the requirements to review (file path, paste content, or describe)</ask>
  <action>Load and analyze the requirements</action>
</step>

<step n="2" goal="Categorize each requirement">
  <action>For each requirement identified, analyze and categorize:
    - ✅ Standard ERPNext Feature (which module, which DocType)
    - ⚙️ Can be Configured (what configuration needed)
    - 🔨 Needs Custom Development (why custom needed)
  </action>

  <action>Map to ERPNext modules</action>
  <action>Identify integration touch-points</action>
  <action>Assign business priorities</action>
</step>

<step n="3" goal="Present analysis">
  <action>Present categorized requirements with:
    - ERPNext module coverage
    - Standard vs Configure vs Custom breakdown
    - Gaps identified
    - Integration points
    - Priority recommendations
  </action>
</step>

<step n="4" goal="Recommendations">
  <action>Provide recommendations:
    - Which requirements can leverage standard ERPNext
    - Which need configuration only
    - Which require custom development
    - Suggested next steps
  </action>
</step>

</workflow>
