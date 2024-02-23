---
title: "Collectors"
weight: 5
---

### Supported options:
1. [RSS Collector](#rss-collector)
2. [Simple Web Collector](#simple-web-collector)

## RSS Collector
RSS Collector enables Taranis-AI to collect data from a user-defined RSS feed (See [RSS feeds details](https://rss.com/blog/how-do-rss-feeds-work/)).
* Required fields: 
  * **FEED_URL**
* Optional fields:
  * USER_AGENT
  * CONTENT_LOCATION
  * PROXY_SERVER
  * REFRESH_INTERVAL

### Basic configuration
* Example: 
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml

### Advanced configuration
The RSS Collector supports the use of XPath for locating elements. (See Simple Web Collector [Advanced configuration](#advanced-configuration-1))
* Example:
  * **FEED_URL**: https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml
  * **XPATH**: //*[@id="getting-started-web-console-creating-new-project_openshift-web-console"]

## Simple Web Collector
Simple Web Collector enables Taranis-AI to collect data using web URLs and XPaths.
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
