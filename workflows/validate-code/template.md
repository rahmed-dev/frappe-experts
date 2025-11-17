# Code Validation Report: {{feature_name}}

**Validated:** {{file_paths}} | **Date:** {{date}}

---

## Table of Contents

1. [Validation Summary](#1-validation-summary)
2. [Anti-Patterns Detected](#2-anti-patterns-detected)
3. [Best Practices Analysis](#3-best-practices-analysis)
4. [Security Review](#4-security-review)
5. [Performance Review](#5-performance-review)
6. [Recommendations](#6-recommendations)

---

## 1. Validation Summary

| Aspect | Status | Issues Found |
|--------|--------|--------------|
| Anti-Patterns | {{anti_pattern_status}} | {{anti_pattern_count}} |
| Best Practices | {{best_practice_status}} | {{best_practice_count}} |
| Security | {{security_status}} | {{security_count}} |
| Performance | {{performance_status}} | {{performance_count}} |
| Overall Grade | {{overall_grade}} | {{total_issues}} |

**Overall Assessment:** {{overall_assessment}}

---

## 2. Anti-Patterns Detected

### 2.1 Critical Issues

{{critical_anti_patterns}}

### 2.2 High Priority Issues

{{high_anti_patterns}}

### 2.3 Medium Priority Issues

{{medium_anti_patterns}}

---

## 3. Best Practices Analysis

### 3.1 Server-Side Design

| Check | Status | Details |
|-------|--------|---------|
| Data operations in Python | {{server_side_status}} | {{server_side_details}} |
| Using frappe.call() | {{frappe_call_status}} | {{frappe_call_details}} |
| Proper error handling | {{error_handling_status}} | {{error_handling_details}} |

### 3.2 Frappe Standards Compliance

| Standard | Compliance | Notes |
|----------|------------|-------|
| frappe.ui.Dialog usage | {{dialog_compliance}} | {{dialog_notes}} |
| @frappe.whitelist() decorator | {{whitelist_compliance}} | {{whitelist_notes}} |
| hooks.py registration | {{hooks_compliance}} | {{hooks_notes}} |
| Permission checks | {{permission_compliance}} | {{permission_notes}} |

### 3.3 Code Quality

| Metric | Score | Comments |
|--------|-------|----------|
| Code Complexity | {{complexity_score}} | {{complexity_comments}} |
| Function Size | {{function_size_score}} | {{function_size_comments}} |
| Code Reusability | {{reusability_score}} | {{reusability_comments}} |
| Documentation | {{documentation_score}} | {{documentation_comments}} |

---

## 4. Security Review

### 4.1 Security Checks

| Check | Status | Findings |
|-------|--------|----------|
| Permission validation | {{permission_check_status}} | {{permission_findings}} |
| SQL injection prevention | {{sql_injection_status}} | {{sql_injection_findings}} |
| XSS prevention | {{xss_status}} | {{xss_findings}} |
| Input sanitization | {{input_sanitization_status}} | {{input_sanitization_findings}} |

### 4.2 Security Issues

{{security_issues}}

---

## 5. Performance Review

### 5.1 Performance Checks

| Check | Status | Impact |
|-------|--------|--------|
| Database query efficiency | {{query_efficiency_status}} | {{query_efficiency_impact}} |
| N+1 query patterns | {{n_plus_one_status}} | {{n_plus_one_impact}} |
| Cache usage | {{cache_usage_status}} | {{cache_usage_impact}} |
| Bulk operations | {{bulk_ops_status}} | {{bulk_ops_impact}} |

### 5.2 Performance Issues

{{performance_issues}}

---

## 6. Recommendations

### 6.1 Required Fixes (Must Fix Before Deployment)

| Issue | File:Line | Fix Required | Priority |
|-------|-----------|--------------|----------|
{{required_fixes}}

### 6.2 Suggested Improvements (Should Fix)

| Issue | File:Line | Improvement | Priority |
|-------|-----------|-------------|----------|
{{suggested_improvements}}

### 6.3 Optional Enhancements (Nice to Have)

| Area | Suggestion | Benefit |
|------|------------|---------|
{{optional_enhancements}}

### 6.4 Code Examples

{{code_examples}}

---

**Document Version:** 1.0
**Validated by:** Frappe Nexus
