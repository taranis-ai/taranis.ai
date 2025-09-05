---
title: Deployment
description: How to deploy Taranis AI
weight: 1
---


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

Open file `.env` and change defaults if needed. More details about environment variables can be found [here](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

Taranis AI images are tagged as follows:

- Official release version number (e.g. `1.1.7`)
- Every official image release comes with an extra stable tag, in case pinning the release is not favourable (`stable`)
- Latest tag for tracking the latest uploaded image, there is no guarantee this is an officially released image (`latest`)

See [Internal TLS Configuration](./tls-configuration.md) for setting up TLS encryption and [Advanced monitoring](./advanced-monitoring.md) for more logging insights.
For detailed information about container tags, release strategy, and deployment recommendations, see [Releases and Container Tags](./releases-and-tags.md).

See [Advanced monitoring](./advanced-monitoring.md) for more logging insights.

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

## Initial Setup 👤

**The default credentials are `user` / `user` and `admin` / `admin`.**

The passwords for these two default users can be overridden by setting the environment variables `PRE_SEED_PASSWORD_ADMIN` or `PRE_SEED_PASSWORD_USER` before first launch.
Afterwards they are stored in the database in the `user` table.

Open `http://<url>:<TARANIS_PORT>/config/sources` and click **load default sources** to import the default sources from: [default_sources.json](https://github.com/taranis-ai/taranis-ai/blob/master/src/core/core/static/default_sources.json)

Or import a source export via the **Import**.

![getting started](/docs/getting-started.png)
