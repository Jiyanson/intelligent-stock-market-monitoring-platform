# Jenkins Credentials Setup Guide

## Step-by-Step Instructions

### 1. Access Credentials Management
1. Go to Jenkins Dashboard: http://localhost:8080
2. Click **"Manage Jenkins"** (left sidebar)
3. Look for **"Credentials"** in the list (under Security section)
4. Click **"Credentials"**

### 2. Add Global Credentials
1. Click **"System"** → **"Global credentials (unrestricted)"**
2. Click **"+ Add Credentials"** (left sidebar)

### 3. Add Each Credential:

#### A. Docker Hub Credentials
- **Kind**: Username with password
- **Scope**: Global
- **Username**: `michoc` (or your Docker Hub username)
- **Password**: `your-docker-hub-password`
- **ID**: `2709ba15-3bf5-42b4-a41e-e2ae435f4951`
- **Description**: Docker Hub Access
- Click **"Create"**

#### B. SonarQube Token
- **Kind**: Secret text
- **Scope**: Global
- **Secret**: `your-sonarqube-token` (or use `dummy-token` for testing)
- **ID**: `sonarqube-token`
- **Description**: SonarQube API Token
- Click **"Create"**

#### C. HuggingFace Token
- **Kind**: Secret text
- **Scope**: Global
- **Secret**: `your-huggingface-token` (or use `dummy-hf-token` for testing)
- **ID**: `huggingface-token`
- **Description**: HuggingFace API Token
- Click **"Create"**

#### D. Grafana API Key
- **Kind**: Secret text
- **Scope**: Global
- **Secret**: `your-grafana-api-key` (or use `dummy-grafana-key` for testing)
- **ID**: `0acea52d-149d-4dce-affc-6e88b440471e`
- **Description**: Grafana API Key
- Click **"Create"**

## Alternative: Use Dummy Values for Testing

If you don't have real tokens yet, use these dummy values:

```
SonarQube Token: dummy-sonar-token
HuggingFace Token: dummy-hf-token  
Grafana API Key: dummy-grafana-key
Docker Hub: your-actual-docker-credentials (needed for pushing)
```

## Quick URLs:
- Credentials: http://localhost:8080/manage/credentials/
- Global Credentials: http://localhost:8080/manage/credentials/store/system/domain/_/

## What if you can't find "Manage Credentials"?

Try these alternative paths:
1. Dashboard → Manage Jenkins → Configure Global Security → scroll down to find credentials section
2. Dashboard → Manage Jenkins → Security → Credentials
3. Direct URL: http://localhost:8080/manage/credentials/

The pipeline will work with dummy credentials - external integrations will just fail gracefully while core security scanning (Trivy, OWASP tools) will still work!