---
title: "Assess"
url: "/documentation/assess"
---

* [Description](#description)
* [Functionalities](#functionalities)


## Description
Assess displays a list of collected news items from various sources, which can be searched, filtered, and sorted based on different attributes (see [Filters](#Filters)). Furthermore, news items can be merged, added to reports, analyzed and have their state changed  (see [Items](#Items)).

## Functionalities
### Filters
* Search: Items can be filtered by string search
* Display: Number of items displayed per page 
* Offset: Number that defines first item displayed
* Source group: Filter items by a particular source group
* Source: Filter items by source 
* Range: Filter time range (all, today, last week)
* Tag: Filter by item's tag
* Read, important, items in reports, relevant: Filter by item's state
* Sort: Filter by published date, relevance
* [DEBUG] Chart properties: Change threshold and range of second y-axis in item's graphic
* [DEBUG] Reload: Update news items

### Items
Items in list view:
* Open & Details: Each item or item aggregation can be displayed in more detail
* Add to report: Add item to a report 
* Unread, mark as read, mark as important: Item's state changes
* Delete: Delete item
* If multiple items are selected, those can be merged or added to reports at once (buttons in bottom bar appear).  

Detail view: 
* Relevance of item/aggregate can be changed with "up/down" buttons 

Charts: 
* Each item displays a chart if data has been aggregated in the last 7 days. 
* Line and bar chart display the same data, which is the accumulation of items per day
* The y-axis of the line chart can be adapted and is the same for all charts in the current items list. Therefore, charts can be compared properly.
