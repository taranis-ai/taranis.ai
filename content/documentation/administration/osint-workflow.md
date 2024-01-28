---
title: "OSINT workflow"
url: "/documentation/administration/osint-workflow"
---

# Functionalities 👤

1. [Create OSINT Sources](#1-create-osint-sources)
1. [Add word lists](#2-add-word-lists)
1. [Adapt word list's functionality](#3-adapt-word-lists-functionality)
1. [Enable include/exclude list filtering](#4-enable-includeexclude-list-filtering)
1. [Bot selection](#5-bot-selection)
1. [Collect Sources](#6-collect-sources)

## 1. Create OSINT Sources

- Import/Export: Sources can be imported and exported as JSON
- CRUD: Sources can be created, updated and deleted. For each source a collector, feed URL and the content location can be defined among other things.

_Note: So far we have used an RSS collector with following sources: [Initial setup](/documentation/deployment/#initial-setup-)_

![osint_sources](/documentation/osint/osint-sources.png)

## 2. Add word lists

- Import/Export: Word lists can be imported and exported as json
- CRUD: Word lists can be created, updated and deleted.

![wordlists](/documentation/osint/wordlists.png)

## 3. Adapt word list's functionality

Word lists can have the following functionalities (displayed under "usage"):

- Collector Includelist: Collected news items using words of this word list will be accepted
- Collector Excludelist: Collected news items using words of this word list will not be accepted
- Tagging Bot: Collected news items will be tagged with words from these word lists
- Collector Includelist & Tagging Bot: A word list can be used for tagging and include listing

![wordlist_usage](/documentation/osint/wordlist-usage.png)

## 4. Enable include/exclude list filtering

To activate include or exclude lists, they need to be added to the default source group.

It has to be mentioned, that this include/exclude filtering happens during the news item collection. Therefore, only filtered news items will be stored in the database and displayed in "Assess".

![source_groups](/documentation/osint/source-groups.png)

## 5. Bot selection

After the collection, it is possible to adapt news items.

Therefore, following bots are currently available:

- Wordlist bot: Tags news items by wordlist
- IOC bot: Finds indicators of compromise in news items
- NLP tagging bot: Tags news items via NLP
- Story bot: Applies story clustering to news items
- Summary bot: Summarizes stories

CRUD: Bots can be created, updated and deleted.

Index: Decides the order of bots

RUN_AFTER_COLLECTOR: Indicates if bot is active after collection

![bot_selection](/documentation/osint/bot-selection.png)

## 6. Collect Sources

After all settings are made, sources can be collected.
Either collect all sources by clicking on the "collect sources" button, or collect single sources.

![collect_sources](/documentation/osint/collect-sources.png)
