---
title: User Stories
description: Feature as seen from the perspective of the end user.
weight: 15
---


## Topics Dashboard
As an OSINT analyst using the Taranis tool, I require access to a Topics Dashboard feature that displays the most important news topics. This dashboard should prioritize the most frequently occurring tags, offering a snapshot of the prevailing themes and subjects within the collected news items. 

## Search, Filter and Sort
As an OSINT analyst using the Taranis tool, I need the capability to search for news items by entering any text string. This feature should provide a ranked list of results based on the relevance to the search query, enabling me to quickly and effectively identify the most pertinent articles for further analysis. 

## Vote on article
As an OSINT analyst using the Taranis tool, I need the ability to mark news items as important by voting on them. This feature should allow me to quickly identify and categorize significant articles for easy retrieval at a later time. The interface should provide a straightforward mechanism, such as a voting button or a star icon, to designate an item as important. 

## Tags 
As an OSINT analyst using the Taranis tool, I need the ability to filter news items based on tags, attributes, or important keywords. This feature should allow me to quickly find relevant news items by applying a tag filter within the tool. The interface should provide an option to enter or select tags, and display the filtered results. In scenarios where no news items match the selected tags, it should result in an empty story list. 

## Create Report 
As an OSINT analyst using the Taranis tool, I require a feature to create reports directly within the Analyse view. To generate a new report, I should be able to click on a "New Report" button, select the type of report item I wish to include, title the report, and then save it. This process allows me to efficiently group stories and news items together.

## Create and edit News Item
As an OSINT analyst using the Taranis tool, I need a feature that enables me to create news items, specifying details such as title, publish date, review, link, article content, and attributes. For news items I manually create, there should be no option to add or edit tags. However, news items automatically gathered from OSINT sources should include automatically created tags that I can edit. To maintain data integrity, the editing function will be disabled for any news item once it is included in a report. For ease of use, each news item has an edit button in the Asses view.  
User Story defined by the following issues:

[#100](https://github.com/taranis-ai/taranis-ai/issues/100) [#101](https://github.com/taranis-ai/taranis-ai/issues/101) [#102](https://github.com/taranis-ai/taranis-ai/issues/102)

# Admin Stories 

## Word Lists
 As an admin of the Taranis tool, I need the ability to utilize Word Lists for filtering news items during collection or enhancing them with a Bot. This includes the capability to import and export word lists and apply them based on their designated usage, such as adding tags with the word_list_bot.

![wordlist workflow](/docs/word_list_workflow.png)

## Configure Sources
As an admin in Taranis, I need to configure OSINT sources to be gathered for intelligence gathering purposes.

## Configure Report Types
As an admin in Taranis, I need the ability to configure new report types.
## Configure Users
As an admin in Taranis, I need to manage user accounts by creating and deleting users, ensuring they have the necessary access for their tasks.

## Configure ACLs and roles
As an admin user of the Taranis tool, I need to configure Access Control Lists (ACLs) and roles to define permissions for each role. This allows me to effectively manage user permissions, control access to sensitive information, and maintain compliance with organizational policies and regulations.





