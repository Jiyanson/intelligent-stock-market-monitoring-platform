#!/usr/bin/env python3
"""
Vulnerability Normalization Script
Processes security scan reports and normalizes them into a unified format

Supports:
- SAST: SonarQube, Semgrep
- SCA: OWASP Dependency-Check
- DAST: OWASP ZAP
- Container: Trivy
- Secrets: Gitleaks
"""
import json
import os
import glob
import xml.etree.ElementTree as ET
from pathlib import Path

def normalize_vulnerabilities():
    reports_dir = os.getenv("REPORTS_DIR", "reports")
    output_dir = os.getenv("OUTPUT_DIR", "processed")
    vulnerabilities = []

    # Ensure directories exist
    os.makedirs(reports_dir, exist_ok=True)
    os.makedirs(output_dir, exist_ok=True)

    # =========================================================================
    # Process SonarQube report (SAST)
    # =========================================================================
    sonarqube_patterns = [
        os.path.join(reports_dir, "sonarqube", "sonarqube-report.json"),
        os.path.join(reports_dir, "sonarqube-report.json")
    ]

    for sonarqube_file in sonarqube_patterns:
        if os.path.exists(sonarqube_file):
            print(f"Processing SonarQube report: {sonarqube_file}")
            try:
                with open(sonarqube_file) as f:
                    sonar_data = json.load(f)
                    issues = sonar_data.get("issues", [])
                    for issue in issues:
                        vulnerabilities.append({
                            "id": issue.get("key", "unknown"),
                            "severity": issue.get("severity", "MEDIUM").upper(),
                            "title": issue.get("message", "unknown"),
                            "description": issue.get("message", ""),
                            "source": "sonarqube",
                            "file": issue.get("component", "unknown"),
                            "line": issue.get("line", 0),
                            "rule": issue.get("rule", "unknown"),
                            "type": issue.get("type", "CODE_SMELL")
                        })
                    print(f"  ✓ Processed {len(issues)} SonarQube issues")
            except Exception as e:
                print(f"  ✗ Error processing SonarQube report: {e}")
            break

    # =========================================================================
    # Process OWASP Dependency-Check report (SCA - XML format)
    # =========================================================================
    dependency_check_patterns = [
        os.path.join(reports_dir, "dependency-check", "dependency-check-report.xml"),
        os.path.join(reports_dir, "dependency-check-report.xml"),
        os.path.join(reports_dir, "dependency-check", "dependency-check-report.json"),
        os.path.join(reports_dir, "dependency-check-report.json")
    ]

    for dc_file in dependency_check_patterns:
        if os.path.exists(dc_file):
            print(f"Processing OWASP Dependency-Check report: {dc_file}")
            try:
                if dc_file.endswith('.xml'):
                    # Parse XML format
                    tree = ET.parse(dc_file)
                    root = tree.getroot()

                    for dependency in root.findall('.//dependency'):
                        file_path = dependency.find('filePath')
                        vulnerabilities_elem = dependency.find('vulnerabilities')

                        if vulnerabilities_elem is not None:
                            for vuln in vulnerabilities_elem.findall('vulnerability'):
                                cve_id = vuln.find('name')
                                severity = vuln.find('severity')
                                description = vuln.find('description')

                                vulnerabilities.append({
                                    "id": cve_id.text if cve_id is not None else "unknown",
                                    "severity": severity.text if severity is not None else "MEDIUM",
                                    "title": f"Dependency vulnerability: {cve_id.text if cve_id is not None else 'unknown'}",
                                    "description": description.text if description is not None else "",
                                    "source": "dependency-check",
                                    "package": file_path.text if file_path is not None else "unknown",
                                    "file": file_path.text if file_path is not None else "unknown"
                                })

                elif dc_file.endswith('.json'):
                    # Parse JSON format
                    with open(dc_file) as f:
                        dc_data = json.load(f)
                        dependencies = dc_data.get("dependencies", [])

                        for dep in dependencies:
                            for vuln in dep.get("vulnerabilities", []):
                                vulnerabilities.append({
                                    "id": vuln.get("name", "unknown"),
                                    "severity": vuln.get("severity", "MEDIUM"),
                                    "title": vuln.get("name", "unknown"),
                                    "description": vuln.get("description", ""),
                                    "source": "dependency-check",
                                    "package": dep.get("fileName", "unknown"),
                                    "cvss_score": vuln.get("cvssv3", {}).get("baseScore", 0)
                                })

                print(f"  ✓ Processed OWASP Dependency-Check report")
            except Exception as e:
                print(f"  ✗ Error processing Dependency-Check report: {e}")
            break

    # =========================================================================
    # Process Trivy report (Container Security)
    # =========================================================================
    trivy_patterns = [
        os.path.join(reports_dir, "trivy", "trivy-report.json"),
        os.path.join(reports_dir, "trivy-report.json")
    ]

    for trivy_file in trivy_patterns:
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
                    print(f"  ✓ Processed Trivy report")
            except Exception as e:
                print(f"  ✗ Error processing Trivy report: {e}")
            break

    # =========================================================================
    # Process Semgrep report (SAST)
    # =========================================================================
    semgrep_patterns = [
        os.path.join(reports_dir, "semgrep-reports", "semgrep-report.json"),
        os.path.join(reports_dir, "semgrep-report.json")
    ]

    for semgrep_file in semgrep_patterns:
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
                    print(f"  ✓ Processed Semgrep report")
            except Exception as e:
                print(f"  ✗ Error processing Semgrep report: {e}")
            break

    # =========================================================================
    # Process Gitleaks report (Secret Scanning)
    # =========================================================================
    gitleaks_patterns = [
        os.path.join(reports_dir, "gitleaks-reports", "gitleaks-report.json"),
        os.path.join(reports_dir, "gitleaks-report.json")
    ]

    for gitleaks_file in gitleaks_patterns:
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
                    print(f"  ✓ Processed Gitleaks report")
            except Exception as e:
                print(f"  ✗ Error processing Gitleaks report: {e}")
            break

    # =========================================================================
    # Process OWASP ZAP report (DAST)
    # =========================================================================
    zap_patterns = [
        os.path.join(reports_dir, "zap", "zap-report.json"),
        os.path.join(reports_dir, "zap-report.json")
    ]

    for zap_file in zap_patterns:
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
                                        "severity": alert.get("riskdesc", "unknown").split()[0].upper() if alert.get("riskdesc") else "MEDIUM",
                                        "title": alert.get("name", "unknown"),
                                        "description": alert.get("desc", ""),
                                        "source": "zap",
                                        "url": alert.get("instances", [{}])[0].get("uri", "unknown") if alert.get("instances") else "unknown",
                                        "confidence": alert.get("confidence", "unknown")
                                    })
                    print(f"  ✓ Processed ZAP report")
            except Exception as e:
                print(f"  ✗ Error processing ZAP report: {e}")
            break

    # =========================================================================
    # Save normalized vulnerabilities
    # =========================================================================
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, "normalized_vulnerabilities.json")

    with open(output_file, "w") as f:
        json.dump(vulnerabilities, f, indent=2)

    print(f"\n{'='*70}")
    print(f"✅ Normalized {len(vulnerabilities)} total vulnerabilities")
    print(f"{'='*70}")

    # Print detailed summary
    severity_counts = {}
    source_counts = {}

    for vuln in vulnerabilities:
        severity = vuln.get("severity", "UNKNOWN").upper()
        source = vuln.get("source", "unknown")

        severity_counts[severity] = severity_counts.get(severity, 0) + 1
        source_counts[source] = source_counts.get(source, 0) + 1

    print(f"\n📊 Severity Breakdown:")
    for severity in ["CRITICAL", "HIGH", "MEDIUM", "LOW", "INFO", "UNKNOWN"]:
        count = severity_counts.get(severity, 0)
        if count > 0:
            print(f"   {severity:>10}: {count:>4}")

    print(f"\n📊 Source Breakdown:")
    for source, count in sorted(source_counts.items()):
        print(f"   {source:>20}: {count:>4}")

    # Save summary for easy consumption
    summary = {
        "total_vulnerabilities": len(vulnerabilities),
        "severity_breakdown": severity_counts,
        "source_breakdown": source_counts,
        "critical": severity_counts.get("CRITICAL", 0),
        "high": severity_counts.get("HIGH", 0),
        "medium": severity_counts.get("MEDIUM", 0),
        "low": severity_counts.get("LOW", 0)
    }

    summary_file = os.path.join(output_dir, "vulnerability_summary.json")
    with open(summary_file, "w") as f:
        json.dump(summary, f, indent=2)

    print(f"\n📄 Reports saved:")
    print(f"   - {output_file}")
    print(f"   - {summary_file}")
    print(f"{'='*70}\n")

    return len(vulnerabilities)

if __name__ == "__main__":
    normalize_vulnerabilities()