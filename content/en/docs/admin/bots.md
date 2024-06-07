---
title: "Bots"
description: "Bots are increasing functuionalities in the background"
weight: 5
---

## List of Bots
1. [IOC BOT](#ioc-bot) - for tagging news items
2. [NLP Tagging BOT](#nlp-tagging-bot) - for tagging news items via NLP
3. [Story BOT](#story-bot) - for story clustering
4. [Summary BOT](#summary-bot) - for summarizing stories
5. [Wordlist BOT](#wordlist-bot) tagging news items by wordlist

## Bot's settings
- Name
- Descrition
- Type: Select an option based on the desired functionalities.
- Index: Specifies the execution order of bots when RUN_AFTER_COLLECTOR is enabled.
- RUN_AFTER_COLLECTOR: Executes the bot after any collector.
- REFRESH_INTERVAL: Specifies the execution interval of the bot (default is 10 minutes).
    - Accepted values:
        - hourly
        - daily 
        - weekly
        - number representing minutes (20 (run every 20 minutes))
        - a certain time (15:44) - run every day at set time (24h time format)