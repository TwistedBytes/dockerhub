FROM quay.io/centos/centos:stream8

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.04.18.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 Stream base image from centos:centos8"

# upgrade packages
RUN true \
    && dnf -y upgrade --setopt=install_weak_deps=False \
    && dnf -y install procps-ng iputils iproute \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
