# Setup Guide

## Prerequisites

- Python 3.8+
- pip
- git

## Installation Steps

### 1. Clone Repository
```bash
git clone https://github.com/Salwan-Mohamed/ansible-automation-journey.git
cd ansible-automation-journey
```

### 2. Create Virtual Environment
```bash
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
ansible-galaxy collection install -r requirements.yml
```

### 4. Configure Credentials
```bash
# Create vault password file
echo "your-secure-password" > .vault_pass
chmod 600 .vault_pass

# Encrypt sensitive files
ansible-vault create vars/secrets.yaml
```

### 5. Verify Installation
```bash
ansible --version
ansible-galaxy collection list
```

## Module-Specific Setup

### Kubernetes
```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Setup kubeconfig
mkdir -p ~/.kube
# Copy your cluster config to ~/.kube/config
```

### Docker
```bash
# Run Docker setup playbook
ansible-playbook docker/playbooks/install-docker.yaml
```

## Testing Setup
```bash
# Test Kubernetes connection
ansible-playbook kubernetes/playbooks/deploy-app.yaml --syntax-check

# Run dry-run
ansible-playbook kubernetes/playbooks/deploy-app.yaml --check
```