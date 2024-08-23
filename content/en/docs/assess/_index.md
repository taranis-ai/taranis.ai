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

![AssessFilters](/docs/assess-nav-annotaded.png)

* Search: Items can be filtered by string search
* Items per page: Number of items displayed per page
* Source group: Filter items by a particular source group
* Source: Filter items by source 
* Time Filter:
    * Filter time range (all, today, last week)
* Tags: Filter by item's tag
    * A Tag is an attribute of a story that usually was extracted by a bot or added by an analyst. It helps analyst finding similar news items and the story clustering bot to create stories.
* Read, important, items in reports, relevant: Filter by item's state
* Sort: Filter by published date, relevance
* Reset filter: Reset all filters and reload news items
* create new item: Opens enter view to create a manual news item
* Show Hotkeys: Open a modal to show available hotkeys

### Items
Items in list view:

![AssessStory](/docs/assess-story.png)


* Open & Details: Each item or item aggregation can be displayed in more detail
* Add to report: Add item to a report 
* Unread, mark as read, mark as important: Item's state changes
* Delete: Delete item
* If multiple items are selected, those can be merged or added to reports at once (buttons in bottom bar appear).  

Detail view: 
* Relevance of item/aggregate can be changed with "up/down" buttons 

Charts: 
* Each item displays a chart if data has been aggregated in the last 7 days. 
* Line and bar chart display the same data, which is the accumulation of items per day.
* The y-axis of the line chart can be adapted and is the same for all charts in the current items list. Therefore, charts can be compared properly.
