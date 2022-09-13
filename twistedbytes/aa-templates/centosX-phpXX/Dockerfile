ARG CENTOS_VERSION
ARG FROM_VERSION

FROM twistedbytes/centos${CENTOS_VERSION}-stream:${FROM_VERSION}

# repeat ARGS because ARGS before from will not work
ARG PHP_MAJOR_VERSION
ARG PHP_VERSION_MAJOR_MINOR
ARG CENTOS_VERSION
ARG IMAGE_VERSION

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION} with base php ${PHP_VERSION_MAJOR_MINOR} from remi repo"

RUN true \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${CENTOS_VERSION}.noarch.rpm \
    && dnf -y install https://rpms.remirepo.net/enterprise/remi-release-${CENTOS_VERSION}.rpm \
    && dnf -y module reset php \
    && dnf -y module install php:remi-${PHP_VERSION_MAJOR_MINOR} \
    && dnf -y --setopt=tsflags=nodocs install unzip \
    && dnf -y --setopt=tsflags=nodocs install \
      php-common php-bcmath php-dba php-gd php-gmp php-imap php-intl php-mbstring php-mysqlnd \
      php-pdo php-pgsql php-process php-soap php-xml php-opcache php-fpm php-cli \
      php-pecl-zip php-sodium php-pecl-redis5 \
      php-mcrypt php-xmlrpc \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1 --1 \
    && dnf clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
