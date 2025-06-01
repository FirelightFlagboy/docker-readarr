# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM alpine:3.22 as builder

COPY --link pkg-info.json /pkg-info.json

ARG PKG_VERSION
ARG TARGETARCH

COPY --link in-docker-build.sh /build.sh

RUN sh /build.sh

FROM alpine:3.22

ARG PKG_VERSION

LABEL org.opencontainers.image.source="https://github.com/Readarr/Readarr"
LABEL org.opencontainers.image.description="Readarr is an ebook and audiobook collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new books from your favorite authors and will grab, sort, and rename them. Note that only one type of a given book is supported. If you want both an audiobook and ebook of a given book you will need multiple instances."
LABEL org.opencontainers.image.version=${PKG_VERSION}
LABEL org.opencontainers.image.title="Readarr"

COPY --from=builder /opt/readarr /opt/readarr
RUN apk --no-cache add icu-libs sqlite-libs

USER 1234:1234

ENTRYPOINT [ "/opt/readarr/Readarr", "-nobrowser", "-data=/config" ]
