#!/bin/bash
# Example: Your first Git commit workflow for Ansible automation

set -e  # Exit on error

echo "========================================="
echo "First Git Commit Workflow for Ansible"
echo "========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    echo "  Ubuntu/Debian: sudo apt install git"
    echo "  RHEL/CentOS: sudo yum install git"
    exit 1
fi

# Initialize repository (if new project)
echo "Step 1: Initializing Git repository..."
if [ ! -d ".git" ]; then
    git init
    echo "✓ Repository initialized"
else
    echo "✓ Repository already initialized"
fi

# Create basic Ansible structure
echo ""
echo "Step 2: Creating Ansible directory structure..."
mkdir -p playbooks roles inventories group_vars host_vars

echo "✓ Directory structure created"

# Create .gitignore
echo ""
echo "Step 3: Creating .gitignore file..."
cat > .gitignore << 'EOF'
# Ansible specific
*.retry
*.log
.vault_pass
*.swp
*.swo

# Python
__pycache__/
*.py[cod]
.venv/
venv/

# IDE
.vscode/
.idea/

# Secrets
*secret*
*password*
*.pem
*.key

# OS
.DS_Store
Thumbs.db
EOF

echo "✓ .gitignore created"

# Create README if it doesn't exist
echo ""
echo "Step 4: Creating README.md..."
if [ ! -f "README.md" ]; then
    cat > README.md << 'EOF'
# Ansible Automation Project

## Overview
This project contains Ansible automation for infrastructure management.

## Structure
- `playbooks/` - Ansible playbooks
- `roles/` - Ansible roles
- `inventories/` - Environment inventories
- `group_vars/` - Group variables
- `host_vars/` - Host-specific variables

## Usage
```bash
ansible-playbook -i inventories/production playbooks/deploy.yml
```

## Requirements
- Ansible 2.15+
- Python 3.8+

## Documentation
See individual role README files for detailed documentation.
EOF
    echo "✓ README.md created"
else
    echo "✓ README.md already exists"
fi

# Create example playbook
echo ""
echo "Step 5: Creating example playbook..."
cat > playbooks/example.yml << 'EOF'
---
- name: Example Playbook
  hosts: localhost
  connection: local
  gather_facts: true
  
  tasks:
    - name: Display system information
      ansible.builtin.debug:
        msg: "Running on {{ ansible_distribution }} {{ ansible_distribution_version }}"
    
    - name: Check Ansible version
      ansible.builtin.debug:
        msg: "Ansible version: {{ ansible_version.full }}"
EOF

echo "✓ Example playbook created"

# Test playbook syntax
echo ""
echo "Step 6: Testing playbook syntax..."
if command -v ansible-playbook &> /dev/null; then
    ansible-playbook --syntax-check playbooks/example.yml
    echo "✓ Syntax check passed"
else
    echo "⚠ Ansible not installed, skipping syntax check"
fi

# First commit
echo ""
echo "Step 7: Creating first commit..."
git add .
git commit -m "Initial commit: Ansible project structure

- Add directory structure for playbooks, roles, and inventories
- Create .gitignore for Ansible-specific exclusions
- Add README with project overview
- Include example playbook for testing

This establishes the foundation for our Ansible automation project."

echo "✓ First commit created"

# Show git status
echo ""
echo "Step 8: Verifying repository status..."
git log --oneline -1
git status

echo ""
echo "========================================="
echo "✓ Repository setup complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Connect to remote repository:"
echo "   git remote add origin git@github.com:username/repo.git"
echo ""
echo "2. Push to GitHub:"
echo "   git push -u origin main"
echo ""
echo "3. Start developing your automation:"
echo "   git checkout -b feature/your-feature"
echo ""
