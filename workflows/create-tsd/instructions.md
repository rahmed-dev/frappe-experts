# Create TSD Workflow Instructions

<critical>Create Technical Specification Document with UX focus from Business Requirements</critical>

<workflow>

<step n="1" goal="Load Business Requirements">
  <ask>Provide the Business Requirements Document (file path or location)</ask>
  <action>Load and read COMPLETE BRD</action>
  <action>Understand all requirements, priorities, and business context</action>
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
  <template-output>technical_specification</template-output>

  <action>Generate complete TSD with:

# Technical Specification Document

**Project:** {{project_name}}
**Based on:** Business Requirements Document v{{brd_version}}
**Date:** {{date}}
**Prepared by:** Frappe Solution Architect

## Executive Summary

[Technical approach and architecture decisions]

## Solution Architecture Overview

- **Approach:** [Configuration-heavy / Script-based / Custom App]
- **Tier Classification:** [Tier 2, 3, or 4]
- **Complexity:** [Low / Medium / High]
- **Upgrade Safety:** ✅ Safe / ⚠️ Requires monitoring

## Technical Design

[For each feature:]

### Feature: [Name]

**Business Requirement Reference:** [Link to BRD requirement]

**Technical Approach:** [Tier 2: Configuration / Tier 3: Scripts / Tier 4: Custom App]

**UX/UI Design:**
- Form Layout Strategy
- User Interactions
- Visual Indicators
- Frappe UI Components Used

**DocType Design:**
[Table of fields with types, options, mandatory status]

**Business Logic:**
- Server Script: [What and when]
- Client Script: [Form behavior]
- Hooks: [doc_events, scheduler_events]

**Workflow Design:** [If applicable]

**API Design:** [If applicable]

**Integration Points:**
- Reads from: [Other DocTypes]
- Writes to: [Other DocTypes]

**Performance Considerations:**
- Indexing: [Fields]
- Background Jobs: [Heavy operations]

**Migration Strategy:** [If applicable]

---

## Data Model Diagram

[ERD showing DocType relationships]

## Configuration Requirements

- Custom Fields: [List]
- Property Setters: [List]
- Workflows: [List]

## Custom Development Requirements

[If Tier 4]

## Upgrade Safety Assessment

- Core Modifications: None ✅
- Risk Level: Low/Medium/High

## Performance Expectations

[Data volume, concurrent users, response times]

## Testing Requirements

[What to test]

## Next Steps

Hand off to Implementation Planner for sequencing.
  </action>

  <action>Save to {{default_output_file}}</action>
</step>

<step n="5" goal="Review and validate">
  <ask>Review the Technical Specification. Any adjustments?</ask>

  <check if="user requests changes">
    <action>Make adjustments</action>
    <action>Save updated version</action>
  </check>
</step>

<step n="6" goal="Completion">
  <action>Confirm TSD complete and saved</action>
  <action>Suggest next step: Load Phase Master agent to create Implementation Plan</action>
</step>

</workflow>
