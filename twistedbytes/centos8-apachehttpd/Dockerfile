FROM twistedbytes/centos8-stream:2022.04.18.01

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.04.15.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with apache"

ARG SHARED_DIR=./a-shared
ARG SERVICE_DIR=.

COPY ${SERVICE_DIR}/setup/repo/twistedbytes.repo /etc/yum.repos.d/twistedbytes.repo

COPY ${SHARED_DIR}/scripts/ /installation/
RUN chmod -R 777 /installation/

RUN true \
    && dnf -y --setopt=tsflags=nodocs install epel-release.noarch \
    && dnf -y --setopt=tsflags=nodocs install httpd httpd-tools mod_ssl mod_http2 wget openssl

# add users
ARG APP_USER=www-data
ARG APP_GROUP=www-data
ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000

RUN /installation/create_user.sh ${APP_USER} ${APP_GROUP} ${APP_USER_ID} ${APP_GROUP_ID}

COPY ${SERVICE_DIR}/setup /installation/apachesetup/

# RUN /installation/install_software.sh /tmp/scripts
RUN bash /installation/apachesetup/scripts/install_apache.sh
RUN bash /installation/apachesetup/scripts/update-tbdocker-certs.sh

RUN true \
    && chown -R www-data:www-data \
      /var/log/httpd /run/httpd

VOLUME ["/var/www/html/public", "/var/log/httpd"]

EXPOSE 80 443

RUN true \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true



# USER ${APP_USER}
# ENTRYPOINT ["/bin/docker-entrypoint/start.sh", "/run-httpd.sh"]


