ARG CENTOS_VERSION
ARG FROM_VERSION

FROM twistedbytes/centos${CENTOS_VERSION}-stream:${FROM_VERSION}

ARG CENTOS_VERSION
ARG IMAGE_VERSION
ARG YUMDNF

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION}  with apache"

COPY ./setup/repo/twistedbytes.repo /etc/yum.repos.d/twistedbytes.repo
COPY ./setup/repo/centos${CENTOS_VERSION}/*.repo /etc/yum.repos.d/

RUN true \
    && ${YUMDNF} -y --setopt=tsflags=nodocs install epel-release.noarch \
    && ${YUMDNF} -y --setopt=tsflags=nodocs install httpd httpd-tools mod_ssl mod_http2 wget openssl \
    && ${YUMDNF} -y --setopt=tsflags=nodocs update libnghttp2 \
    && true

COPY ${SERVICE_DIR}/setup /installation/
RUN bash /installation/scripts/install_apache.sh && rm -Rf /installation

RUN true \
    && ${YUMDNF} clean all \
    && rm -rf /tmp/* \
    && find /var/log -type f -name '*.log' -delete \
    && true

COPY run-on-start/ /aa-run-on-start/
RUN find /aa-run-on-start/ -type f -exec chmod 755 {} ';'

EXPOSE 80 443

ENTRYPOINT ["/aa-run-on-start/run-on-start.sh"]
