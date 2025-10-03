# Git Collaboration Guide for Ansible Automation

[Previous content continues...]

## Branching Strategies

### Feature Branch Workflow

The most common pattern for infrastructure teams:

```
main (production-ready)
  └── feature/add-monitoring
  └── feature/update-security
  └── bugfix/fix-nginx-config
```

**Process:**
1. Create feature branch from main
2. Develop and test in isolation
3. Submit pull request
4. Code review
5. Merge to main

**Example:**
```bash
# Create feature branch
git checkout -b feature/postgresql-backup

# Work on feature
# ... make changes ...

# Push and create PR
git push origin feature/postgresql-backup
```

### GitFlow (for complex releases)

```
main (production)
  └── develop (integration)
       ├── feature/monitoring
       ├── feature/security
       └── release/v2.0
            └── hotfix/critical-fix
```

**When to use:** Organizations with formal release cycles

### Branch Naming Conventions

```
feature/description       - New functionality
bugfix/description       - Bug fixes
hotfix/description       - Urgent production fixes
docs/description         - Documentation updates
refactor/description     - Code improvements
```

## Collaboration Patterns

### Pattern 1: Fork and Pull Request

**Best for:** Open source, external contributors

```bash
# Contributor workflow
1. Fork repository on GitHub
2. Clone your fork
3. Create feature branch
4. Make changes
5. Push to your fork
6. Create PR to original repository

# Commands
git clone git@github.com:yourname/ansible-automation-journey.git
git checkout -b feature/my-contribution
# ... make changes ...
git push origin feature/my-contribution
# Create PR via GitHub web interface
```

### Pattern 2: Direct Branch

**Best for:** Internal teams with repo access

```bash
# Team member workflow
git clone git@github.com:company/ansible-automation.git
git checkout -b feature/new-role
# ... make changes ...
git push origin feature/new-role
# Create PR via GitHub web interface
```

### Pattern 3: Pair Programming

```bash
# Engineer A creates branch
git checkout -b feature/complex-automation
git push origin feature/complex-automation

# Engineer B pulls same branch
git fetch origin
git checkout feature/complex-automation

# Both engineers commit to same branch
# Regular communication via comments/chat
```

## Code Review Process

### Creating a Pull Request

**Good PR Description:**
```markdown
## Summary
Add PostgreSQL backup automation for production clusters

## Changes
- Implement pg_dump wrapper script
- Add retention policy (30 days)
- Configure cron schedule
- Include email notifications

## Testing
- Syntax check: ✓
- Linted: ✓
- Tested in dev: ✓
- Backup restoration verified: ✓

## Related Issues
Closes #234
```

### Review Checklist

**Code Quality:**
- [ ] Code is readable
- [ ] Variables are descriptive
- [ ] Tasks have clear names
- [ ] Proper error handling

**Ansible Best Practices:**
- [ ] Uses FQCN
- [ ] Idempotent operations
- [ ] Proper module usage
- [ ] Variables in correct locations

**Security:**
- [ ] No hardcoded secrets
- [ ] Ansible Vault for sensitive data
- [ ] Appropriate file permissions

**Testing:**
- [ ] Syntax check passes
- [ ] Linting passes
- [ ] Tested in non-production

## Handling Merge Conflicts

### When Conflicts Occur

```bash
# Update your branch with latest main
git checkout feature/your-branch
git fetch origin
git merge origin/main

# Git shows conflicts
# CONFLICT (content): Merge conflict in roles/webserver/tasks/main.yml
```

### Resolving Conflicts

```yaml
# File shows conflict markers:
<<<<<<< HEAD
- name: Install nginx 1.20
  ansible.builtin.package:
    name: nginx-1.20
=======
- name: Install nginx 1.22
  ansible.builtin.package:
    name: nginx-1.22
>>>>>>> origin/main
```

**Resolution:**
```yaml
# Choose correct version or combine both
- name: Install nginx 1.22
  ansible.builtin.package:
    name: nginx-1.22
```

**Complete resolution:**
```bash
# Edit files to resolve conflicts
vim roles/webserver/tasks/main.yml

# Test that it still works
ansible-playbook --syntax-check playbooks/webserver.yml

# Mark as resolved
git add roles/webserver/tasks/main.yml

# Complete the merge
git commit -m "Resolve merge conflict in webserver role"

# Push updated branch
git push origin feature/your-branch
```

## Best Practices

### Commit Frequently

```bash
# Bad: One massive commit
git add .
git commit -m "Updated everything"

# Good: Logical, small commits
git add roles/webserver/tasks/main.yml
git commit -m "feat: Add nginx installation task"

git add roles/webserver/handlers/main.yml
git commit -m "feat: Add nginx restart handler"

git add roles/webserver/templates/nginx.conf.j2
git commit -m "feat: Add nginx configuration template"
```

### Keep Branches Short-Lived

- Create branch for specific task
- Complete work within days, not weeks
- Merge quickly after review
- Delete branch after merge

### Sync Regularly

```bash
# Daily routine
git checkout main
git pull origin main
git checkout feature/your-branch
git merge main  # Keep feature branch updated
```

### Use .gitignore Properly

```gitignore
# Always exclude
*.retry
.vault_pass
*secret*
*.pem

# Never commit
actual_passwords.yml
production_keys/
```

### Protect Sensitive Data

```bash
# Use Ansible Vault for secrets
ansible-vault create secrets.yml
ansible-vault encrypt existing_file.yml

# Commit encrypted files safely
git add secrets.yml
git commit -m "Add encrypted production credentials"
```

## Advanced Techniques

### Interactive Rebase

Clean up commit history before merging:

```bash
# View last 3 commits
git log --oneline -3

# Start interactive rebase
git rebase -i HEAD~3

# In editor, choose action for each commit:
pick abc123 Add feature
squash def456 Fix typo
reword ghi789 Update docs

# This combines commits and cleans history
```

### Cherry-Pick

Apply specific commits from another branch:

```bash
# Find commit you need
git log feature/other-branch --oneline

# Apply that commit to current branch
git cherry-pick abc123

# Resolve conflicts if any
git cherry-pick --continue
```

### Git Bisect

Find which commit introduced a bug:

```bash
# Start bisect
git bisect start

# Mark current (broken) state
git bisect bad

# Mark last known good commit
git bisect good v1.5.0

# Git checks out middle commit
# Test your automation
ansible-playbook playbooks/test.yml

# Mark as good or bad
git bisect good  # or git bisect bad

# Repeat until Git finds the problem commit

# Exit bisect
git bisect reset
```

### Git Stash

Temporarily save uncommitted changes:

```bash
# Save current work
git stash save "Work in progress on feature X"

# Switch to different branch
git checkout hotfix/urgent-issue

# ... fix urgent issue ...

# Return to original branch
git checkout feature/your-branch

# Restore stashed work
git stash pop
```

## Troubleshooting

### Accidentally Committed to Wrong Branch

```bash
# You're on main but wanted feature branch
git log --oneline -1  # Note the commit hash

# Undo the commit (keep changes)
git reset HEAD~1

# Create correct branch
git checkout -b feature/correct-branch

# Commit properly
git add .
git commit -m "feat: Your commit message"
```

### Accidentally Committed Secret

```bash
# If NOT pushed yet
git reset HEAD~1
ansible-vault encrypt secrets.yml
git add secrets.yml
git commit -m "Add encrypted secrets"

# If already pushed - more serious
# 1. Rotate the exposed credential immediately
# 2. Use git filter-branch to remove from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch secrets.yml" \
  --prune-empty --tag-name-filter cat -- --all

# 3. Force push (dangerous - coordinate with team)
git push origin --force --all
```

### Pushed to Wrong Remote

```bash
# Check remotes
git remote -v

# Remove wrong remote
git remote remove origin

# Add correct remote
git remote add origin git@github.com:correct/repo.git

# Push to correct remote
git push -u origin main
```

### Large Binary File Committed

```bash
# Use Git LFS for large files
git lfs install
git lfs track "*.iso"
git lfs track "*.tar.gz"

# Add .gitattributes
git add .gitattributes
git commit -m "Configure Git LFS"

# For already committed large files
# Use BFG Repo Cleaner or git filter-branch
```

## Resources

- [Official Git Documentation](https://git-scm.com/doc)
- [GitHub Skills](https://skills.github.com/)
- [Ansible Documentation](https://docs.ansible.com/)
- [Pro Git Book](https://git-scm.com/book/en/v2)

## Quick Reference

### Most Used Commands

```bash
git status                 # Check current state
git add filename          # Stage changes
git commit -m "msg"       # Save changes
git push                  # Upload to remote
git pull                  # Download from remote
git checkout -b branch    # Create branch
git merge branch          # Merge branch
git log --oneline         # View history
```

### Emergency Commands

```bash
git reset HEAD~1          # Undo last commit (keep changes)
git reset --hard HEAD~1   # Undo last commit (discard changes)
git revert abc123         # Create new commit that undoes abc123
git stash                 # Temporarily save work
git reflog                # View all actions (recovery tool)
```

### Configuration

```bash
git config --list                    # View all settings
git config user.name "Your Name"     # Set name
git config user.email "you@email"    # Set email
git config --global core.editor vim  # Set editor
```

---

This guide is continuously updated. For questions or improvements, please open an issue or submit a pull request.
