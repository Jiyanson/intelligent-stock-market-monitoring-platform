# Getting Started with the DevSecOps Pipeline

This guide will help you set up and run the complete DevSecOps pipeline for AI-driven security policy generation.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Initial Setup](#initial-setup)
3. [Running Security Scans](#running-security-scans)
4. [Processing Reports](#processing-reports)
5. [Generating AI Policies](#generating-ai-policies)
6. [Evaluating Policy Quality](#evaluating-policy-quality)
7. [Using Docker Compose](#using-docker-compose)
8. [GitHub Actions Pipeline](#github-actions-pipeline)
9. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Tools

- **Docker Desktop** (20.10+): [Install Docker](https://docs.docker.com/get-docker/)
- **Git**: [Install Git](https://git-scm.com/downloads)
- **Python 3.11+**: [Install Python](https://www.python.org/downloads/)

### Optional Tools

- **Visual Studio Code**: [Install VS Code](https://code.visualstudio.com/)
- **SonarQube** (local or cloud): [SonarCloud](https://sonarcloud.io/)

### API Keys and Accounts

1. **Hugging Face Account**
   - Create account at https://huggingface.co/
   - Generate API token: Settings → Access Tokens
   - Keep token secure (never commit to Git)

2. **SonarQube** (optional for local SAST)
   - Sign up at https://sonarcloud.io/ OR
   - Run local SonarQube with Docker Compose

3. **GitHub Account**
   - Required for GitHub Actions CI/CD

---

## Initial Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd intelligent-stock-market-monitoring-platform
```

### 2. Set Up Environment Variables

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Edit `.env` and add your credentials:

```env
# Database Configuration
DATABASE_URL=postgresql://fastapi:fastapi@db:5432/fastapi_db

# Redis Configuration
REDIS_URL=redis://redis:6379/0

# Hugging Face API Token (REQUIRED for LLM policy generation)
HF_TOKEN=your_huggingface_token_here

# SonarQube Configuration (optional)
SONAR_TOKEN=your_sonarqube_token_here
SONAR_HOST_URL=https://sonarcloud.io

# OpenAI API Key (optional - for alternative LLM)
OPENAI_API_KEY=your_openai_key_here
```

### 3. Install Python Dependencies

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Linux/Mac:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 4. Create Required Directories

```bash
mkdir -p reports/{sonarqube,dependency-check,zap,trivy}
mkdir -p processed
mkdir -p ai-policies
mkdir -p evaluation-results
```

---

## Running Security Scans

### Option 1: Using Docker (Recommended)

#### 1. SAST with Semgrep

```bash
docker run --rm -v $(pwd):/src returntocorp/semgrep \
  scan --config=auto --json -o reports/semgrep-report.json /src
```

#### 2. Container Security with Trivy

First, build your application image:

```bash
docker build -t stock-monitoring-platform:latest .
```

Then scan it:

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image \
  --format json \
  --output reports/trivy/trivy-report.json \
  stock-monitoring-platform:latest
```

#### 3. Secret Scanning with Gitleaks

```bash
docker run --rm -v $(pwd):/path zricethezav/gitleaks:latest \
  detect --source=/path \
  --report-path=/path/reports/gitleaks-report.json \
  --no-git
```

#### 4. SCA with OWASP Dependency-Check

```bash
docker run --rm -v $(pwd):/src \
  -v $(pwd)/reports/dependency-check:/report \
  owasp/dependency-check \
  --scan /src \
  --format JSON \
  --out /report
```

#### 5. DAST with OWASP ZAP

First, ensure your application is running:

```bash
docker-compose up -d web
```

Then run ZAP baseline scan:

```bash
docker run --rm -v $(pwd)/reports/zap:/zap/wrk:rw \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py \
  -t http://host.docker.internal:8000 \
  -J zap-report.json \
  -r zap-report.html
```

### Option 2: Using Local Tools

If you have tools installed locally:

```bash
# Semgrep
semgrep scan --config=auto --json -o reports/semgrep-report.json .

# Trivy
trivy image --format json -o reports/trivy/trivy-report.json your-image:tag

# Gitleaks
gitleaks detect --report-path=reports/gitleaks-report.json
```

---

## Processing Reports

### Normalize Vulnerability Data

After running security scans, normalize all reports into a unified format:

```bash
python normalize_vulnerabilities.py
```

**Output:**
- `processed/normalized_vulnerabilities.json` - Unified vulnerability data
- `processed/vulnerability_summary.json` - Summary statistics

**Expected Output:**

```
======================================================================
✅ Normalized 127 total vulnerabilities
======================================================================

📊 Severity Breakdown:
   CRITICAL:    5
       HIGH:   23
     MEDIUM:   67
        LOW:   32

📊 Source Breakdown:
   dependency-check:   45
           gitleaks:    3
           semgrep:   15
        sonarqube:   38
            trivy:   23
               zap:    3
```

---

## Generating AI Policies

### Using LLaMA 3.3

```bash
export HF_TOKEN=your_huggingface_token

python real_llm_integration.py --model llama
```

### Using DeepSeek R1

```bash
export HF_TOKEN=your_huggingface_token

python real_llm_integration.py --model deepseek
```

### Using OpenAI (Alternative)

```bash
export OPENAI_API_KEY=your_openai_key

python real_llm_integration.py --model openai
```

**Output Location:** `ai-policies/<model>_generated_policy.json`

**Example Output Structure:**

```json
{
  "llm_model": "LLaMA 3.3 70B Instruct",
  "llm_generated": true,
  "vulnerability_analysis": {
    "total_analyzed": 127,
    "severity_breakdown": {...}
  },
  "nist_csf_recommendations": [...],
  "iso27001_controls": [...],
  "remediation_priorities": [...],
  "timestamp": "2025-01-15T10:30:00"
}
```

---

## Evaluating Policy Quality

### Run BLEU and ROUGE-L Evaluation

```bash
python evaluate_policies.py --models llama deepseek
```

**Output:**
- `evaluation-results/summary.md` - Markdown summary with scores
- `evaluation-results/detailed_results.json` - Full metrics

**Example Summary:**

```
======================================================================
EVALUATION SUMMARY
======================================================================

LLAMA:
  BLEU Score:        0.3842
  ROUGE-L Precision: 0.4156
  ROUGE-L Recall:    0.3987
  ROUGE-L F1:        0.4068

DEEPSEEK:
  BLEU Score:        0.4123
  ROUGE-L Precision: 0.4398
  ROUGE-L Recall:    0.4201
  ROUGE-L F1:        0.4297
```

### Understanding Metrics

- **BLEU Score** (0-1): Measures n-gram precision
  - > 0.3: Good alignment with reference policy
  - > 0.5: Excellent alignment

- **ROUGE-L** (0-1): Measures semantic similarity
  - **Precision**: How much generated text is relevant
  - **Recall**: How much reference text is covered
  - **F1**: Harmonic mean of precision and recall
  - > 0.4: Good semantic similarity

---

## Using Docker Compose

### Start Core Application

```bash
docker-compose up -d
```

**Services Started:**
- FastAPI application (port 8000)
- PostgreSQL database (port 5432)
- Redis cache (port 6379)
- Celery worker
- pgAdmin (port 5050)

### Start with DevSecOps Tools

```bash
docker-compose --profile devsecops up -d
```

**Additional Services:**
- SonarQube (port 9000)
- OWASP ZAP (port 8080)

### Run AI Processing Pipeline

```bash
docker-compose --profile ai-processing run ai-processor
```

This will:
1. Normalize vulnerability reports
2. Generate policies with both LLaMA and DeepSeek
3. Evaluate policy quality with BLEU/ROUGE-L

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web

# AI processing
docker-compose logs ai-processor
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

---

## GitHub Actions Pipeline

### Setup GitHub Secrets

Navigate to repository Settings → Secrets and add:

1. **HF_TOKEN**: Your Hugging Face API token
2. **SONAR_TOKEN**: SonarQube/SonarCloud token
3. **SONAR_HOST_URL**: SonarQube server URL

### Trigger Pipeline

The pipeline runs automatically on:
- Push to `main` or `develop` branches
- Pull requests to `main`
- Manual trigger via Actions tab

### Manual Trigger

1. Go to repository → Actions tab
2. Select "DevSecOps Pipeline with AI Policy Generation"
3. Click "Run workflow"
4. Select branch and click "Run"

### View Results

After pipeline completion:

1. **Summary Tab**: Overview of all stages
2. **Artifacts**: Download generated reports
   - Security scan reports
   - Normalized vulnerabilities
   - AI-generated policies
   - Evaluation results

### Pipeline Stages

```
1. SAST (Semgrep, SonarQube)
2. SCA (OWASP Dependency-Check)
3. Secret Scanning (Gitleaks)
4. Build & Container Security (Trivy)
5. Deploy to Staging
6. DAST (OWASP ZAP)
7. Process & Normalize Reports
8. AI Policy Generation (LLaMA + DeepSeek)
9. Evaluation (BLEU/ROUGE-L)
10. Security Summary Report
```

---

## Troubleshooting

### Issue: Hugging Face API Rate Limiting

**Error:** `503 Service Unavailable` or `429 Too Many Requests`

**Solutions:**
1. Wait a few minutes and retry
2. Use local LLM with Ollama:
   ```bash
   python real_llm_integration.py --model local
   ```
3. Upgrade Hugging Face account for higher rate limits

### Issue: Empty Vulnerability Reports

**Error:** `No policies found to evaluate`

**Solutions:**
1. Verify security scans completed successfully
2. Check report files exist in `reports/` directory
3. Manually inspect JSON files for correct format
4. Re-run normalize_vulnerabilities.py with debugging:
   ```bash
   python -c "import normalize_vulnerabilities as nv; nv.normalize_vulnerabilities()"
   ```

### Issue: SonarQube Connection Failed

**Error:** `Could not reach SonarQube server`

**Solutions:**
1. Verify SONAR_HOST_URL is correct
2. Check SONAR_TOKEN is valid
3. For local SonarQube:
   ```bash
   docker-compose --profile devsecops up -d sonarqube
   # Wait 2-3 minutes for startup
   # Access http://localhost:9000
   # Default credentials: admin/admin
   ```

### Issue: Docker Build Failures

**Error:** `failed to solve with frontend dockerfile.v0`

**Solutions:**
1. Clear Docker build cache:
   ```bash
   docker builder prune -a
   ```
2. Rebuild with no cache:
   ```bash
   docker-compose build --no-cache
   ```

### Issue: Policy Evaluation Low Scores

**Problem:** BLEU/ROUGE-L scores < 0.2

**Solutions:**
1. Check reference policy exists:
   ```bash
   ls -l policy-templates/nist_csf_reference.json
   ```
2. Verify generated policies have content:
   ```bash
   jq '.nist_csf_recommendations | length' ai-policies/llama_generated_policy.json
   ```
3. Review LLM generation logs for API errors

### Getting Help

- **Project Issues**: https://github.com/<your-org>/<your-repo>/issues
- **DevSecOps Documentation**: See `readme_devsecops.md`
- **Main Documentation**: See `README.md`

---

## Next Steps

1. **Customize Reference Policies**
   - Edit `policy-templates/nist_csf_reference.json`
   - Edit `policy-templates/iso27001_reference.json`
   - Add organization-specific controls

2. **Integrate with Your CI/CD**
   - Copy `.github/workflows/devsecops.yml` to your repository
   - Customize for your deployment environment
   - Add additional security tools

3. **Enhance LLM Prompts**
   - Modify prompts in `real_llm_integration.py`
   - Experiment with temperature and token settings
   - Test different LLM models

4. **Research Analysis**
   - Compare LLM performance across models
   - Analyze BLEU/ROUGE-L trends over time
   - Document ethical implications and bias

---

**Happy Secure Coding!** 🛡️🤖
