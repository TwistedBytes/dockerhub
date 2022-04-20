FROM quay.io/centos/centos:stream8

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.04.20.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 Stream base image from centos:centos8"

# upgrade packages
RUN true \
    && dnf -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs upgrade \
    && dnf -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs install procps-ng iputils iproute rsync \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
