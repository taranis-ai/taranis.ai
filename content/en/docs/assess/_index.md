---
title: Assess
description: Assessing News Items and Stories
weight: 3
---

* [Description](#description)
* [Functionalities](#functionalities)


## Description
Assess displays a list of collected news items from various sources, which can be searched, filtered, and sorted based on different attributes (see [Filters](#filters)). Furthermore, news items can be merged, added to reports, analyzed and have their state changed  (see [Items](#items)).

## Functionalities

### Omnisearch

The global search field can search across Stories, Reports, and Products. Use a scope prefix to search only one area:

- `story: phishing campaign`
- `report: weekly`
- `product: pdf`

Story searches can also use Assess filter tokens. Tokens can be combined with free text, for example:

```text
story: source:"CERT.at" tag:ransomware read:false important:true range:last7 sort:updated_desc
```

Supported Assess tokens are:

- `source:` source name or ID
- `group:` source group name or ID
- `tag:` tag value
- `read:`, `important:`, `relevant:`, `in-report:` with `true` or `false`
- `cybersecurity:` with `yes`, `no`, `mixed`, or `incomplete`
- `changed-by:me`
- `range:` with `shift`, `24h`, `week`, `day`, `month`, `last7`, or `last<N>`
- `from:` and `to:` for date or datetime values
- `sort:` with `date_desc`, `date_asc`, `relevance`, `updated_desc`, or `updated_asc`

Quote values containing spaces.

### Filters

![AssessFilters](/docs/assess-nav-annotated.png)

##### Details:

- **First Day**: The Story's creation date, typically matching the oldest News Item's "published date."
- **Last Day**: The Story's update date, usually reflecting the latest addition or change.

For **manually created stories**, the "updated" timestamp is essentially the creation time. As a result, filtering by **Last day** for a manually created story will not return it, even if an older "published date" is set.

Users can save the current Assess filters from the **Saved filters** button. A saved filter can be marked as the default for the user profile. Dashboard shortcuts show saved Assess filters so frequently used queues can be opened directly.


### Items
News items collected by [Collectors](../admin/collectors.md) become visible in the Assess section. These items can later be grouped by context, either automatically by the [Bots](../admin/bots.md) or manually.

![AssessStory](/docs/assess-story.png)

Detail view:
* Relevance of item/aggregate can be changed with "up/down" buttons

Charts:
* Each item displays a chart if data has been aggregated in the last 7 days.
* Line and bar chart display the same data, which is the accumulation of items per day.
* The y-axis of the line chart can be adapted and is the same for all charts in the current items list. Therefore, charts can be compared properly.

Story actions include marking read/unread, marking important, sharing to connectors, ungrouping, version history, deleting, editing, adding to reports, and bookmarking. Bulk actions are available after selecting stories; visible shortcuts include `Shift+R` for adding to a report and `Shift+B` for bookmarking.

### Bookmarks

Bookmark collections are private per user. A story can be bookmarked from its action menu, or selected stories can be added to an existing or new collection from the Assess toolbar. If a user bookmarks a single story before creating any collections, Taranis AI creates a default collection named `Bookmarks`.

The Assess page shows up to six bookmark collections in a compact bar. Use **All bookmarks** to open the full bookmark page, rename or delete collections, reorder them, and remove stories from a collection. Removing a story from a bookmark collection does not delete the story from Assess.

### Story Edit Advanced View

The Story Edit view can expose AI assisted actions when advanced story options are enabled in user settings. Available actions include generating a summary and title, and running sentiment analysis. When sentiment attributes are present, the advanced view shows the story sentiment status.
