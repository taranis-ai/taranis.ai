---
title: "Connectors"
description: "Connectors are used to push information out of Taranits (experimental)"
weight: 6
---

Supported options:
1. [MISP Connector](#misp-connector)

## MISP Connector
*The MISP connector is currently in an experimental stage. Please submit issues when you discover any problems or need support with its usage.*

MISP Connector enables Taranis AI to push Stories to [MISP](https://www.misp-project.org/) in the representation of MISP Events.

The created events contain automatically an [Event Report](https://www.circl.lu/doc/misp/create-event-report/) based on the Story content (currently it encompasses the Story description and Story summary, if you feel the Event Report would benefit extending with more information, please open a feature request for it [here](https://github.com/taranis-ai/taranis-ai/issues)).


The Connector needs to be first setup in the Admin section under the Connectors tab.

![admin_connectors](/docs/admin_connectors.png)

* Requuired parameters:
  * URL: Base URL to the MISP instance (e.g. `https://localhost)
  * API_KEY: API key to access the instance (see [MISP Automation API](https://www.circl.lu/doc/misp/automation/#automation-api))
  * ORGANISATION_ID: ID of your organisation, usually starts with ID=1 (*It is very important that this value is correct, otherwise the tool will not work properly!*)

* Optional parameters:
  * SSL_CHECK: if enabled, the SSL certificate will be validated
  * SHARING_GROUP_ID: set to the ID of a sharing group, if you want to collect only one sharing group (see [Create and manage Sharing Groups](https://www.circl.lu/doc/misp/using-the-system/#create-and-manage-sharing-groups))
  * DISTRIBUTION: Integer value of the distribution of the created events (see [Setting distribution](https://www.circl.lu/doc/misp/best-practices/#setting-distribution) and [Creating an event](https://www.circl.lu/doc/misp/using-the-system/#creating-an-event))
  * REQUEST_TIMEOUT
  * USER_AGENT
  * PROXY_SERVER
  * ADDITIONAL_HEADERS
  * REFRESH_INTERVAL

  ### Usage of the MISP Connector
  To send a story to MISP, use the button "Share to Connector" in Story options in Assess. When an update to the Story is later on made, it is recommended to share the change immediately, you need to do this manually like the first time.

  ![assess_share_to_connector](/docs/assess_share_to_connector.png)


  When you digest a Story, that is not owned by your organisation, it is possible to update it in Taranis AI and by using the same "Share to Connector" button in the Story options a proposal to the event is created. Then the owning organisation should review this proposal, and approve or reject the changes.
