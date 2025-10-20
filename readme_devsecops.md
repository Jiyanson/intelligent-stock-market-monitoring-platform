# 🛡️ Integrating Generative AI into DevSecOps for Automated Security Policy Generation

**Final Project - 2025/2026 3GL**

This project explores how **Large Language Models (LLMs)** can transform DevSecOps vulnerability reports (SAST, SCA, DAST) into actionable, human-readable security policies aligned with international standards such as **NIST CSF** and **ISO/IEC 27001**.

**Target Application**: Stock Market Monitoring Platform (FastAPI + PostgreSQL + Redis + Celery)

---

## 🎯 Project Objectives

By the end of this project, we will:

1. **Understand DevSecOps** role in modern secure software development
2. **Apply AI-assisted automation** to enhance the security lifecycle  
3. **Use SAST, SCA, and DAST tools** to identify vulnerabilities in our FastAPI application
4. **Develop parsing mechanisms** to preprocess security reports (JSON, XML, HTML)
5. **Employ LLMs** (LLaMA 3.3, DeepSeek R1) for automatic security policy generation conforming to NIST CSF/ISO 27001

**Bonus Objectives**:
6. **Conduct research-level evaluation** using BLEU and ROUGE-L metrics
7. **Analyze ethical, privacy, and reliability concerns** when using AI in security governance

---

## 🏗️ Project Architecture

```
FastAPI App → CI Pipeline (SAST + SCA + Tests)
           → Build (Docker)
           → Image Scanning (Trivy)
           → Deploy to Staging
           → DAST (OWASP ZAP)
           → Collect Reports (JSON/XML/HTML)
           → Rule-based Parser (Python)
           → Normalized Vulnerability Data
           → LLM Processing (LLaMA 3.3/DeepSeek R1)
           → NIST CSF/ISO 27001 Policy Generation
           → BLEU/ROUGE-L Evaluation
           → Human Review + Policy Refinement
```

**Two Main Components:**
- **A. Technical Implementation**: DevSecOps pipeline + LLM policy generation
- **B. Research & Evaluation**: Metrics analysis + ethical discussion

### 🛠️ Required Tools & Technologies

| Category                  | Tools                                    | Purpose                                  |
| ------------------------- | ---------------------------------------- | ---------------------------------------- |
| **SAST**                  | SonarQube, Semgrep                      | Static code analysis of FastAPI app     |
| **SCA**                   | OWASP Dependency-Check                  | Python dependency vulnerability scanning |
| **DAST**                  | OWASP ZAP                               | Dynamic testing of running application   |
| **Container Security**    | Trivy                                   | Docker image vulnerability scanning      |
| **LLM Integration**       | Hugging Face (LLaMA 3.3, DeepSeek R1)  | Policy generation from vulnerability data |
| **Evaluation Metrics**    | BLEU, ROUGE-L (Python libraries)       | Quality assessment of generated policies |
| **CI/CD Platform**        | GitHub Actions / GitLab CI             | Automated pipeline orchestration         |
| **Report Processing**     | Python (JSON/XML/HTML parsing)         | Vulnerability report normalization       |
| **Standards Reference**   | NIST CSF, ISO/IEC 27001 templates      | Policy compliance benchmarking          |

---

## 📋 Expected Tasks (6 Phases)

### Task 1: Literature Review
* Research DevSecOps practices and security automation
* Study LLMs in cybersecurity applications  
* Analyze existing policy automation frameworks
* Review NIST CSF and ISO/IEC 27001 structures

### Task 2: DevSecOps Pipeline Setup
* Configure CI/CD pipeline (GitHub Actions/GitLab CI)
* Integrate **SonarQube** (SAST) for FastAPI code analysis
* Add **OWASP Dependency-Check** (SCA) for Python dependencies
* Set up **OWASP ZAP** (DAST) for running application testing
* Configure **Trivy** for Docker image scanning

### Task 3: Report Parser Development
* Build rule-based parsing scripts for:
  - SonarQube JSON reports
  - OWASP Dependency-Check XML reports  
  - OWASP ZAP HTML/XML reports
  - Trivy JSON vulnerability reports
* Normalize data into consistent schema
* Store processed data for LLM consumption

### Task 4: LLM Policy Generation
* **Prompt engineering** for vulnerability-to-policy translation
* **Comparative study**: LLaMA 3.3 vs DeepSeek R1 performance
* Generate NIST CSF and ISO 27001 compliant policies
* Link policies to specific detected vulnerabilities

### Task 5: Evaluation & Metrics
* Compare generated policies with reference NIST/ISO templates
* Calculate **BLEU scores** (n-gram similarity)
* Calculate **ROUGE-L scores** (longest common subsequence)
* Assess policy fluency, compliance, and actionability

### Task 6: Analysis & Documentation
* Technical implementation results
* Research findings on LLM effectiveness
* Ethical discussion: AI bias, explainability, governance
* Future work recommendations

---

## 📊 Deliverables & Evaluation Criteria

### 📄 Required Deliverables
1. **Project Report** (Structure & Clarity: 15%)
   - Introduction & Context
   - Architecture & Implementation  
   - Results & Evaluation
   - Discussion & Future Work

2. **Functional Demonstration** (Technical Implementation: 25%)
   - Working DevSecOps pipeline
   - LLM-based policy generation prototype
   - Vulnerability report processing

3. **Research Analysis** (Research & Analysis: 20%)
   - LLM comparative study (LLaMA 3.3 vs DeepSeek R1)
   - BLEU/ROUGE-L evaluation results
   - Ethical implications discussion

4. **Generated Policy Quality** (Quality Assessment: 20%)
   - NIST CSF/ISO 27001 compliance
   - Policy actionability and clarity
   - Vulnerability-to-policy traceability

5. **Presentation** (Discussion: 20%)
   - 10-15 minute methodology overview
   - Findings and reflections
   - Technical demonstration

### 🎯 Success Metrics
- **Technical**: Functional pipeline processing multiple report formats
- **Research**: Statistically significant BLEU/ROUGE-L scores vs baselines  
- **Policy Quality**: Human expert validation of generated security policies
- **Innovation**: Novel approaches to AI-driven security governance

---

## 💻 Implementation Roadmap

### Phase 1: Foundation Setup (Weeks 1-2)
```bash
# 1. Literature Review & Tool Selection
- Research NIST CSF, ISO 27001 policy structures
- Study LLaMA 3.3 and DeepSeek R1 capabilities
- Set up development environment

# 2. Basic CI/CD Pipeline
- Configure GitHub Actions for FastAPI project
- Add SonarQube for SAST analysis
- Integrate OWASP Dependency-Check for SCA
```

### Phase 2: Security Scanning Integration (Weeks 3-4)
```bash
# 3. Complete DevSecOps Pipeline
- Add Trivy for container scanning
- Integrate OWASP ZAP for DAST
- Configure report generation in multiple formats

# 4. Report Parser Development
- Build JSON parser for SonarQube reports
- Build XML parser for Dependency-Check reports
- Build HTML/XML parser for ZAP reports
- Create unified vulnerability schema
```

### Phase 3: AI Integration (Weeks 5-7)
```bash
# 5. LLM Setup & Prompt Engineering
- Configure Hugging Face models (LLaMA 3.3, DeepSeek R1)
- Design prompt templates for policy generation
- Create NIST CSF and ISO 27001 reference templates

# 6. Policy Generation Engine
- Implement vulnerability-to-policy mapping
- Generate comparative outputs from both models
- Add policy validation and formatting
```

### Phase 4: Evaluation & Analysis (Weeks 8-9)
```bash
# 7. Metrics Implementation
- Calculate BLEU scores against reference policies
- Calculate ROUGE-L scores for content similarity
- Implement policy quality assessment framework

# 8. Research Analysis
- Compare LLaMA 3.3 vs DeepSeek R1 performance
- Analyze ethical implications and AI bias
- Document findings and recommendations
```

---

## 🎯 Key Research Questions

1. **Effectiveness**: How accurately can LLMs translate technical vulnerabilities into compliance policies?
2. **Comparison**: Which model (LLaMA 3.3 vs DeepSeek R1) performs better for security policy generation?
3. **Standards Alignment**: How well do generated policies align with NIST CSF and ISO 27001 frameworks?
4. **Practical Impact**: Can AI-generated policies reduce manual policy writing effort while maintaining quality?
5. **Ethical Considerations**: What are the risks of automated security governance and how can they be mitigated?

---

## 🚀 Getting Started

Ready to begin? Start with these steps:

1. **Literature Review**: Research NIST CSF and ISO 27001 policy structures
2. **Environment Setup**: Configure GitHub Actions workflow
3. **Tool Integration**: Add SonarQube, OWASP tools, and Trivy
4. **LLM Setup**: Configure Hugging Face models for policy generation
5. **Evaluation Framework**: Implement BLEU/ROUGE-L scoring

---

## 📚 Key References

* **Standards**: [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework), [ISO/IEC 27001](https://www.iso.org/standard/27001)
* **DevSecOps Tools**: [SonarQube](https://www.sonarsource.com/), [OWASP Dependency-Check](https://owasp.org/www-project-dependency-check/), [OWASP ZAP](https://zaproxy.org/), [Trivy](https://aquasecurity.github.io/trivy/)
* **LLM Resources**: [Hugging Face](https://huggingface.co/), [LLaMA 3.3](https://huggingface.co/meta-llama), [DeepSeek R1](https://huggingface.co/deepseek-ai)
* **Evaluation Metrics**: [BLEU](https://huggingface.co/spaces/evaluate-metric/bleu), [ROUGE-L](https://huggingface.co/spaces/evaluate-metric/rouge)

---

**Project**: Final Project 2025/2026 3GL - AI-Driven DevSecOps Policy Generation  
**Student**: Saad Aittaleb  
**Technologies**: FastAPI, Python, GitHub Actions, SonarQube, OWASP Tools, Trivy, LLaMA 3.3, DeepSeek R1, BLEU/ROUGE-L  
**Target**: Transform vulnerability reports into NIST CSF/ISO 27001 compliant security policies using LLMs
