* [Topics Dashboard](#Topics-Dashboard)
* [Search, Filter and Sort](#search-filter-and-sort)
* [Vote on article](#vote-on-article)
* [Tags](#tags)
* [Create Report](#create-report)
* [Create & Edit News Item](#create-and-edit-news-item)
* [(Admin)Word Lists](#word-lists)
* [(Admin)Configure Sources](#configure-sources)
* [(Admin)Configure Users](#configure-users)
* [(Admin)Configure Report Types](#configure-report-types)
* [(Admin)Configure ACLs and roles](#configure-ACLs-and-roles)


## Topics Dashboard

A user wants to see the most important news topics, so that he can find relevant news items easier. 
 

## Search, Filter and Sort
A user wants to find News Items by searching for any text string. 
He wants to get ranked list of results to further work with. 

https://dev.taranis.cyberrange.rocks/assess?search=Asus&range=week

## Vote on article
A user wants to mark an item as important, so that it is easier to find later. 
 
## Tags 
A user wants to find news times based on an “tag”, an attribute or an important keyword, so that he can easier find relevant news items. 

https://dev.taranis.cyberrange.rocks/assess?tags=ICSA-23-166-01 

https://dev.taranis.cyberrange.rocks/assess?tags=Siemens&tags=ICSA-23-166-10

=> Tag filter can result in empty Storylist: https://dev.taranis.cyberrange.rocks/assess?tags=Siemens&tags=ICSA-23-166-10&tags=Deutschland&tags=xxxxx



## Create Report 
A User wants to create a Report. So that it can later be shared. 

https://dev.taranis.cyberrange.rocks/report/0


## Create and edit News Item

User Story defined by the following issues:

[#100](https://github.com/taranis-ai/taranis-ai/issues/100) [#101](https://github.com/taranis-ai/taranis-ai/issues/101) [#102](https://github.com/taranis-ai/taranis-ai/issues/102)

# Admin Stories 

## Word Lists
An admin wants to use Word Lists to either Filter News Items while collecting, or enhance them with a Bot.
The admin should be able to import & export a wordlist. And use the wordlist based on its designated usage.
For example to add Tags with the word_list_bot.

![wordlist workflow](/documentation/word_list_workflow.png)


## Configure Sources
An admin wants to configure OSINT Sources to be gathered.

## Configure Report Types
An admin wants to configure new Report Types. 


## Configure Users
An admin wants to create and delete users. They want to ensure they have the necessary access for their task. 


## Configure ACLs and roles
An admin wants to define which permissions each role has. 