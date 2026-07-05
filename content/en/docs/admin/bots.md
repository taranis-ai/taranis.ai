---
title: "Bots"
description: "Bots are increasing functionalities in the background"
weight: 5
---

## List of Bots

1. [IOC BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/ioc_bot.py) - for tagging news items
2. [NLP Tagging BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/nlp_bot.py) - for tagging news items via NLP
3. [Story BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/story_bot.py) - for story clustering
4. [Summary BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/summary_bot.py) - for summarizing stories and optionally generating story titles
5. [Sentiment Analysis BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/sentiment_analysis_bot.py) - for adding sentiment attributes to news items
6. [Wordlist BOT](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/bots/wordlist_bot.py) - tagging news items by wordlist
7. [More bots](https://github.com/taranis-ai/taranis-ai/tree/master/src/worker/worker/bots)

## Bot's settings

- Name
- Description
- Type: Select an option based on the desired functionalities.
- Index: Specifies the execution order of bots when RUN_AFTER_COLLECTOR is enabled.
- RUN_AFTER_COLLECTOR: Executes the bot after any collector.
- REFRESH_INTERVAL: Specifies the execution interval of the bot (default is every 8 hours - `0 */8 * * *`).
  - Accepted values: Crontab-like style.
    - Helper buttons: daily, weekly, monthly.
- REQUESTS_TIMEOUT: Optional HTTP timeout for calls from worker bots to external bot services.

## Summary and title generation

The Summary BOT sends story news item titles and content to the configured summary service. If a story contains more than one news item and `TITLE_ENDPOINT` is configured, the bot can also update the story title.

Common parameters:

- `SUMMARY_ENDPOINT`: overrides the default summary service endpoint.
- `TITLE_ENDPOINT`: optional title generation endpoint.
- `BOT_API_KEY`: API key used when calling the bot service.
- `REQUESTS_TIMEOUT`: request timeout for the external call.

## Sentiment analysis

The Sentiment Analysis BOT sends news item content to the configured sentiment service and writes these attributes back to the news item:

- `sentiment_score`
- `sentiment_category`

The Story Edit advanced view displays the sentiment status when these attributes are present.
