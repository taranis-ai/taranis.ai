---
title: "Bots"
description: "Bots are increasing functionalities in the background"
weight: 5
---

## List of Bots

1. [IOC BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/ioc_bot.py) - for tagging news items
2. [NLP Tagging BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/nlp_bot.py) - for tagging news items via NLP
3. [Story BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/story_bot.py) - for story clustering
4. [Summary BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/summary_bot.py) - for summarizing stories
5. [Wordlist BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/wordlist_bot.py) - tagging news items by wordlist
6. [Any many more...](https://github.com/taranis-ai/taranis-ai/tree/master/src/worker/worker/bots)

## Bot's settings

- Name
- Description
- Type: Select an option based on the desired functionalities.
- Index: Specifies the execution order of bots when RUN_AFTER_COLLECTOR is enabled.
- RUN_AFTER_COLLECTOR: Executes the bot after any collector.
- REFRESH_INTERVAL: Specifies the execution interval of the bot (default is every 8 hours - `0 */8 * * *`).
  - Accepted values: Crontab-like style.
    - Helper buttons: daily, weekly, monthly.
