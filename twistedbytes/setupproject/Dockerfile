FROM twistedbytes/centos9-php82:latest

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.06.02.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Setup a directory for PHP development"

#RUN true \
#    && dnf -y --setopt=tsflags=nodocs install rsync \
#    && dnf clean all \
#    && rm -rf /tmp/* \
#    && rm -rf /var/cache/yum \
#    && rm -rf /var/cache/dnf \
#    && find /var/log -type f -name '*.log' -delete \
#    && true

COPY configs/ /configs/

RUN rm -Rf /aa-run-on-start/
COPY run-on-start/ /aa-run-on-start/
RUN find /aa-run-on-start/ -type f -exec chmod 755 {} ';'

VOLUME ["/projectroot"]

ENTRYPOINT ["/aa-run-on-start/run-on-start.sh"]
