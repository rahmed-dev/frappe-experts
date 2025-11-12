# Create BRD Workflow Instructions

<critical>Execute this workflow to convert messy meeting notes into structured Business Requirements Document</critical>
<critical>Communicate in {communication_language} throughout</critical>

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
  <template-output>business_requirements_document</template-output>

  <action>Generate complete BRD with following sections:

# Business Requirements Document

**Project:** {{project_name}}
**Client:** [Client Name]
**Date:** {{date}}
**Prepared by:** ERPNext Business Analyst

## Executive Summary

[2-3 sentences: What the client needs and why]

## Business Context

- **Industry:** {{industry}}
- **Current System:** {{current_system}}
- **Key Pain Points:**
  - [Bullet list of main problems]
- **Business Goals:**
  - [What success looks like]

## Requirements Analysis

[For each requirement category:]

### [Category Name - e.g., Sales Order Processing]

**Requirement:** [Clear statement of need]

**Business Value:** [Why this matters to the business]

**ERPNext Status:**
- ✅ Standard Feature (Module: [Module Name], DocType: [DocType])
- ⚙️ Can be Configured (needs Custom Fields/Workflow)
- 🔨 Needs Custom Development (gap identified)

**Integration Touch-Points:** [Which other requirements this connects to]

**Priority:** Must-Have / Should-Have / Nice-to-Have

---

## ERPNext Module Coverage

| Module | Used For | Standard Features Leveraged |
|--------|----------|----------------------------|
| [Module] | [Purpose] | [Features] |

## Gaps Summary

- **Standard Features:** [X requirements]
- **Configuration Needed:** [Y requirements]
- **Custom Development:** [Z requirements]

## Next Steps

Hand off to Frappe Solution Architect for technical design.
  </action>

  <action>Save to output file: {{default_output_file}}</action>
  <action>Show user the file location</action>
</step>

<step n="4" goal="Review and validate">
  <ask>Review the Business Requirements Document above. Any adjustments needed?</ask>

  <check if="user requests changes">
    <action>Make requested adjustments</action>
    <action>Save updated version</action>
  </check>
</step>

<step n="5" goal="Completion">
  <action>Confirm BRD is complete and saved</action>
  <action>Remind user this document is ready for handoff to Frappe Solution Architect</action>
  <action>Suggest next step: Load Frappe SA agent to create Technical Specification</action>
</step>

</workflow>
