# Frappe Experts Module - Template Standards

**Version:** 1.0
**Date:** 2024-11-16
**Purpose:** Token-efficient, practical documentation standards for all workflows

---

## Token-Efficient Document Structure

All document outputs in this module MUST follow this structure to minimize token usage while maximizing information density.

### 1. Document Header

```markdown
# {{document_title}}

**Project:** {{project_name}} | **Version:** {{version}} | **Date:** {{date}}
```

**Rationale:** Single line with key metadata, easy to scan, no fluff.

---

### 2. Table of Contents

```markdown
## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Section Name](#2-section-name)
   2.1 [Subsection](#21-subsection)
   2.2 [Subsection](#22-subsection)
3. [Section Name](#3-section-name)
4. [Next Steps](#n-next-steps)
```

**Requirements:**
- ✓ Numbered sections (1, 2, 3...)
- ✓ Numbered subsections (2.1, 2.2, 2.3...)
- ✓ Anchor links for navigation
- ✓ Max 2 levels deep (section.subsection)

**Rationale:** Quick navigation, easy to reference ("See 3.2"), hierarchical structure.

---

### 3. Executive Summary

```markdown
## 1. Executive Summary

| Aspect | Detail |
|--------|--------|
| Purpose | {{purpose}} |
| Scope | {{scope}} |
| Key Decisions | {{key_decisions}} |
| Timeline | {{timeline}} |
```

**Requirements:**
- ✓ Use table format (not prose)
- ✓ 3-5 key aspects max
- ✓ One-line details (not paragraphs)

**Rationale:** 70% fewer tokens than prose, scannable, to-the-point.

---

### 4. Content Sections

**Format Options:**

#### Option A: Feature/Component Table

```markdown
## 2. Features

### 2.1 {{Feature Name}}

| Component | Specification |
|-----------|---------------|
| Description | {{brief_description}} |
| Tier | {{tier_level}} |
| Dependencies | {{dependencies}} |
| DocType | {{doctype_name}} |
| Status | {{status}} |

**Logic:**
1. {{step_1}}
2. {{step_2}}
3. {{step_3}}

**Expected Behavior:**
- {{behavior_1}}
- {{behavior_2}}
```

#### Option B: Detailed Specification Table

```markdown
## 3. Technical Design

### 3.1 {{Component Name}}

| Field | Type | Mandatory | Default | Options | Notes |
|-------|------|-----------|---------|---------|-------|
| {{field_name}} | {{type}} | Yes/No | {{default}} | {{opts}} | {{notes}} |
```

#### Option C: Decision/Rationale Table

```markdown
## 4. Architectural Decisions

| Decision | Options Considered | Chosen | Rationale |
|----------|-------------------|--------|-----------|
| {{decision_topic}} | {{option1}}, {{option2}} | {{chosen}} | {{why}} |
```

**Requirements:**
- ✓ Tables for structured data (fields, features, decisions)
- ✓ Numbered lists for sequential steps
- ✓ Bullet lists for non-sequential items
- ✓ NO long prose paragraphs
- ✓ Each section self-contained (can read independently)

**Rationale:** Tables = more information, fewer tokens. Lists = structured, scannable.

---

### 5. Next Steps Section

```markdown
## N. Next Steps

| Action | Responsibility | Priority |
|--------|---------------|----------|
| {{action_1}} | {{who}} | High/Medium/Low |
| {{action_2}} | {{who}} | High/Medium/Low |
```

**Requirements:**
- ✓ Always last section
- ✓ Clear action items
- ✓ Assigned responsibility
- ✓ Priority indicated

---

## Quality Standards

All documents MUST meet these standards:

### Content Quality

- ✅ **Non-fluffy** - No marketing speak, no excessive adjectives
- ✅ **To-the-point** - Direct, clear, concise
- ✅ **Practical** - Actionable, implementable, realistic
- ✅ **Reliable** - Accurate, validated, tested
- ❌ **NOT wordy** - No verbose explanations
- ❌ **NOT repetitive** - Don't repeat information

### Structure Quality

- ✅ **Numbered sections** - 1, 2, 3 (not "Section 1", just "1")
- ✅ **Hierarchical** - 2.1, 2.2, 2.3 for subsections
- ✅ **Tables preferred** - Use tables over prose for structured data
- ✅ **Self-contained sections** - Each section readable independently
- ✅ **No placeholders** - All {{variables}} filled, no [TODO] or [TBD]

### Token Efficiency

- ✅ **40-60% fewer tokens** than prose-heavy documents
- ✅ **Scannable** - Reader can find information in < 10 seconds
- ✅ **Referenceable** - "See section 3.2.1" works
- ✅ **Modular** - Can extract single section without context loss

---

## Anti-Patterns to Avoid

### ❌ DON'T: Verbose Prose

```markdown
## Feature Description

This feature will allow users to manage their customer data more effectively
by providing them with a comprehensive interface that includes all the necessary
fields and functionality they need to successfully track and maintain customer
relationships in a way that is both efficient and user-friendly.
```

### ✅ DO: Token-Efficient Table

```markdown
## 2.1 Customer Management

| Aspect | Specification |
|--------|---------------|
| Purpose | Track customer data and relationships |
| Interface | Form with required fields + relationship tracking |
| Efficiency | Single screen, minimal clicks |
```

---

### ❌ DON'T: Redundant Information

```markdown
## Customer Fields

The Customer DocType will have the following fields:
- Name: This field stores the customer name
- Email: This field stores the customer email
- Phone: This field stores the customer phone number
```

### ✅ DO: Concise Table

```markdown
## 2.2 Customer Fields

| Field | Type | Purpose |
|-------|------|---------|
| name | Data | Customer name |
| email | Data | Contact email |
| phone | Data | Contact phone |
```

---

### ❌ DON'T: Unnumbered Sections

```markdown
## Requirements
### Functional Requirements
### Non-Functional Requirements
## Design
### UX Design
### Technical Design
```

### ✅ DO: Numbered Hierarchy

```markdown
## 2. Requirements
### 2.1 Functional Requirements
### 2.2 Non-Functional Requirements
## 3. Design
### 3.1 UX Design
### 3.2 Technical Design
```

---

## Validation Checklist

Before finalizing any document, validate:

### Structure
- [ ] Table of Contents present with numbered sections
- [ ] All sections numbered (1, 2, 3, 2.1, 2.2, etc.)
- [ ] Executive Summary in table format
- [ ] Next Steps section present

### Content
- [ ] Tables used for structured data (not prose)
- [ ] No verbose or wordy explanations
- [ ] No fluff or marketing language
- [ ] All information practical and actionable
- [ ] No placeholder text remains

### Quality
- [ ] Each section self-contained
- [ ] Easy to scan and find information
- [ ] Can reference specific sections (e.g., "See 3.2")
- [ ] Token-efficient (40-60% reduction vs prose)

### Completeness
- [ ] All required sections present
- [ ] All variables filled
- [ ] All instructions followed
- [ ] User-approved (if deviations exist)

---

## Token Savings Examples

### Example 1: Requirements Documentation

**Prose Version (385 tokens):**
> The system should provide comprehensive customer management capabilities that allow
> users to efficiently track and maintain customer information. This includes the ability
> to create new customer records, update existing customer data, view customer history,
> and manage customer relationships. The interface should be intuitive and user-friendly,
> providing all necessary fields in a logical layout. Users should be able to quickly
> access customer information and perform common operations with minimal clicks. The system
> must ensure data validation to maintain data quality and integrity.

**Table Version (145 tokens):**

| Requirement | Specification |
|-------------|---------------|
| Feature | Customer management |
| Operations | Create, update, view, manage relationships |
| Interface | Intuitive form with logical field layout |
| Efficiency | Quick access, minimal clicks |
| Data Quality | Validation enforced |

**Savings: 62% fewer tokens**

---

## Template Variable Naming

Use descriptive snake_case for all template variables:

**✅ Good:**
- `{{project_name}}`
- `{{technical_approach}}`
- `{{acceptance_criteria}}`
- `{{next_steps}}`

**❌ Avoid:**
- `{{pn}}` (too cryptic)
- `{{ProjectName}}` (wrong case)
- `{{the_next_steps_to_take}}` (too verbose)

---

## Document Versioning

Include version and date in all documents:

```markdown
**Version:** 1.0
**Date:** 2024-11-16
```

When updating:
- Minor changes (typos, clarifications): Increment 1.0 → 1.1
- Major changes (new sections, restructuring): Increment 1.1 → 2.0

---

**This is a living document. Update as module standards evolve.**
