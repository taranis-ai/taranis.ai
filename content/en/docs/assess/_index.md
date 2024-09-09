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
### Filters

![AssessFilters](/docs/assess-nav-annotated.png)

##### Details:

- **First Day**: The Story's creation date, typically matching the oldest News Item's "published date."
- **Last Day**: The Story's update date, usually reflecting the latest addition or change.

For **manually created stories**, the "updated" timestamp is essentially the creation time. As a result, filtering by **Last day** for a manually created story will not return it, even if an older "published date" is set.


### Items
News items collected by [Collectors](../admin/collectors.md) become visible in the Assess section. These items can later be grouped by context, either automatically by the [Bots](../admin/bots.md) or manually.

![AssessStory](/docs/assess-story.png)

Detail view: 
* Relevance of item/aggregate can be changed with "up/down" buttons 

Charts: 
* Each item displays a chart if data has been aggregated in the last 7 days. 
* Line and bar chart display the same data, which is the accumulation of items per day.
* The y-axis of the line chart can be adapted and is the same for all charts in the current items list. Therefore, charts can be compared properly.
