---
title: Advanced monitoring
description: Use Sentry for more runtime insights
weight: 5
---

### Prerequisites
- Sentry instance available, either SaaS or self-hosted.
- Follow this [guide](https://docs.sentry.io/product/sentry-basics/integrate-frontend/create-new-project/#create-a-project) to have a Sentry project (and `SENTRY_DSN`) ready.

## What is Sentry
[Sentry](https://sentry.io/welcome/) is a monitoring tool that enables more insights about an application. Taranis AI takes advantage of this if you enable it at the start up.

## What is there to monitor
Sentry can be used to monitor insights about **GUI**, **Core** and **database**. In Taranis AI: *Issues*, *Traces*, *Profiles* and *Queries* can be tracked.

## How to enable Sentry in Taranis AI
To enable Sentry, set the `SENTRY_DSN` variables in the `.env` file before start of the application. More details about environment variables can be found [here](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

### GUI monitoring
To gain insights about GUI, use the `TARANIS_GUI_SENTRY_DSN` variable and set it to your Sentry DSN address.

### Core and database monitoring
To gain insights about Core and database, use the `TARANIS_CORE_SENTRY_DSN` variable and set it to your Sentry DSN address.