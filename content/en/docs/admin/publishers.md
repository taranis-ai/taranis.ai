---
title: Publishers
description: Publishers allow handling created products.
weight: 6
---

### Supported options:
1. [Email Publisher](#email-publisher)
2. [FTP Publisher](#ftp-publisher)

## Email Publisher
The Email Publisher allows to send out Products.

* Fields:
    * SMTP_SERVER_ADDRESS*: Address of the SMTP server.
    * SMTP_SERVER_PORT*: Port of the SMTP server.
    * SERVER_TLS: Enable/Disable TLS.
    * EMAIL_USERNAME: Login username for the SMTP server.
    * EMAIL_PASSWORD: Login password for the SMTP server.
    * EMAIL_SENDER*: This will be displayed as the sender of the email.
    * EMAIL_RECIPIENT*: This is the email address of the recipient. It is possible to use only one email recipient.
    * EMAIL_SUBJECT: Subject of the email.

_Required fields are marked with a *._

### General usage
Once the publisher is created, it becomes available in the "Publish" section of each product.
To send out a product via email, the product must be "Rendered" first. To render a product use the option available in the product's view.


