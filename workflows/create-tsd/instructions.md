# Create TSD Workflow Instructions

<critical>Create Technical Specification Document with UX focus from Business Requirements</critical>
<critical>Follow template standards from: {project-root}/.bmad/custom/modules/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>

<workflow>

<step n="1" goal="Load Business Requirements and gather context">
  <ask>Provide the Business Requirements Document (file path or location)</ask>
  <action>Load and read COMPLETE BRD</action>
  <action>Understand all requirements, priorities, and business context</action>

  <ask>What is the BRD version? (e.g., 1.0, 2.0)</ask>
  <action>Store as {{brd_version}}</action>

  <ask>What is the project name?</ask>
  <action>Store as {{project_name}}</action>
</step>

<step n="2" goal="Apply 4-tier framework to each requirement">
  <action>For each requirement from BRD, determine tier classification:
    - Tier 1: Standard ERPNext (use out-of-box)
    - Tier 2: Configuration (Custom Fields, Workflows, Property Setters)
    - Tier 3: Scripting (Server/Client Scripts, Hooks)
    - Tier 4: Custom App (Full custom DocTypes, modules)
  </action>

  <action>Document the technical approach for each requirement</action>
</step>

<step n="3" goal="Design technical solution with UX focus">
  <action>For each feature/requirement, design:
    - DocType structure (fields, relationships, permissions)
    - UX/UI design using Frappe components (form layouts, buttons, dialogs, dashboards)
    - Business logic (server scripts, client scripts, hooks)
    - Workflow design (if approval flows needed)
    - API design (if integrations needed)
    - Performance considerations (indexing, caching, background jobs)
    - Migration strategy (if legacy data needs mapping)
  </action>
</step>

<step n="4" goal="Generate Technical Specification Document">

  <action>Generate Executive Summary:
    - Technical Approach: High-level strategy (Configuration-heavy / Script-based / Custom App)
    - Complexity: Low / Medium / High
    - Primary Tier: Tier 2 / 3 / 4
    - Upgrade Safety: ✅ Safe / ⚠️ Monitor / ❌ Risk
    - Key Decisions: Major architectural choices
  </action>
  <template-output>technical_approach</template-output>
  <template-output>complexity</template-output>
  <template-output>primary_tier</template-output>
  <template-output>upgrade_safety</template-output>
  <template-output>key_decisions</template-output>

  <action>Generate Solution Architecture Overview table:
    - Approach: Configuration / Scripting / Custom App
    - Tier Classification: Which tiers used
    - ERPNext Modules Used: List of modules
    - Custom DocTypes Needed: Count
    - Performance Profile: Expected load characteristics
  </action>
  <template-output>approach</template-output>
  <template-output>tier_classification</template-output>
  <template-output>modules_used</template-output>
  <template-output>custom_doctypes_count</template-output>
  <template-output>performance_profile</template-output>

  <action>Generate Technical Design for each feature:
    For each feature/requirement, create numbered section (3.1, 3.2, 3.3...):

    ### 3.# {{Feature Name}}

    | Aspect | Specification |
    |--------|---------------|
    | BRD Reference | {{brd_section}} |
    | Tier | {{tier}} |
    | Complexity | Low/Medium/High |

    **UX/UI Design:**
    | Component | Specification |
    |-----------|---------------|
    | Form Layout | {{layout_strategy}} |
    | User Actions | {{user_interactions}} |
    | Visual Indicators | {{indicators}} |
    | Frappe Components | {{components_used}} |

    **DocType Design:**
    | Field | Type | Mandatory | Options | Default | Purpose |
    |-------|------|-----------|---------|---------|---------|
    {{fields_table}}

    **Business Logic:**
    - Server Hook: {{hook_name}} - {{logic_description}}
    - Client Script: {{behavior}}
    - Pseudo-code: {{pseudo_code}} (NO actual code, explain logic only)

    **Integration:**
    | Reads From | Writes To | Purpose |
    |------------|-----------|---------|
    {{integration_table}}

    **Performance:**
    - Index: {{fields_to_index}}
    - Background Jobs: {{jobs_needed}}

    Use tables exclusively. NO prose paragraphs.
  </action>
  <template-output>technical_design</template-output>

  <action>Generate Data Model:
    - ERD diagram showing DocType relationships
    - Integration points table showing all connections
  </action>
  <template-output>data_model_diagram</template-output>
  <template-output>integration_points</template-output>

  <action>Generate Configuration Requirements tables:
    - Custom Fields table (Target DocType, Field Name, Type, Mandatory, Options, Purpose)
    - Property Setters table (DocType, Property, Value, Reason)
    - Workflows table (Name, Applied To, States, Purpose)
    - Custom Development (if Tier 4): What needs building
  </action>
  <template-output>custom_fields</template-output>
  <template-output>property_setters</template-output>
  <template-output>workflows</template-output>
  <template-output>custom_development</template-output>

  <action>Generate Testing Requirements table:
    - Form Validation tests
    - Business Logic tests
    - Workflow Transition tests
    - Performance tests
    - Integration tests
  </action>
  <template-output>form_tests</template-output>
  <template-output>logic_tests</template-output>
  <template-output>workflow_tests</template-output>
  <template-output>perf_tests</template-output>
  <template-output>integration_tests</template-output>
</step>

<step n="5" goal="Quality validation and user approval">
  <action>Review generated TSD against quality standards:
    ✓ Non-fluffy, to-the-point, practical
    ✓ No wordiness or verbose explanations
    ✓ Tables used over prose throughout
    ✓ All sections numbered (1, 2, 3, 3.1, 3.2...)
    ✓ All template variables filled (no placeholders)
    ✓ Token-efficient structure maintained
    ✓ 4-tier framework correctly applied
    ✓ UX/UI designs leverage Frappe components
    ✓ Pseudo-code used (NO actual code blocks)
    ✓ Upgrade safety validated
  </action>

  <action>Present summary of generated TSD:
    - Primary tier: {{primary_tier}}
    - Complexity: {{complexity}}
    - Custom DocTypes needed: {{custom_doctypes_count}}
    - Upgrade safety: {{upgrade_safety}}
    - ERPNext modules: {{modules_used}}
  </action>

  <ask>Review the Technical Specification Document. Any sections need refinement? Any deviations from expected output?</ask>

  <check if="user requests changes">
    <action>Note requested changes</action>
    <action>Apply changes with user approval</action>
    <action>Re-validate quality standards</action>
    <action>Update template outputs as needed</action>
  </check>

  <action>Confirm document approved and ready for next phase</action>
</step>

<step n="6" goal="Completion">
  <action>Confirm TSD is complete, validated, and saved to: {{default_output_file}}</action>
  <action>Remind user this document is ready for handoff to Phase Master</action>
  <action>Suggest next step: Load Phase Master agent to create Implementation Plan</action>
</step>

</workflow>
