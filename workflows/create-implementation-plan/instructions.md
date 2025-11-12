# Create Implementation Plan Workflow Instructions

<critical>Transform Technical Specification into sequenced, dependency-aware Implementation Plan</critical>

<workflow>

<step n="1" goal="Load Technical Specification">
  <ask>Provide the Technical Specification Document (file path or location)</ask>
  <action>Load and read COMPLETE TSD</action>
  <action>Understand all features, technical approaches, and complexity levels</action>
</step>

<step n="2" goal="Analyze dependencies and constraints">
  <action>For each feature from TSD, identify:
    - Technical dependencies (what must exist before this can be built)
    - Data dependencies (what data/DocTypes this needs)
    - Integration dependencies (what APIs/hooks this relies on)
    - User dependencies (what features users need trained on first)
  </action>

  <action>Map dependency graph</action>
  <action>Identify critical path (longest dependency chain)</action>
  <action>Identify quick wins (high value, low dependency)</action>
</step>

<step n="3" goal="Sequence into phases">
  <action>Apply sequencing principles:
    - Dependencies first, always
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

<step n="4" goal="Generate Implementation Plan">
  <template-output>implementation_plan</template-output>

  <action>Generate complete Implementation Plan with:

# Implementation Plan

**Project:** {{project_name}}
**Based on:** Technical Specification Document v{{tsd_version}}
**Date:** {{date}}
**Prepared by:** Phase Master

## Executive Summary

[Overview of phased approach and delivery timeline]

## Dependency Analysis

### Critical Path
[Longest dependency chain that determines minimum timeline]

### Quick Wins
[High-value features with low dependencies - candidates for early delivery]

### Risk Areas
[Complex features with unknowns - tackle early]

## Implementation Phases

### Phase 1: MVP (Minimum Viable Product)

**Goal:** Deliver core functionality that solves primary business need

**Duration:** [X weeks/sprints]

**Features:**
1. [Feature Name]
   - **Technical Approach:** [Tier 2/3/4]
   - **Dependencies:** [What must exist first]
   - **Estimated Effort:** [Hours/Days]
   - **Deliverable:** [What user can do after this]

[Repeat for each MVP feature in dependency order]

**Phase 1 Acceptance Criteria:**
- [What must work]
- [What user can accomplish]

---

### Phase 2: Enhancement

**Goal:** Extend core with additional capabilities

**Duration:** [X weeks/sprints]

**Features:**
[Same structure as Phase 1]

**Phase 2 Acceptance Criteria:**
[What must work]

---

### Phase 3: Polish

**Goal:** Optimize and add nice-to-haves

**Duration:** [X weeks/sprints]

**Features:**
[Same structure as Phase 1]

**Phase 3 Acceptance Criteria:**
[What must work]

---

## Sprint Breakdown

### Sprint 1: [Focus Area]
- Feature: [Name]
- Feature: [Name]
- **Sprint Goal:** [What's working by end of sprint]

### Sprint 2: [Focus Area]
[Same structure]

[Continue for all sprints]

## Testing Strategy

- **Unit Testing:** [When and what]
- **Integration Testing:** [Between phases]
- **UAT:** [User acceptance testing milestones]

## Rollout Strategy

- **Phase 1:** [How to deploy MVP]
- **Training:** [When to train users]
- **Data Migration:** [When to migrate legacy data]

## Risk Mitigation

- **Risk:** [Description]
  - **Impact:** High/Medium/Low
  - **Mitigation:** [How we're handling it]
  - **Phase:** [Which phase addresses this]

## Success Metrics

- **Phase 1:** [How we measure MVP success]
- **Phase 2:** [How we measure enhancement success]
- **Phase 3:** [How we measure polish success]

## Next Steps

Hand off to Nexus for execution.
  </action>

  <action>Save to {{default_output_file}}</action>
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
