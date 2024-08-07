---
title: Deployment
description: How to deploy Taranis AI
weight: 1
---


Clone via git
```
git clone --depth 1  https://github.com/taranis-ai/taranis-ai
cd taranis-ai/docker/
```

## Configuration

Copy `env.sample` to `.env`
```bash
cp env.sample .env
```

Open file `.env` and change defaults if needed. More details about environment variables can be found [here](https://github.com/taranis-ai/taranis-ai/blob/master/docker/README.md).

See [Advanced monitoring](./advanced-monitoring.md) for more logging insights.


## Startup & Usage 

Start-up application
```bash
docker compose up -d
```

Use the application 
```bash
http://<url>:<TARANIS_PORT>/login
```

## Initial Setup 👤

**The default credentials are `user` / `user` and `admin` / `admin`.**

The passwords for these two default users can be overridden by setting the environment variables `PRE_SEED_PASSWORD_ADMIN` or `PRE_SEED_PASSWORD_USER` before first launch.
Afterwards they are stored in the database in the `user` table.

Open `http://<url>:<TARANIS_PORT>/config/sources` and click **Import** to import json-file with sources (see below).

Example RSS Sources:

```json
{
    "version": 3,
    "sources": [
        {
            "name": "CERT.at - Blog",
            "description": "This feed contains the blog from www.CERT.at",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "http://cert.at/cert-at.en.blog.rss_2.0.xml"
                },
                {
                    "CONTENT_LOCATION": "description"
                }
            ],
            "group_idx": 1
        },
        {
            "name": "BSI RSS-Newsfeed Presse-, Kurzmitteilungen und Veranstaltungshinweise",
            "description": "Aktuelle Informationen vom Bundesamt f\u00fcr Sicherheit in der Informationstechnik",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://www.bsi.bund.de/SiteGlobals/Functions/RSSFeed/RSSNewsfeed/RSSNewsfeed.xml"
                }
            ],
            "group_idx": 2
        },
        {
            "name": "CERT.org",
            "description": "",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://www.kb.cert.org/vulfeed"
                }
            ],
            "group_idx": 3
        },
        {
            "name": "Aktuelles aus dem BM.I",
            "description": "\u00dcbersicht der neuesten Artikel aus dem Bundesministerium f\u00fcr Inneres",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "http://www.bmi.gv.at/rss/bmi_presse.xml"
                }
            ],
            "group_idx": 4
        },
        {
            "name": "The CZ.NIC Staff Blog",
            "description": "@ IN SOA domains.dns.enum.mojeid.internet. nic.cz.",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "http://en.blog.nic.cz/feed/"
                },
                {
                    "CONTENT_LOCATION": "content:encoded"
                }
            ],
            "group_idx": 5
        },
        {
            "name": "CERT.at - All",
            "description": "Dieser Feed kombiniert alle deutschsprachigen Feed-Updates von www.CERT.at",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "http://cert.at/cert-at.de.all.rss_2.0.xml"
                },
                {
                    "CONTENT_LOCATION": "description"
                }
            ],
            "group_idx": 6
        },
        {
            "name": "Gunnar Haslinger",
            "description": "My shared public notes: Blog about IT, Security, etc ...",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://hitco.at/blog/feed/"
                }
            ],
            "group_idx": 7
        },
        {
            "name": "futurezone.at",
            "description": "",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://futurezone.at/xml/rss"
                }
            ],
            "group_idx": 8
        },
        {
            "name": "Fefes Blog",
            "description": "Verschw\u00f6rungen und Obskures aus aller Welt",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "http://blog.fefe.de/rss.xml?html"
                }
            ],
            "group_idx": 9
        },
        {
            "name": "Web - derStandard.at",
            "description": "",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://www.derstandard.at/rss/web"
                }
            ],
            "group_idx": 10
        },
        {
            "name": "news.ORF.at",
            "description": "Die aktuellsten Nachrichten auf einen Blick - aus \u00d6sterreich und der ganzen Welt. In Text, Bild und Video.",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://rss.orf.at/news.xml"
                }
            ],
            "group_idx": 11
        },
        {
            "name": "oesterreich.ORF.at",
            "description": "Die aktuellsten Nachrichten auf einen Blick - aus \u00d6sterreich und der ganzen Welt. In Text, Bild und Video.",
            "type": "rss_collector",
            "parameters": [
                {
                    "FEED_URL": "https://rss.orf.at/oesterreich.xml"
                }
            ],
            "group_idx": 12
        }
    ],
    "groups": [
        {
            "name": "General News",
            "description": "",
            "osint_sources": [
                8,
                9,
                10,
                11,
                12
            ]
        },
        {
            "name": "Technical News",
            "description": "",
            "osint_sources": [
                1,
                2,
                3,
                4,
                5,
                6,
                7
            ]
        }
    ]
}
```