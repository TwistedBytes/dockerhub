ARG BASE_IMAGE

FROM ${BASE_IMAGE}

# repeat ARGS because ARGS before from will not work
ARG CENTOS_VERSION
ARG IMAGE_VERSION
ARG YUMDNF

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION} Stream base image from centos:centos8"

COPY ./setup/ /installation/
RUN bash /installation/install-gosu.sh && rm -Rf /installation

# upgrade packages
RUN true \
    && ${YUMDNF} -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs upgrade \
    && ${YUMDNF} -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs install \
      procps-ng iputils iproute rsync openssh-clients git which sudo \
    && true

RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/10_all

RUN true \
    && ${YUMDNF} clean all \
    && rm -rf /tmp/* \
    && find /var/log -type f -name '*.log' -delete \
    && true
