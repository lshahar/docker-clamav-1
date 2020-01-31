FROM tiredofit/alpine:3.11
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features From Base Image
ENV ENABLE_SMTP=FALSE

### Install Dependencies
RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
              clamav \
              clamav-libunrar \
              && \
    \
### Cleanup
    rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 3310
### Docker Health-Check
HEALTHCHECK --interval=60s --timeout=3s CMD nc localhost 3310 || exit 1

### Add Files
ADD install /
