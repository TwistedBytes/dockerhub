FROM twistedbytes/centos8-stream:2022.05.26.01

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.05.26.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with apache"

COPY ./setup/repo/twistedbytes.repo /etc/yum.repos.d/twistedbytes.repo

RUN true \
    && dnf -y --setopt=tsflags=nodocs install epel-release.noarch \
    && dnf -y --setopt=tsflags=nodocs install httpd httpd-tools mod_ssl mod_http2 wget openssl

COPY ${SERVICE_DIR}/setup /installation/
RUN bash /installation/scripts/install_apache.sh && rm -Rf /installation

RUN true \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true

COPY run-on-start/ /aa-run-on-start/
RUN find /aa-run-on-start/ -type f -exec chmod 755 {} ';'

EXPOSE 80 443

ENTRYPOINT ["/aa-run-on-start/run-on-start.sh"]
