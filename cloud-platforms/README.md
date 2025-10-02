# Cloud Platforms Automation

Ansible automation for major cloud providers.

## Modules

### AWS
- EC2 instance management
- S3 bucket operations
- RDS database provisioning
- VPC and networking

### Azure
- Virtual Machines
- Storage accounts
- Azure Kubernetes Service (AKS)
- Resource groups

### GCP
- Compute Engine instances
- Google Kubernetes Engine (GKE)
- Cloud Storage
- Networking

## Coming Soon

Full playbooks and examples for each cloud provider will be added as the journey progresses.

## Prerequisites

```bash
# AWS
pip install boto3 botocore
ansible-galaxy collection install amazon.aws

# Azure
pip install azure-cli
ansible-galaxy collection install azure.azcollection

# GCP
pip install google-auth
ansible-galaxy collection install google.cloud
```