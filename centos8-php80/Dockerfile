FROM centos:8

ARG PHP_MAJOR_VERSION=8
ARG PHP_MAJOR_MINOR_VERSION=8.0
ARG IMAGE_CREATED

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.created="${IMAGE_CREATED}" \
      org.opencontainers.image.version="2022.01.13.01" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with base php ${PHP_MAJOR_MINOR_VERSION} from remi repo"

RUN true \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${PHP_MAJOR_VERSION}.noarch.rpm \
    && dnf -y install https://rpms.remirepo.net/enterprise/remi-release-${PHP_MAJOR_VERSION}.rpm \
    && dnf -y module reset php \
    && dnf -y module install php:remi-${PHP_MAJOR_MINOR_VERSION} \
    && dnf -y install php-common php-bcmath php-dba php-gd php-gmp php-imap php-intl php-mbstring php-mcrypt php-mysqlnd \
                      php-pdo php-pgsql php-process php-soap php-xml php-xmlrpc php-opcache php-fpm php-cli \
                      php-pecl-zip  \
    && dnf -y install git \
    && dnf clean all \
    && true
