# 🛡️ Intelligent Stock Market Monitoring Platform with AI-Driven DevSecOps

**Final Project - 2025/2026 3GL**

A production-ready FastAPI application demonstrating how **Large Language Models (LLMs)** can transform DevSecOps vulnerability reports into actionable, human-readable security policies aligned with **NIST CSF** and **ISO/IEC 27001**.

This project integrates advanced security scanning (SAST, SCA, DAST) with AI-powered policy generation using **LLaMA 3.3** and **DeepSeek R1** to automate security governance.

---

## 🎯 Project Overview

This platform showcases the integration of Generative AI into DevSecOps workflows:

1. **Automated Security Scanning**: SAST, SCA, DAST, and Container Security tools
2. **Intelligent Report Processing**: Parse and normalize vulnerability data from multiple sources
3. **AI-Powered Policy Generation**: Use LLMs to generate NIST CSF/ISO 27001 compliant policies
4. **Research-Level Evaluation**: BLEU and ROUGE-L metrics for policy quality assessment
5. **Ethical AI Governance**: Analysis of AI reliability and bias in security contexts

---

## 🔧 Features

### Application Stack
- **FastAPI** – Modern async Python web framework
- **PostgreSQL** – Production database for stock market data
- **SQLAlchemy 2.0** – ORM with Pydantic v2 integration
- **Alembic** – Database schema migrations
- **Celery + Redis** – Background task processing
- **Docker Compose** – Full containerized environment

### DevSecOps Pipeline
- **SAST**: SonarQube, Semgrep for static code analysis
- **SCA**: OWASP Dependency-Check for dependency vulnerabilities
- **DAST**: OWASP ZAP for dynamic application security testing
- **Container Security**: Trivy for Docker image scanning
- **Secret Detection**: Gitleaks for credential scanning

### AI/ML Integration
- **LLM Models**: LLaMA 3.3, DeepSeek R1 via Hugging Face
- **Policy Generation**: Automated NIST CSF and ISO 27001 policy creation
- **Quality Metrics**: BLEU and ROUGE-L evaluation frameworks
- **Prompt Engineering**: Optimized templates for security policy generation

---

## 🗂️ Project Structure

```text
.
├── app/
│   ├── api/                    # FastAPI routes (stocks, watchlist)
│   ├── core/                   # Config, Celery, authentication
│   ├── db/                     # SQLAlchemy models and session
│   ├── services/               # Business logic and background tasks
│   │   ├── report_processor.py # Security report processing
│   │   └── tasks.py            # Celery tasks
│   └── main.py                 # Application entrypoint
├── alembic/                    # Database migrations
├── .github/
│   └── workflows/
│       └── devsecops.yml       # CI/CD DevSecOps pipeline
├── reports/                    # Security scan outputs
│   ├── sonarqube/
│   ├── dependency-check/
│   ├── zap/
│   └── trivy/
├── processed/                  # Normalized vulnerability data
├── ai-policies/                # LLM-generated security policies
├── policy-templates/           # NIST CSF and ISO 27001 templates
├── normalize_vulnerabilities.py # Report normalization script
├── real_llm_integration.py     # LLM policy generation
├── evaluate_policies.py        # BLEU/ROUGE-L evaluation
├── docker-compose.yml          # Multi-service orchestration
├── Dockerfile                  # Application container
├── requirements.txt            # Python dependencies
├── .env                        # Environment configuration
├── README.md                   # Project documentation
└── readme_devsecops.md         # Detailed DevSecOps guide
```

---

## 🏗️ DevSecOps Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     GitHub Actions Workflow                      │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│  SAST Tools  │      │  SCA Tools   │      │Secret Scanning│
│              │      │              │      │              │
│ • SonarQube  │      │ • OWASP DC   │      │ • Gitleaks   │
│ • Semgrep    │      │              │      │              │
└──────────────┘      └──────────────┘      └──────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ Build & Package  │
                    │  Docker Image    │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │Container Security│
                    │     (Trivy)      │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ Deploy to Staging│
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │   DAST Testing   │
                    │   (OWASP ZAP)    │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │Report Processing │
                    │  & Normalization │
                    └──────────────────┘
                              │
                              ▼
            ┌─────────────────────────────────┐
            │    LLM Policy Generation        │
            │  (LLaMA 3.3 / DeepSeek R1)     │
            └─────────────────────────────────┘
                              │
                              ▼
            ┌─────────────────────────────────┐
            │   BLEU/ROUGE-L Evaluation       │
            │   (Policy Quality Metrics)      │
            └─────────────────────────────────┘
```

---

## ⚙️ Getting Started

### 1️⃣ Prerequisites

Install the following tools:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (20.10+)
- [Git](https://git-scm.com/)
- [Python 3.11+](https://www.python.org/) (for local development)
- **Optional**: [VS Code](https://code.visualstudio.com/) with [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

**For DevSecOps Pipeline:**
- GitHub account (for Actions)
- Hugging Face account & API token (for LLM access)
- SonarQube server (or use SonarCloud)

---

### 2️⃣ Quick Start

**Clone the repository:**

```bash
git clone <repository-url>
cd intelligent-stock-market-monitoring-platform
```

**Configure environment:**

```bash
cp .env.example .env
# Edit .env and add:
# - DATABASE_URL
# - REDIS_URL
# - HF_TOKEN (Hugging Face API token)
# - SONAR_TOKEN (SonarQube token)
```

**Start the application:**

```bash
docker-compose up -d
```

**Access the services:**

- FastAPI Application: [http://localhost:8000](http://localhost:8000)
- API Documentation: [http://localhost:8000/docs](http://localhost:8000/docs)
- PostgreSQL: localhost:5432
- Redis: localhost:6379

---

### 3️⃣ Running the DevSecOps Pipeline Locally

**Step 1: Run Security Scans**

```bash
# SAST with Semgrep
docker run --rm -v $(pwd):/src returntocorp/semgrep scan --config=auto --json -o reports/semgrep-report.json

# Container Security with Trivy
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image your-image:tag --format json -o reports/trivy-report.json

# Secret Scanning with Gitleaks
docker run --rm -v $(pwd):/path zricethezav/gitleaks:latest detect \
  --source=/path --report-path=/path/reports/gitleaks-report.json
```

**Step 2: Normalize Vulnerability Reports**

```bash
python normalize_vulnerabilities.py
# Output: processed/normalized_vulnerabilities.json
```

**Step 3: Generate AI Policies**

```bash
# Set your Hugging Face token
export HF_TOKEN=your_hugging_face_token

# Generate policies with LLaMA 3.3
python real_llm_integration.py --model llama

# Generate policies with DeepSeek R1
python real_llm_integration.py --model deepseek

# Outputs saved to: ai-policies/
```

**Step 4: Evaluate Policy Quality**

```bash
python evaluate_policies.py
# Calculates BLEU and ROUGE-L scores against reference policies
```

---

### 4️⃣ Database Migrations with Alembic

```bash
# Create a new migration
alembic revision --autogenerate -m "add users table"

# Apply migrations
alembic upgrade head

# View migration history
alembic history
```

---

## 🔬 Research & Evaluation

### LLM Comparative Study

This project compares two leading LLMs for security policy generation:

| Model | Strengths | Use Case |
|-------|-----------|----------|
| **LLaMA 3.3** | General-purpose reasoning, multilingual | Comprehensive policy generation |
| **DeepSeek R1** | Code-aware, security-focused reasoning | Technical vulnerability analysis |

### Evaluation Metrics

**BLEU Score** (BiLingual Evaluation Understudy)
- Measures n-gram overlap with reference policies
- Range: 0-1 (higher is better)
- Evaluates precision of generated text

**ROUGE-L Score** (Recall-Oriented Understudy for Gisting Evaluation)
- Measures longest common subsequence
- Range: 0-1 (higher is better)
- Evaluates recall and fluency

### Running Evaluation

```bash
# Generate reference policies (manually created or from templates)
python create_reference_policies.py

# Generate LLM policies
python real_llm_integration.py --model llama
python real_llm_integration.py --model deepseek

# Calculate metrics
python evaluate_policies.py
# Output: Comparative analysis with BLEU/ROUGE-L scores
```

---

## 📊 Security Standards Alignment

### NIST Cybersecurity Framework

The generated policies map to five core functions:

1. **IDENTIFY** (ID): Asset management, risk assessment
2. **PROTECT** (PR): Access control, data security
3. **DETECT** (DE): Anomaly detection, monitoring
4. **RESPOND** (RS): Response planning, incident handling
5. **RECOVER** (RC): Recovery planning, improvements

### ISO/IEC 27001:2022 Controls

Policies align with key Annex A controls:

- **A.5**: Organizational controls
- **A.8**: Technology controls
- **A.12.6.1**: Management of technical vulnerabilities
- **A.14**: Security in development and support
- **A.16**: Incident management

---

## 📚 Learning Resources

### DevSecOps & Security
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [ISO/IEC 27001 Standard](https://www.iso.org/standard/27001)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [DevSecOps Best Practices](https://www.devsecops.org/)

### Tools Documentation
- [SonarQube](https://docs.sonarqube.org/)
- [OWASP Dependency-Check](https://jeremylong.github.io/DependencyCheck/)
- [OWASP ZAP](https://www.zaproxy.org/docs/)
- [Trivy](https://aquasecurity.github.io/trivy/)
- [Semgrep](https://semgrep.dev/docs/)

### AI/ML Resources
- [Hugging Face Transformers](https://huggingface.co/docs/transformers/)
- [LLaMA Models](https://huggingface.co/meta-llama)
- [DeepSeek R1](https://huggingface.co/deepseek-ai)
- [BLEU Metric](https://huggingface.co/spaces/evaluate-metric/bleu)
- [ROUGE Metric](https://huggingface.co/spaces/evaluate-metric/rouge)

### Application Development
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [SQLAlchemy 2.0](https://docs.sqlalchemy.org/en/20/)
- [Celery](https://docs.celeryq.dev/)
- [Docker Compose](https://docs.docker.com/compose/)

---

## ❓ FAQ

**Q: How do I add new security scanning tools?**
- Add tool configuration to `.github/workflows/devsecops.yml`
- Create parser in `normalize_vulnerabilities.py`
- Update LLM prompts to include new vulnerability types

**Q: Can I use other LLM models?**
- Yes! Edit `real_llm_integration.py` and add your model
- Supported: OpenAI API, local Ollama, any HuggingFace model
- Update evaluation scripts accordingly

**Q: How do I customize policy templates?**
- Edit files in `policy-templates/` directory
- Modify NIST CSF and ISO 27001 reference policies
- Re-run evaluation to see impact on BLEU/ROUGE-L scores

**Q: What if the LLM API is rate-limited?**
- The system includes automatic fallback to rule-based generation
- Configure retry logic in `real_llm_integration.py`
- Consider using local LLMs via Ollama for unlimited access

**Q: How do I contribute new features?**
- Fork the repository and create a feature branch
- Ensure all security scans pass
- Submit a pull request with clear documentation

---

## 🎯 Project Deliverables

For academic evaluation, this project includes:

1. **Technical Implementation** (25%)
   - Functional DevSecOps pipeline
   - Multi-tool security scanning
   - LLM integration with multiple models

2. **Report Processing** (20%)
   - Parsers for JSON/XML/HTML formats
   - Normalized vulnerability schema
   - Data quality validation

3. **AI Policy Generation** (20%)
   - LLaMA 3.3 and DeepSeek R1 integration
   - NIST CSF and ISO 27001 compliance
   - Prompt engineering optimization

4. **Research Analysis** (20%)
   - BLEU and ROUGE-L evaluation
   - Comparative LLM performance study
   - Ethical implications discussion

5. **Documentation** (15%)
   - Technical documentation
   - Implementation guide
   - Research findings report

---

## 🔒 Security Considerations

**Secrets Management:**
- Never commit `.env` files
- Use GitHub Secrets for CI/CD credentials
- Rotate API tokens regularly

**Vulnerability Disclosure:**
- This is an educational project
- Real vulnerabilities found should be reported responsibly
- Follow coordinated disclosure practices

**AI Ethics:**
- LLM-generated policies require human review
- Potential for bias in automated recommendations
- Transparency in AI decision-making

---

## 📄 License & Attribution

**Project**: Final Project 2025/2026 3GL
**Student**: Saad Aittaleb
**Institution**: [Your Institution]
**Course**: AI-Driven DevSecOps

---

## 🚀 Next Steps

For detailed implementation guidance, see [readme_devsecops.md](readme_devsecops.md)

**Phase 1**: Set up DevSecOps pipeline
**Phase 2**: Integrate security scanning tools
**Phase 3**: Implement LLM policy generation
**Phase 4**: Conduct evaluation and research analysis