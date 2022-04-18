FROM centos:8

ARG SHARED_DIR=./a-shared
ARG SERVICE_DIR=.

COPY ${SHARED_DIR}/scripts/ /tmp/scripts/
RUN chmod -R 777 /tmp/scripts/
COPY ${SERVICE_DIR}/setup /tmp/scripts/apachesetup/

RUN /tmp/scripts/install_software.sh /tmp/scripts
RUN bash /tmp/scripts/apachesetup/scripts/install_apache.sh

RUN \
    cp /tmp/scripts/apachesetup/scripts/update-tbdocker-certs.sh /usr/local/bin/autorun/ && \
    chmod 755 /usr/local/bin/autorun/* \
    ;

RUN yum -y --setopt=tsflags=nodocs install which

# set timezone
ARG TZ=UTC
RUN /tmp/scripts/set_timezone.sh ${TZ}

# add users
ARG APP_USER=www-data
ARG APP_GROUP=www-data
ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000

RUN /tmp/scripts/create_user.sh ${APP_USER} ${APP_GROUP} ${APP_USER_ID} ${APP_GROUP_ID}

ARG APP_CODE_PATH_CONTAINER=/var/www/html
ARG DOCROOT_CONTAINER=/docroot

RUN cp /tmp/scripts/apachesetup/scripts/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

RUN chown ${APP_USER}:${APP_GROUP} /etc/httpd /var/log/httpd /etc/ssl/tbdocker* /run/httpd -Rf
# RUN ls -la /etc/httpd /var/log/httpd /etc/ssl/tbdocker* /run/httpd

# cleanup
RUN /tmp/scripts/cleanup.sh

RUN echo "/var/log/httpd" >> /etc/logdirs.txt

# USER ${APP_USER}
ENTRYPOINT ["/bin/docker-entrypoint/start.sh", "/run-httpd.sh"]

EXPOSE 80 443
