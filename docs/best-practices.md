# Ansible Best Practices

## Project Structure
- Use clear, descriptive names for playbooks and roles
- Organize by technology domain (kubernetes/, docker/, cloud/)
- Keep playbooks focused and modular
- Use roles for reusable components

## Security
- **Never commit secrets to git**
- Use Ansible Vault for sensitive data
- Implement RBAC in Kubernetes
- Use service accounts with minimal permissions
- Rotate credentials regularly
- Use SSH keys instead of passwords

## Code Quality
- Run ansible-lint before committing
- Use meaningful variable names (avoid single letters)
- Add comments for complex logic
- Keep playbooks idempotent
- Follow YAML best practices (consistent indentation)

## Variables
- Use group_vars and host_vars for organization
- Prefix variables with role/purpose (k8s_namespace, docker_image)
- Define defaults in roles
- Use vault for sensitive variables

## Testing
- Always use --syntax-check before running
- Test with --check (dry-run) first
- Have separate dev/staging/prod inventories
- Implement CI/CD checks (ansible-lint, syntax check)

## Version Control
- Commit frequently with clear messages
- Use feature branches for development
- Tag releases (v1.0.0, v1.1.0)
- Document changes in commit messages

## Performance
- Use pipelining in ansible.cfg
- Leverage fact caching when possible
- Use async for long-running tasks
- Optimize with strategy plugins (free, linear)
- Limit gathered facts when not needed

## Documentation
- Maintain README in each module
- Document required variables
- Provide usage examples
- Include troubleshooting guides