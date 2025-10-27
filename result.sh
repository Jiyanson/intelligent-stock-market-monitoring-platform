Started by user SaadAit
Checking out git https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git into /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline@script/cbe398852023f564e2b92a873eede6ac1feb8c1d9fb80543b1097ecc240f9d6a to read jenkinsfile
The recommended git tool is: git
No credentials specified
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline@script/cbe398852023f564e2b92a873eede6ac1feb8c1d9fb80543b1097ecc240f9d6a/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git # timeout=10
Fetching upstream changes from https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
 > git fetch --tags --force --progress -- https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 450ea872ba4c854f60175d87d65d432f7a6a3e25 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 450ea872ba4c854f60175d87d65d432f7a6a3e25 # timeout=10
Commit message: "Fix publishHTML issue - use archiveArtifacts instead"
 > git rev-list --no-walk 05d832f1698a1480e1ca4a4dbd7c0b61c31fdd92 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
The recommended git tool is: git
No credentials specified
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git # timeout=10
Fetching upstream changes from https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git
 > git --version # timeout=10
 > git --version # 'git version 2.47.3'
 > git fetch --tags --force --progress -- https://github.com/ait-saad/intelligent-stock-market-monitoring-platform-backend.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 450ea872ba4c854f60175d87d65d432f7a6a3e25 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 450ea872ba4c854f60175d87d65d432f7a6a3e25 # timeout=10
Commit message: "Fix publishHTML issue - use archiveArtifacts instead"
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] echo
📦 Source code already checked out by Jenkins SCM
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Pre-commit Security)
[Pipeline] parallel
[Pipeline] { (Branch: Secrets Scanning)
[Pipeline] { (Branch: SAST - Semgrep)
[Pipeline] stage
[Pipeline] { (Secrets Scanning)
[Pipeline] stage
[Pipeline] { (SAST - Semgrep)
[Pipeline] script
[Pipeline] {
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🕵️ Scanning for secrets with Gitleaks...
[Pipeline] sh
[Pipeline] echo
🔍 Running SAST with Semgrep...
[Pipeline] sh
+ pwd
+ docker run --rm -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline:/repo zricethezav/gitleaks:latest detect --source=/repo --report-format=json --report-path=/repo/reports/gitleaks-report.json --no-git
+ mkdir -p reports
+ pwd
+ docker run --rm -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline:/src returntocorp/semgrep:latest --config=p/python --json --output=/src/reports/semgrep-report.json /src
docker: Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "--config=p/python": stat --config=p/python: no such file or directory: unknown.
+ echo Semgrep scan completed
Semgrep scan completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

[90m5:09PM[0m [32mINF[0m [1mscanned ~2932693 bytes (2.93 MB) in 3.91s[0m
[90m5:09PM[0m [33mWRN[0m [1mleaks found: 4[0m
+ echo Gitleaks scan completed
Gitleaks scan completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // parallel
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Docker Image)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🐳 Building Docker image: saadait02/stock-market-platform:24
[Pipeline] sh
+ docker build -t saadait02/stock-market-platform:24 .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 522B 0.0s done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.10-slim
#2 DONE 1.4s

#3 [internal] load .dockerignore
#3 transferring context: 102B 0.0s done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 28.67kB 0.0s done
#4 DONE 0.1s

#5 [1/6] FROM docker.io/library/python:3.10-slim@sha256:e0c4fae70d550834a40f6c3e0326e02cfe239c2351d922e1fb1577a3c6ebde02
#5 resolve docker.io/library/python:3.10-slim@sha256:e0c4fae70d550834a40f6c3e0326e02cfe239c2351d922e1fb1577a3c6ebde02 0.1s done
#5 DONE 0.1s

#6 [2/6] WORKDIR /code
#6 CACHED

#7 [3/6] RUN apt-get update && apt-get install -y     build-essential     libpq-dev     curl     && rm -rf /var/lib/apt/lists/*
#7 CACHED

#8 [4/6] COPY requirements.txt dev-requirements.txt ./
#8 CACHED

#9 [5/6] RUN pip install --no-cache-dir -r requirements.txt -r dev-requirements.txt
#9 CACHED

#10 [6/6] COPY . .
#10 DONE 0.7s

#11 exporting to image
#11 exporting layers
#11 exporting layers 2.1s done
#11 exporting manifest sha256:1d979c08a34a8b68563ff6ad4d090b28f59cffeadf4c192cd0977940806052af 0.0s done
#11 exporting config sha256:eb3f6d30b7a9af29114ec5d9a1a9aa4c564ebc6e70a39ddfa921bd2981ff8715 0.0s done
#11 exporting attestation manifest sha256:a51ba96321230c9a9323fb583fc0f24564cd80aaf31d0d27f87ad8a30ff88982 0.0s done
#11 exporting manifest list sha256:36d4ef5cf212b8510b095718fdd1c67f82f8e04ff54cfd6fddeb6a7bf33836ea
#11 exporting manifest list sha256:36d4ef5cf212b8510b095718fdd1c67f82f8e04ff54cfd6fddeb6a7bf33836ea 0.0s done
#11 naming to docker.io/saadait02/stock-market-platform:24 done
#11 unpacking to docker.io/saadait02/stock-market-platform:24
#11 unpacking to docker.io/saadait02/stock-market-platform:24 0.4s done
#11 DONE 2.8s
+ docker tag saadait02/stock-market-platform:24 saadait02/stock-market-platform:latest
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build AI Processor Image)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🤖 Building AI processor image (cached for faster AI stages)...
[Pipeline] sh
+ docker build -f Dockerfile.ai-processor -t ai-security-processor:latest .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile.ai-processor
#1 transferring dockerfile: 1.19kB 0.0s done
#1 DONE 0.1s

#2 [internal] load metadata for docker.io/library/python:3.11-slim
#2 DONE 0.1s

#3 [internal] load .dockerignore
#3 transferring context: 102B 0.0s done
#3 DONE 0.1s

#4 [1/7] FROM docker.io/library/python:3.11-slim@sha256:8eb5fc663972b871c528fef04be4eaa9ab8ab4539a5316c4b8c133771214a617
#4 resolve docker.io/library/python:3.11-slim@sha256:8eb5fc663972b871c528fef04be4eaa9ab8ab4539a5316c4b8c133771214a617 1.6s done
#4 DONE 1.7s

#5 [2/7] WORKDIR /app
#5 DONE 0.2s

#6 [3/7] RUN apt-get update && apt-get install -y     curl     git     && rm -rf /var/lib/apt/lists/*
#6 35.05 Setting up libnghttp2-14:amd64 (1.64.0-1.1) ...
#6 35.07 Setting up less (668-1) ...
#6 35.10 Setting up krb5-locales (1.21.3-5) ...
#6 35.12 Setting up libcom-err2:amd64 (1.47.2-3+b3) ...
#6 35.14 Setting up libldap-common (2.6.10+dfsg-1) ...
#6 35.16 Setting up libkrb5support0:amd64 (1.21.3-5) ...
#6 35.18 Setting up libsasl2-modules-db:amd64 (2.1.28+dfsg1-9) ...
#6 35.20 Setting up libx11-data (2:1.8.12-1) ...
#6 35.22 Setting up bash-completion (1:2.16.0-7) ...
#6 35.26 Setting up libp11-kit0:amd64 (0.25.5-3) ...
#6 35.28 Setting up libunistring5:amd64 (1.3-2) ...
#6 35.30 Setting up patch (2.8-2) ...
#6 35.32 Setting up libk5crypto3:amd64 (1.21.3-5) ...
#6 35.34 Setting up libsasl2-2:amd64 (2.1.28+dfsg1-9) ...
#6 35.35 Setting up libnghttp3-9:amd64 (1.8.0-1) ...
#6 35.37 Setting up perl-modules-5.40 (5.40.1-6) ...
#6 35.39 Setting up libtasn1-6:amd64 (4.20.0-2) ...
#6 35.41 Setting up git-man (1:2.47.3-0+deb13u1) ...
#6 35.43 Setting up libx11-6:amd64 (2:1.8.12-1) ...
#6 35.45 Setting up libngtcp2-16:amd64 (1.11.0-1) ...
#6 35.47 Setting up libkrb5-3:amd64 (1.21.3-5) ...
#6 35.49 Setting up libssh2-1t64:amd64 (1.11.1-1) ...
#6 35.51 Setting up libfido2-1:amd64 (1.15.0-1+b1) ...
#6 35.53 Setting up publicsuffix (20250328.1952-0.1) ...
#6 35.56 Setting up libldap2:amd64 (2.6.10+dfsg-1) ...
#6 35.57 Setting up libxmuu1:amd64 (2:1.1.3-3+b4) ...
#6 35.59 Setting up libxext6:amd64 (2:1.3.4-1+b3) ...
#6 35.61 Setting up libidn2-0:amd64 (2.3.8-2) ...
#6 35.63 Setting up libperl5.40:amd64 (5.40.1-6) ...
#6 35.65 Setting up perl (5.40.1-6) ...
#6 35.69 Setting up libgssapi-krb5-2:amd64 (1.21.3-5) ...
#6 35.72 Setting up xauth (1:1.1.2-1.1) ...
#6 35.73 Setting up libgnutls30t64:amd64 (3.8.9-3) ...
#6 35.75 Setting up openssh-client (1:10.0p1-7) ...
#6 36.42 Setting up libpsl5t64:amd64 (0.21.2-1.1+b1) ...
#6 36.66 Setting up liberror-perl (0.17030-1) ...
#6 36.86 Setting up librtmp1:amd64 (2.4+20151223.gitfa8646d.1-2+b5) ...
#6 36.88 Setting up libngtcp2-crypto-gnutls8:amd64 (1.11.0-1) ...
#6 36.90 Setting up libcurl4t64:amd64 (8.14.1-2) ...
#6 36.92 Setting up libcurl3t64-gnutls:amd64 (8.14.1-2) ...
#6 36.94 Setting up git (1:2.47.3-0+deb13u1) ...
#6 36.98 Setting up curl (8.14.1-2) ...
#6 37.00 Processing triggers for libc-bin (2.41-12) ...
#6 DONE 37.5s

#7 [4/7] RUN pip install --no-cache-dir     torch --index-url https://download.pytorch.org/whl/cpu &&     pip install --no-cache-dir     transformers     huggingface_hub     requests     pandas     numpy     python-dotenv
#7 3.324 Looking in indexes: https://download.pytorch.org/whl/cpu
#7 4.258 Collecting torch
#7 4.293   Downloading https://download.pytorch.org/whl/cpu/torch-2.9.0%2Bcpu-cp311-cp311-manylinux_2_28_x86_64.whl.metadata (29 kB)
#7 4.813 Collecting filelock (from torch)
#7 4.906   Downloading https://download.pytorch.org/whl/filelock-3.19.1-py3-none-any.whl.metadata (2.1 kB)
#7 5.075 Collecting typing-extensions>=4.10.0 (from torch)
#7 5.104   Downloading https://download.pytorch.org/whl/typing_extensions-4.15.0-py3-none-any.whl.metadata (3.3 kB)
#7 5.505 Collecting sympy>=1.13.3 (from torch)
#7 5.544   Downloading https://download.pytorch.org/whl/sympy-1.14.0-py3-none-any.whl.metadata (12 kB)
#7 5.942 Collecting networkx>=2.5.1 (from torch)
#7 5.977   Downloading https://download.pytorch.org/whl/networkx-3.5-py3-none-any.whl.metadata (6.3 kB)
#7 6.348 Collecting jinja2 (from torch)
#7 6.383   Downloading https://download.pytorch.org/whl/jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#7 6.782 Collecting fsspec>=0.8.5 (from torch)
#7 6.823   Downloading https://download.pytorch.org/whl/fsspec-2025.9.0-py3-none-any.whl.metadata (10 kB)
#7 7.420 Collecting mpmath<1.4,>=1.1.0 (from sympy>=1.13.3->torch)
#7 7.455   Downloading https://download.pytorch.org/whl/mpmath-1.3.0-py3-none-any.whl (536 kB)
#7 7.626      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 536.2/536.2 kB 3.2 MB/s eta 0:00:00
#7 8.012 Collecting MarkupSafe>=2.0 (from jinja2->torch)
#7 8.042   Downloading https://download.pytorch.org/whl/MarkupSafe-2.1.5-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (28 kB)
#7 8.113 Downloading https://download.pytorch.org/whl/cpu/torch-2.9.0%2Bcpu-cp311-cp311-manylinux_2_28_x86_64.whl (184.5 MB)
#7 74.04    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 184.5/184.5 MB 5.0 MB/s eta 0:00:00
#7 74.08 Downloading https://download.pytorch.org/whl/fsspec-2025.9.0-py3-none-any.whl (199 kB)
#7 74.15    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 199.3/199.3 kB 2.9 MB/s eta 0:00:00
#7 74.18 Downloading https://download.pytorch.org/whl/networkx-3.5-py3-none-any.whl (2.0 MB)
#7 74.56    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.0/2.0 MB 5.4 MB/s eta 0:00:00
#7 74.60 Downloading https://download.pytorch.org/whl/sympy-1.14.0-py3-none-any.whl (6.3 MB)
#7 76.11    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.3/6.3 MB 4.2 MB/s eta 0:00:00
#7 76.15 Downloading https://download.pytorch.org/whl/typing_extensions-4.15.0-py3-none-any.whl (44 kB)
#7 76.20    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.6/44.6 kB 68.5 MB/s eta 0:00:00
#7 76.23 Downloading https://download.pytorch.org/whl/filelock-3.19.1-py3-none-any.whl (15 kB)
#7 76.26 Downloading https://download.pytorch.org/whl/jinja2-3.1.6-py3-none-any.whl (134 kB)
#7 76.35    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 1.5 MB/s eta 0:00:00
#7 78.20 Installing collected packages: mpmath, typing-extensions, sympy, networkx, MarkupSafe, fsspec, filelock, jinja2, torch
#7 120.3 Successfully installed MarkupSafe-2.1.5 filelock-3.19.1 fsspec-2025.9.0 jinja2-3.1.6 mpmath-1.3.0 networkx-3.5 sympy-1.14.0 torch-2.9.0+cpu typing-extensions-4.15.0
#7 120.3 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
#7 122.2 Collecting transformers
#7 122.4   Downloading transformers-4.57.1-py3-none-any.whl.metadata (43 kB)
#7 122.4      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.0/44.0 kB 2.7 MB/s eta 0:00:00
#7 122.7 Collecting huggingface_hub
#7 122.7   Downloading huggingface_hub-0.36.0-py3-none-any.whl.metadata (14 kB)
#7 122.9 Collecting requests
#7 122.9   Downloading requests-2.32.5-py3-none-any.whl.metadata (4.9 kB)
#7 123.3 Collecting pandas
#7 123.3   Downloading pandas-2.3.3-cp311-cp311-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (91 kB)
#7 123.3      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 91.2/91.2 kB 3.8 MB/s eta 0:00:00
#7 123.9 Collecting numpy
#7 124.1   Downloading numpy-2.3.4-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (62 kB)
#7 124.2      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.1/62.1 kB 5.5 MB/s eta 0:00:00
#7 124.3 Collecting python-dotenv
#7 124.3   Downloading python_dotenv-1.2.1-py3-none-any.whl.metadata (25 kB)
#7 125.0 Requirement already satisfied: filelock in /usr/local/lib/python3.11/site-packages (from transformers) (3.19.1)
#7 125.2 Collecting packaging>=20.0 (from transformers)
#7 125.2   Downloading packaging-25.0-py3-none-any.whl.metadata (3.3 kB)
#7 125.4 Collecting pyyaml>=5.1 (from transformers)
#7 125.4   Downloading pyyaml-6.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.4 kB)
#7 126.8 Collecting regex!=2019.12.17 (from transformers)
#7 126.8   Downloading regex-2025.10.23-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (40 kB)
#7 126.8      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 40.5/40.5 kB 7.7 MB/s eta 0:00:00
#7 127.3 Collecting tokenizers<=0.23.0,>=0.22.0 (from transformers)
#7 127.3   Downloading tokenizers-0.22.1-cp39-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.8 kB)
#7 127.6 Collecting safetensors>=0.4.3 (from transformers)
#7 127.7   Downloading safetensors-0.6.2-cp38-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.1 kB)
#7 127.9 Collecting tqdm>=4.27 (from transformers)
#7 128.0   Downloading tqdm-4.67.1-py3-none-any.whl.metadata (57 kB)
#7 128.0      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 57.7/57.7 kB 12.6 MB/s eta 0:00:00
#7 128.1 Requirement already satisfied: fsspec>=2023.5.0 in /usr/local/lib/python3.11/site-packages (from huggingface_hub) (2025.9.0)
#7 128.2 Requirement already satisfied: typing-extensions>=3.7.4.3 in /usr/local/lib/python3.11/site-packages (from huggingface_hub) (4.15.0)
#7 128.3 Collecting hf-xet<2.0.0,>=1.1.3 (from huggingface_hub)
#7 128.4   Downloading hf_xet-1.2.0-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.9 kB)
#7 128.6 Collecting charset_normalizer<4,>=2 (from requests)
#7 128.7   Downloading charset_normalizer-3.4.4-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (37 kB)
#7 128.8 Collecting idna<4,>=2.5 (from requests)
#7 128.8   Downloading idna-3.11-py3-none-any.whl.metadata (8.4 kB)
#7 128.9 Collecting urllib3<3,>=1.21.1 (from requests)
#7 128.9   Downloading urllib3-2.5.0-py3-none-any.whl.metadata (6.5 kB)
#7 129.0 Collecting certifi>=2017.4.17 (from requests)
#7 129.1   Downloading certifi-2025.10.5-py3-none-any.whl.metadata (2.5 kB)
#7 129.3 Collecting python-dateutil>=2.8.2 (from pandas)
#7 129.4   Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl.metadata (8.4 kB)
#7 129.6 Collecting pytz>=2020.1 (from pandas)
#7 129.7   Downloading pytz-2025.2-py2.py3-none-any.whl.metadata (22 kB)
#7 129.8 Collecting tzdata>=2022.7 (from pandas)
#7 129.8   Downloading tzdata-2025.2-py2.py3-none-any.whl.metadata (1.4 kB)
#7 130.1 Collecting six>=1.5 (from python-dateutil>=2.8.2->pandas)
#7 130.1   Downloading six-1.17.0-py2.py3-none-any.whl.metadata (1.7 kB)
#7 130.3 Downloading transformers-4.57.1-py3-none-any.whl (12.0 MB)
#7 136.4    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.0/12.0 MB 1.8 MB/s eta 0:00:00
#7 136.4 Downloading huggingface_hub-0.36.0-py3-none-any.whl (566 kB)
#7 136.6    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 566.1/566.1 kB 4.1 MB/s eta 0:00:00
#7 136.6 Downloading requests-2.32.5-py3-none-any.whl (64 kB)
#7 136.6    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 64.7/64.7 kB 11.8 MB/s eta 0:00:00
#7 136.7 Downloading pandas-2.3.3-cp311-cp311-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl (12.8 MB)
#7 140.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.8/12.8 MB 3.9 MB/s eta 0:00:00
#7 140.3 Downloading numpy-2.3.4-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl (16.9 MB)
#7 144.6    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 16.9/16.9 MB 4.4 MB/s eta 0:00:00
#7 144.6 Downloading python_dotenv-1.2.1-py3-none-any.whl (21 kB)
#7 144.6 Downloading certifi-2025.10.5-py3-none-any.whl (163 kB)
#7 144.7    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 163.3/163.3 kB 4.8 MB/s eta 0:00:00
#7 144.7 Downloading charset_normalizer-3.4.4-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (151 kB)
#7 144.7    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 151.6/151.6 kB 4.8 MB/s eta 0:00:00
#7 144.8 Downloading hf_xet-1.2.0-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.3 MB)
#7 145.9    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.3/3.3 MB 3.0 MB/s eta 0:00:00
#7 146.0 Downloading idna-3.11-py3-none-any.whl (71 kB)
#7 146.0    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 71.0/71.0 kB 14.6 MB/s eta 0:00:00
#7 146.0 Downloading packaging-25.0-py3-none-any.whl (66 kB)
#7 146.0    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 66.5/66.5 kB 49.2 MB/s eta 0:00:00
#7 146.1 Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl (229 kB)
#7 146.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 kB 2.5 MB/s eta 0:00:00
#7 146.2 Downloading pytz-2025.2-py2.py3-none-any.whl (509 kB)
#7 146.4    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 509.2/509.2 kB 3.9 MB/s eta 0:00:00
#7 146.4 Downloading pyyaml-6.0.3-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (806 kB)
#7 146.8    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 806.6/806.6 kB 2.1 MB/s eta 0:00:00
#7 146.8 Downloading regex-2025.10.23-cp311-cp311-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (800 kB)
#7 147.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 800.3/800.3 kB 2.3 MB/s eta 0:00:00
#7 147.2 Downloading safetensors-0.6.2-cp38-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (485 kB)
#7 147.5    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 485.8/485.8 kB 2.1 MB/s eta 0:00:00
#7 147.6 Downloading tokenizers-0.22.1-cp39-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.3 MB)
#7 148.9    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.3/3.3 MB 2.6 MB/s eta 0:00:00
#7 148.9 Downloading tqdm-4.67.1-py3-none-any.whl (78 kB)
#7 148.9    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.5/78.5 kB 1.7 MB/s eta 0:00:00
#7 149.0 Downloading tzdata-2025.2-py2.py3-none-any.whl (347 kB)
#7 149.1    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 347.8/347.8 kB 3.3 MB/s eta 0:00:00
#7 149.1 Downloading urllib3-2.5.0-py3-none-any.whl (129 kB)
#7 149.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 129.8/129.8 kB 3.3 MB/s eta 0:00:00
#7 149.3 Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
#7 151.3 Installing collected packages: pytz, urllib3, tzdata, tqdm, six, safetensors, regex, pyyaml, python-dotenv, packaging, numpy, idna, hf-xet, charset_normalizer, certifi, requests, python-dateutil, pandas, huggingface_hub, tokenizers, transformers
#7 ...

#8 [internal] load build context
#8 transferring context: 83B 0.1s done
#8 DONE 0.1s

#7 [4/7] RUN pip install --no-cache-dir     torch --index-url https://download.pytorch.org/whl/cpu &&     pip install --no-cache-dir     transformers     huggingface_hub     requests     pandas     numpy     python-dotenv
#7 190.3 Successfully installed certifi-2025.10.5 charset_normalizer-3.4.4 hf-xet-1.2.0 huggingface_hub-0.36.0 idna-3.11 numpy-2.3.4 packaging-25.0 pandas-2.3.3 python-dateutil-2.9.0.post0 python-dotenv-1.2.1 pytz-2025.2 pyyaml-6.0.3 regex-2025.10.23 requests-2.32.5 safetensors-0.6.2 six-1.17.0 tokenizers-0.22.1 tqdm-4.67.1 transformers-4.57.1 tzdata-2025.2 urllib3-2.5.0
#7 190.3 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
#7 190.6 
#7 190.6 [notice] A new release of pip is available: 24.0 -> 25.3
#7 190.6 [notice] To update, run: pip install --upgrade pip
#7 DONE 193.2s

#9 [5/7] RUN mkdir -p /reports /output /app/scripts
#9 DONE 1.6s

#10 [6/7] COPY reports/process_vulnerabilities.py /app/scripts/
#10 DONE 0.2s

#11 [7/7] RUN chmod +x /app/scripts/process_vulnerabilities.py
#11 DONE 0.8s

#12 exporting to image
#12 exporting layers
#12 exporting layers 101.4s done
#12 exporting manifest sha256:1e2b15e673c627fb43366e16adc195f72e41ed9848f2146f06f0c3d6665adaff 0.1s done
#12 exporting config sha256:5ddf7913864d3a498a5e8a427f3c88671ff49e47b9b08d646e651607d412db3b 0.0s done
#12 exporting attestation manifest sha256:871995293313f690a57db911a97bccc8f9aaad2260205bab40c96bca37fd6e1f 0.1s done
#12 exporting manifest list sha256:90791946fca2740671d72ea4ae906f99ff1ddee40dedf192a62e7a9a4c91c034
#12 exporting manifest list sha256:90791946fca2740671d72ea4ae906f99ff1ddee40dedf192a62e7a9a4c91c034 0.0s done
#12 naming to docker.io/library/ai-security-processor:latest 0.0s done
#12 unpacking to docker.io/library/ai-security-processor:latest
#12 unpacking to docker.io/library/ai-security-processor:latest 50.1s done
#12 DONE 152.0s
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Security Scanning)
[Pipeline] parallel
[Pipeline] { (Branch: SCA - Dependency Check)
[Pipeline] { (Branch: Container Scan - Trivy)
[Pipeline] { (Branch: SAST - SonarQube)
[Pipeline] stage
[Pipeline] { (SCA - Dependency Check)
[Pipeline] stage
[Pipeline] { (Container Scan - Trivy)
[Pipeline] stage
[Pipeline] { (SAST - SonarQube)
[Pipeline] script
[Pipeline] {
[Pipeline] script
[Pipeline] {
[Pipeline] script
[Pipeline] {
[Pipeline] echo
📦 Running SCA with OWASP Dependency-Check...
[Pipeline] sh
[Pipeline] echo
🔒 Running container scan with Trivy...
[Pipeline] sh (show)
[Pipeline] echo (show)
[Pipeline] withCredentials (show)
+ mkdir -p reports
+ pwd
+ docker run --rm -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline:/src -v dependency-check-data:/usr/share/dependency-check/data owasp/dependency-check:latest --scan /src --format JSON,HTML --out /src/reports --project Stock Market Platform
An invalid 'format' of 'JSON,HTML' was specified. Supported output formats are HTML, XML, CSV, JSON, JUNIT, SARIF, JENKINS, GITLAB or ALL, and custom template files.
usage: Dependency-Check Core [--advancedHelp] [--disableVersionCheck]
       [--enableExperimental] [--exclude <pattern>] [-f <format>]
       [--failOnCVSS <score>] [-h] [--junitFailOnCVSS <score>] [-l <file>]
       [-n] [--nvdApiKey <apiKey>] [-o <path>] [--prettyPrint] [--project
       <name>] [-s <path>] [--suppression <file>] [-v]

Dependency-Check Core can be used to identify if there are any known CVE
vulnerabilities in libraries utilized by an application. Dependency-Check
Core will automatically update required data from the Internet, such as
the CVE and CPE data files from nvd.nist.gov.

    --advancedHelp              Print the advanced help message.
    --disableVersionCheck       Disables the dependency-check version
                                check
    --enableExperimental        Enables the experimental analyzers.
    --exclude <pattern>         Specify an exclusion pattern. This option
                                can be specified multiple times and it
                                accepts Ant style exclusions.
 -f,--format <format>           The report format (HTML, XML, CSV, JSON,
                                JUNIT, SARIF, JENKINS, GITLAB or ALL). The
                                default is HTML. Multiple format
                                parameters can be specified.
    --failOnCVSS <score>        Specifies if the build should be failed if
                                a CVSS score above a specified level is
                                identified. The default is 11; since the
                                CVSS scores are 0-10, by default the build
                                will never fail.
 -h,--help                      Print this message.
    --junitFailOnCVSS <score>   Specifies the CVSS score that is
                                considered a failure when generating the
                                junit report. The default is 0.
 -l,--log <file>                The file path to write verbose logging
                                information.
 -n,--noupdate                  Disables the automatic updating of the
                                NVD-CVE, hosted-suppressions and RetireJS
                                data.
    --nvdApiKey <apiKey>        The API Key to access the NVD API.
 -o,--out <path>                The folder to write reports to. This
                                defaults to the current directory. It is
                                possible to set this to a specific file
                                name if the format argument is not set to
                                ALL.
    --prettyPrint               When specified the JSON and XML report
                                formats will be pretty printed.
    --project <name>            The name of the project being scanned.
 -s,--scan <path>               The path to scan - this option can be
                                specified multiple times. Ant style paths
                                are supported (e.g. 'path/**/*.jar'); if
                                using Ant style paths it is highly
                                recommended to quote the argument value.
    --suppression <file>        The file path to the suppression XML file.
                                This can be specified more then once to
                                utilize multiple suppression files
 -v,--version                   Print the version information.
+ echo Dependency check completed
Dependency check completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // parallel
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy for DAST)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🚀 Deploying application for DAST testing...
[Pipeline] sh
+ docker run -d --name dast-app -p 8000:8000 saadait02/stock-market-platform:24
9ed6ccf5f1eed6d4f8cc8fb2be6fcd0d5e87ad85582aacf2a1cba7c13d3988a0
docker: Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint dast-app (02a583a54ae1db0d41d841cf463a0bdb1ecf832e5177ee8856e84e6b80d0b0b1): Bind for 0.0.0.0:8000 failed: port is already allocated.
+ true
+ echo Waiting for application to start...
Waiting for application to start...
+ sleep 20
+ curl -f http://localhost:8000/api/v1/ping
+ echo Attempt {1..5}: Application not ready yet, waiting...
Attempt {1..5}: Application not ready yet, waiting...
+ docker run --rm --network=host saadait02/stock-market-platform:24 sh -c python -c "from fastapi import FastAPI; app = FastAPI(); print("App created")"
  File "<string>", line 1
    from fastapi import FastAPI; app = FastAPI(); print(App
                                                       ^
SyntaxError: '(' was never closed
+ true
+ sleep 10
+ echo Setting up test endpoint for DAST...
Setting up test endpoint for DAST...
+ docker run -d --name dast-nginx -p 8001:80 nginx:latest
ddfea83a45bc737e63d3d8203442f625b4a1f3243914cdd24c740f4ab2303c65
+ sleep 5
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (DAST - OWASP ZAP)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🕷️ Running DAST with OWASP ZAP...
[Pipeline] sh
+ mkdir -p reports
+ TARGET_URL=http://localhost:8000
+ curl -f http://localhost:8000
+ echo FastAPI not responding, using nginx endpoint
FastAPI not responding, using nginx endpoint
+ TARGET_URL=http://localhost:8001
+ pwd
+ docker run --rm --network=host -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/reports:/zap/wrk/:rw owasp/zap2docker-stable:latest zap-baseline.py -t http://localhost:8001 -J zap-report.json -r zap-report.html
Unable to find image 'owasp/zap2docker-stable:latest' locally
docker: Error response from daemon: pull access denied for owasp/zap2docker-stable, repository does not exist or may require 'docker login'.
See 'docker run --help'.
+ echo ZAP scan completed
ZAP scan completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (AI Security Policy Generation)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🤖 Generating security policies with AI...
[Pipeline] sh
+ docker images
+ grep -q ai-security-processor
+ echo AI processor image already exists, skipping build...
AI processor image already exists, skipping build...
[Pipeline] withCredentials
Masking supported pattern matches of $HF_TOKEN
[Pipeline] {
[Pipeline] sh
+ pwd
+ pwd
+ docker run --rm -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/reports:/reports -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/ai-policies:/output -e HF_TOKEN=**** ai-security-processor:latest
🤖 Starting AI-driven vulnerability processing...
📊 Processing Trivy report...
✅ Trivy: 631 vulnerabilities processed
📈 Total vulnerabilities processed: 631
🧠 Generating security policy with AI...
✅ Results saved:
   📄 Normalized vulnerabilities: /output/normalized_vulnerabilities.json
   📋 AI-generated policy: /output/ai_generated_policy.json
🎉 AI processing completed successfully!
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Report Processing & Analysis)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
📊 Processing and normalizing security reports...
[Pipeline] sh
+ pwd
+ pwd
+ docker run --rm -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/reports:/input -v /var/jenkins_home/workspace/Stock-Market-DevSecOps-Pipeline/processed:/output saadait02/stock-market-platform:24 python -c 
                            import json
                            import sys
                            sys.path.append('/code')
                            from app.services.report_processor import process_all_reports
                            process_all_reports('/input', '/output')
                            
  File "<string>", line 2
    import json
IndentationError: unexpected indent
+ echo Report processing completed
Report processing completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Tests)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🧪 Running tests...
[Pipeline] sh
+ docker run --rm -e DATABASE_URL=sqlite:///./test.db -e REDIS_URL=redis://localhost:6379 saadait02/stock-market-platform:24 sh -c pip install pytest && python -m pytest -v app/ || echo "No tests found - tests completed"
Requirement already satisfied: pytest in /usr/local/lib/python3.10/site-packages (8.4.1)
Requirement already satisfied: pygments>=2.7.2 in /usr/local/lib/python3.10/site-packages (from pytest) (2.19.2)
Requirement already satisfied: iniconfig>=1 in /usr/local/lib/python3.10/site-packages (from pytest) (2.1.0)
Requirement already satisfied: tomli>=1 in /usr/local/lib/python3.10/site-packages (from pytest) (2.2.1)
Requirement already satisfied: exceptiongroup>=1 in /usr/local/lib/python3.10/site-packages (from pytest) (1.3.0)
Requirement already satisfied: pluggy<2,>=1.5 in /usr/local/lib/python3.10/site-packages (from pytest) (1.6.0)
Requirement already satisfied: packaging>=20 in /usr/local/lib/python3.10/site-packages (from pytest) (25.0)
Requirement already satisfied: typing-extensions>=4.6.0 in /usr/local/lib/python3.10/site-packages (from exceptiongroup>=1->pytest) (4.14.1)
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

[notice] A new release of pip is available: 23.0.1 -> 25.3
[notice] To update, run: pip install --upgrade pip
============================= test session starts ==============================
platform linux -- Python 3.10.19, pytest-8.4.1, pluggy-1.6.0 -- /usr/local/bin/python
cachedir: .pytest_cache
rootdir: /code
plugins: anyio-4.9.0
collecting ... collected 0 items

============================ no tests ran in 0.05s =============================
No tests found - tests completed
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push to Docker Hub)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
🚀 Pushing image to Docker Hub...
[Pipeline] withCredentials
Masking supported pattern matches of $DOCKER_PASS
[Pipeline] {
[Pipeline] sh
Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [DOCKER_PASS]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
+ echo ****
+ docker login -u saadait02 --password-stdin
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
+ docker push saadait02/stock-market-platform:24
The push refers to repository [docker.io/saadait02/stock-market-platform]
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
296e07bd32e3: Waiting
8cf1d0b23c42: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
275c0b7a1608: Layer already exists
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
8f3ff2960122: Waiting
38513bd72563: Waiting
a9a29352df11: Waiting
61f959655c81: Waiting
dcc665d66e71: Layer already exists
79b6c8751c20: Waiting
bdbf59bd156c: Waiting
296e07bd32e3: Waiting
8cf1d0b23c42: Waiting
296e07bd32e3: Layer already exists
8cf1d0b23c42: Layer already exists
8f3ff2960122: Waiting
38513bd72563: Layer already exists
a9a29352df11: Layer already exists
61f959655c81: Layer already exists
79b6c8751c20: Layer already exists
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
bdbf59bd156c: Waiting
8f3ff2960122: Waiting
bdbf59bd156c: Pushed
8f3ff2960122: Pushed
24: digest: sha256:36d4ef5cf212b8510b095718fdd1c67f82f8e04ff54cfd6fddeb6a7bf33836ea size: 856
+ docker push saadait02/stock-market-platform:latest
The push refers to repository [docker.io/saadait02/stock-market-platform]
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
38513bd72563: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
dcc665d66e71: Waiting
38513bd72563: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
275c0b7a1608: Waiting
61f959655c81: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
38513bd72563: Layer already exists
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
61f959655c81: Layer already exists
79b6c8751c20: Waiting
296e07bd32e3: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
79b6c8751c20: Waiting
296e07bd32e3: Layer already exists
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Waiting
bdbf59bd156c: Waiting
8cf1d0b23c42: Waiting
dcc665d66e71: Waiting
8f3ff2960122: Waiting
a9a29352df11: Waiting
275c0b7a1608: Layer already exists
79b6c8751c20: Waiting
79b6c8751c20: Layer already exists
8f3ff2960122: Layer already exists
a9a29352df11: Layer already exists
dcc665d66e71: Layer already exists
bdbf59bd156c: Already exists
8cf1d0b23c42: Layer already exists
latest: digest: sha256:36d4ef5cf212b8510b095718fdd1c67f82f8e04ff54cfd6fddeb6a7bf33836ea size: 856
+ docker logout
Removing login credentials for https://index.docker.io/v1/
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Archive Reports)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
📁 Archiving security reports and AI-generated policies...
[Pipeline] archiveArtifacts
Archiving artifacts
‘reports/*.json’ doesn’t match anything: ‘reports’ exists but not ‘reports/*.json’
No artifacts found that match the file pattern "reports/*.json,reports/*.html,ai-policies/*.json,processed/*.json". Configuration error?
[Pipeline] echo
📄 HTML reports archived in artifacts:
[Pipeline] echo
- OWASP ZAP Report: reports/zap-report.html
[Pipeline] echo
- Trivy Report: reports/trivy-report.html
[Pipeline] echo
- Dependency-Check Report: reports/dependency-check-report.html
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Grafana Notification)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
📢 Sending deployment annotation with security metrics to Grafana...
[Pipeline] withCredentials
Masking supported pattern matches of $GRAFANA_API_KEY
[Pipeline] {
[Pipeline] sh
+ date +%s%3N
+ TIME_MS=1761498956722
+ find reports -name *.json -exec grep -l HIGH\|CRITICAL {} ;
+ wc -l
+ HIGH_VULNS=0
+ MESSAGE=🚀 DevSecOps Deployment Complete! Tag: 24 | Build: 24 | Security Scans: ✅ | High/Critical Vulns: 0
+ curl -X POST -H Authorization: Bearer **** -H Content-Type: application/json -d {
                                     "dashboardId": ${GRAFANA_DASHBOARD_ID},
                                     "time": ${TIME_MS},
                                     "tags": ["devsecops", "ai-policy", "security", "24"],
                                     "text": "${MESSAGE}"
                                 } https://ayoubcpge9.grafana.net/api/annotations
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:03 --:--:--     0
100   403  100    84  100   319     20     76  0:00:04  0:00:04 --:--:--    96
100   403  100    84  100   319     20     76  0:00:04  0:00:04 --:--:--   102
{"code":"Loading","message":"Your instance is loading, and will be ready shortly."}
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
🧹 Cleaning up...
[Pipeline] sh
+ docker stop dast-app dast-nginx
dast-app
dast-nginx
+ docker rm dast-app dast-nginx
dast-app
dast-nginx
+ docker images saadait02/stock-market-platform --format {{.Tag}}
+ tail -n +6
+ xargs -r docker rmi saadait02/stock-market-platform:
+ docker image prune -f
Total reclaimed space: 0B
+ find reports/ -name *.json -mtime +7 -delete
[Pipeline] echo
✅ DevSecOps Pipeline completed successfully!
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ echo 📊 Security Scan Summary:
📊 Security Scan Summary:
+ ls reports/
+ wc -l
+ echo - Reports generated: 2
- Reports generated: 2
+ ls ai-policies/
+ wc -l
+ echo - AI policies created: 0
- AI policies created: 0
+ ls processed/
+ wc -l
+ echo - Processing artifacts: 0
- Processing artifacts: 0
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS