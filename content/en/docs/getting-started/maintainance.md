---
title: Maintainance
description: How to upgrade database of Taranis AI
weight: 10
---

Supported upgrade of PostgreSQL 14.x to PostgreSQL 17.x. This upgrade is capable of upgrading a fully running instance of Taranis AI. Expect Taranis AI downtime during the process of the upgrade.

### Prerequisites
- Installed [Docker Compose V2](https://docs.docker.com/compose/install/) or [podman-compose](https://github.com/containers/podman-compose)
- Running Taranis AI deployment using the `docker/compose.yml` file.
- Running database PostgreSQL of major version 14
- Compose file (`docker/compose.yml`) is setup to use the image of PostgreSQL 17 (check your `POSTGRES_TAG` variable in the `.env` file)

## Steps to upgrade
1. Go to directory: `taranis-ai/docker`
2. Ensure the script `upgrade-database.sh` is executable
3. Run the script: `./upgrade-database.sh`

All containers should now be again up and running!