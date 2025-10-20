"""
DevSecOps Report Processing Service
Handles normalization and processing of security scan reports
"""

import json
import os
from typing import Dict, List, Any, Optional
from datetime import datetime
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class SecurityReportProcessor:
    """Process and normalize security reports from various tools"""
    
    def __init__(self):
        self.supported_tools = ["trivy", "semgrep", "zap", "dependency-check", "gitleaks"]
        
    def normalize_trivy_report(self, report_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Normalize Trivy container vulnerability report"""
        vulnerabilities = []
        
        try:
            for result in report_data.get("Results", []):
                target = result.get("Target", "unknown")
                for vuln in result.get("Vulnerabilities", []):
                    normalized = {
                        "id": f"trivy-{vuln.get('VulnerabilityID', 'unknown')}",
                        "tool": "trivy",
                        "tool_vuln_id": vuln.get("VulnerabilityID"),
                        "title": vuln.get("Title", ""),
                        "description": vuln.get("Description", ""),
                        "severity": vuln.get("Severity", "UNKNOWN"),
                        "cvss_score": self._extract_cvss_score(vuln),
                        "target": target,
                        "package": vuln.get("PkgName", ""),
                        "installed_version": vuln.get("InstalledVersion", ""),
                        "fixed_version": vuln.get("FixedVersion", ""),
                        "references": vuln.get("References", []),
                        "published_date": vuln.get("PublishedDate", ""),
                        "last_modified": vuln.get("LastModifiedDate", ""),
                        "remediation": f"Upgrade {vuln.get('PkgName', 'package')} to {vuln.get('FixedVersion', 'latest version')}" if vuln.get('FixedVersion') else "No fix available",
                        "category": "Container Security",
                        "tool_raw": vuln
                    }
                    vulnerabilities.append(normalized)
        except Exception as e:
            logger.error(f"Error processing Trivy report: {e}")
            
        return vulnerabilities
    
    def normalize_semgrep_report(self, report_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Normalize Semgrep SAST report"""
        vulnerabilities = []
        
        try:
            for result in report_data.get("results", []):
                normalized = {
                    "id": f"semgrep-{result.get('check_id', 'unknown')}-{result.get('path', '').replace('/', '-')}",
                    "tool": "semgrep",
                    "tool_vuln_id": result.get("check_id"),
                    "title": result.get("extra", {}).get("message", ""),
                    "description": result.get("extra", {}).get("metadata", {}).get("description", ""),
                    "severity": self._map_semgrep_severity(result.get("extra", {}).get("severity", "INFO")),
                    "cvss_score": None,
                    "file_path": result.get("path", ""),
                    "line_start": result.get("start", {}).get("line"),
                    "line_end": result.get("end", {}).get("line"),
                    "category": result.get("extra", {}).get("metadata", {}).get("category", "SAST"),
                    "cwe": result.get("extra", {}).get("metadata", {}).get("cwe", []),
                    "owasp": result.get("extra", {}).get("metadata", {}).get("owasp", []),
                    "confidence": result.get("extra", {}).get("metadata", {}).get("confidence", "MEDIUM"),
                    "remediation": result.get("extra", {}).get("fix", "Review and fix the identified security issue"),
                    "tool_raw": result
                }
                vulnerabilities.append(normalized)
        except Exception as e:
            logger.error(f"Error processing Semgrep report: {e}")
            
        return vulnerabilities
    
    def normalize_zap_report(self, report_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Normalize OWASP ZAP DAST report"""
        vulnerabilities = []
        
        try:
            site = report_data.get("site", [{}])[0] if report_data.get("site") else {}
            for alert in site.get("alerts", []):
                for instance in alert.get("instances", [{}]):
                    normalized = {
                        "id": f"zap-{alert.get('pluginid', 'unknown')}-{hash(instance.get('uri', ''))}",
                        "tool": "zap",
                        "tool_vuln_id": alert.get("pluginid"),
                        "title": alert.get("name", ""),
                        "description": alert.get("desc", ""),
                        "severity": self._map_zap_severity(alert.get("riskdesc", "")),
                        "cvss_score": None,
                        "url": instance.get("uri", ""),
                        "method": instance.get("method", ""),
                        "parameter": instance.get("param", ""),
                        "attack": instance.get("attack", ""),
                        "evidence": instance.get("evidence", ""),
                        "confidence": alert.get("confidence", ""),
                        "cwe_id": alert.get("cweid"),
                        "wasc_id": alert.get("wascid"),
                        "solution": alert.get("solution", ""),
                        "reference": alert.get("reference", ""),
                        "remediation": alert.get("solution", "Apply recommended security measures"),
                        "category": "Web Application Security",
                        "tool_raw": alert
                    }
                    vulnerabilities.append(normalized)
        except Exception as e:
            logger.error(f"Error processing ZAP report: {e}")
            
        return vulnerabilities
    
    def normalize_dependency_check_report(self, report_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Normalize OWASP Dependency-Check SCA report"""
        vulnerabilities = []
        
        try:
            for dependency in report_data.get("dependencies", []):
                for vuln in dependency.get("vulnerabilities", []):
                    normalized = {
                        "id": f"dependency-check-{vuln.get('name', 'unknown')}-{dependency.get('sha1', '')}",
                        "tool": "dependency-check",
                        "tool_vuln_id": vuln.get("name"),
                        "title": vuln.get("description", ""),
                        "description": vuln.get("description", ""),
                        "severity": self._map_cvss_to_severity(vuln.get("cvssv3", {}).get("baseScore")),
                        "cvss_score": vuln.get("cvssv3", {}).get("baseScore"),
                        "cvss_vector": vuln.get("cvssv3", {}).get("vectorString"),
                        "file_path": dependency.get("filePath", ""),
                        "package": dependency.get("fileName", ""),
                        "references": [ref.get("url") for ref in vuln.get("references", [])],
                        "cwe": vuln.get("cwes", []),
                        "remediation": "Update dependency to a secure version",
                        "category": "Dependency Vulnerability",
                        "tool_raw": vuln
                    }
                    vulnerabilities.append(normalized)
        except Exception as e:
            logger.error(f"Error processing Dependency-Check report: {e}")
            
        return vulnerabilities
    
    def normalize_gitleaks_report(self, report_data: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Normalize Gitleaks secrets scanning report"""
        vulnerabilities = []
        
        try:
            for secret in report_data:
                normalized = {
                    "id": f"gitleaks-{secret.get('RuleID', 'unknown')}-{hash(secret.get('Secret', ''))}",
                    "tool": "gitleaks",
                    "tool_vuln_id": secret.get("RuleID"),
                    "title": f"Secret detected: {secret.get('Description', 'Unknown secret')}",
                    "description": secret.get("Description", ""),
                    "severity": "HIGH",  # All secrets are high severity
                    "cvss_score": None,
                    "file_path": secret.get("File", ""),
                    "line_number": secret.get("StartLine"),
                    "commit": secret.get("Commit", ""),
                    "author": secret.get("Author", ""),
                    "email": secret.get("Email", ""),
                    "date": secret.get("Date", ""),
                    "remediation": "Remove secret from code and rotate credentials",
                    "category": "Secrets Management",
                    "tool_raw": secret
                }
                vulnerabilities.append(normalized)
        except Exception as e:
            logger.error(f"Error processing Gitleaks report: {e}")
            
        return vulnerabilities
    
    def _extract_cvss_score(self, vuln: Dict[str, Any]) -> Optional[float]:
        """Extract CVSS score from various formats"""
        cvss = vuln.get("CVSS", {})
        if isinstance(cvss, dict):
            # Try NVD first, then other sources
            for source in ["nvd", "redhat", "ubuntu"]:
                if source in cvss and "V3Score" in cvss[source]:
                    return cvss[source]["V3Score"]
        return None
    
    def _map_semgrep_severity(self, severity: str) -> str:
        """Map Semgrep severity to standard levels"""
        mapping = {
            "ERROR": "HIGH",
            "WARNING": "MEDIUM", 
            "INFO": "LOW"
        }
        return mapping.get(severity.upper(), "MEDIUM")
    
    def _map_zap_severity(self, risk_desc: str) -> str:
        """Map ZAP risk description to severity"""
        if "High" in risk_desc:
            return "HIGH"
        elif "Medium" in risk_desc:
            return "MEDIUM"
        elif "Low" in risk_desc:
            return "LOW"
        elif "Informational" in risk_desc:
            return "INFO"
        return "MEDIUM"
    
    def _map_cvss_to_severity(self, cvss_score: Optional[float]) -> str:
        """Map CVSS score to severity level"""
        if cvss_score is None:
            return "MEDIUM"
        
        if cvss_score >= 9.0:
            return "CRITICAL"
        elif cvss_score >= 7.0:
            return "HIGH"
        elif cvss_score >= 4.0:
            return "MEDIUM"
        else:
            return "LOW"
    
    def process_report(self, file_path: str, tool: str) -> List[Dict[str, Any]]:
        """Process a single report file"""
        try:
            with open(file_path, 'r') as f:
                if file_path.endswith('.json'):
                    data = json.load(f)
                else:
                    logger.error(f"Unsupported file format: {file_path}")
                    return []
            
            if tool == "trivy":
                return self.normalize_trivy_report(data)
            elif tool == "semgrep":
                return self.normalize_semgrep_report(data)
            elif tool == "zap":
                return self.normalize_zap_report(data)
            elif tool == "dependency-check":
                return self.normalize_dependency_check_report(data)
            elif tool == "gitleaks":
                return self.normalize_gitleaks_report(data)
            else:
                logger.error(f"Unsupported tool: {tool}")
                return []
                
        except Exception as e:
            logger.error(f"Error processing {file_path}: {e}")
            return []

def process_all_reports(input_dir: str, output_dir: str):
    """Process all reports in input directory and save to output directory"""
    processor = SecurityReportProcessor()
    
    # Ensure output directory exists
    os.makedirs(output_dir, exist_ok=True)
    
    all_vulnerabilities = []
    report_summary = {
        "timestamp": datetime.now().isoformat(),
        "total_vulnerabilities": 0,
        "by_tool": {},
        "by_severity": {"CRITICAL": 0, "HIGH": 0, "MEDIUM": 0, "LOW": 0, "INFO": 0},
        "processed_files": []
    }
    
    # Define expected report files and their tools
    report_files = {
        "trivy-report.json": "trivy",
        "semgrep-report.json": "semgrep", 
        "zap-report.json": "zap",
        "dependency-check-report.json": "dependency-check",
        "gitleaks-report.json": "gitleaks"
    }
    
    for filename, tool in report_files.items():
        file_path = os.path.join(input_dir, filename)
        if os.path.exists(file_path):
            logger.info(f"Processing {filename} with {tool} parser...")
            vulnerabilities = processor.process_report(file_path, tool)
            all_vulnerabilities.extend(vulnerabilities)
            
            # Update summary
            report_summary["by_tool"][tool] = len(vulnerabilities)
            report_summary["processed_files"].append(filename)
            
            for vuln in vulnerabilities:
                severity = vuln.get("severity", "UNKNOWN")
                if severity in report_summary["by_severity"]:
                    report_summary["by_severity"][severity] += 1
            
            logger.info(f"✅ {tool}: {len(vulnerabilities)} vulnerabilities processed")
    
    report_summary["total_vulnerabilities"] = len(all_vulnerabilities)
    
    # Save normalized vulnerabilities
    vulns_output = os.path.join(output_dir, "normalized_vulnerabilities.json")
    with open(vulns_output, 'w') as f:
        json.dump(all_vulnerabilities, f, indent=2)
    
    # Save summary
    summary_output = os.path.join(output_dir, "processing_summary.json")
    with open(summary_output, 'w') as f:
        json.dump(report_summary, f, indent=2)
    
    logger.info(f"📊 Processing complete:")
    logger.info(f"   Total vulnerabilities: {report_summary['total_vulnerabilities']}")
    logger.info(f"   By severity: {report_summary['by_severity']}")
    logger.info(f"   Output files: {vulns_output}, {summary_output}")
    
    return all_vulnerabilities, report_summary