FROM centos:centos8
LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.created="${IMAGE_CREATED}" \
      org.opencontainers.image.version="2022.02.01.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 Stream base image from centos:centos8"

RUN true \
    && sed -r -i \
         -e 's/^mirrorlist/#mirrorlist/' \
         -e 's/^#baseurl/baseurl/' \
         -e 's/mirror.centos.org/vault.centos.org/' \
         /etc/yum.repos.d/CentOS-Linux-AppStream.repo /etc/yum.repos.d/CentOS-Linux-BaseOS.repo \
    && dnf -y install centos-release-stream \
    && dnf -y swap centos-{linux,stream}-repos \
    && dnf -y distro-sync \
    && rm -f /etc/yum.repos.d/*rpmsave \
    && dnf clean all \
    && true
