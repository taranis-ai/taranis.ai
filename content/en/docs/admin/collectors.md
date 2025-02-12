---
title: "Collectors"
description: "Collectors are used to gather data from various sources."
weight: 5
---

### Supported options:
1. [RSS Collector](#rss-collector)
2. [Simple Web Collector](#simple-web-collector)
3. [RT Collector](#rt-collector)

The administration view now allows users to use the Preview feature to see the result of the configuration without the items being processed further for the Assess view.
This feature is available for RSS, Simple Web and RT collector.

## RSS Collector
RSS Collector enables Taranis AI to collect data from a user-defined RSS feed (See [RSS feeds details](https://rss.com/blog/how-do-rss-feeds-work/)).
* Required fields: 
  * **FEED_URL**
* Optional fields:
  * USER_AGENT
  * PROXY_SERVER
  * ADDITIONAL_HEADERS [accepts a valid `json`] (can be used to add additional headers, not all headers work as expected)
  * CONTENT_LOCATION
  * XPATH
  * TLP_LEVEL
  * REFRESH_INTERVAL (see [Bots - refresh_interval](/docs/admin/bots/#bot's-settings))
  * DIGEST_SPLITTING On/Off (creates News Items out of URLs present in the `Summary` field of RSS feed)
  * DIGEST_SPLITTING_LIMIT (default: 30)
  * BROWSER_MODE On/Off (see [Browser Mode](#browser-mode))

### Basic configuration
* Example: 
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml

### Advanced configuration
The RSS Collector supports the use of XPath for locating elements. (See Simple Web Collector [Advanced configuration](#advanced-configuration-1))
* Example:
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml
  * **XPATH**: //*[@id="getting-started-web-console-creating-new-project_openshift-web-console"]
  * **ADDITIONAL_HEADERS**: `{
    "AUTHORIZATION": "Bearer Token1234",
    "X-API-KEY": "12345",
    "Cookie": "firstcookie=1234; second-cookie=4321",
}`


## Simple Web Collector
Simple Web Collector enables Taranis AI to collect data using web URLs and XPaths.
* Required field: 
  * **WEB_URL**
* Optional fields:
  * USER_AGENT
  * PROXY_SERVER
  * ADDITIONAL_HEADERS
  * XPATH
  * TLP_LEVEL
  * DIGEST_SPLITTING On/Off
  * DIGEST_SPLITTING_LIMIT (default: 30)
  * BROWSER_MODE On/Off (see [Browser Mode](#browser-mode))

### Basic configuration
The simplest way to use this collector is to use the **WEB_URL** field only. 
By using only the WEB_URL field, Taranis-AI autonomously determines the content to be collected. Even though it is mostly reliable,
sometimes it is not perfect.

### Advanced configuration
When content cannot be reliably collected using the [Basic configuration](#basic-configuration), adding the attribute **XPATH**
(See [tutorial how to find it](https://www.appsierra.com/blog/how-to-get-xpath-in-chrome)), can be useful. 
It is crucial to specify the XPath of the precise element containing the desired data.

### Configuration for Mastodon Feeds
To set up an RSS Collector for collecting posts from a Mastodon hashtag or user, follow these steps:
1. **Finding the Mastodon RSS Feed URL**:
   - **Hashtag Feed**: Add `.rss` to the hashtag URL. For example, to collect posts tagged with #cybersecurity:
     ` https://mastodon.social/tags/cybersecurity.rss `
   - **User Feed**: Similarly, add `.rss` to the user's profile URL. Example:
     ` https://mastodon.social/@username.rss `

2. **Creating a New RSS Source with Required Parameters**:
When creating the new RSS source, configure it with the following parameters. Here’s an example of how to fill out the fields:
     - **FEED_URL**: Enter the RSS feed URL for the Mastodon hashtag or user (e.g., `https://mastodon.social/tags/cybersecurity.rss`).
     - **CONTENT_LOCATION**  Set this to `"summary"` to specify the main content location within each RSS entry.
     - **REFRESH_INTERVAL**  Set the refresh interval in seconds for the frequency of updates.
     - **DIGEST_SPLITTING** is set to `"false"` since we’re not splitting entries into multiple items.

### Configuration for Darkweb Feeds

Extend your compose.yml with a tor service, e.g.

```yaml
tor:
  image: "docker.io/dperson/torproxy:latest"
  deploy:
    restart_policy:
      condition: always
  environment:
    # LOCATION: "AT"
  logging:
    driver: "json-file"
    options:
      max-size: "200k"
      max-file: "10"
```

Read details about the used docker image [here](https://github.com/dperson/torproxy)

The important setting is "PROXY_SERVER" in the OSINT Source you want to crawl.

## RT Collector
RT Collector enables Taranis AI to collect data from a user-defined [Request Tracker](https://bestpractical.com/request-tracker) instance.

* Required fields:
  * **BASE_URL**: Base URL of the RT instance (e.g. `localhost`).
  * **RT_TOKEN**: User token for the RT instance.

* Optional fields:
  * ADDITIONAL_HEADERS
  * TLP_LEVEL

## Digest Splitting
Digest Splitting is a feature that allows the user to split all available URLs in the located element into individual News Items.
The Digest Splitting Limit is the maximum number of URLs that will be split into individual News Items. If the limit is reached, the remaining URLs are dropped.
The Digest Splitting Limit is set to 30 News Items by default but can be adjusted by the administrator. Useful in case of timeouts during collection of too many News Items.

## Browser Mode
Collectors will fail if the web page content is only available with JavaScript. In that case it is possible to turn on the **Browser Mode**. All requests will have JavaScript enabled, therefore, it is slower and can use more resources.
