ARG CENTOS_VERSION

FROM quay.io/centos/centos:stream${CENTOS_VERSION}

# repeat ARGS because ARGS before from will not work
ARG CENTOS_VERSION
ARG IMAGE_VERSION

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION} Stream base image from centos:centos8"

COPY ./setup/ /installation/
RUN bash /installation/install-gosu.sh && rm -Rf /installation

# upgrade packages
RUN true \
    && dnf -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs upgrade \
    && dnf -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs install procps-ng iputils iproute rsync openssh-clients git \
    && true

RUN true \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
