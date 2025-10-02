# Ansible Automation Journey 🚀

A comprehensive collection of Ansible automation playbooks, roles, and best practices covering infrastructure automation across multiple domains.

## 📚 Learning Modules

### 🐳 Container & Orchestration
- **[Docker](./docker/)** - Container lifecycle management and image building
- **[Kubernetes](./kubernetes/)** - K8s cluster management and application deployment

### ☁️ Cloud Platforms
- **[AWS](./cloud-platforms/aws/)** - EC2, S3, RDS, and more
- **[Azure](./cloud-platforms/azure/)** - VMs, Storage, AKS
- **[GCP](./cloud-platforms/gcp/)** - Compute Engine, GKE

### 🔧 Infrastructure
- **[Networking](./networking/)** - Network automation and configuration
- **[Security](./security/)** - Hardening, compliance, and secrets management
- **[Monitoring](./monitoring/)** - Prometheus, Grafana, ELK stack

### 🔄 DevOps Pipeline
- **[CI/CD](./ci-cd/)** - Jenkins, GitLab CI, GitHub Actions integration

## 🎯 Quick Start

### Prerequisites
```bash
# Install Ansible
pip install ansible

# Install required collections
ansible-galaxy collection install -r requirements.yml

# Install Python dependencies
pip install -r requirements.txt
```

### Basic Usage
```bash
# Check syntax
ansible-playbook playbooks/example.yaml --syntax-check

# Dry run
ansible-playbook playbooks/example.yaml --check

# Execute playbook
ansible-playbook playbooks/example.yaml
```

## 📖 Documentation

- [Setup Guide](./docs/setup-guide.md)
- [Best Practices](./docs/best-practices.md)
- [Kubernetes Module](./kubernetes/README.md)

## 🏗️ Repository Structure

```
ansible-automation-journey/
├── kubernetes/          # Kubernetes automation
├── docker/             # Docker automation
├── cloud-platforms/    # Cloud provider automation
├── networking/         # Network automation
├── security/          # Security & compliance
├── monitoring/        # Monitoring solutions
├── ci-cd/            # CI/CD integration
├── docs/             # Documentation
└── examples/         # Example playbooks
```

## 🚀 Featured Projects

### Kubernetes Application Deployment
```bash
ansible-playbook kubernetes/playbooks/deploy-app.yaml \
  -e "app_name=myapp" \
  -e "app_version=v1.0" \
  -e "namespace=production"
```

## 📝 License

MIT License

---

**Made with ❤️ for learning DevOps automation**