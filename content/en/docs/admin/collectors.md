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
  * CONTENT_LOCATION
  * PROXY_SERVER
  * REFRESH_INTERVAL (see [Bots - refresh_interval](/docs/admin/bots/#bot's-settings))
  * Digest Splitting On/Off
  * DIGEST_SPLITTING_LIMIT (default: 30)

### Basic configuration
* Example: 
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml

### Advanced configuration
The RSS Collector supports the use of XPath for locating elements. (See Simple Web Collector [Advanced configuration](#advanced-configuration-1))
* Example:
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml
  * **XPATH**: //*[@id="getting-started-web-console-creating-new-project_openshift-web-console"]

### Digest Splitting
Digest Splitting is a feature that allows the user to split all available URLs in the RSS feed into individual News Items.
The Digest Splitting Limit is the maximum number of URLs that will be split into individual News Items. If the limit is reached, the remaining URLs are dropped.
The Digest Splitting Limit is set to 30 by default but can be adjusted by the administrator. It is generally recommended to keep the limit low to avoid overloading the system, which could lead to unsuccessful gathering.


## Simple Web Collector
Simple Web Collector enables Taranis AI to collect data using web URLs and XPaths.
* Required field: 
  * **WEB_URL**
* Optional fields:
  * USER_AGENT
  * PROXY_SERVER
  * XPATH

### Basic configuration
The simplest way to use this collector is to use the **WEB_URL** field only. 
By using only the WEB_URL field, Taranis-AI autonomously determines the content to be collected. Even though it is mostly reliable,
sometimes it is not perfect.

### Advanced configuration
When content cannot be reliably collected using the [Basic configuration](#basic-configuration), adding the attribute **XPATH**
(See [tutorial how to find it](https://www.appsierra.com/blog/how-to-get-xpath-in-chrome)), can be useful. 
It is crucial to specify the XPath of the precise element containing the desired data.


## RT Collector
RT Collector enables Taranis AI to collect data from a user-defined RT instance.

* Required fields:
  * **BASE_URL**: Base URL of the RT instance (e.g. `localhost`).
  * **RT_TOKEN**: User token for the RT instance.

* Optional fields:
  * **TLP_LEVEL**