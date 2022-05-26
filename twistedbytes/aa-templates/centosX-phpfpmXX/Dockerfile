ARG CENTOS_VERSION
ARG FROM_VERSION
ARG PHP_VERSION_MAJOR
ARG PHP_VERSION_MINOR

FROM twistedbytes/centos${CENTOS_VERSION}-php${PHP_VERSION_MAJOR}${PHP_VERSION_MINOR}:${FROM_VERSION}

# repeat ARGS because ARGS before from will not work
ARG PHP_VERSION_MAJOR
ARG PHP_VERSION_MINOR
ARG PHP_VERSION_MAJOR_MINOR
ARG CENTOS_VERSION
ARG IMAGE_VERSION

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION} with base php ${PHP_VERSION_MAJOR_MINOR} from remi repo"

COPY ./setup/config/conf.d/* /etc/php.d/
COPY ./setup/config/php-fpm.conf /etc/php-fpm.conf
RUN touch /etc/php-fpm-pool-www-extra.conf

COPY run-on-start/ /aa-run-on-start/
RUN find /aa-run-on-start/ -type f -exec chmod 755 {} ';'

# CMD ["/aa-run-on-start/run-on-start.sh"]

ENTRYPOINT ["/aa-run-on-start/run-on-start.sh"]

EXPOSE 9000
