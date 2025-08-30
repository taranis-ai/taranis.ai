---
title: "Settings"
description: The settings section enables the administrator to make global changes.
weight: 8
---

### Options

1. Default TLP Level
2. Default Collector Proxy
3. Default Collector Interval

## Default TLP Level

Learn more about what TLP version 2.0 is under [first.org/tlp/](https://www.first.org/tlp/).

**Default value**: Clear

**Options**: Green, Amber, Amber+Strict, Red

All newly collected items by [Collectors](/docs/admin/osint-sources) use this default TLP value. When this setting is changed, it does not affect the items that are already present in [Assess](/docs/assess) section.

This setting can be overridden for each [collector](docs/admin/collectors) with the `TLP_LEVEL` field.

## Default Collector Proxy

When a default [collector](docs/admin/collectors) proxy is set, it can then be used in the collectors by enabling the switch `USE_GLOBAL_PROXY`.

### The following matrix of the states applies

- 🟢 **Per-source proxy set**: A proxy is set or not for a collector.
- 🔵 **Default proxy set**: A default proxy is set or not in global settings.
- **USE_GLOBAL_PROXY**: In the collector (OSINT Source) settings, the switch `USE_GLOBAL_PROXY` is enabled.
- **Result**: The resulting state.

|  # | Per-source proxy | Default proxy | `USE_GLOBAL_PROXY` | Result                                            |
| -: | :--------------: | :-----------: | :----------------: | :------------------------------------------------ |
|  1 |         ❌        |       ❌       |       `false`      | ⚪ **No proxy**                                    |
|  2 |         ✅        |       ❌       |       `false`      | 🟢 **Per-source proxy**                           |
|  3 |         ❌        |       ✅       |       `false`      | ⚪ **No proxy**                                    |
|  4 |         ✅        |       ✅       |       `false`      | 🟢 **Per-source proxy**                           |
|  5 |         ❌        |       ❌       |       `true`       | ⚪ **No proxy**                                    |
|  6 |         ✅        |       ❌       |       `true`       | ⚪ **No proxy** *(global forced; default missing)* |
|  7 |         ❌        |       ✅       |       `true`       | 🔵 **Default proxy**                              |
|  8 |         ✅        |       ✅       |       `true`       | 🔵 **Default proxy**                              |

## Default Collector Interval

This value is used for `REFRESH_INTERVAL` for all collectors (OSINT Sources) when this field is left unset individually for all collectors. The syntax is the same as `REFRESH_INTERVAL` in [bot's settings](/docs/admin/bots/#bots-settings).

## Export options

- **Export all Stories**: Export all stories without any metadata (tags, etc.).
- **Export all Stories with metadata**: Export all stories with all the metadata (tags, attributes, likes, dislikes, relevance, etc.). It is not safe to use these data back for importing (some tags and attributes are used for internal purposes and could create unexpected behaviour). Drop metadata before importing, if doing so.

## Danger Zone

- **Clear all Worker Queues**: Delete all messages from all worker queues. This action cannot be undone.
- **Delete all Tags**: Delete all tags from all Stories in the system. This action cannot be undone.
