# Design System Workflow Instructions

<critical>Load COMPLETE file {agent-folder}/frappe-nexus-sidecar/knowledge/Frappe-dev-critical.md for Frappe patterns</critical>
<critical>Follow template standards from: {project-root}/{bmad_folder}/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>
<critical>Communicate in {communication_language} throughout</critical>

<workflow>

<step n="1" goal="Load requirements and context">
  <ask>What are you building? Provide:
a) Requirements document (file path or paste content)
b) BRD or TSD reference (if exists)
c) Verbal description of business requirements
  </ask>

  <action>Load complete requirements context</action>
  <action>Store as {{project_name}}, {{requirements_source}}</action>
</step>

<step n="2" goal="Requirements analysis">
  <action>Analyze requirements systematically:
    - Extract business requirements
    - Identify key entities and relationships
    - Map business processes to Frappe patterns
    - Identify integration touch-points
  </action>

  <action>For each requirement, identify:
    - Core entities (will become DocTypes)
    - Relationships between entities
    - Business rules and validations
    - User workflows
    - Data flow
  </action>
</step>

<step n="3" goal="Data model design">
  <action>Design DocTypes with:
    - Fields, field types, and properties
    - Relationships (Link, Table, Child Table)
    - Naming conventions and series
    - Permission rules by role
    - Validation requirements
    - Index requirements
  </action>

  <action>Map relationships:
    - One-to-Many (Link + fetch_from)
    - Many-to-Many (Child Table)
    - Parent-Child (is_child_table=1)
  </action>

  <action>Apply Frappe patterns from knowledge base</action>
</step>

<step n="4" goal="API architecture">
  <action>Identify required API endpoints:
    - Whitelisted methods (@frappe.whitelist())
    - Request/response structures
    - Authentication requirements
    - Permission checks needed
    - Business logic flow
  </action>

  <action>Design validation rules:
    - Field-level validations
    - Document-level validations
    - Business rule validations
    - Error messages
  </action>
</step>

<step n="5" goal="Integration planning">
  <action>Identify integration points:
    - External system touchpoints
    - Webhook/API integration strategy
    - Data synchronization approach
    - Conflict resolution
  </action>
</step>

<step n="6" goal="Implementation strategy">
  <action>Break down into phases:
    - Phase dependencies
    - Deliverables per phase
    - Testing strategy
    - Performance considerations
  </action>

  <action>Identify reusable patterns from knowledge base</action>
</step>

<step n="7" goal="Generate architecture document">
  <template-output name="architecture_document" file="{{default_output_file}}">
    <variable name="project_name">{{project_name}}</variable>
    <variable name="requirements_source">{{requirements_source}}</variable>
    <variable name="date">{{date}}</variable>
    <variable name="business_goal">{{business_goal}}</variable>
    <variable name="solution_approach">{{solution_approach}}</variable>
    <variable name="key_technologies">{{key_technologies}}</variable>
    <variable name="complexity">{{complexity}}</variable>
    <variable name="timeline">{{timeline}}</variable>
    <variable name="business_requirements">{{business_requirements}}</variable>
    <variable name="key_entities">{{key_entities}}</variable>
    <variable name="business_processes">{{business_processes}}</variable>
    <variable name="doctype_overview">{{doctype_overview}}</variable>
    <variable name="doctype_details">{{doctype_details}}</variable>
    <variable name="relationships">{{relationships}}</variable>
    <variable name="naming_conventions">{{naming_conventions}}</variable>
    <variable name="permission_rules">{{permission_rules}}</variable>
    <variable name="api_endpoints">{{api_endpoints}}</variable>
    <variable name="request_response_structures">{{request_response_structures}}</variable>
    <variable name="business_logic_flow">{{business_logic_flow}}</variable>
    <variable name="validation_rules">{{validation_rules}}</variable>
    <variable name="external_systems">{{external_systems}}</variable>
    <variable name="webhook_strategy">{{webhook_strategy}}</variable>
    <variable name="data_sync">{{data_sync}}</variable>
    <variable name="implementation_phases">{{implementation_phases}}</variable>
    <variable name="reusable_patterns">{{reusable_patterns}}</variable>
    <variable name="unit_test_coverage">{{unit_test_coverage}}</variable>
    <variable name="integration_test_coverage">{{integration_test_coverage}}</variable>
    <variable name="ui_test_coverage">{{ui_test_coverage}}</variable>
    <variable name="perf_test_coverage">{{perf_test_coverage}}</variable>
    <variable name="performance_considerations">{{performance_considerations}}</variable>
  </template-output>

  <action>Generate complete architecture document following template</action>
  <action>Ensure all sections use tables for structured data</action>
  <action>Keep prose minimal, use numbered lists and tables</action>
  <action>Fill all template variables with concrete values</action>
</step>

<step n="8" goal="Quality validation and user approval">
  <action>Review generated document against quality standards:
    ✓ Non-fluffy, to-the-point, practical
    ✓ No wordiness or verbose explanations
    ✓ Tables used over prose where appropriate
    ✓ All sections numbered
    ✓ All template variables filled (no placeholders)
    ✓ Token-efficient structure maintained
  </action>

  <action>Present summary of generated document</action>

  <ask>Review the architecture document. Any sections need refinement? Any deviations from expected output?</ask>

  <check if="user requests changes">
    <action>Note requested changes</action>
    <action>Apply changes with user approval</action>
    <action>Re-validate quality standards</action>
    <action>Update template outputs as needed</action>
  </check>

  <action>Confirm document approved and ready for next phase</action>
</step>

<step n="9" goal="Completion">
  <action>Confirm architecture document complete and saved</action>
  <action>Present summary:
    - Total DocTypes designed
    - API endpoints identified
    - Integration points mapped
    - Implementation phases planned
  </action>
  <action>Suggest next step: Create detailed TSD from this architecture</action>
</step>

</workflow>
