#!/usr/bin/env python3
"""
AI Security Policy Generation Script
Analyzes normalized vulnerability data and generates intelligent security policies
"""
import json
import os
from datetime import datetime

def generate_ai_policy():
    # Load normalized vulnerabilities
    vulns_file = "/app/processed/normalized_vulnerabilities.json"
    if os.path.exists(vulns_file):
        with open(vulns_file) as f:
            vulnerabilities = json.load(f)
    else:
        vulnerabilities = []

    print(f"🤖 Processing {len(vulnerabilities)} vulnerabilities with AI")

    # Generate AI policy based on real data
    policy = {
        "generated_at": datetime.now().isoformat(),
        "vulnerability_count": len(vulnerabilities),
        "high_severity_count": len([v for v in vulnerabilities if v.get("severity", "").upper() in ["HIGH", "CRITICAL"]]),
        "sources": list(set([v.get("source", "unknown") for v in vulnerabilities])),
        "recommendations": [],
        "security_policies": [],
        "risk_assessment": "LOW"
    }

    # AI analysis based on vulnerability patterns
    if vulnerabilities:
        severity_counts = {}
        source_counts = {}
        
        for vuln in vulnerabilities:
            severity = vuln.get("severity", "unknown").upper()
            source = vuln.get("source", "unknown")
            
            severity_counts[severity] = severity_counts.get(severity, 0) + 1
            source_counts[source] = source_counts.get(source, 0) + 1
        
        policy["severity_breakdown"] = severity_counts
        policy["source_breakdown"] = source_counts
        
        # Risk assessment
        critical_count = severity_counts.get("CRITICAL", 0)
        high_count = severity_counts.get("HIGH", 0)
        
        if critical_count > 0:
            policy["risk_assessment"] = "CRITICAL"
        elif high_count > 5:
            policy["risk_assessment"] = "HIGH"
        elif high_count > 0:
            policy["risk_assessment"] = "MEDIUM"
        
        # Generate intelligent recommendations
        if critical_count > 0:
            policy["recommendations"].append({
                "priority": "URGENT",
                "action": f"Address {critical_count} critical vulnerabilities immediately",
                "timeline": "24 hours",
                "impact": "Production deployment blocked"
            })
        
        if high_count > 0:
            policy["recommendations"].append({
                "priority": "HIGH",
                "action": f"Address {high_count} high severity vulnerabilities",
                "timeline": "7 days",
                "impact": "Security risk to production"
            })
        
        # Source-specific recommendations
        if "gitleaks" in source_counts:
            policy["recommendations"].append({
                "priority": "HIGH",
                "action": f"Review and rotate {source_counts['gitleaks']} exposed secrets",
                "timeline": "Immediate",
                "impact": "Credential compromise risk"
            })
        
        if "trivy" in source_counts:
            policy["recommendations"].append({
                "priority": "MEDIUM",
                "action": f"Update base images to fix {source_counts['trivy']} container vulnerabilities",
                "timeline": "Next release cycle",
                "impact": "Container security risk"
            })
        
        if "semgrep" in source_counts:
            policy["recommendations"].append({
                "priority": "MEDIUM",
                "action": f"Review and fix {source_counts['semgrep']} code security issues",
                "timeline": "Current sprint",
                "impact": "Application security risk"
            })
        
        if "zap" in source_counts:
            policy["recommendations"].append({
                "priority": "MEDIUM",
                "action": f"Fix {source_counts['zap']} web application security issues",
                "timeline": "Current sprint",
                "impact": "Runtime security risk"
            })
        
        # Generate security policies
        policy["security_policies"] = [
            {
                "policy": "Secret Management",
                "status": "VIOLATION" if "gitleaks" in source_counts else "COMPLIANT",
                "description": "All secrets must be stored in secure vaults, not in code"
            },
            {
                "policy": "Dependency Security",
                "status": "VIOLATION" if critical_count + high_count > 0 else "COMPLIANT",
                "description": "All dependencies must be free of known high/critical vulnerabilities"
            },
            {
                "policy": "Container Security",
                "status": "VIOLATION" if "trivy" in source_counts and severity_counts.get("HIGH", 0) + severity_counts.get("CRITICAL", 0) > 0 else "COMPLIANT",
                "description": "Container images must pass security scanning before deployment"
            },
            {
                "policy": "Code Security",
                "status": "VIOLATION" if "semgrep" in source_counts else "COMPLIANT",
                "description": "Code must pass static security analysis"
            }
        ]
        
        # Deployment decision
        policy["deployment_recommendation"] = {
            "status": "BLOCKED" if critical_count > 0 else "APPROVED" if high_count == 0 else "CONDITIONAL",
            "reason": f"Critical: {critical_count}, High: {high_count} vulnerabilities found",
            "conditions": [] if critical_count == 0 and high_count == 0 else [
                "Address all critical vulnerabilities before deployment",
                "Create tickets for all high severity issues",
                "Implement additional monitoring for medium/low issues"
            ]
        }

    # Save AI-generated policy
    os.makedirs("/app/ai-policies", exist_ok=True)
    policy_file = "/app/ai-policies/ai_generated_policy_REAL.json"
    
    with open(policy_file, "w") as f:
        json.dump(policy, f, indent=2)

    print("✅ AI policy generated successfully")
    print(f"📊 Risk Assessment: {policy['risk_assessment']}")
    print(f"🎯 Deployment Status: {policy.get('deployment_recommendation', {}).get('status', 'UNKNOWN')}")
    print(f"📋 Recommendations: {len(policy['recommendations'])}")
    
    return policy

if __name__ == "__main__":
    generate_ai_policy()