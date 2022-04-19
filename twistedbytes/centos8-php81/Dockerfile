FROM twistedbytes/centos8-stream:2022.04.19.01

ARG PHP_MAJOR_VERSION=8
ARG PHP_MAJOR_MINOR_VERSION=8.1

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="2022.04.19.07" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with base php ${PHP_MAJOR_MINOR_VERSION} from remi repo"

RUN true \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    && dnf -y module reset php \
    && dnf -y module install php:remi-${PHP_MAJOR_MINOR_VERSION} \
    && dnf -y --setopt=tsflags=nodocs install unzip p7zip \
    && dnf -y --setopt=tsflags=nodocs install \
      php-common php-bcmath php-dba php-gd php-gmp php-imap php-intl php-mbstring php-mcrypt php-mysqlnd \
      php-pdo php-pgsql php-process php-soap php-xml php-xmlrpc php-opcache php-fpm php-cli \
      php-pecl-zip php-sodium \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
