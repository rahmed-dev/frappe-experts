# Create User Guide Workflow Instructions

<critical>Generate anti-fluff, action-oriented documentation that gets users productive FAST</critical>
<critical>Communicate in {communication_language} throughout</critical>

<critical>Follow template standards from: {project-root}/.bmad/custom/modules/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>

<workflow>

<step n="1" goal="Identify documentation target">
  <ask>What feature/module needs documentation?

Options:
a) ERPNext standard feature (which module/DocType?)
b) Custom feature from Technical Spec (provide TSD)
c) Workflow process (provide workflow name)
d) Integration (provide integration details)
  </ask>

  <action>Load context (TSD, existing docs, or ERPNext docs)</action>
  <action>Store as {{feature_name}}</action>

  <ask>Who is the target user? (e.g., Sales Team, Warehouse Staff, Accountant)</ask>
  <action>Store as {{target_user}}</action>
</step>

<step n="2" goal="Map user workflow">
  <action>Identify the user's journey:
    - What triggers this task?
    - What's the goal?
    - What steps must they take?
    - Where do they get stuck?
    - What's the success criteria?
  </action>

  <action>Break into logical sections:
    - Common scenario (80% use case)
    - Quick actions (daily tasks)
    - Troubleshooting (when things go wrong)
  </action>
</step>

<step n="3" goal="Generate Quick Guide">
  <template-output>user_quick_guide</template-output>

  <action>Generate anti-fluff documentation:

# [Feature Name] - Quick Guide

**For:** {{target_user}}
**Updated:** {{date}}

---

## What This Does

[ONE sentence: What problem this solves]

---

## Quick Start (Most Common Scenario)

### Step 1: [Action Verb - e.g., "Open Sales Order"]

1. Navigate to: **Selling > Sales Order > New**
2. Fill required fields:
   - **Customer:** Start typing customer name
   - **Delivery Date:** Click calendar, select date
   - **Items:** Click "Add Row"

💡 **Pro tip:** [One practical tip]

### Step 2: [Next Action Verb]

[Continue with numbered steps, SHOWING exactly what to click/type]

### Step 3: [Final Action]

[Complete the workflow]

✅ **You're done when:** [Success indicator - what they should see]

---

## Quick Actions

### [Common Task 1]
**Shortcut:** [If any]
**Steps:**
1. [Action]
2. [Action]

### [Common Task 2]
**Steps:**
1. [Action]
2. [Action]

---

## Field Reference

| Field | What It Means | When Required |
|-------|---------------|---------------|
| [Field Name] | [Plain language explanation] | [Always / Only if...] |

---

## Permissions

**Who can do what:**
- **[Role]:** Can view, create, submit
- **[Role]:** Can only view

❌ **Can't see this feature?** Ask your System Manager for access.

---

## Common Issues

### "I can't submit the document"
**Why:** [Reason]
**Fix:**
1. Check [field/permission/status]
2. [Specific action]

### "[Error message]"
**Why:** [Reason]
**Fix:** [Specific action]

---

## Related Features

- **[Related Feature 1]:** [One sentence why user might need this]
- **[Related Feature 2]:** [One sentence connection]

---

## Need Help?

1. Check error message at top of screen (red bar)
2. Ask System Administrator: {{support_contact}}

  </action>

  <action>Save to {{default_output_file}}</action>
</step>

<step n="4" goal="Screenshot guidance">
  <ask>Would you like me to generate screenshot instructions for visual documentation?</ask>

  <check if="user wants screenshot guidance">
    <action>Generate list of screenshots needed:
      - [Step 1: Screenshot of navigation path]
      - [Step 2: Screenshot of form with key fields highlighted]
      - [Step 3: Screenshot of success state]
    </action>
    <action>Append screenshot instructions to guide</action>
  </check>
</step>

<step n="5" goal="Review and validate">
  <ask>Review the Quick Guide. Any adjustments?</ask>

  <check if="user requests changes">
    <action>Make adjustments (keeping anti-fluff principle)</action>
    <action>Save updated version</action>
  </check>
</step>

<step n="6" goal="Completion">
  <action>Confirm Quick Guide complete and saved</action>
  <action>Remind: This guide covers 80% use case - create separate guides for edge cases if needed</action>
</step>

</workflow>
