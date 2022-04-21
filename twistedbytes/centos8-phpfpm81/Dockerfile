FROM twistedbytes/centos8-php81:2022.04.20.02

ARG PHP_MAJOR_VERSION=8
ARG PHP_MAJOR_MINOR_VERSION=${PHP_MAJOR_VERSION}.1

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.04.21.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with base php ${PHP_MAJOR_MINOR_VERSION} from remi repo"

RUN true \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1 --version=1.10.16

COPY ./setup/config/conf.d/* /etc/php.d/
COPY ./setup/config/php-fpm.conf /etc/php-fpm.conf
RUN touch /etc/php-fpm-pool-www-extra.conf

COPY run-on-start/ /aa-run-on-start/
RUN find /aa-run-on-start/ -type f -exec chmod 755 {} ';'

# CMD ["/aa-run-on-start/run-on-start.sh"]

ENTRYPOINT ["/aa-run-on-start/run-on-start.sh"]

EXPOSE 9000
