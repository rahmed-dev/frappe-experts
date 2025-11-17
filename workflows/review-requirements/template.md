# Requirements Analysis Report: {{project_name}}

**Source:** {{requirements_source}} | **Date:** {{date}}

---

## Table of Contents

1. [Analysis Summary](#1-analysis-summary)
2. [Requirements Breakdown](#2-requirements-breakdown)
3. [ERPNext Module Coverage](#3-erpnext-module-coverage)
4. [Gap Analysis](#4-gap-analysis)
5. [Integration Touch-points](#5-integration-touch-points)
6. [Priority Recommendations](#6-priority-recommendations)
7. [Next Steps](#7-next-steps)

---

## 1. Analysis Summary

| Aspect | Detail |
|--------|--------|
| Total Requirements | {{total_requirements}} |
| Standard Features | {{standard_count}} ({{standard_percentage}}%) |
| Configuration Needed | {{config_count}} ({{config_percentage}}%) |
| Custom Development | {{custom_count}} ({{custom_percentage}}%) |
| ERPNext Modules Used | {{modules_count}} |

---

## 2. Requirements Breakdown

### 2.1 Standard ERPNext Features

| Requirement | ERPNext Module | DocType/Feature | Notes |
|-------------|----------------|-----------------|-------|
{{standard_features}}

### 2.2 Configuration Required

| Requirement | Module | Configuration Type | Complexity |
|-------------|--------|-------------------|------------|
{{config_requirements}}

### 2.3 Custom Development Required

| Requirement | Reason for Custom | Estimated Effort | Tier |
|-------------|-------------------|------------------|------|
{{custom_requirements}}

---

## 3. ERPNext Module Coverage

### 3.1 Modules Utilized

| Module | Usage Percentage | Features Used | Customizations |
|--------|-----------------|---------------|----------------|
{{module_coverage}}

### 3.2 Module Dependencies

| Primary Module | Dependent Modules | Integration Type |
|----------------|-------------------|------------------|
{{module_dependencies}}

---

## 4. Gap Analysis

### 4.1 Feature Gaps

| Gap | Impact | Mitigation | Priority |
|-----|--------|------------|----------|
{{feature_gaps}}

### 4.2 Configuration vs Custom

| Requirement | Standard Approach | Proposed Approach | Rationale |
|-------------|-------------------|-------------------|-----------|
{{config_vs_custom}}

### 4.3 Upgrade Safety

| Custom Item | Upgrade Risk | Mitigation Strategy |
|-------------|--------------|---------------------|
{{upgrade_safety}}

---

## 5. Integration Touch-points

### 5.1 Internal Integrations

| From Module | To Module | Data Flow | Trigger |
|-------------|-----------|-----------|---------|
{{internal_integrations}}

### 5.2 External Integrations

| External System | Integration Type | Direction | Requirements |
|----------------|-----------------|-----------|--------------|
{{external_integrations}}

---

## 6. Priority Recommendations

### 6.1 Quick Wins (Standard Features)

| Requirement | ERPNext Feature | Effort | Business Value |
|-------------|----------------|--------|----------------|
{{quick_wins}}

### 6.2 Configuration Projects

| Requirement | Configuration Type | Effort | Priority |
|-------------|-------------------|--------|----------|
{{config_projects}}

### 6.3 Custom Development Projects

| Requirement | Development Type | Effort | Priority |
|-------------|-----------------|--------|----------|
{{custom_projects}}

---

## 7. Next Steps

| Action | Responsibility | Priority | Timeline |
|--------|---------------|----------|----------|
| Review analysis with stakeholders | Business Analyst | High | Immediate |
| Prioritize requirements | Product Owner | High | This week |
| Create BRD for approved scope | ERPNext BA | High | Next |
| Create TSD for custom items | Frappe SA | Medium | After BRD |

---

**Document Version:** 1.0
**Prepared by:** ERPNext Business Analyst
