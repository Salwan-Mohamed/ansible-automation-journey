# Docker Automation with Ansible

Automate Docker installation, container management, and image building.

## 📁 Contents

### Playbooks
- `install-docker.yaml` - Install Docker engine on hosts
- `container-manage.yaml` - Manage container lifecycle
- `container-build.yaml` - Build and push container images

## 🚀 Quick Examples

### Install Docker
```bash
ansible-playbook docker/playbooks/install-docker.yaml
```

### Manage Containers
```bash
ansible-playbook docker/playbooks/container-manage.yaml \
  -e "container_action=run" \
  -e "container_image=nginx"
```

### Build Image
```bash
ansible-playbook docker/playbooks/container-build.yaml \
  -e "app_version=v1.0" \
  --ask-vault-pass
```

## 🔧 Prerequisites

- Docker host with SSH access
- Python 3.x on target hosts
- community.docker collection installed

## 📚 Learning Path

1. **Installation** - Set up Docker on target hosts
2. **Container Management** - Start, stop, and configure containers
3. **Image Building** - Build custom images from Dockerfiles
4. **Registry Integration** - Push to Docker Hub, private registries