# Kubernetes Automation with Ansible

Comprehensive Ansible automation for Kubernetes cluster management and application deployment.

## 📁 Contents

### Playbooks
- `deploy-app.yaml` - Deploy applications to K8s
- `scale-app.yaml` - Scale deployments
- `wordpress-stack.yaml` - Multi-container WordPress deployment

### Templates
- `deployment.j2` - Deployment template
- `service.j2` - Service template
- `ingress.j2` - Ingress template

## 🚀 Quick Examples

### Deploy Application
```bash
ansible-playbook kubernetes/playbooks/deploy-app.yaml \
  -e "app_name=myapp" \
  -e "app_version=v1.0" \
  -e "namespace=production"
```

### Scale Deployment
```bash
ansible-playbook kubernetes/playbooks/scale-app.yaml \
  -e "deployment_name=myapp" \
  -e "replicas=5"
```

## 🔧 Setup

### Install Collections
```bash
ansible-galaxy collection install kubernetes.core community.docker
```

### Configure kubeconfig
```bash
# Copy your kubeconfig
mkdir -p ~/.kube
cp /path/to/kubeconfig ~/.kube/config

# Or for Minikube
minikube start
```

## 📚 Learning Path

1. **Basic Deployments** - Start with simple single-container apps
2. **Multi-Container Apps** - WordPress + MariaDB stack
3. **Advanced Operations** - Scaling, rolling updates, rollbacks
4. **Production Patterns** - Monitoring, backup, security