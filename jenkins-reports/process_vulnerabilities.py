#!/usr/bin/env python3
"""
AI-Driven Vulnerability Processing Script
Processes security scan reports and generates policies using LLMs
"""

import json
import os
import sys
from typing import Dict, List, Any
from datetime import datetime

def load_report(file_path: str) -> Dict[str, Any]:
    """Load and parse a JSON security report"""
    try:
        with open(file_path, 'r') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return {}

def normalize_trivy_report(report: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Normalize Trivy container scan report"""
    vulnerabilities = []
    
    for result in report.get("Results", []):
        for vuln in result.get("Vulnerabilities", []):
            normalized = {
                "tool": "trivy",
                "vulnerability_id": vuln.get("VulnerabilityID"),
                "severity": vuln.get("Severity"),
                "title": vuln.get("Title"),
                "description": vuln.get("Description"),
                "package": vuln.get("PkgName"),
                "installed_version": vuln.get("InstalledVersion"),
                "fixed_version": vuln.get("FixedVersion"),
                "cvss_score": vuln.get("CVSS", {}).get("nvd", {}).get("V3Score"),
                "references": vuln.get("References", [])
            }
            vulnerabilities.append(normalized)
    
    return vulnerabilities

def normalize_semgrep_report(report: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Normalize Semgrep SAST report"""
    vulnerabilities = []
    
    for result in report.get("results", []):
        normalized = {
            "tool": "semgrep",
            "vulnerability_id": result.get("check_id"),
            "severity": result.get("extra", {}).get("severity", "INFO").upper(),
            "title": result.get("extra", {}).get("message"),
            "description": result.get("extra", {}).get("metadata", {}).get("description", ""),
            "file_path": result.get("path"),
            "line_number": result.get("start", {}).get("line"),
            "category": result.get("extra", {}).get("metadata", {}).get("category"),
            "cwe": result.get("extra", {}).get("metadata", {}).get("cwe", [])
        }
        vulnerabilities.append(normalized)
    
    return vulnerabilities

def normalize_zap_report(report: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Normalize OWASP ZAP DAST report"""
    vulnerabilities = []
    
    site = report.get("site", [{}])[0]
    for alert in site.get("alerts", []):
        normalized = {
            "tool": "zap",
            "vulnerability_id": alert.get("pluginid"),
            "severity": alert.get("riskdesc", "").split()[0].upper(),  # Extract severity
            "title": alert.get("name"),
            "description": alert.get("desc"),
            "solution": alert.get("solution"),
            "url": alert.get("instances", [{}])[0].get("uri") if alert.get("instances") else "",
            "method": alert.get("instances", [{}])[0].get("method") if alert.get("instances") else "",
            "confidence": alert.get("confidence"),
            "cwe_id": alert.get("cweid"),
            "wasc_id": alert.get("wascid")
        }
        vulnerabilities.append(normalized)
    
    return vulnerabilities

def generate_policy_with_ai(vulnerabilities: List[Dict[str, Any]]) -> Dict[str, Any]:
    """Generate security policy using AI (placeholder for now)"""
    
    # Count vulnerabilities by severity
    severity_counts = {}
    for vuln in vulnerabilities:
        severity = vuln.get("severity", "UNKNOWN")
        severity_counts[severity] = severity_counts.get(severity, 0) + 1
    
    # Generate basic policy structure
    policy = {
        "timestamp": datetime.now().isoformat(),
        "total_vulnerabilities": len(vulnerabilities),
        "severity_breakdown": severity_counts,
        "nist_csf_recommendations": [],
        "iso27001_controls": [],
        "ai_model": "placeholder",  # Will be replaced with actual LLM
        "remediation_priority": []
    }
    
    # Basic NIST CSF mappings based on vulnerabilities
    if severity_counts.get("CRITICAL", 0) > 0:
        policy["nist_csf_recommendations"].append({
            "function": "PROTECT",
            "category": "PR.DS",
            "subcategory": "PR.DS-6",
            "description": "Integrity checking mechanisms are used to verify software, firmware, and information integrity",
            "reason": f"Critical vulnerabilities detected: {severity_counts['CRITICAL']}"
        })
    
    if severity_counts.get("HIGH", 0) > 0:
        policy["nist_csf_recommendations"].append({
            "function": "DETECT",
            "category": "DE.CM",
            "subcategory": "DE.CM-8",
            "description": "Vulnerability scans are performed",
            "reason": f"High severity vulnerabilities detected: {severity_counts['HIGH']}"
        })
    
    # ISO 27001 control mappings
    if any(vuln.get("tool") == "trivy" for vuln in vulnerabilities):
        policy["iso27001_controls"].append({
            "control": "A.12.6.1",
            "title": "Management of technical vulnerabilities",
            "description": "Information about technical vulnerabilities of information systems being used shall be obtained in a timely fashion",
            "implementation": "Container vulnerability scanning with Trivy implemented"
        })
    
    return policy

def main():
    """Main processing function"""
    print("🤖 Starting AI-driven vulnerability processing...")
    
    # Define input and output directories
    input_dir = "/reports"
    output_dir = "/output"
    
    # Ensure output directory exists
    os.makedirs(output_dir, exist_ok=True)
    
    all_vulnerabilities = []
    
    # Process Trivy report
    trivy_path = os.path.join(input_dir, "trivy-report.json")
    if os.path.exists(trivy_path):
        print("📊 Processing Trivy report...")
        trivy_report = load_report(trivy_path)
        trivy_vulns = normalize_trivy_report(trivy_report)
        all_vulnerabilities.extend(trivy_vulns)
        print(f"✅ Trivy: {len(trivy_vulns)} vulnerabilities processed")
    
    # Process Semgrep report
    semgrep_path = os.path.join(input_dir, "semgrep-report.json")
    if os.path.exists(semgrep_path):
        print("📊 Processing Semgrep report...")
        semgrep_report = load_report(semgrep_path)
        semgrep_vulns = normalize_semgrep_report(semgrep_report)
        all_vulnerabilities.extend(semgrep_vulns)
        print(f"✅ Semgrep: {len(semgrep_vulns)} vulnerabilities processed")
    
    # Process ZAP report
    zap_path = os.path.join(input_dir, "zap-report.json")
    if os.path.exists(zap_path):
        print("📊 Processing ZAP report...")
        zap_report = load_report(zap_path)
        zap_vulns = normalize_zap_report(zap_report)
        all_vulnerabilities.extend(zap_vulns)
        print(f"✅ ZAP: {len(zap_vulns)} vulnerabilities processed")
    
    print(f"📈 Total vulnerabilities processed: {len(all_vulnerabilities)}")
    
    # Generate AI-driven security policy
    print("🧠 Generating security policy with AI...")
    policy = generate_policy_with_ai(all_vulnerabilities)
    
    # Save normalized vulnerabilities
    vulns_output = os.path.join(output_dir, "normalized_vulnerabilities.json")
    with open(vulns_output, 'w') as f:
        json.dump(all_vulnerabilities, f, indent=2)
    
    # Save generated policy
    policy_output = os.path.join(output_dir, "ai_generated_policy.json")
    with open(policy_output, 'w') as f:
        json.dump(policy, f, indent=2)
    
    print(f"✅ Results saved:")
    print(f"   📄 Normalized vulnerabilities: {vulns_output}")
    print(f"   📋 AI-generated policy: {policy_output}")
    print("🎉 AI processing completed successfully!")

if __name__ == "__main__":
    main()