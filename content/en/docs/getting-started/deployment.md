---
title: Deployment
description: How to deploy Taranis AI
weight: 1
---


Clone via git
```
git clone --depth 1  https://github.com/taranis-ai/taranis-ai
cd taranis-ai/docker/
```

## Configuration

Copy `env.sample` to `.env`
```bash
cp env.sample .env
```

Open file `.env` and change defaults if needed. More details about environment variables can be found [here](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

See [Advanced monitoring](./advanced-monitoring.md) for more logging insights.


## Startup & Usage 

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

Open `http://<url>:<TARANIS_PORT>/config/sources` and click **load default sources** to import the default sources from: [default_sources.json](https://github.com/taranis-ai/taranis-ai/blob/master/src/gui/public/default_sources.json)

Or import a source export via the **Import**.

![getting started](/docs/getting-started.png)
