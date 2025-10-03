# Contributing to Ansible Automation Journey

Thank you for your interest in contributing to this project! This guide will help you get started.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Code Review](#code-review)
- [Community Guidelines](#community-guidelines)

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- Git installed (version 2.30+)
- Ansible installed (version 2.15+)
- Python 3.8 or higher
- ansible-lint for code quality checks
- yamllint for YAML validation

### Fork the Repository

1. Click the "Fork" button on GitHub
2. Clone your fork locally:
   ```bash
   git clone git@github.com:YOUR-USERNAME/ansible-automation-journey.git
   cd ansible-automation-journey
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream git@github.com:Salwan-Mohamed/ansible-automation-journey.git
   ```

4. Keep your fork synchronized:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

## Development Setup

### Install Development Dependencies

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install Ansible and tools
pip install ansible ansible-lint yamllint

# Install Git hooks (optional but recommended)
cp .githooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### Verify Setup

```bash
# Check Ansible version
ansible --version

# Run linter
ansible-lint --version

# Test syntax checking
ansible-playbook --syntax-check playbooks/example.yml
```

## Making Changes

### Create a Feature Branch

Always create a new branch for your changes:

```bash
# Update main branch first
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/your-feature-name
```

### Branch Naming Conventions

Use descriptive branch names with prefixes:

- `feature/` - New functionality
- `bugfix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code improvements
- `test/` - Test additions or fixes

Examples:
- `feature/add-postgresql-role`
- `bugfix/fix-nginx-config`
- `docs/update-readme`

### Code Style Guidelines

#### Ansible Playbooks and Roles

```yaml
# Use descriptive task names
- name: Install and configure nginx web server
  ansible.builtin.package:
    name: nginx
    state: present

# Use fully qualified collection names (FQCN)
- name: Copy configuration file
  ansible.builtin.copy:
    src: nginx.conf
    dest: /etc/nginx/nginx.conf
    owner: root
    group: root
    mode: '0644'

# Keep playbooks idempotent
- name: Ensure nginx is running
  ansible.builtin.service:
    name: nginx
    state: started
    enabled: true
```

#### Variable Naming

- Use snake_case for variables: `database_host`, `web_server_port`
- Use descriptive names: `postgresql_backup_directory` not `pg_bak_dir`
- Group related variables with prefixes: `app_name`, `app_version`, `app_port`

#### File Organization

```
roles/
  └── role-name/
      ├── defaults/
      │   └── main.yml          # Default variables
      ├── files/                # Static files
      ├── handlers/
      │   └── main.yml          # Handlers
      ├── tasks/
      │   └── main.yml          # Main tasks
      ├── templates/            # Jinja2 templates
      ├── vars/
      │   └── main.yml          # Role variables
      └── README.md             # Role documentation
```

### Testing Your Changes

Before committing, always test:

```bash
# Syntax check
ansible-playbook playbooks/your-playbook.yml --syntax-check

# Lint check
ansible-lint playbooks/ roles/

# YAML lint
yamllint .

# Dry run
ansible-playbook playbooks/your-playbook.yml --check

# Test in development environment
ansible-playbook -i inventories/dev playbooks/your-playbook.yml
```

### Documentation

Update documentation for any changes:

- Update `README.md` if adding new features
- Add inline comments for complex logic
- Create or update files in `docs/` for significant changes
- Include examples in `examples/` directory
- Update CHANGELOG.md with your changes

## Commit Guidelines

### Commit Message Format

We follow the Conventional Commits specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

#### Examples

**Good commit messages:**

```
feat(roles): Add PostgreSQL backup automation

- Implement daily backup script with pg_dump
- Add retention policy configuration (30 days default)
- Include restore validation tasks
- Add email notifications on failure

Tested on PostgreSQL 14 and 15
Closes #45
```

```
fix(playbooks): Correct nginx SSL certificate path

The certificate path was pointing to a non-existent directory
causing the service to fail on startup.

Fixes #78
```

```
docs(readme): Update quick start installation steps

- Add Python version requirement
- Clarify Ansible installation process
- Update example commands
```

**Bad commit messages:**

```
update files
fix stuff
changes
wip
asdf
```

### Atomic Commits

- Make small, focused commits
- Each commit should represent a single logical change
- Don't mix unrelated changes in one commit
- Commit working code (it should pass tests)

## Pull Request Process

### Before Submitting

1. **Rebase on latest main:**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run all tests:**
   ```bash
   ansible-lint playbooks/ roles/
   yamllint .
   ```

3. **Update documentation**

4. **Review your changes:**
   ```bash
   git diff upstream/main
   ```

### Creating the Pull Request

1. Push your branch:
   ```bash
   git push origin feature/your-feature-name
   ```

2. Go to GitHub and create Pull Request

3. Fill out the PR template completely:
   - Describe what the PR accomplishes
   - List specific changes made
   - Describe testing performed
   - Link related issues
   - Add screenshots if applicable

### Pull Request Template

Your PR description should include:

```markdown
## Description
Brief summary of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Changes Made
- Specific change 1
- Specific change 2

## Testing
- [ ] Syntax check passed
- [ ] ansible-lint passed
- [ ] Tested in dev environment
- [ ] Documentation updated

## Related Issues
Closes #123
```

### PR Size Guidelines

- Keep PRs small and focused (< 400 lines of changes)
- Split large changes into multiple PRs
- Each PR should have a single purpose

## Code Review

### For Contributors

- Respond to all review comments
- Be open to feedback
- Ask questions if unclear
- Make requested changes promptly
- Mark conversations as resolved when addressed
- Be patient - reviews take time

### For Reviewers

Review checklist:

#### Code Quality
- [ ] Code is readable and well-organized
- [ ] Variable names are descriptive
- [ ] Tasks have clear names
- [ ] No hardcoded values (use variables)
- [ ] Proper error handling

#### Ansible Best Practices
- [ ] Uses FQCN (fully qualified collection names)
- [ ] Playbooks are idempotent
- [ ] Proper use of modules
- [ ] Handlers are used appropriately
- [ ] Variables are in correct locations

#### Security
- [ ] No hardcoded passwords or secrets
- [ ] Sensitive data uses Ansible Vault
- [ ] File permissions are appropriate
- [ ] No exposure of sensitive information

#### Testing
- [ ] Syntax check passes
- [ ] ansible-lint passes
- [ ] Tested in development environment
- [ ] Edge cases considered

#### Documentation
- [ ] README updated if needed
- [ ] Inline comments for complex logic
- [ ] Examples provided
- [ ] CHANGELOG updated

### Review Etiquette

#### For Reviewers:
- Be constructive and kind
- Explain the "why" behind suggestions
- Distinguish between required changes and suggestions
- Approve when standards are met
- Use "Request Changes" only for serious issues

#### For Contributors:
- Don't take feedback personally
- Ask for clarification if needed
- Explain your reasoning if you disagree
- Thank reviewers for their time

## Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on what is best for the community
- Show empathy towards others
- Accept constructive criticism gracefully

### Communication

- Use clear, professional language
- Stay on topic
- Provide context in discussions
- Search for existing issues before creating new ones
- Use appropriate labels

### Getting Help

- Check documentation first
- Search existing issues
- Ask in discussions for questions
- Provide details when reporting bugs
- Include error messages and logs

## Recognition

Contributors who follow these guidelines and make valuable contributions may be:

- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Invited to become maintainers

## Questions?

- Open an issue with the question label
- Start a discussion in GitHub Discussions
- Check existing documentation

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Ansible Automation Journey! Your efforts help make infrastructure automation better for everyone.
