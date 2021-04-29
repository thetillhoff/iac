# web

The `web` application is a bit special; It contains a caddyserver, which is configured to reverse-proxy all web-applications.


## Background

As it is not possible to share port `80` and `443` with multiple containers, there has to be one primary web-server, which delegates all URLs to the respectives applications.
This also ensures that caddy can handle the SSL-certificate-management properly.

## Configuration

All applications are configured in the `Caddyfile`. In addition to them, some other endpoints are configured. They can be used for debugging or healthchecking.
