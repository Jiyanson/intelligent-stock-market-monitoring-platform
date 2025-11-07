#!/usr/bin/env python3
"""
Vulnerability Normalization Script
Processes security scan reports and normalizes them into a unified format
"""
import json
import os
import glob

def normalize_vulnerabilities():
    reports_dir = "/reports"
    output_dir = "/output"
    vulnerabilities = []

    # Process Trivy report
    trivy_file = os.path.join(reports_dir, "trivy-report.json")
    if os.path.exists(trivy_file):
        print(f"Processing Trivy report: {trivy_file}")
        try:
            with open(trivy_file) as f:
                trivy_data = json.load(f)
                if "Results" in trivy_data:
                    for result in trivy_data["Results"]:
                        if "Vulnerabilities" in result:
                            for vuln in result["Vulnerabilities"]:
                                vulnerabilities.append({
                                    "id": vuln.get("VulnerabilityID", "unknown"),
                                    "severity": vuln.get("Severity", "unknown"),
                                    "title": vuln.get("Title", "unknown"),
                                    "description": vuln.get("Description", ""),
                                    "source": "trivy",
                                    "package": vuln.get("PkgName", "unknown"),
                                    "fixed_version": vuln.get("FixedVersion", "")
                                })
        except Exception as e:
            print(f"Error processing Trivy report: {e}")

    # Process Semgrep report
    semgrep_file = os.path.join(reports_dir, "semgrep-report.json")
    if os.path.exists(semgrep_file):
        print(f"Processing Semgrep report: {semgrep_file}")
        try:
            with open(semgrep_file) as f:
                semgrep_data = json.load(f)
                if "results" in semgrep_data:
                    for result in semgrep_data["results"]:
                        vulnerabilities.append({
                            "id": result.get("check_id", "unknown"),
                            "severity": result.get("extra", {}).get("severity", "unknown").upper(),
                            "title": result.get("extra", {}).get("message", "unknown"),
                            "description": result.get("extra", {}).get("metadata", {}).get("owasp", ""),
                            "source": "semgrep",
                            "file": result.get("path", "unknown"),
                            "line": result.get("start", {}).get("line", 0)
                        })
        except Exception as e:
            print(f"Error processing Semgrep report: {e}")

    # Process Gitleaks report
    gitleaks_file = os.path.join(reports_dir, "gitleaks-report.json")
    if os.path.exists(gitleaks_file):
        print(f"Processing Gitleaks report: {gitleaks_file}")
        try:
            with open(gitleaks_file) as f:
                gitleaks_data = json.load(f)
                if isinstance(gitleaks_data, list):
                    for result in gitleaks_data:
                        vulnerabilities.append({
                            "id": result.get("RuleID", "unknown"),
                            "severity": "HIGH",
                            "title": "Secret Detected: " + result.get("Description", "unknown"),
                            "description": "Secret found in: " + result.get("File", "unknown"),
                            "source": "gitleaks",
                            "file": result.get("File", "unknown"),
                            "secret_type": result.get("RuleID", "unknown")
                        })
        except Exception as e:
            print(f"Error processing Gitleaks report: {e}")

    # Process OWASP ZAP report
    zap_file = os.path.join(reports_dir, "zap-report.json")
    if os.path.exists(zap_file):
        print(f"Processing ZAP report: {zap_file}")
        try:
            with open(zap_file) as f:
                zap_data = json.load(f)
                if "site" in zap_data:
                    for site in zap_data["site"]:
                        if "alerts" in site:
                            for alert in site["alerts"]:
                                vulnerabilities.append({
                                    "id": alert.get("pluginid", "unknown"),
                                    "severity": alert.get("riskdesc", "unknown").split()[0].upper(),
                                    "title": alert.get("name", "unknown"),
                                    "description": alert.get("desc", ""),
                                    "source": "zap",
                                    "url": alert.get("instances", [{}])[0].get("uri", "unknown"),
                                    "confidence": alert.get("confidence", "unknown")
                                })
        except Exception as e:
            print(f"Error processing ZAP report: {e}")

    # Save normalized vulnerabilities
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, "normalized_vulnerabilities.json")
    
    with open(output_file, "w") as f:
        json.dump(vulnerabilities, f, indent=2)

    print(f"✅ Normalized {len(vulnerabilities)} vulnerabilities")
    
    # Print summary
    severity_counts = {}
    source_counts = {}
    
    for vuln in vulnerabilities:
        severity = vuln.get("severity", "unknown").upper()
        source = vuln.get("source", "unknown")
        
        severity_counts[severity] = severity_counts.get(severity, 0) + 1
        source_counts[source] = source_counts.get(source, 0) + 1
    
    print(f"📊 Severity breakdown: {severity_counts}")
    print(f"📊 Source breakdown: {source_counts}")
    
    return len(vulnerabilities)

if __name__ == "__main__":
    normalize_vulnerabilities()