---
title: "Releases and Container Tags"
linkTitle: "Releases and Tags"
weight: 7
description: >
  Understanding Taranis AI release strategy, container image tags, and their meaning for deployment and upgrades.
---
## Tags

Taranis AI publishes container images to GitHub Container Registry (`ghcr.io`) with different tagging strategies for core services and bots.

All images are available at [GitHub Container Registry](https://github.com/orgs/taranis-ai/packages).

### For Core Services (core, gui, worker, frontend)

Core Taranis AI services follow a **stable and tested** release process:

| Tag | Description | Use Case | Stability |
|-----|-------------|----------|-----------|
| `stable` | Latest manually tested and verified release | **Production deployments** | ✅ High |
| `v1.2.3` (semver) | Specific version (semantic versioning) | **Pinned production deployments** | ✅ High |
| `latest` | Latest build from main branch | **Development/testing only** | ⚠️ May contain bugs |

### For Bots

Bot containers have a different tagging strategy focused on experimental features:

| Tag | Description | Use Case | Stability |
|-----|-------------|----------|-----------|
| `latest` (alias: `stable`) | Latest manually tested and verified release | **Production bot deployments** | ✅ High |
| `dev` or `experimental` | Development builds with experimental features | **Testing new bot capabilities** | ⚠️ Experimental |
