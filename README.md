MailHog [![Docker Build and Push](https://github.com/cloudogu/mailhog-image/actions/workflows/docker-image.yml/badge.svg)](https://github.com/cloudogu/mailhog/actions/workflows/docker-image.yml)
=========

Mailhog [Docker/OCI image](https://github.com/cloudogu/mailhog-image/pkgs/container/mailhog), regularly rebuilt

See [mailhog's README](https://github.com/mailhog/MailHog/blob/master/README.md) for more details.

## Running

```bash
docker run --rm -d -p 1025:1025 -p 8025:8025 ghcr.io/cloudogu/mailhog
```
You can send mails via SMTP to localhost:1025 and see mailhogs web UI via localhost:8025

## Releasing

To build and push a fresh image on the latest alpine version and mailhog, just [run GH action](https://github.com/cloudogu/mailhog-image/actions/workflows/docker-image.yml). This sets three tags
* `latest`
* MailHog's latest tag, e.g. `v1.0.1`
* MailHog's latest tag + time stamp, e.g. `v1.0.1-2023-10-25`