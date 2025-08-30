---
title: Publishers
description: Publishers allow handling created products.
weight: 6
---

### Supported options

- [Publishers](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/publishers/)
  - [FTP Publisher](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/publishers/ftp_publisher.py)
  - [SFTP Publisher](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/publishers/sftp_publisher.py)
  - [EMail Publisher](https://github.com/taranis-ai/taranis-ai/blob/master/src/worker/worker/publishers/email_publisher.py)

## Email Publisher

The Email Publisher allows sending out Products.

- Fields:
  - SMTP_SERVER_ADDRESS*: Address of the SMTP server.
  - SMTP_SERVER_PORT*: Port of the SMTP server.
  - SERVER_TLS: Enable/Disable TLS.
  - EMAIL_USERNAME: Login username for the SMTP server.
  - EMAIL_PASSWORD: Login password for the SMTP server.
  - EMAIL_SENDER*: Sender of the email for message envelope.
  - EMAIL_RECIPIENT*: Email address of the recipient for message envelope. It is possible to use only one email recipient.
  - EMAIL_SUBJECT: Subject of the email.

_Note: The EMAIL_SENDER and EMAIL_RECIPIENT parameters are used to construct the message envelope used by the transport agents. Message headers are not modified by these parameters in any way._

_Required fields are marked with a *._

### General usage

Once the publisher is created, it becomes available in the "Publish" section of each product.
To send out a product via email, the product must be "Rendered" first. To render a product, use the option available in the product's view.
