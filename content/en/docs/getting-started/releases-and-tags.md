---
title: "Releases and Container Tags"
linkTitle: "Releases and Tags"
weight: 7
description: >
  Understanding Taranis AI release strategy, container image tags, and their meaning for deployment and upgrades.
---
## Container Image Tags Overview

Taranis AI publishes container images to GitHub Container Registry (`ghcr.io`) with different tagging strategies for core services and bots.

### For Core Services (core, gui, worker, frontend)

Core Taranis AI services follow a **stable and tested** release process:

| Tag | Description | Use Case | Stability |
|-----|-------------|----------|-----------|
| `stable` | Latest manually tested and verified release | **Production deployments** | ✅ High |
| `v1.2.3` (semver) | Specific version (semantic versioning) | **Pinned production deployments** | ✅ High |
| `latest` | Latest build from main branch | **Development/testing only** | ⚠️ May contain bugs |

### For Bots (collectors, analyzers, publishers)

Bot containers have a different tagging strategy focused on experimental features:

| Tag | Description | Use Case | Stability |
|-----|-------------|----------|-----------|
| `latest` | Equivalent to `stable` for bots | **Production bot deployments** | ✅ High |
| `stable` | Same as `latest` - tested bot release | **Production bot deployments** | ✅ High |
| `dev` | Development builds with experimental features | **Testing new bot capabilities** | ⚠️ Experimental |
| `experimental` | Cutting-edge features under development | **Research and development** | ❌ Unstable |

## Release Process

### Core Services Release Workflow

1. **Development**: New features and fixes are developed on feature branches
2. **Integration**: Changes are merged to the `main` branch and tagged as `latest`
3. **Testing**: Manual testing and validation of the `latest` build
4. **Release**: Once validated, the build is tagged with:
   - Semantic version (e.g., `v1.2.3`)
   - `stable` tag for easy reference

### Bot Release Workflow

1. **Stable Features**: Proven bot functionality is tagged as `latest`/`stable`
2. **Experimental Features**: New bot capabilities are tagged as `dev` or `experimental`
3. **Promotion**: Successful experimental features are promoted to `stable`

## Semantic Versioning

Taranis AI follows [Semantic Versioning](https://semver.org/) for official releases:

```
v1.2.3
│ │ │
│ │ └── PATCH: Bug fixes, security updates
│ └──── MINOR: New features, backwards compatible
└────── MAJOR: Breaking changes, incompatible API changes
```

### Version Examples

- `v1.0.0` - First stable release
- `v1.1.0` - New features added (backwards compatible)
- `v1.1.1` - Bug fixes for v1.1.0
- `v2.0.0` - Major version with breaking changes

## Deployment Recommendations

### Production Environments

**Recommended approach**: Use specific semantic versions for maximum stability and control.

```yaml
services:
  core:
    image: ghcr.io/taranis-ai/taranis-core:v1.2.3
  gui:
    image: ghcr.io/taranis-ai/taranis-gui:v1.2.3
  worker:
    image: ghcr.io/taranis-ai/taranis-worker:v1.2.3
  frontend:
    image: ghcr.io/taranis-ai/taranis-frontend:v1.2.3
```

**Alternative**: Use `stable` tag for automatic updates to tested releases.

```yaml
services:
  core:
    image: ghcr.io/taranis-ai/taranis-core:stable
  gui:
    image: ghcr.io/taranis-ai/taranis-gui:stable
  worker:
    image: ghcr.io/taranis-ai/taranis-worker:stable
  frontend:
    image: ghcr.io/taranis-ai/taranis-frontend:stable
```

### Development Environments

For development and testing, you can use `latest` tags:

```yaml
services:
  core:
    image: ghcr.io/taranis-ai/taranis-core:latest
  gui:
    image: ghcr.io/taranis-ai/taranis-gui:latest
  worker:
    image: ghcr.io/taranis-ai/taranis-worker:latest
  frontend:
    image: ghcr.io/taranis-ai/taranis-frontend:latest
```

### Bot Deployments

**Production bots**: Use `latest` or `stable` (they are equivalent for bots).

```yaml
services:
  collector-bot:
    image: ghcr.io/taranis-ai/taranis-bot-collector:latest
  
  analyzer-bot:
    image: ghcr.io/taranis-ai/taranis-bot-analyzer:stable
```

**Experimental features**: Use `dev` or `experimental` tags carefully.

```yaml
services:
  experimental-bot:
    image: ghcr.io/taranis-ai/taranis-bot-new-feature:experimental
```

## Upgrade Strategy

### Safe Upgrade Process

1. **Check Release Notes**: Review the changelog for breaking changes
2. **Backup**: Always backup your data before upgrading (see [backup documentation](../deployment#backup-and-restore))
3. **Test**: Test the new version in a staging environment first
4. **Gradual Rollout**: Update non-critical services first

### Version Compatibility

- **Patch versions** (1.2.3 → 1.2.4): Safe to upgrade, only bug fixes
- **Minor versions** (1.2.x → 1.3.0): Generally safe, may require configuration updates
- **Major versions** (1.x.x → 2.0.0): Requires careful planning, may have breaking changes

### Rollback Plan

Always have a rollback plan:

```bash
# Quick rollback to previous version
docker-compose down
# Edit docker-compose.yml to use previous tag
docker-compose up -d
```

## Tag Selection Best Practices

### ✅ Do

- **Use semantic version tags** for production deployments
- **Pin specific versions** in production for predictable deployments
- **Test new versions** in staging before production
- **Monitor release notes** for security updates and breaking changes
- **Use stable tags** for core services in production
- **Use latest/stable tags** for bots in production

### ❌ Don't

- **Use `latest` tag** for core services in production (may contain bugs)
- **Use `experimental` tags** in production environments
- **Mix different versioning strategies** across services without understanding compatibility
- **Upgrade directly** without testing and backup
- **Ignore security updates** - upgrade patch versions promptly

## Container Registry Information

Taranis AI containers are hosted on GitHub Container Registry:

- **Registry**: `ghcr.io`
- **Namespace**: `taranis-ai`
- **Public Access**: All images are publicly available

### Available Images

- `ghcr.io/taranis-ai/taranis-core` - REST API and central component
- `ghcr.io/taranis-ai/taranis-gui` - Vue.js web interface
- `ghcr.io/taranis-ai/taranis-worker` - Background processing service
- `ghcr.io/taranis-ai/taranis-frontend` - Flask & HTMX admin interface

## Getting Release Information

### Latest Release Information

Check the latest releases and tags:

```bash
# List available tags for core service
docker run --rm gcr.io/go-containerregistry/crane ls ghcr.io/taranis-ai/taranis-core

# Check current version in running container
docker exec <container_name> cat /app/version.txt
```

### Release Notes

- **GitHub Releases**: Check [GitHub Releases](https://github.com/taranis-ai/taranis-ai/releases) for detailed changelog
- **Git Tags**: View all tags in the repository for version history
- **Container Labels**: Images include metadata about build information

## Monitoring and Alerts

Consider setting up monitoring for:

- **New release notifications** from GitHub
- **Security advisories** for dependencies
- **Container image vulnerability scanning**
- **Version tracking** in your deployment monitoring

## Support and Maintenance

- **LTS Support**: Major versions receive long-term support
- **Security Updates**: Critical security fixes are backported to supported versions
- **End of Life**: Older versions reach end-of-life according to the support policy

{{% pageinfo %}}
**Important**: Always review the [release notes](https://github.com/taranis-ai/taranis-ai/releases) before upgrading to understand potential impacts and required actions.
{{% /pageinfo %}}
