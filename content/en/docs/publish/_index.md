---
title: "Publish"
description: >
    The "Publish" section enables users to manage and display their products. These products allow users to render their reports into various formats such as HTML, JSON, PDF or plain text.
weight: 5
---

## Functionalities

Publish manages Products. A Product combines one or more Reports with a Product Type, renders the result into a file format, and sends the rendered file to a configured Publisher.

### Product setup

1. Select a Product Type.
2. Add supported Report Items.
3. Save the Product.
4. Render the Product.
5. Preview or download the rendered output.
6. Publish manually, or enable autopublish with a default Publisher.

Product Types define the renderer, template, output format, and which Report Types are compatible. See [Product Types](/docs/admin/product-types/).

### Render and preview

Rendering is a worker-backed action. HTML, JSON, text, and PDF Products can be previewed in the Product view after rendering. Other formats can be downloaded after rendering.

If workers are down, the render job can still be queued but will not complete until a worker starts. See [Background Jobs](/docs/getting-started/07_background-jobs/).

### Publishing

Manual publishing sends the rendered Product to a selected Publisher. Autopublish requires a default Publisher; when enabled, Taranis AI can automatically render and publish matching Products during report/product workflows.

Supported Publishers and their parameters are documented in [Publishers](/docs/admin/publishers/).

### Filter

* Search: Items can be filtered by string search
* Items per page: Number of items displayed per page
* Filter: Show items created today, this week, or this month

## Screenshot
![screenshot](/docs/publish_panel.png)

{{% pageinfo %}}
See also [Product Types](/docs/admin/product-types/) and [Publishers](/docs/admin/publishers/).
{{% /pageinfo %}}
