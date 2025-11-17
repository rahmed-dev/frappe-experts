# Create BRD Workflow Instructions

<critical>Execute this workflow to convert messy meeting notes into structured Business Requirements Document</critical>
<critical>Communicate in {communication_language} throughout</critical>
<critical>Follow template standards from: {project-root}/.bmad/custom/modules/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>

<workflow>

<step n="1" goal="Gather input and context">
  <ask>What source material do you have for the requirements?

Options:
a) Meeting notes (rough notes from client conversations)
b) Existing requirements document (needs structuring)
c) Verbal description (tell me what the client needs)
d) Multiple sources (combination of above)
  </ask>

  <action>Based on response, request the source material</action>
  <action>Store as {{source_material}}</action>

  <ask>What's the project name?</ask>
  <action>Store as {{project_name}}</action>

  <ask>What's the client name?</ask>
  <action>Store as {{client_name}}</action>

  <ask>What industry is the client in? (e.g., Manufacturing, Distribution, Services)</ask>
  <action>Store as {{industry}}</action>

  <ask>What's their current system? (e.g., Manual process, Excel, Legacy ERP)</ask>
  <action>Store as {{current_system}}</action>
</step>

<step n="2" goal="Analyze and categorize requirements">
  <action>Read and analyze the source material</action>
  <action>Identify distinct business requirements</action>
  <action>For each requirement, determine:
    - Business value (why this matters)
    - ERPNext status (Standard / Can be Configured / Needs Custom Development)
    - Priority (Must-Have / Should-Have / Nice-to-Have)
    - Integration touch-points (what other requirements this connects to)
  </action>

  <action>Categorize requirements by business area (e.g., Sales, Inventory, Production, Accounting)</action>
  <action>Identify which ERPNext modules handle each requirement</action>
</step>

<step n="3" goal="Generate Business Requirements Document">

  <action>Generate Executive Summary:
    - Purpose: What the client needs and why (1 sentence)
    - Current State: {{current_system}}
    - Desired Outcome: Business goals achieved
    - Key Challenges: Main pain points identified
  </action>
  <template-output>purpose</template-output>
  <template-output>desired_outcome</template-output>
  <template-output>key_challenges</template-output>

  <action>Generate Business Context table:
    - Industry: {{industry}}
    - Current System: {{current_system}}
    - Pain Points: List of main problems from source material
    - Business Goals: What success looks like
    - Success Criteria: How to measure success
  </action>
  <template-output>pain_points</template-output>
  <template-output>business_goals</template-output>
  <template-output>success_criteria</template-output>

  <action>Generate Requirements Analysis:
    For each requirement category (Sales, Inventory, Production, Accounting, etc.):

    ### [#.# Category Name - e.g., 3.1 Sales Order Processing]

    | Aspect | Detail |
    |--------|--------|
    | Requirement | Clear statement of need |
    | Business Value | Why this matters to business |
    | ERPNext Status | ✅ Standard / ⚙️ Configure / 🔨 Custom |
    | ERPNext Module | Module name |
    | Standard DocType | DocType (if standard) |
    | Integration | Which other requirements connect |
    | Priority | Must-Have / Should-Have / Nice-to-Have |

    Use tables, not prose. Number each requirement (3.1, 3.2, 3.3...).
  </action>
  <template-output>requirements_analysis</template-output>

  <action>Generate ERPNext Module Coverage table:
    List modules used and what standard features they provide.
    Format: | Module | Used For | Standard Features Leveraged |
  </action>
  <template-output>module_coverage</template-output>

  <action>Generate Gaps Summary table:
    Count and categorize requirements by gap type.
  </action>
  <template-output>standard_count</template-output>
  <template-output>standard_details</template-output>
  <template-output>config_count</template-output>
  <template-output>config_details</template-output>
  <template-output>custom_count</template-output>
  <template-output>custom_details</template-output>
  <template-output>total_requirements</template-output>
</step>

<step n="4" goal="Quality validation and user approval">
  <action>Review generated BRD against quality standards:
    ✓ Non-fluffy, to-the-point, practical
    ✓ No wordiness or verbose explanations
    ✓ Tables used over prose throughout
    ✓ All sections numbered (1, 2, 3, 3.1, 3.2...)
    ✓ All template variables filled (no placeholders)
    ✓ Token-efficient structure maintained
    ✓ Requirements clearly categorized by ERPNext status
    ✓ Module coverage accurately mapped
  </action>

  <action>Present summary of generated BRD:
    - Total requirements analyzed: {{total_requirements}}
    - Standard features: {{standard_count}}
    - Configuration needed: {{config_count}}
    - Custom development: {{custom_count}}
    - ERPNext modules involved: [list]
  </action>

  <ask>Review the Business Requirements Document. Any sections need refinement? Any deviations from expected output?</ask>

  <check if="user requests changes">
    <action>Note requested changes</action>
    <action>Apply changes with user approval</action>
    <action>Re-validate quality standards</action>
    <action>Update template outputs as needed</action>
  </check>

  <action>Confirm document approved and ready for next phase</action>
</step>

<step n="5" goal="Completion">
  <action>Confirm BRD is complete, validated, and saved to: {{default_output_file}}</action>
  <action>Remind user this document is ready for handoff to Frappe Solution Architect</action>
  <action>Suggest next step: Load Frappe SA agent to create Technical Specification</action>
</step>

</workflow>
