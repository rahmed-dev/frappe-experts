# Create Implementation Plan Workflow Instructions

<critical>Transform Technical Specification into sequenced, dependency-aware Implementation Plan optimized for Frappe/ERPNext development</critical>
<critical>Frappe development has TWO distinct layers: UI-based configuration (no-code/low-code) and Code-based implementation</critical>

<workflow>

<step n="1" goal="Load Technical Specification and gather context">
  <ask>Provide the Technical Specification Document (file path or location)</ask>
  <action>Load and read COMPLETE TSD</action>
  <action>Understand all features, technical approaches, and complexity levels</action>
  <ask>What is the project name?</ask>
  <action>Store as {{project_name}}</action>
  <ask>What is the TSD version? (e.g., 1.0, 2.1)</ask>
  <action>Store as {{tsd_version}}</action>
</step>

<step n="2" goal="Analyze dependencies and constraints">
  <action>For each feature from TSD, identify:
    - Technical dependencies (what must exist before this can be built)
    - Data dependencies (what data/DocTypes this needs)
    - Integration dependencies (what APIs/hooks this relies on)
    - User dependencies (what features users need trained on first)
    - UI-to-Code dependencies (what UI config must be done before code can be written)
  </action>

  <action>Map dependency graph with special attention to:
    - UI configuration that must happen first (creates DocTypes, fields, etc.)
    - Code implementation that depends on UI being configured
  </action>

  <action>Identify critical path (longest dependency chain)</action>
  <action>Identify quick wins (high value, low dependency)</action>

  <template-output>critical_path</template-output>
  <template-output>quick_wins</template-output>
  <template-output>risk_areas</template-output>
</step>

<step n="3" goal="Sequence into phases">
  <action>Apply sequencing principles:
    - Dependencies first, always (UI before Code when there's a dependency)
    - Shortest path to value
    - Incremental delivery
    - Risk mitigation (hardest unknowns early)
  </action>

  <action>Group features into phases:
    - Phase 1: MVP (Minimum Viable Product - must-haves with dependencies satisfied)
    - Phase 2: Enhancement (should-haves that build on MVP)
    - Phase 3: Polish (nice-to-haves and optimizations)
  </action>

  <action>For each phase, sequence features by dependency order</action>
</step>

<step n="4" goal="Generate Implementation Plan with Frappe-specific structure">

  <action>For EACH phase, analyze and categorize work into two sections:

  **4.1 UI-Based Configuration (Manual Setup)**

  This is what the user will configure through Frappe UI. Extract from TSD and organize by dependency order:

  **Custom DocTypes:**
  For each new DocType needed, specify in this format:
  ```
  **DocType Name**: `Custom_Name`
     - **Module**: [Which Frappe module]
     - **Fields**:
       - `field_name` (Field Type, Properties)
         * Field Type: Data, Link, Select, Check, Int, Currency, Date, etc.
         * Properties: Mandatory, Unique, Read Only, Default value, Options (for Select/Link)
     - **Permissions**: [Role-based permissions]
     - **Naming**: [Naming series or format]
     - **Expected Behavior**: [Brief description of what this DocType does]
  ```

  **Customizations (Custom Fields & Modifications):**
  For modifications to existing DocTypes (standard or custom), specify:
  ```
  **Add to [DocType Name]**:
     - `custom_field_name` (Field Type, Properties)
     - Hide field: `field_name`
     - Make mandatory: `field_name`
     - **Expected Behavior**: [Why this customization matters]
  ```

  **Workflows:**
  For approval/state workflows, specify:
  ```
  **[Workflow Name]**:
     - **Applied to**: [DocType]
     - **States**: State1 → State2 → State3
     - **Transitions**: [Who can transition and conditions]
     - **Expected Behavior**: [What this enforces]
  ```

  **Other UI Configurations:**
  Include as needed:
  - Print Formats: [Name and purpose]
  - Custom Reports: [Report name and what it shows]
  - Dashboards: [Dashboard name and widgets]
  - Naming Series: [Series configuration]

  **4.2 Code-Based Implementation (Nexus Responsibility)**

  This is what the AI agent will implement. Extract from TSD and specify:

  **Server-Side Logic:**
  ```
  **Feature**: [Feature name]
     - **File**: [Controller/API file name]
     - **Logic**: [What code does]
     - **Hooks**: [validate, before_save, on_submit, etc.]
     - **Expected Behavior**: [How it works]
  ```

  **Client-Side Logic:**
  ```
  **Feature**: [Feature name]
     - **File**: [JavaScript file]
     - **Logic**: [What code does]
     - **Expected Behavior**: [UI interaction]
  ```

  **API Endpoints:**
  ```
  **Endpoint**: [API path]
     - **Purpose**: [What it does]
     - **Expected Behavior**: [Input/Output]
  ```

  **Background Jobs:**
  ```
  **Job**: [Job name]
     - **Schedule**: [Cron or trigger]
     - **Logic**: [What it does]
     - **Expected Behavior**: [When it runs and what happens]
  ```

  </action>

  <action>Generate executive summary covering:
    - Overview of phased approach
    - Key architectural decisions from dependency analysis
    - Timeline implications (phases, not specific durations)
  </action>
  <template-output>executive_summary</template-output>

  <action>For Phase 1, generate all sections following the structure above</action>
  <template-output>phase_1_goal</template-output>
  <template-output>phase_1_custom_doctypes</template-output>
  <template-output>phase_1_customizations</template-output>
  <template-output>phase_1_workflows</template-output>
  <template-output>phase_1_other_ui_config</template-output>
  <template-output>phase_1_code_implementation</template-output>
  <template-output>phase_1_acceptance_criteria</template-output>

  <action>For Phase 2, generate all sections following the structure above</action>
  <template-output>phase_2_goal</template-output>
  <template-output>phase_2_custom_doctypes</template-output>
  <template-output>phase_2_customizations</template-output>
  <template-output>phase_2_workflows</template-output>
  <template-output>phase_2_other_ui_config</template-output>
  <template-output>phase_2_code_implementation</template-output>
  <template-output>phase_2_acceptance_criteria</template-output>

  <action>For Phase 3, generate all sections following the structure above</action>
  <template-output>phase_3_goal</template-output>
  <template-output>phase_3_custom_doctypes</template-output>
  <template-output>phase_3_customizations</template-output>
  <template-output>phase_3_workflows</template-output>
  <template-output>phase_3_other_ui_config</template-output>
  <template-output>phase_3_code_implementation</template-output>
  <template-output>phase_3_acceptance_criteria</template-output>

  <action>Generate Sprint Breakdown organizing features into 1-2 week sprints:
    - Sprint N: [Focus Area]
      - UI Config: [What to configure]
      - Code Work: [What Nexus implements]
      - Sprint Goal: [What's working by sprint end]
  </action>
  <template-output>sprint_breakdown</template-output>

  <action>Generate Testing Strategy covering:
    - UI Testing: Verify forms, workflows, permissions work as configured
    - Code Testing: Unit tests, integration tests for business logic
    - UAT: User acceptance testing milestones
  </action>
  <template-output>testing_strategy</template-output>

  <action>Generate Rollout Strategy covering:
    - Phase deployment approach
    - Training plan (when to train users on new features)
    - Data migration plan (if applicable)
  </action>
  <template-output>rollout_strategy</template-output>

  <action>Generate Risk Mitigation identifying:
    - Technical risks (complexity, unknowns)
    - Dependency risks (blocked work)
    - User adoption risks
    - For each: Impact level, mitigation strategy, which phase addresses it
  </action>
  <template-output>risk_mitigation</template-output>

  <action>Generate Success Metrics for each phase:
    - How to measure if phase objectives are met
    - User adoption indicators
    - Technical performance indicators
  </action>
  <template-output>success_metrics</template-output>

  <action>Generate Next Steps:
    - Immediate actions after plan approval
    - Who does what (user does UI, Nexus does code)
    - Hand-off to Nexus for code execution
  </action>
  <template-output>next_steps</template-output>
</step>

<step n="5" goal="Review and validate">
  <ask>Review the Implementation Plan. Any adjustments to sequencing or phasing?</ask>

  <check if="user requests changes">
    <action>Adjust sequencing</action>
    <action>Re-evaluate dependencies if needed</action>
    <action>Save updated version</action>
  </check>
</step>

<step n="6" goal="Completion">
  <action>Confirm Implementation Plan complete and saved</action>
  <action>Suggest next step: Load Nexus agent to begin execution</action>
</step>

</workflow>
