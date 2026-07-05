---
title: Deployment
description: How to deploy Taranis AI
weight: 1
---

Install from [`stable` release](https://github.com/taranis-ai/taranis-ai/releases/latest)

```bash
curl -fsSL https://taranis.ai/install.sh | bash
```

Clone via git

```bash
git clone --depth 1  https://github.com/taranis-ai/taranis-ai
cd taranis-ai/docker/
```

## Configuration

Copy `env.sample` to `.env`

```bash
cp env.sample .env
```

Open file `.env` and change defaults if needed. More details about environment variables can be found in the [README.md](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

### Queue and Redis settings

Taranis AI uses Redis for worker queues and frontend cache storage.

| Variable | Used by | Purpose |
| --- | --- | --- |
| `REDIS_URL` | core, frontend, worker | Redis connection URL for RQ queues and cache fallback. |
| `REDIS_PASSWORD` | core, frontend, worker | Redis password. Set this in production. |
| `CACHE_REDIS_URL` | core, frontend | Optional dedicated Redis URL for frontend cache and cache invalidation. Falls back to `REDIS_URL`. |
| `CACHE_REDIS_PASSWORD` | core, frontend | Optional dedicated cache Redis password. Falls back to `REDIS_PASSWORD`. |
| `RQ_DEFAULT_JOB_TIMEOUT` | core | Default RQ job timeout in seconds for queued worker tasks. Default: `180`. |

The Compose deployment wires `REDIS_URL` and `REDIS_PASSWORD` into core, frontend, collector, cron, and worker services. If queued jobs are accepted but not processed, verify that Redis is reachable and at least one worker container is running.

Taranis AI images are tagged as follows:

- Official release version number (e.g. `1.1.7`)
- Every official image release comes with an extra stable tag, in case pinning the release is not favourable (`stable`)
- Latest tag for tracking the latest uploaded image, there is no guarantee this is an officially released image (`latest`)

See [Internal TLS Configuration](/docs/getting-started/20_tls-configuration) for setting up TLS encryption and [Advanced monitoring](/docs/getting-started/15_advanced-monitoring) for more logging insights.
For detailed information about container tags, release strategy, and deployment recommendations, see [Releases and Container Tags](/docs/getting-started/05_releases-and-tags).

See [Advanced monitoring](/docs/getting-started/15_advanced-monitoring) for more logging insights.

## Startup & Usage

TO circumvent the potential reusage of older local images

```bash
docker compose pull
```

Start-up application

```bash
docker compose up -d
```

Use the application

```bash
http://<url>:<TARANIS_PORT>/login
```

## Initial Setup

**The default credentials are `user` / `user` and `admin` / `admin`.**

The passwords for these two default users can be overridden by setting the environment variables `PRE_SEED_PASSWORD_ADMIN` or `PRE_SEED_PASSWORD_USER` before first launch.
Afterwards they are stored in the database in the `user` table.

For existing database-auth users, passwords and role assignments can be repaired with the operational CLI. See [User Management](/docs/admin/user-management/#operational-cli).

Open `http://<url>:<TARANIS_PORT>/config/sources` and click **load default sources** to import the default sources from: [default_sources.json](https://github.com/taranis-ai/taranis-ai/blob/master/src/core/core/static/default_sources.json)

Or import a source export via the **Import**.

![getting started](/docs/getting-started.png)
