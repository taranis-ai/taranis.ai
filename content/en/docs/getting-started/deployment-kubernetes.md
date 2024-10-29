---
title: Kubernetes deployment
description: How to deploy Taranis AI on Kubernetes
weight: 5
---

## Configuration

Clone via git

```bash
git clone --depth 1  https://github.com/taranis-ai/taranis-ai
cd taranis-ai/docker/
```

Copy `env.sample` to `.env`

```bash
cp env.sample .env
```

Open file `.env` and change defaults if needed. More details about environment variables can be found [here](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

See [Advanced monitoring](./advanced-monitoring.md) for more logging insights.

## Convert via Kompose

Download and install [kompose.io](https://kompose.io/installation/)

```bash
# resovle variables from .env into taranis-ai/docker/compose.yml 
docker compose config > resolved-compose.yml

# convert compose file to kubernetes 
kompose --file resolved-compose.yaml convert
```
