---
title: "Analyze"
url: "/documentation/analyze"
---

* [Description](#description)
* [Functionalities](#functionalities)
* [Screenshots](#screenshots)


## Description
Analyze displays a list of all report items. They can be created, edited, deleted and filtered. 
Different types of reports can be created. Those types can be managed by the _admin_ user in the Administration/Report Types endpoint (see [Report Types](/documentation/administration/report-types)).

_After one of the next releases, it will also be possible to create products from reports._

## Functionalities
### CRUD 
* Create: Reports can be created for any given report type ("New Report" button). After creating a new report, it can instantly be filled with data.
* Read & Update: Details of reports can be edited/read by clicking on them.  News items added to reports (assess) are also displayed in the report item view.
* Delete: One or multiple reports can be deleted at once.

_Note: Reports can be set to "completed" by changing the switch button in the report edit view (top right)._

### Filter 
* Search: Items can be filtered by string search
* Display: Number of items displayed per page
* Offset: Number that defines first item displayed
* Filter: Filter time range (creation date)
* Completed/Incomplete: Filter by report's status  

## Screenshots
Incomplete reports created today 
![analyze_view](/documentation/analyze_view.png)

Add new report item 
![report_item_add](/documentation/report_item_add.png)

Deleting multiple reports at once
![report_item_delete_multiple](/documentation/report_item_delete_multiple.png)

Report item view
![report_item_view](/documentation/report_item_view.png)
