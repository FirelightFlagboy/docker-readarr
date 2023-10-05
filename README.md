# Docker Readarr

Provide a simple docker image for [`readarr`].

[`readarr`]: https://github.com/Readarr/Readarr

The goal is to provide a simpler docker image that don't package a bootstrap script like [`linuxserver/readarr`] to be used on `docker-compose` & `k8s`.

[`linuxserver/readarr`]: https://github.com/linuxserver/docker-readarr

The image is provided at <https://hub.docker.com/r/firelightflagbot/readarr>

## Quick start

Here is a simple `docker-compose` file:

```yaml
services:
  readarr:
    image: firelightflagbot/readarr:0.3.6.2232
    user: 1234:1234 # This is the default uid/gid, you can change it.
    ports:
      - 8787:8787
    volumes:
      - type: bind
        source: /somewhere/readarr-config # The folder need to be owned by the set'd user in `services.readarr.user` (readarr need to be able to write to it).
        target: /config
```
