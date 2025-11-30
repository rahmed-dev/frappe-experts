# Diagnose Error Workflow Instructions

<critical>Root cause analysis for 3 AM production issues - plain language first, technical details after</critical>
<critical>Communicate in {communication_language} throughout</critical>

<critical>Follow template standards from: {project-root}/{bmad_folder}/frappe-experts/standards/template-standards.md</critical>
<critical>Output MUST be token-efficient: tables over prose, numbered sections, no fluff</critical>

<workflow>

<step n="1" goal="Capture error information">
  <ask>What's the error you're facing? Provide any of the following:

a) Error message (paste full error text)
b) Error logs (provide file path or paste logs)
c) Screenshot of error
d) Description of what happened
e) Multiple sources (combination above)
  </ask>

  <action>Capture error details</action>
  <action>Store as {{error_description}}</action>

  <ask>When did this start happening? (e.g., "Just now", "After deployment", "Always been there")</ask>
  <action>Store as {{error_timing}}</action>

  <ask>What were you/user trying to do when error occurred?</ask>
  <action>Store as {{user_action}}</action>

  <ask>Error severity? (Choose one):
1. 🔴 CRITICAL - Production down, users blocked
2. 🟡 HIGH - Feature broken, workaround exists
3. 🟢 MEDIUM - Minor issue, low impact
4. ⚪ LOW - Cosmetic, no business impact
  </ask>
  <action>Store as {{severity}}</action>
</step>

<step n="2" goal="Triage and analyze">
  <action>Based on severity, set urgency:
    - 🔴 CRITICAL: Must fix NOW (stop everything else)
    - 🟡 HIGH: Fix today (within hours)
    - 🟢 MEDIUM: Fix this week
    - ⚪ LOW: Backlog
  </action>

  <action>Analyze error for root cause:
    - Read error message/stack trace
    - Identify error type (validation, permission, code bug, data issue, config)
    - Trace back to origin (which file, function, line)
    - Identify trigger (what action caused this)
    - Check recent changes (deployments, config changes, data migrations)
  </action>

  <action>Categorize error:
    - Data Issue (bad data, missing records, corrupted)
    - Permission Issue (role, user permissions, DocType permissions)
    - Validation Error (business rule violated)
    - Code Bug (logic error, null pointer, syntax)
    - Configuration Issue (wrong settings, missing config)
    - Integration Failure (API down, timeout, auth failed)
    - Performance Issue (timeout, memory, slow query)
    - Environment Issue (server resources, services down)
  </action>
</step>

<step n="3" goal="Generate diagnosis report">
  <template-output>error_diagnosis_report</template-output>

  <action>Generate comprehensive diagnosis:

# Error Diagnosis Report

**Error ID:** {{error_id}}
**Date:** {{date}}
**Severity:** {{severity}}
**Diagnosed by:** Debug Master

---

## 🎯 What's Happening (Plain Language)

[Explain in simple terms what's broken and why user is seeing this error]

**Example:**
"The system is trying to create a Stock Entry but can't find the Warehouse record. It's like trying to deliver a package to an address that doesn't exist."

---

## 📊 Severity Assessment

**Impact:** {{severity}}
- **Users Affected:** [Who can't work?]
- **Business Impact:** [What business process is blocked?]
- **Urgency:** [Must fix now / Fix today / Fix this week / Backlog]

---

## 🔍 Root Cause

**Primary Cause:**
[What is the actual root cause - not just the symptom]

**How This Happened:**
[Sequence of events that led to this error]

**Why It Wasn't Caught Earlier:**
[Missing validation? Test gap? Recent change?]

---

## 🛠️ Technical Details

**Error Type:** [Validation / Permission / Code Bug / Data Issue / Config / Integration / Performance]

**Error Message:**
```
[Full error message]
```

**Stack Trace Analysis:**
```
[Key parts of stack trace with explanation]

File: frappe/stock/doctype/stock_entry/stock_entry.py
Line: 156
Function: validate_warehouse()
Issue: Warehouse 'WH-001' does not exist in database
```

**Affected Components:**
- DocType: [Which DocType]
- Module: [Which module]
- Integration Points: [Any integrations affected]

**Database Impact:**
- [Any corrupted data?]
- [Missing records?]
- [Inconsistent state?]

---

## 🎯 Recommended Fix

### Quick Fix (Immediate Relief)

**What:** [Quick action to unblock users NOW]

**Steps:**
1. [Specific step]
2. [Specific step]
3. [Verification step]

**Limitation:** [Why this is only temporary if applicable]

---

### Permanent Fix (Root Cause Resolution)

**What:** [Long-term solution]

**Implementation:**

1. **[Step 1 - e.g., Add validation]**
   ```python
   # Code change needed
   def validate_warehouse(self):
       if not frappe.db.exists("Warehouse", self.warehouse):
           frappe.throw(_("Warehouse {0} does not exist").format(self.warehouse))
   ```
   **File:** `frappe/stock/doctype/stock_entry/stock_entry.py`
   **Function:** `validate_warehouse()`

2. **[Step 2 - e.g., Data cleanup]**
   ```sql
   -- SQL to fix data
   UPDATE `tabStock Entry`
   SET warehouse = 'Stores - C'
   WHERE warehouse = 'WH-001';
   ```

3. **[Step 3 - e.g., Add test]**
   **Create test:** `test_stock_entry_invalid_warehouse()`

**Testing Required:**
- [ ] Test scenario 1
- [ ] Test scenario 2
- [ ] Regression test

---

## 🚨 Preventive Measures

**To prevent this in future:**

1. **Validation:** [What validation should be added]
2. **Testing:** [What test scenario was missing]
3. **Monitoring:** [What should we monitor]
4. **Documentation:** [What should be documented]

---

## 📋 Action Plan

### Immediate (Next 30 minutes)
- [ ] [Action 1 - e.g., Apply quick fix]
- [ ] [Action 2 - e.g., Notify affected users]
- [ ] [Action 3 - e.g., Verify fix working]

### Short-term (Today)
- [ ] [Action - e.g., Implement permanent fix]
- [ ] [Action - e.g., Test in staging]
- [ ] [Action - e.g., Deploy to production]

### Long-term (This week/sprint)
- [ ] [Action - e.g., Add test coverage]
- [ ] [Action - e.g., Update documentation]
- [ ] [Action - e.g., Code review similar areas]

---

## 🔗 Related Issues

**Similar errors to check:**
- [Related error pattern 1]
- [Related error pattern 2]

**Documentation:**
- [Link to ERPNext docs if relevant]
- [Link to Frappe Framework docs if relevant]

---

## 📝 Additional Notes

[Any other context, warnings, or observations]

---

## ✅ Resolution Verification

**How to verify fix worked:**
1. [Verification step 1]
2. [Verification step 2]
3. [Success criteria]

**Monitoring:**
- Check error logs for next 24 hours
- Monitor [specific metric/process]
- User feedback

  </action>

  <action>Save to {{default_output_file}}</action>
</step>

<step n="4" goal="Provide immediate guidance">
  <action>If severity is CRITICAL or HIGH:
    - Highlight the "Quick Fix" section
    - Provide step-by-step guidance for immediate relief
    - Stay online for follow-up questions during fix
  </action>

  <action>If code inspection needed:
    - Provide file paths to check
    - Suggest using grep/search to find related code
    - Recommend debugging techniques (print statements, logger, bench console)
  </action>
</step>

<step n="5" goal="Review and expand">
  <ask>Review the diagnosis. Need me to:
a) Investigate deeper (specific area)
b) Provide more technical details
c) Help with implementation
d) Diagnosis is complete
  </ask>

  <check if="user needs deeper investigation">
    <action>Investigate specific area user mentioned</action>
    <action>Update diagnosis report</action>
  </check>

  <check if="user needs implementation help">
    <action>Suggest: "Load Nexus agent for implementation" OR provide detailed implementation guide</action>
  </check>
</step>

<step n="6" goal="Completion">
  <action>Confirm diagnosis complete and saved</action>
  <action>Provide diagnosis summary with action plan</action>
  <action>Remind: Update this diagnosis report after fix is applied to document resolution</action>
</step>

</workflow>
